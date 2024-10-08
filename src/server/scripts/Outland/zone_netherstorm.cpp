/*
 * Copyright (C) 2020+     Project "Sol" <https://gitlab.com/opfesoft/sol>, released under the GNU GPLv2 license: https://gitlab.com/opfesoft/sol/-/blob/master/deps/gpl-2.0.md; you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2016-2020 AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Netherstorm
SD%Complete: 80
SDComment: Quest support: 10337, 10438, 10652 (special flight paths), 10198, 10191
SDCategory: Netherstorm
EndScriptData */

/* ContentData
npc_commander_dawnforge
npc_bessy
npc_maxx_a_million
go_captain_tyralius_prison
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "Player.h"
#include "GameObjectAI.h"
#include "SpellInfo.h"

// Ours
enum saeed
{
    NPC_PROTECTORATE_AVENGER        = 21805,
    NPC_PROTECTORATE_DEFENDER       = 20984,
    NPC_PROTECTORATE_REGENERATOR    = 21783,
    NPC_DIMENSIUS                   = 19554,

    EVENT_START_WALK                = 1,
    EVENT_START_FIGHT1              = 2,
    EVENT_START_FIGHT2              = 3,
    EVENT_START_FIGHT3              = 4,
    EVENT_START_FIGHT4              = 5,
    EVENT_SUMMONS_ACTION            = 6,
    EVENT_WAIT                      = 7,

    DATA_START_ENCOUNTER            = 1,
    DATA_START_FIGHT                = 2,

    QUEST_DIMENSIUS_DEVOURING       = 10439,

    SPELL_DIMENSIUS_TRANSFORM       = 35939,
    SPELL_ETHEREAL_TELEPORT         = 34427,
    SPELL_CLEAVE                    = 15496,

    GOSSIP_MENU_SAEED               = 8228,
    TEXT_NPC_SAEED_DEFAULT          = 10229,
    TEXT_NPC_SAEED_START_FIGHT      = 10232,
};

class npc_captain_saeed : public CreatureScript
{
    public:
        npc_captain_saeed() : CreatureScript("npc_captain_saeed") { }        

        struct npc_captain_saeedAI : public npc_escortAI
        {
            npc_captain_saeedAI(Creature* creature) : npc_escortAI(creature), summons(me) {}

            SummonList summons;
            EventMap events;
            bool started, fight;
            uint32 cleaveTimer;

            void Reset() override
            {
                events.Reset();
                summons.clear();
                started = false;
                fight = false;
                cleaveTimer = 5000;
                me->RestoreFaction();
                me->SetCorpseDelay(5);
            }

            void MoveInLineOfSight(Unit* who) override
            {
                if (Player* player = GetPlayerForEscort())
                    if (me->GetDistance(who) < 10.0f && !me->GetVictim())
                        if (player->IsValidAttackTarget(who))
                        {
                            AttackStart(who);
                            return;
                        }

                npc_escortAI::MoveInLineOfSight(who);
            }

            void SetGUID(uint64 playerGUID, int32 type) override
            {
                if (type == DATA_START_ENCOUNTER)
                {
                    me->setActive(true);
                    Start(true, true, playerGUID);
                    SetDespawnAtFar(false);
                    SetDespawnAtEnd(false);
                    SetEscortPaused(true);
                    started = true;

                    std::list<Creature*> cl;
                    me->GetCreaturesWithEntryInRange(cl, 20.0f, NPC_PROTECTORATE_AVENGER);
                    for (std::list<Creature*>::iterator itr = cl.begin(); itr != cl.end(); ++itr)
                    {
                        summons.Summon(*itr);
                        (*itr)->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                        (*itr)->setFaction(250);
                        (*itr)->setActive(true);
                        (*itr)->SetCorpseDelay(5);
                    }
                    cl.clear();
                    me->GetCreaturesWithEntryInRange(cl, 20.0f, NPC_PROTECTORATE_REGENERATOR);
                    for (std::list<Creature*>::iterator itr = cl.begin(); itr != cl.end(); ++itr)
                    {
                        summons.Summon(*itr);
                        (*itr)->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                        (*itr)->setFaction(250);
                        (*itr)->setActive(true);
                        (*itr)->SetCorpseDelay(5);
                    }
                    cl.clear();
                    me->GetCreaturesWithEntryInRange(cl, 20.0f, NPC_PROTECTORATE_DEFENDER);
                    for (std::list<Creature*>::iterator itr = cl.begin(); itr != cl.end(); ++itr)
                    {
                        summons.Summon(*itr);
                        (*itr)->HandleEmoteCommand(EMOTE_ONESHOT_ROAR);
                        (*itr)->setFaction(250);
                        (*itr)->setActive(true);
                        (*itr)->SetCorpseDelay(5);
                    }

                    me->setFaction(250);
                    Talk(0);
                    events.ScheduleEvent(EVENT_START_WALK, 3000);
                }
                else if (type == DATA_START_FIGHT)
                {
                    events.CancelEvent(EVENT_WAIT);
                    Talk(2);
                    SetEscortPaused(false);
                    me->SetUInt32Value(UNIT_NPC_FLAGS, 0);
                }
            }

            void EnterEvadeMode() override
            {
                if (fight)
                    SetEscortPaused(false);

                cleaveTimer = 5000;
                npc_escortAI::EnterEvadeMode();
            }

            void SummonsAction(Unit* who)
            {
                float i = 0;
                for (std::list<uint64>::iterator itr = summons.begin(); itr != summons.end(); ++itr, i += 1.0f)
                    if (Creature* cr = ObjectAccessor::GetCreature(*me, *itr); cr && cr->IsAlive())
                    {
                        cr->SetHomePosition(cr->GetPositionX(), cr->GetPositionY(), cr->GetPositionZ(), cr->GetOrientation());

                        if (who == NULL)
                        {
                            if (cr->GetMotionMaster()->GetCurrentMovementGeneratorType() != FOLLOW_MOTION_TYPE)
                            {
                                cr->CombatStop(true);
                                cr->GetMotionMaster()->Clear(false);
                                cr->GetMotionMaster()->MoveFollow(me, 2.0f, M_PI/2.0f + (i / summons.size() * M_PI));
                            }
                        }
                        else if (!cr->GetVictim())
                            cr->AI()->AttackStart(who);
                    }
            }

            void WaypointReached(uint32 i) override
            {
                Player* player = GetPlayerForEscort();
                if (!player)
                    return;

                switch (i)
                {
                    case 73:
                        Talk(1, player);
                        me->SetUInt32Value(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        SetEscortPaused(true);
                        events.ScheduleEvent(EVENT_WAIT, 300000);
                        break;
                    case 85:
                        events.ScheduleEvent(EVENT_START_FIGHT1, 0);
                        SetEscortPaused(true);
                        break;
                    case 87:
                        for (std::list<uint64>::iterator itr = summons.begin(); itr != summons.end(); ++itr)
                            if (Creature* cr = ObjectAccessor::GetCreature(*me, *itr); cr && cr->IsAlive())
                            {
                                cr->DespawnOrUnsummon(1000);
                                cr->CastSpell(cr, SPELL_ETHEREAL_TELEPORT, true);
                            }

                        me->DespawnOrUnsummon(1000);
                        me->CastSpell(me, SPELL_ETHEREAL_TELEPORT, true);
                        summons.clear();
                        break;
                }
            }

            void JustDied(Unit* /*killer*/) override
            {
                for (std::list<uint64>::iterator itr = summons.begin(); itr != summons.end(); ++itr)
                    if (Creature* cr = ObjectAccessor::GetCreature(*me, *itr); cr && cr->IsAlive())
                        cr->AI()->SetData(1,1);
                summons.clear();
            }

            uint32 GetData(uint32 data) const override
            {
                if (data == 1)
                    return (uint32)started;

                return 0;
            }

            void UpdateAI(uint32 diff) override
            {
                npc_escortAI::UpdateAI(diff);

                events.Update(diff);
                bool updateVictim = UpdateVictim();
                switch (events.ExecuteEvent())
                {
                    case EVENT_START_WALK:
                        events.ScheduleEvent(EVENT_SUMMONS_ACTION, 1000);
                        SetEscortPaused(false);
                        break;
                    case EVENT_START_FIGHT1:
                        Talk(3);
                        events.ScheduleEvent(EVENT_START_FIGHT2, 4000);
                        break;
                    case EVENT_START_FIGHT2:
                        if (Creature* dimensius = me->FindNearestCreature(NPC_DIMENSIUS, 50.0f))
                        {
                            dimensius->RemoveAurasDueToSpell(SPELL_DIMENSIUS_TRANSFORM);
                            dimensius->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            dimensius->AI()->Talk(1);
                        }
                        events.ScheduleEvent(EVENT_START_FIGHT3, 2000);
                        break;
                    case EVENT_START_FIGHT3:
                        if (Creature* dimensius = me->FindNearestCreature(NPC_DIMENSIUS, 50.0f))
                            dimensius->AI()->Talk(2);
                        events.ScheduleEvent(EVENT_START_FIGHT4, 4000);
                        break;
                    case EVENT_START_FIGHT4:
                        if (Creature* dimensius = me->FindNearestCreature(NPC_DIMENSIUS, 50.0f))
                        {
                            dimensius->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                            AttackStart(dimensius);
                            fight = true;
                        }
                        break;
                    case EVENT_SUMMONS_ACTION:
                        SummonsAction(updateVictim ? me->GetVictim() : NULL);
                        events.ScheduleEvent(EVENT_SUMMONS_ACTION, 3000);
                        break;
                    case EVENT_WAIT:
                        summons.DespawnAll();
                        me->DespawnOrUnsummon(1);
                        break;
                }

                if (!updateVictim)
                    return;

                if (cleaveTimer <= diff)
                {
                    DoCastVictim(SPELL_CLEAVE);
                    cleaveTimer = urand(7000,11000);
                }
                else
                    cleaveTimer -= diff;

                DoMeleeAttackIfReady();
            }
        };

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*uiSender*/, uint32 uiAction) override
        {
            ClearGossipMenuFor(player);
            if (uiAction == GOSSIP_ACTION_INFO_DEF+1)
            {
                creature->AI()->SetGUID(player->GetGUID(), DATA_START_ENCOUNTER);
                player->KilledMonsterCredit(creature->GetEntry(), 0);
            }
            else if (uiAction == GOSSIP_ACTION_INFO_DEF+2)
            {
                creature->AI()->SetGUID(player->GetGUID(), DATA_START_FIGHT);
            }

            CloseGossipMenuFor(player);
            return true;
        }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            if (creature->IsQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            if (player->GetQuestStatus(QUEST_DIMENSIUS_DEVOURING) == QUEST_STATUS_INCOMPLETE)
            {
                if (!creature->AI()->GetData(1))
                    AddGossipItemFor(player, GOSSIP_MENU_SAEED, 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                else
                    AddGossipItemFor(player, GOSSIP_MENU_SAEED, 1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
            }

            SendGossipMenuFor(player, creature->AI()->GetData(1) ? TEXT_NPC_SAEED_START_FIGHT : TEXT_NPC_SAEED_DEFAULT, creature->GetGUID());

            return true;
        }

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_captain_saeedAI(creature);
        }
};


