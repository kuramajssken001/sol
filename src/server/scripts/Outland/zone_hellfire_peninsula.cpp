/*
 * Copyright (C) 2020+     Project "Sol" <https://gitlab.com/opfesoft/sol>, released under the GNU GPLv2 license: https://gitlab.com/opfesoft/sol/-/blob/master/deps/gpl-2.0.md; you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2016-2020 AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Hellfire_Peninsula
SD%Complete: 100
SDComment: Quest support: 9375, 9410, 9418, 10129, 10146, 10162, 10163, 10340, 10346, 10347, 10382 (Special flight paths) "Needs update"
SDCategory: Hellfire Peninsula
EndScriptData */

/* ContentData
npc_aeranas
npc_wounded_blood_elf
EndContentData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptedEscortAI.h"
#include "Player.h"
#include "WorldSession.h"
#include "SpellScript.h"

// Ours

class spell_q10935_the_exorcism_of_colonel_jules : public SpellScriptLoader
{
    public:
        spell_q10935_the_exorcism_of_colonel_jules() : SpellScriptLoader("spell_q10935_the_exorcism_of_colonel_jules") { }

        class spell_q10935_the_exorcism_of_colonel_jules_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_q10935_the_exorcism_of_colonel_jules_SpellScript);

            void HandleDummy(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                Creature* target = GetHitCreature();
                if (!target)
                    return;

                if (GetCaster()->IsHostileTo(target))
                    GetCaster()->CastSpell(target, 39323 /*SPELL_HOLY_FIRE*/, true);
                else
                    GetCaster()->CastSpell(target, 39322 /*SPELL_HEAL_BARADA*/, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_q10935_the_exorcism_of_colonel_jules_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_q10935_the_exorcism_of_colonel_jules_SpellScript();
        }
};


// Theirs
/*######
## npc_aeranas
######*/

enum Aeranas
{
    SAY_SUMMON                  = 0,
    SAY_FREE                    = 1,
    FACTION_HOSTILE             = 16,
    FACTION_FRIENDLY            = 35,
    SPELL_ENVELOPING_WINDS      = 15535,
    SPELL_SHOCK                 = 12553
};

class npc_aeranas : public CreatureScript
{
public:
    npc_aeranas() : CreatureScript("npc_aeranas") { }

    struct npc_aeranasAI : public ScriptedAI
    {
        npc_aeranasAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset()
        {
            faction_Timer = 8000;
            envelopingWinds_Timer = 9000;
            shock_Timer = 5000;

            me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
            me->setFaction(FACTION_FRIENDLY);

            Talk(SAY_SUMMON);
        }

        void UpdateAI(uint32 diff)
        {
            if (faction_Timer)
            {
                if (faction_Timer <= diff)
                {
                    me->setFaction(FACTION_HOSTILE);
                    faction_Timer = 0;
                } else faction_Timer -= diff;
            }

            if (!UpdateVictim())
                return;

            if (HealthBelowPct(30))
            {
                me->setFaction(FACTION_FRIENDLY);
                me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                me->RemoveAllAuras();
                me->DeleteThreatList();
                me->CombatStop(true);
                Talk(SAY_FREE);
                return;
            }

            if (shock_Timer <= diff)
            {
                DoCastVictim(SPELL_SHOCK);
                shock_Timer = 10000;
            } else shock_Timer -= diff;

            if (envelopingWinds_Timer <= diff)
            {
                DoCastVictim(SPELL_ENVELOPING_WINDS);
                envelopingWinds_Timer = 25000;
            } else envelopingWinds_Timer -= diff;

            DoMeleeAttackIfReady();
        }

    private:
        uint32 faction_Timer;
        uint32 envelopingWinds_Timer;
        uint32 shock_Timer;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_aeranasAI(creature);
    }
};

/*######
## npc_wounded_blood_elf
######*/

