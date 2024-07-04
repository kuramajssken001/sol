/*
 * Copyright (C) 2020+     Project "Sol" <https://gitlab.com/opfesoft/sol>, released under the GNU GPLv2 license: https://gitlab.com/opfesoft/sol/-/blob/master/deps/gpl-2.0.md; you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2016-2020 AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Creature.h"
#include "CreatureAISelector.h"
#include "PassiveAI.h"

#include "MovementGenerator.h"
#include "Pet.h"
#include "TemporarySummon.h"
#include "CreatureAIFactory.h"
#include "ScriptMgr.h"
#include "SmartAI.h"

namespace FactorySelector
{
    CreatureAI* selectAI(Creature* creature)
    {
        const CreatureAICreator* ai_factory = NULL;
        CreatureAIRegistry& ai_registry(*CreatureAIRepository::instance());
        std::string ainame = creature->GetAIName();
        std::string scriptname = creature->GetScriptName();
        CreatureAI* scriptedAI = sScriptMgr->GetCreatureAI(creature);
        if (!ainame.empty() && !scriptname.empty())
            if ((ainame == "SmartAI" && (!scriptedAI || (scriptedAI && !dynamic_cast<SmartAI*>(scriptedAI)))) || (ainame != "SmartAI" && scriptedAI))
                sLog->outError("creature %u (entry %u) uses %s but overrides AI via script %s", creature->GetGUIDLow(), creature->GetEntry(), ainame.c_str(), scriptname.c_str());

        // xinef: if we have controlable guardian, define petai for players as they can steer him, otherwise db / normal ai
        // xinef: dont remember why i changed this qq commented out as may break some quests
        if (creature->IsPet()/* || (creature->HasUnitTypeMask(UNIT_MASK_CONTROLABLE_GUARDIAN) && ((Guardian*)creature)->GetOwner()->GetTypeId() == TYPEID_PLAYER)*/)
            ai_factory = ai_registry.GetRegistryItem("PetAI");

        //scriptname in db
        if (!ai_factory)
        {
            if (scriptedAI)
                return scriptedAI;
        }
        else if (scriptedAI)
            delete scriptedAI;

        // AIname in db
        if (!ai_factory && !ainame.empty())
            ai_factory = ai_registry.GetRegistryItem(ainame);

        // select by NPC flags
        if (!ai_factory)
        {
            if (creature->IsVehicle())
                ai_factory = ai_registry.GetRegistryItem("VehicleAI");
            else if (creature->HasUnitTypeMask(UNIT_MASK_CONTROLABLE_GUARDIAN) && ((Guardian*)creature)->GetOwner()->GetTypeId() == TYPEID_PLAYER)
                ai_factory = ai_registry.GetRegistryItem("PetAI");
            else if (creature->HasFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK))
                ai_factory = ai_registry.GetRegistryItem("NullCreatureAI");
            else if (creature->IsGuard())
                ai_factory = ai_registry.GetRegistryItem("GuardAI");
            else if (creature->HasUnitTypeMask(UNIT_MASK_CONTROLABLE_GUARDIAN))
                ai_factory = ai_registry.GetRegistryItem("PetAI");
            else if (creature->IsTotem())
                ai_factory = ai_registry.GetRegistryItem("TotemAI");
            else if (creature->IsTrigger())
            {
                if (creature->m_spells[0])
                    ai_factory = ai_registry.GetRegistryItem("TriggerAI");
                else
                    ai_factory = ai_registry.GetRegistryItem("NullCreatureAI");
            }
            else if (creature->IsCritter() && !creature->HasUnitTypeMask(UNIT_MASK_GUARDIAN))
                ai_factory = ai_registry.GetRegistryItem("CritterAI");
        }

        // select by permit check
        if (!ai_factory)
        {
            int best_val = -1;
            typedef CreatureAIRegistry::RegistryMapType RMT;
            RMT const& l = ai_registry.GetRegisteredItems();
            for (RMT::const_iterator iter = l.begin(); iter != l.end(); ++iter)
            {
                const CreatureAICreator* factory = iter->second;
                const SelectableAI* p = dynamic_cast<const SelectableAI*>(factory);
                ASSERT(p);
                int val = p->Permit(creature);
                if (val > best_val)
                {
                    best_val = val;
                    ai_factory = p;
                }
            }
        }

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        // select NullCreatureAI if not another cases
        ainame = (ai_factory == NULL) ? "NullCreatureAI" : ai_factory->key();
        sLog->outDebug(LOG_FILTER_TSCR, "Creature %u used AI is %s.", creature->GetGUIDLow(), ainame.c_str());
#endif
        return (ai_factory == NULL ? new NullCreatureAI(creature) : ai_factory->Create(creature));
    }

    MovementGenerator* selectMovementGenerator(Creature* creature)
    {
        MovementGeneratorRegistry& mv_registry(*MovementGeneratorRepository::instance());
        ASSERT(creature->GetCreatureTemplate());
        const MovementGeneratorCreator* mv_factory = mv_registry.GetRegistryItem(creature->GetDefaultMovementType());

        /* if (mv_factory == NULL)
        {
            int best_val = -1;
            StringVector l;
            mv_registry.GetRegisteredItems(l);
            for (StringVector::iterator iter = l.begin(); iter != l.end(); ++iter)
            {
            const MovementGeneratorCreator *factory = mv_registry.GetRegistryItem((*iter).c_str());
            const SelectableMovement *p = dynamic_cast<const SelectableMovement *>(factory);
            ASSERT(p != NULL);
            int val = p->Permit(creature);
            if (val > best_val)
            {
                best_val = val;
                mv_factory = p;
            }
            }
        }*/

        return (mv_factory == NULL ? NULL : mv_factory->Create(creature));

    }

    GameObjectAI* SelectGameObjectAI(GameObject* go)
    {
        const GameObjectAICreator* ai_factory = NULL;
        GameObjectAIRegistry& ai_registry(*GameObjectAIRepository::instance());
        std::string ainame = go->GetAIName();
        std::string scriptname = go->GetScriptName();
        GameObjectAI* scriptedAI = sScriptMgr->GetGameObjectAI(go);
        if (!ainame.empty() && !scriptname.empty())
            if ((ainame == "SmartGameObjectAI" && (!scriptedAI || (scriptedAI && !dynamic_cast<SmartGameObjectAI*>(scriptedAI)))) || (ainame != "SmartGameObjectAI" && scriptedAI))
                sLog->outError("gameobject %u (entry %u) uses %s but overrides AI via script %s", go->GetGUIDLow(), go->GetEntry(), ainame.c_str(), scriptname.c_str());

        if (scriptedAI)
            return scriptedAI;

        ai_factory = ai_registry.GetRegistryItem(ainame);

        //future goAI types go here

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        ainame = (ai_factory == NULL || go->GetScriptId()) ? "NullGameObjectAI" : ai_factory->key();
        sLog->outDebug(LOG_FILTER_TSCR, "GameObject %u used AI is %s.", go->GetGUIDLow(), ainame.c_str());
#endif

        return (ai_factory == NULL ? new NullGameObjectAI(go) : ai_factory->Create(go));
    }
}