// Theirs
/*######
## npc_commander_dawnforge
######*/

// The Speech of Dawnforge, Ardonis & Pathaleon
enum CommanderDawnforgeData
{
    SAY_COMMANDER_DAWNFORGE_1       = 0,
    SAY_COMMANDER_DAWNFORGE_2       = 1,
    SAY_COMMANDER_DAWNFORGE_3       = 2,
    SAY_COMMANDER_DAWNFORGE_4       = 3,
    SAY_COMMANDER_DAWNFORGE_5       = 4,

    SAY_ARCANIST_ARDONIS_1          = 0,
    SAY_ARCANIST_ARDONIS_2          = 1,

    SAY_PATHALEON_CULATOR_IMAGE_1   = 0,
    SAY_PATHALEON_CULATOR_IMAGE_2   = 1,
    SAY_PATHALEON_CULATOR_IMAGE_2_1 = 2,
    SAY_PATHALEON_CULATOR_IMAGE_2_2 = 3,

    QUEST_INFO_GATHERING            = 10198,
    SPELL_SUNFURY_DISGUISE          = 34603,
};

// Entries of Arcanist Ardonis, Commander Dawnforge, Pathaleon the Curators Image
const uint32 CreatureEntry[3] =
{
    19830,                                                // Ardonis
    19831,                                                // Dawnforge
    21504                                                 // Pathaleon
};