enum WoundedBloodElf
{
    SAY_ELF_START               = 0,
    SAY_ELF_SUMMON1             = 1,
    SAY_ELF_RESTING             = 2,
    SAY_ELF_SUMMON2             = 3,
    SAY_ELF_COMPLETE            = 4,
    SAY_ELF_AGGRO               = 5,
    QUEST_ROAD_TO_FALCON_WATCH  = 9375,
    NPC_HAALESHI_WINDWALKER     = 16966,
    NPC_HAALESHI_TALONGUARD     = 16967,
    NPC_TALERIS                 = 17015,
    FACTION_FALCON_WATCH_QUEST  = 775,
    ARAKKOA_CAGE                = 181664,
};

class npc_wounded_blood_elf : public CreatureScript
{
public:
    npc_wounded_blood_elf() : CreatureScript("npc_wounded_blood_elf") { }

    struct npc_wounded_blood_elfAI : public npc_escortAI
    {
        npc_wounded_blood_elfAI(Creature* creature) : npc_escortAI(creature) { }

        void Reset()
        {
            me->SetStandState(UNIT_STAND_STATE_STAND);
            if (GameObject* go = me->FindNearestGameObject(ARAKKOA_CAGE, 10.0f))
                go->SetGoState(GO_STATE_READY);
        }

        void EnterCombat(Unit* /*who*/)
        {
            if (HasEscortState(STATE_ESCORT_ESCORTING) && roll_chance_i(10))
                Talk(SAY_ELF_AGGRO);
        }

        void JustSummoned(Creature* summoned)
        {
            summoned->AI()->AttackStart(me);
        }

        void sQuestAccept(Player* player, Quest const* quest)
        {
            if (quest->GetQuestId() == QUEST_ROAD_TO_FALCON_WATCH)
            {
                me->setActive(true);
                npc_escortAI::Start(true, false, player->GetGUID(), quest);
            }
        }

        void WaypointReached(uint32 waypointId)
        {
            Player* player = GetPlayerForEscort();
            if (!player)
                return;

            switch (waypointId)
            {
                case 1:
                    Talk(SAY_ELF_START, player);
                    if (GameObject* go = me->FindNearestGameObject(ARAKKOA_CAGE, 10.0f))
                        go->SetGoState(GO_STATE_ACTIVE);
                    break;
                case 2:
                    me->setFaction(FACTION_FALCON_WATCH_QUEST);
                    break;
                case 40:
                    Talk(SAY_ELF_SUMMON1, player);
                    me->SetFacingTo(4.16746f);
                    me->SetOrientation(4.16746f);
                    break;
                case 41:
                    // Spawn two Haal'eshi Talonguard
                    DoSpawnCreature(NPC_HAALESHI_TALONGUARD, -15, -15, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    DoSpawnCreature(NPC_HAALESHI_TALONGUARD, -17, -17, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                case 59:
                    Talk(SAY_ELF_RESTING, player);
                    me->SetStandState(UNIT_STAND_STATE_KNEEL);
                    me->SetReactState(REACT_PASSIVE);
                    break;
                case 60:
                    me->SetStandState(UNIT_STAND_STATE_STAND);
                    me->SetReactState(REACT_AGGRESSIVE);
                    break;
                case 62:
                    Talk(SAY_ELF_SUMMON2, player);
                    break;
                case 63:
                    // Spawn two Haal'eshi Windwalker
                    DoSpawnCreature(NPC_HAALESHI_WINDWALKER, -15, -15, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    DoSpawnCreature(NPC_HAALESHI_WINDWALKER, -17, -17, 0, 0, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 5000);
                    break;
                case 102:
                    if (Creature* taleris = GetClosestCreatureWithEntry(me, NPC_TALERIS, 1.f))
                        taleris->AI()->SetData(1, 1);
                    Talk(SAY_ELF_COMPLETE, player);
                    me->SetStandState(UNIT_STAND_STATE_SLEEP);
                    // Award quest credit
                    player->GroupEventHappens(QUEST_ROAD_TO_FALCON_WATCH, me);
                    break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_wounded_blood_elfAI(creature);
    }
};

void AddSC_hellfire_peninsula()
{
    // Ours
    new spell_q10935_the_exorcism_of_colonel_jules();

    // Theirs
    new npc_aeranas();
    new npc_wounded_blood_elf();
}