class npc_commander_dawnforge : public CreatureScript
{
public:
    npc_commander_dawnforge() : CreatureScript("npc_commander_dawnforge") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_commander_dawnforgeAI(creature);
    }

    struct npc_commander_dawnforgeAI : public ScriptedAI
    {
        npc_commander_dawnforgeAI(Creature* creature) : ScriptedAI(creature) { }

        uint64 PlayerGUID;
        uint64 ardonisGUID;
        uint64 pathaleonGUID;

        uint32 Phase;
        uint32 PhaseSubphase;
        uint32 Phase_Timer;
        bool isEvent;

        void Reset()
        {
            PlayerGUID = 0;
            ardonisGUID = 0;
            pathaleonGUID = 0;

            Phase = 1;
            PhaseSubphase = 0;
            Phase_Timer = 4000;
            isEvent = false;
        }

        void EnterCombat(Unit* /*who*/) { }

        void JustSummoned(Creature* summoned)
        {
            pathaleonGUID = summoned->GetGUID();
        }

        // Emote Ardonis and Pathaleon
        void Turn_to_Pathaleons_Image()
        {
            Creature* ardonis = ObjectAccessor::GetCreature(*me, ardonisGUID);
            Creature* pathaleon = ObjectAccessor::GetCreature(*me, pathaleonGUID);

            if (!ardonis || !pathaleon)
                return;

            // Turn Dawnforge
            me->SetFacingToObject(pathaleon);

            // Turn Ardonis
            ardonis->SetFacingToObject(pathaleon);

            //Set them to kneel
            me->SetStandState(UNIT_STAND_STATE_KNEEL);
            ardonis->SetStandState(UNIT_STAND_STATE_KNEEL);
        }

        //Set them back to each other
        void Turn_to_eachother()
        {
            if (Unit* ardonis = ObjectAccessor::GetUnit(*me, ardonisGUID))
            {
                // Turn Dawnforge
                me->SetFacingToObject(ardonis);

                // Turn Ardonis
                ardonis->SetFacingToObject(me);

                //Set state
                me->SetStandState(UNIT_STAND_STATE_STAND);
                ardonis->SetStandState(UNIT_STAND_STATE_STAND);
            }
        }

        bool CanStartEvent(Player* player)
        {
            if (!isEvent)
            {
                Creature* ardonis = me->FindNearestCreature(CreatureEntry[0], 10.0f);
                if (!ardonis)
                    return false;

                ardonisGUID = ardonis->GetGUID();
                PlayerGUID = player->GetGUID();

                isEvent = true;

                Turn_to_eachother();
                return true;
            }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_TSCR, "TSCR: npc_commander_dawnforge event already in progress, need to wait.");
#endif
            return false;
        }

        void UpdateAI(uint32 diff)
        {
            //Is event even running?
            if (!isEvent)
                return;

            //Phase timing
            if (Phase_Timer >= diff)
            {
                Phase_Timer -= diff;
                return;
            }

            Creature* ardonis = ObjectAccessor::GetCreature(*me, ardonisGUID);
            Creature* pathaleon = ObjectAccessor::GetCreature(*me, pathaleonGUID);
            Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID);

            if (!ardonis || !player)
            {
                Reset();
                return;
            }

            if (Phase > 4 && !pathaleon)
            {
                Reset();
                return;
            }

            //Phase 1 Dawnforge say
            switch (Phase)
            {
            case 1:
                Talk(SAY_COMMANDER_DAWNFORGE_1);
                ++Phase;
                Phase_Timer = 16000;
                break;
                //Phase 2 Ardonis say
            case 2:
                ardonis->AI()->Talk(SAY_ARCANIST_ARDONIS_1);
                ++Phase;
                Phase_Timer = 16000;
                break;
                //Phase 3 Dawnforge say
            case 3:
                Talk(SAY_COMMANDER_DAWNFORGE_2);
                ++Phase;
                Phase_Timer = 16000;
                break;
                //Phase 4 Pathaleon spawns up to phase 9
            case 4:
                //spawn pathaleon's image
                me->SummonCreature(CreatureEntry[2], 2325.851563f, 2799.534668f, 133.084229f, 6.038996f, TEMPSUMMON_TIMED_DESPAWN, 90000);
                ++Phase;
                Phase_Timer = 500;
                break;
                //Phase 5 Pathaleon say
            case 5:
                pathaleon->AI()->Talk(SAY_PATHALEON_CULATOR_IMAGE_1);
                ++Phase;
                Phase_Timer = 6000;
                break;
                //Phase 6
            case 6:
                switch (PhaseSubphase)
                {
                    //Subphase 1: Turn Dawnforge and Ardonis
                case 0:
                    Turn_to_Pathaleons_Image();
                    ++PhaseSubphase;
                    Phase_Timer = 8000;
                    break;
                    //Subphase 2 Dawnforge say
                case 1:
                    Talk(SAY_COMMANDER_DAWNFORGE_3);
                    PhaseSubphase = 0;
                    ++Phase;
                    Phase_Timer = 8000;
                    break;
                }
                break;
                //Phase 7 Pathaleons say 3 Sentence, every sentence need a subphase
            case 7:
                switch (PhaseSubphase)
                {
                    //Subphase 1
                case 0:
                    pathaleon->AI()->Talk(SAY_PATHALEON_CULATOR_IMAGE_2);
                    ++PhaseSubphase;
                    Phase_Timer = 12000;
                    break;
                    //Subphase 2
                case 1:
                    pathaleon->AI()->Talk(SAY_PATHALEON_CULATOR_IMAGE_2_1);
                    ++PhaseSubphase;
                    Phase_Timer = 16000;
                    break;
                    //Subphase 3
                case 2:
                    pathaleon->AI()->Talk(SAY_PATHALEON_CULATOR_IMAGE_2_2);
                    PhaseSubphase = 0;
                    ++Phase;
                    Phase_Timer = 10000;
                    break;
                }
                break;
                //Phase 8 Dawnforge & Ardonis say
            case 8:
                Talk(SAY_COMMANDER_DAWNFORGE_4);
                ardonis->AI()->Talk(SAY_ARCANIST_ARDONIS_2);
                ++Phase;
                Phase_Timer = 4000;
                break;
                //Phase 9 Pathaleons Despawn, Reset Dawnforge & Ardonis angle
            case 9:
                Turn_to_eachother();
                //hide pathaleon, unit will despawn shortly
                pathaleon->SetVisible(false);
                PhaseSubphase = 0;
                ++Phase;
                Phase_Timer = 3000;
                break;
                //Phase 10 Dawnforge say
            case 10:
                Talk(SAY_COMMANDER_DAWNFORGE_5);
                player->AreaExploredOrEventHappens(QUEST_INFO_GATHERING);
                Reset();
                break;
            }
         }
    };
};

class at_commander_dawnforge : public AreaTriggerScript
{
public:
    at_commander_dawnforge() : AreaTriggerScript("at_commander_dawnforge") { }

    bool OnTrigger(Player* player, const AreaTrigger* /*at*/)
    {
        //if player lost aura or not have at all, we should not try start event.
        if (!player->HasAura(SPELL_SUNFURY_DISGUISE))
            return false;

        if (player->IsAlive() && player->GetQuestStatus(QUEST_INFO_GATHERING) == QUEST_STATUS_INCOMPLETE)
        {
            Creature* Dawnforge = player->FindNearestCreature(CreatureEntry[1], 30.0f);
            if (!Dawnforge)
                return false;

            if (CAST_AI(npc_commander_dawnforge::npc_commander_dawnforgeAI, Dawnforge->AI())->CanStartEvent(player))
                return true;
        }
        return false;
    }
};

/*######
## npc_phase_hunter
######*/

enum PhaseHunterData
{
    QUEST_RECHARGING_THE_BATTERIES  = 10190,

    NPC_PHASE_HUNTER_ENTRY          = 18879,
    NPC_DRAINED_PHASE_HUNTER_ENTRY  = 19595,

    EMOTE_WEAK                      = 0,

    // Spells
    SPELL_RECHARGING_BATTERY        = 34219,
    SPELL_PHASE_SLIP                = 36574,
    SPELL_MANA_BURN                 = 13321,
    SPELL_MATERIALIZE               = 34804,
    SPELL_DE_MATERIALIZE            = 34814,
};

class npc_phase_hunter : public CreatureScript
{
public:
    npc_phase_hunter() : CreatureScript("npc_phase_hunter") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_phase_hunterAI(creature);
    }

    struct npc_phase_hunterAI : public ScriptedAI
    {
        npc_phase_hunterAI(Creature* creature) : ScriptedAI(creature) { }

        bool Weak;
        bool Materialize;
        bool Drain;
        bool Drained;
        uint8 WeakPercent;

        uint64 PlayerGUID;

        uint32 ManaBurnTimer;

        void Reset()
        {
            Weak = false;
            Materialize = false;
            Drain = false;
            Drained = false;
            WeakPercent = 25 + (rand() % 16); // 25-40

            PlayerGUID = 0;

            ManaBurnTimer = 5000 + (rand() % 3 * 1000); // 5-8 sec cd

            if (me->GetEntry() == NPC_DRAINED_PHASE_HUNTER_ENTRY)
                me->UpdateEntry(NPC_PHASE_HUNTER_ENTRY);
        }

        void EnterCombat(Unit* who)
        {
            if (who->GetTypeId() == TYPEID_PLAYER)
                PlayerGUID = who->GetGUID();
        }

        //void SpellHit(Unit* /*caster*/, const SpellInfo* /*spell*/)
        //{
        //    DoCast(me, SPELL_DE_MATERIALIZE);
        //}

        void UpdateAI(uint32 diff)
        {
            if (!Materialize)
            {
                DoCast(me, SPELL_MATERIALIZE);
                Materialize = true;
            }

            if (me->HasAuraType(SPELL_AURA_MOD_DECREASE_SPEED) || me->HasUnitState(UNIT_STATE_ROOT)) // if the mob is rooted/slowed by spells eg.: Entangling Roots, Frost Nova, Hamstring, Crippling Poison, etc. => remove it
                DoCast(me, SPELL_PHASE_SLIP);

            if (!UpdateVictim())
                return;

            // some code to cast spell Mana Burn on random target which has mana
            if (ManaBurnTimer <= diff)
            {
                std::list<HostileReference*> AggroList = me->getThreatManager().getThreatList();
                std::list<Unit*> UnitsWithMana;

                for (std::list<HostileReference*>::const_iterator itr = AggroList.begin(); itr != AggroList.end(); ++itr)
                {
                    if (Unit* unit = ObjectAccessor::GetUnit(*me, (*itr)->getUnitGuid()))
                    {
                        if (unit->GetCreateMana() > 0)
                            UnitsWithMana.push_back(unit);
                    }
                }
                if (!UnitsWithMana.empty())
                {
                    DoCast(acore::Containers::SelectRandomContainerElement(UnitsWithMana), SPELL_MANA_BURN);
                    ManaBurnTimer = 8000 + (rand() % 10 * 1000); // 8-18 sec cd
                }
                else
                    ManaBurnTimer = 3500;
            } else ManaBurnTimer -= diff;

            if (Player* player = ObjectAccessor::GetPlayer(*me, PlayerGUID)) // start: support for quest 10190
            {
                if (!Weak)
                {
                    if (HealthBelowPct(WeakPercent) && player->GetQuestStatus(QUEST_RECHARGING_THE_BATTERIES) == QUEST_STATUS_INCOMPLETE)
                    {
                        Weak = true;
                        Talk(EMOTE_WEAK);
                    }
                }
                else if (!Drain)
                {
                    if (!Drained && me->HasAura(SPELL_RECHARGING_BATTERY))
                        Drain = true;
                }
                else if (!Drained)
                {
                    if (!me->HasAura(SPELL_RECHARGING_BATTERY))
                    {
                        Drained = true;
                        int32 uHpPct = int32(me->GetHealthPct());

                        if (uHpPct > 0)
                        {
                            me->UpdateEntry(NPC_DRAINED_PHASE_HUNTER_ENTRY);
                            me->SetHealth(me->CountPctFromMaxHealth(uHpPct));
                            me->LowerPlayerDamageReq(me->GetMaxHealth() - me->GetHealth());
                            me->SetInCombatWith(player);
                        }
                    }
                }
            } // end: support for quest 10190

            DoMeleeAttackIfReady();
        }
    };
};

/*######
## npc_bessy
######*/
enum BessyData
{
    QUEST_WHEN_THE_COWS_COME_HOME = 10337,
    NPC_THADELL                   = 20464,
    SPAWN_FIRST                   = 20512,
    SPAWN_SECOND                  = 19881,
    SAY_THADELL_0                 =     0,
    SAY_BESSY_0                   =     0,
    SAY_BESSY_1                   =     1
};

class npc_bessy : public CreatureScript
{
public:
    npc_bessy() : CreatureScript("npc_bessy") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_WHEN_THE_COWS_COME_HOME)
        {
            creature->setFaction(113);
            creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            creature->AI()->Talk(SAY_BESSY_0);
            CAST_AI(npc_escortAI, (creature->AI()))->Start(true, false, player->GetGUID());
        }
        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_bessyAI(creature);
    }

    struct npc_bessyAI : public npc_escortAI
    {
        npc_bessyAI(Creature* creature) : npc_escortAI(creature) { }

        void JustDied(Unit* /*killer*/) override
        {
            if (Player* player = GetPlayerForEscort())
                player->FailQuest(QUEST_WHEN_THE_COWS_COME_HOME);
        }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);

            if (UpdateVictim())
                me->SetControlled(true, UNIT_STATE_ROOT);
            else
                me->SetControlled(false, UNIT_STATE_ROOT);
        }

        void WaypointReached(uint32 waypointId) override
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 3: //first spawn
                    Talk(SAY_BESSY_1);
                    me->SummonCreature(SPAWN_FIRST, 2449.67f, 2183.11f, 96.85f, 6.20f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(SPAWN_FIRST, 2449.53f, 2184.43f, 96.36f, 6.27f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(SPAWN_FIRST, 2449.85f, 2186.34f, 97.57f, 6.08f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    break;
                case 7:
                    Talk(SAY_BESSY_1);
                    me->SummonCreature(SPAWN_SECOND, 2309.64f, 2186.24f, 92.25f, 6.06f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    me->SummonCreature(SPAWN_SECOND, 2309.25f, 2183.46f, 91.75f, 6.22f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 25000);
                    break;
                case 12:
                    player->GroupEventHappens(QUEST_WHEN_THE_COWS_COME_HOME, me);
                    break;
                case 13:
                    if (Creature* thadell = me->FindNearestCreature(NPC_THADELL, 30))
                        thadell->AI()->Talk(SAY_THADELL_0);
                    break;
            }
        }

        void JustSummoned(Creature* summoned) override
        {
            summoned->AI()->AttackStart(me);
        }

        void Reset()
        {
            me->RestoreFaction();
        }
    };
};

/*######
## npc_maxx_a_million
######*/

enum MaxxAMillion
{
    QUEST_MARK_V_IS_ALIVE   = 10191,
    GO_DRAENEI_MACHINE      = 183771
};

class npc_maxx_a_million_escort : public CreatureScript
{
public:
    npc_maxx_a_million_escort() : CreatureScript("npc_maxx_a_million_escort") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_maxx_a_million_escortAI(creature);
    }

    struct npc_maxx_a_million_escortAI : public npc_escortAI
    {
        npc_maxx_a_million_escortAI(Creature* creature) : npc_escortAI(creature) { }

        bool bTake;
        uint32 uiTakeTimer;

        void Reset()
        {
            bTake=false;
            uiTakeTimer=3000;
        }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 7:
                case 17:
                case 29:
                    //Find Object and "work"
                    if (GetClosestGameObjectWithEntry(me, GO_DRAENEI_MACHINE, INTERACTION_DISTANCE))
                    {
                        // take the GO -> animation
                        me->HandleEmoteCommand(EMOTE_STATE_LOOT);
                        SetEscortPaused(true);
                        bTake=true;
                    }
                    break;
                case 36: //return and quest_complete
                    player->CompleteQuest(QUEST_MARK_V_IS_ALIVE);
                    break;
            }
        }

        void JustDied(Unit* /*killer*/)
        {
            if (Player* player = GetPlayerForEscort())
                player->FailQuest(QUEST_MARK_V_IS_ALIVE);
        }

        void UpdateAI(uint32 uiDiff)
        {
            npc_escortAI::UpdateAI(uiDiff);

            if (bTake)
            {
                if (uiTakeTimer < uiDiff)
                {
                    me->HandleEmoteCommand(EMOTE_STATE_NONE);
                    if (GameObject* go = GetClosestGameObjectWithEntry(me, GO_DRAENEI_MACHINE, INTERACTION_DISTANCE))
                    {
                        SetEscortPaused(false);
                        bTake=false;
                        uiTakeTimer = 3000;
                        go->Delete();
                    }
                }
                else
                    uiTakeTimer -= uiDiff;
            }
            DoMeleeAttackIfReady();
        }
    };

    bool OnQuestAccept(Player* player, Creature* creature, const Quest* quest)
    {
        if (quest->GetQuestId() == QUEST_MARK_V_IS_ALIVE)
        {
            if (npc_maxx_a_million_escortAI* pEscortAI = CAST_AI(npc_maxx_a_million_escort::npc_maxx_a_million_escortAI, creature->AI()))
            {
                creature->setFaction(113);
                pEscortAI->Start(false, false, player->GetGUID());
            }
        }
        return true;
    }
};

void AddSC_netherstorm()
{
    // Ours
    new npc_captain_saeed();

    // Theirs
    new npc_commander_dawnforge();
    new at_commander_dawnforge();
    new npc_phase_hunter();
    new npc_bessy();
    new npc_maxx_a_million_escort();
}
