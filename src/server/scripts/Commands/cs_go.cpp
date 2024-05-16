/*
 * Copyright (C) 2020+     Project "Sol" <https://gitlab.com/opfesoft/sol>, released under the GNU GPLv2 license: https://gitlab.com/opfesoft/sol/-/blob/master/deps/gpl-2.0.md; you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2016-2020 AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
Name: go_commandscript
%Complete: 100
Comment: All go related commands
Category: commandscripts
EndScriptData */

#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "MapManager.h"
#include "TicketMgr.h"
#include "Chat.h"
#include "Language.h"
#include "Player.h"
#include "GameGraveyard.h"

class go_commandscript : public CommandScript
{
public:
    go_commandscript() : CommandScript("go_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> goCommandTable =
        {
            { "creature",       SEC_MODERATOR,      false, &HandleGoCreatureCommand,          "" },
            { "graveyard",      SEC_MODERATOR,      false, &HandleGoGraveyardCommand,         "" },
            { "grid",           SEC_MODERATOR,      false, &HandleGoGridCommand,              "" },
            { "object",         SEC_MODERATOR,      false, &HandleGoObjectCommand,            "" },
            { "gobject",        SEC_MODERATOR,      false, &HandleGoObjectCommand,            "" },
            { "taxinode",       SEC_MODERATOR,      false, &HandleGoTaxinodeCommand,          "" },
            { "trigger",        SEC_MODERATOR,      false, &HandleGoTriggerCommand,           "" },
            { "zonexy",         SEC_MODERATOR,      false, &HandleGoZoneXYCommand,            "" },
            { "xyz",            SEC_MODERATOR,      false, &HandleGoXYZCommand,               "" },
            { "ticket",         SEC_GAMEMASTER,     false, &HandleGoTicketCommand,            "" },
            { "",               SEC_MODERATOR,      false, &HandleGoXYZCommand,               "" }
        };

        static std::vector<ChatCommand> commandTable =
        {
            { "go",             SEC_MODERATOR,      false, nullptr,                     "", goCommandTable }
        };
        return commandTable;
    }

    /** \brief Teleport the GM to the specified creature
    *
    * .go creature [db]                 --> TP to the selected creature (db: force DB position)
    * .go creature [db] <GUID>          --> TP using creature.guid (db: force DB position)
    * .go creature [db] azuregos        --> TP player to the mob with this name (db: force DB position;
    *                                       replace blanks in the name with underscore)
    *                                       Warning: If there is more than one mob with this name
    *                                       you will be teleported to the first one that is found.
    * .go creature id 6109              --> TP player to the mob, that has this creature_template.entry
    *                                       Warning: If there is more than one mob with this "id"
    *                                       you will be teleported to the first one that is found.
    * .go creature [ignore_orientation] --> TP player to the selected mob; if "ignore_orientation" is
    *                                       specified, don't adjust the player's orientation
    */
    //teleport to creature
    static bool HandleGoCreatureCommand(ChatHandler* handler, char const* args)
    {
        float x = 0.f, y = 0.f, z = 0.f, ort = 0.f;
        int mapId = 0;
        bool ignoreOrientation = false;
        bool useDB = false;
        bool useID = false;
        bool argsFound = false;
        char* param1;
        Player* player = handler->GetSession()->GetPlayer();

        if (*args)
        {
            // "id" or "ignore_orientation" or number or [name] Shift-click form |color|Hcreature_entry:creature_id|h[name]|h|r
            param1 = handler->extractKeyFromLink((char*)args, "Hcreature");
            if (!param1)
                return false;

            if (strcmp(param1, "ignore_orientation") == 0)
                ignoreOrientation = true;
            else
                argsFound = true;
        }

        if (argsFound)
        {
            std::ostringstream whereClause;

            // User wants to teleport to the NPC's template entry
            if (strcmp(param1, "id") == 0)
            {
                useID = true;

                // Get the "creature_template.entry"
                // number or [name] Shift-click form |color|Hcreature_entry:creature_id|h[name]|h|r
                char* tail = strtok(nullptr, "");
                if (!tail)
                    return false;
                char* id = handler->extractKeyFromLink(tail, "Hcreature_entry");
                if (!id)
                    return false;

                int32 entry = atoi(id);
                if (!entry)
                    return false;

                whereClause << "WHERE id = '" << entry << '\'';
            }
            else if (strcmp(param1, "db") == 0)
            {
                useDB = true;
                param1 = strtok(nullptr, "");
            }

            if (!useID)
            {
                int32 guid = 0;

                if (!param1)
                {
                    if (Unit* unit = handler->getSelectedUnit())
                        if (Creature* creature = unit->ToCreature())
                            guid = creature->GetDBTableGUIDLow();
                }
                else
                    guid = atoi(param1);

                // Number is invalid - maybe the user specified the mob's name
                if (!guid)
                {
                    if (!param1)
                    {
                        handler->SendSysMessage(LANG_COMMAND_GOCREATNOTFOUND);
                        handler->SetSentErrorMessage(true);
                        return false;
                    }

                    std::string name = param1;
                    WorldDatabase.EscapeString(name);
                    whereClause << ", creature_template WHERE creature.id = creature_template.entry AND creature_template.name " _LIKE_ " '" << name << '\'';
                }
                else
                    whereClause <<  "WHERE guid = '" << guid << '\'';
            }

            QueryResult result = WorldDatabase.PQuery("SELECT position_x, position_y, position_z, orientation, map, guid, id FROM creature %s", whereClause.str().c_str());
            if (!result)
            {
                handler->SendSysMessage(LANG_COMMAND_GOCREATNOTFOUND);
                handler->SetSentErrorMessage(true);
                return false;
            }
            if (result->GetRowCount() > 1)
                handler->SendSysMessage(LANG_COMMAND_GOCREATMULTIPLE);

            Field* fields = result->Fetch();
            x = fields[0].GetFloat();
            y = fields[1].GetFloat();
            z = fields[2].GetFloat();
            ort = fields[3].GetFloat();
            mapId = fields[4].GetUInt16();
            uint32 guid = fields[5].GetUInt32();
            uint32 id = fields[6].GetUInt32();

            // if creature is in same map with caster go at its current location
            if (Creature* creature = ObjectAccessor::GetCreature(*player, MAKE_NEW_GUID(guid, id, HIGHGUID_UNIT)); creature && !useDB)
            {
                x = creature->GetPositionX();
                y = creature->GetPositionY();
                z = creature->GetPositionZ();
                ort = creature->GetOrientation();
            }
        }
        else if (Unit* unit = handler->getSelectedUnit())
        {
            if (unit->ToCreature())
            {
                x = unit->GetPositionX();
                y = unit->GetPositionY();
                z = unit->GetPositionZ();
                ort = ignoreOrientation ? player->GetOrientation() : unit->GetOrientation();
                mapId = unit->GetMapId();
            }
            else
                return false;
        }
        else
            return false;

        if (!MapManager::IsValidMapCoord(mapId, x, y, z, ort))
        {
            handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, x, y, mapId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        player->TeleportTo(mapId, x, y, z, ort);
        return true;
    }

    static bool HandleGoGraveyardCommand(ChatHandler* handler, char const* args)
    {
        Player* player = handler->GetSession()->GetPlayer();

        if (!*args)
            return false;

        char* gyId = strtok((char*)args, " ");
        if (!gyId)
            return false;

        int32 graveyardId = atoi(gyId);

        if (!graveyardId)
            return false;

        GraveyardStruct const* gy = sGraveyard->GetGraveyard(graveyardId);
        if (!gy)
        {
            handler->PSendSysMessage(LANG_COMMAND_GRAVEYARDNOEXIST, graveyardId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!MapManager::IsValidMapCoord(gy->Map, gy->x, gy->y, gy->z))
        {
            handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, gy->x, gy->y, gy->Map);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        player->TeleportTo(gy->Map, gy->x, gy->y, gy->z, player->GetOrientation());
        return true;
    }

    //teleport to grid
    static bool HandleGoGridCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* player = handler->GetSession()->GetPlayer();

        char* gridX = strtok((char*)args, " ");
        char* gridY = strtok(nullptr, " ");
        char* id = strtok(nullptr, " ");

        if (!gridX || !gridY)
            return false;

        uint32 mapId = id ? (uint32)atoi(id) : player->GetMapId();

        // center of grid
        float x = ((float)atof(gridX) - CENTER_GRID_ID + 0.5f) * SIZE_OF_GRIDS;
        float y = ((float)atof(gridY) - CENTER_GRID_ID + 0.5f) * SIZE_OF_GRIDS;

        if (!MapManager::IsValidMapCoord(mapId, x, y))
        {
            handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, x, y, mapId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        Map const* map = sMapMgr->CreateBaseMap(mapId);
        float z = std::max(map->GetHeight(x, y, MAX_HEIGHT), map->GetWaterLevel(x, y));

        player->TeleportTo(mapId, x, y, z, player->GetOrientation());
        return true;
    }

    //teleport to gameobject
    static bool HandleGoObjectCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* player = handler->GetSession()->GetPlayer();

        // number or [name] Shift-click form |color|Hgameobject:go_guid|h[name]|h|r
        char* param1 = handler->extractKeyFromLink((char*)args, "Hgameobject");
        if (!param1)
            return false;

        int32 guid = 0;

        if (strcmp(param1, "id") == 0)
        {
            char* tail = strtok(nullptr, "");
            if (!tail)
                return false;
            char* id = handler->extractKeyFromLink(tail, "Hgameobject_entry");
            if (!id)
                return false;

            int32 entry = atoi(id);
            if (!entry)
                return false;

            QueryResult result = WorldDatabase.PQuery("SELECT guid FROM gameobject WHERE id = %i", entry);
            if (!result)
            {
                handler->SendSysMessage(LANG_COMMAND_GOOBJNOTFOUND);
                handler->SetSentErrorMessage(true);
                return false;
            }
            if (result->GetRowCount() > 1)
                handler->SendSysMessage(LANG_COMMAND_GOOBJECTMULTIPLE);

            Field* fields = result->Fetch();
            guid = fields[0].GetUInt32();
        }
        else
            guid = atoi(param1);

        if (!guid)
            return false;

        float x, y, z, ort;
        int mapId;

        // by DB guid
        if (GameObjectData const* goData = sObjectMgr->GetGOData(guid))
        {
            x = goData->posX;
            y = goData->posY;
            z = goData->posZ;
            ort = goData->orientation;
            mapId = goData->mapid;
        }
        else
        {
            handler->SendSysMessage(LANG_COMMAND_GOOBJNOTFOUND);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!MapManager::IsValidMapCoord(mapId, x, y, z, ort))
        {
            handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, x, y, mapId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        player->TeleportTo(mapId, x, y, z, ort);
        return true;
    }

    static bool HandleGoTaxinodeCommand(ChatHandler* handler, char const* args)
    {
        Player* player = handler->GetSession()->GetPlayer();

        if (!*args)
            return false;

        char* id = handler->extractKeyFromLink((char*)args, "Htaxinode");
        if (!id)
            return false;

        int32 nodeId = atoi(id);
        if (!nodeId)
            return false;

        TaxiNodesEntry const* node = sTaxiNodesStore.LookupEntry(nodeId);
        if (!node)
        {
            handler->PSendSysMessage(LANG_COMMAND_GOTAXINODENOTFOUND, nodeId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if ((node->x == 0.0f && node->y == 0.0f && node->z == 0.0f) ||
            !MapManager::IsValidMapCoord(node->map_id, node->x, node->y, node->z))
        {
            handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, node->x, node->y, node->map_id);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        player->TeleportTo(node->map_id, node->x, node->y, node->z, player->GetOrientation());
        return true;
    }

    static bool HandleGoTriggerCommand(ChatHandler* handler, char const* args)
    {
        Player* player = handler->GetSession()->GetPlayer();

        if (!*args)
            return false;

        char* id = strtok((char*)args, " ");
        if (!id)
            return false;

        int32 areaTriggerId = atoi(id);

        if (!areaTriggerId)
            return false;

        AreaTrigger const* at = sObjectMgr->GetAreaTrigger(areaTriggerId);
        if (!at)
        {
            handler->PSendSysMessage(LANG_COMMAND_GOAREATRNOTFOUND, areaTriggerId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (!MapManager::IsValidMapCoord(at->map, at->x, at->y, at->z))
        {
            handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, at->x, at->y, at->map);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        player->TeleportTo(at->map, at->x, at->y, at->z, player->GetOrientation());
        return true;
    }

    //teleport at coordinates
    static bool HandleGoZoneXYCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player* player = handler->GetSession()->GetPlayer();

        char* zoneX = strtok((char*)args, " ");
        char* zoneY = strtok(nullptr, " ");
        char* tail = strtok(nullptr, "");

        char* id = handler->extractKeyFromLink(tail, "Harea");       // string or [name] Shift-click form |color|Harea:area_id|h[name]|h|r

        if (!zoneX || !zoneY)
            return false;

        float x = (float)atof(zoneX);
        float y = (float)atof(zoneY);

        // prevent accept wrong numeric args
        if ((x == 0.0f && *zoneX != '0') || (y == 0.0f && *zoneY != '0'))
            return false;

        uint32 areaId = id ? (uint32)atoi(id) : player->GetZoneId();

        AreaTableEntry const* areaEntry = sAreaTableStore.LookupEntry(areaId);

        if (x < 0 || x > 100 || y < 0 || y > 100 || !areaEntry)
        {
            handler->PSendSysMessage(LANG_INVALID_ZONE_COORD, x, y, areaId);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // update to parent zone if exist (client map show only zones without parents)
        AreaTableEntry const* zoneEntry = areaEntry->zone ? sAreaTableStore.LookupEntry(areaEntry->zone) : areaEntry;

        Map const* map = sMapMgr->CreateBaseMap(zoneEntry->mapid);

        if (map->Instanceable())
        {
            handler->PSendSysMessage(LANG_INVALID_ZONE_MAP, areaEntry->ID, areaEntry->area_name[handler->GetSessionDbcLocale()], map->GetId(), map->GetMapName());
            handler->SetSentErrorMessage(true);
            return false;
        }

        Zone2MapCoordinates(x, y, zoneEntry->ID);

        if (!MapManager::IsValidMapCoord(zoneEntry->mapid, x, y))
        {
            handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, x, y, zoneEntry->mapid);
            handler->SetSentErrorMessage(true);
            return false;
        }

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        float z = std::max(map->GetHeight(x, y, MAX_HEIGHT), map->GetWaterLevel(x, y));

        player->TeleportTo(zoneEntry->mapid, x, y, z, player->GetOrientation());
        return true;
    }

    //teleport at coordinates, including Z and orientation
    static bool HandleGoXYZCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        std::string s(args);
        std::replace(s.begin(), s.end(), ',', ' ');
        std::replace(s.begin(), s.end(), '|', ' ');

        Player* player = handler->GetSession()->GetPlayer();

        char* goX = strtok((char*)s.c_str(), " ");
        char* goY = strtok(nullptr, " ");
        char* goZ = strtok(nullptr, " ");
        char* id = strtok(nullptr, " ");
        char* port = strtok(nullptr, " ");

        if (!goX || !goY)
            return false;

        float x = (float)atof(goX);
        float y = (float)atof(goY);
        float z;
        float ort = port ? (float)atof(port) : player->GetOrientation();
        uint32 mapId = id ? (uint32)atoi(id) : player->GetMapId();

        if (goZ)
        {
            z = (float)atof(goZ);
            if (!MapManager::IsValidMapCoord(mapId, x, y, z))
            {
                handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, x, y, mapId);
                handler->SetSentErrorMessage(true);
                return false;
            }
        }
        else
        {
            if (!MapManager::IsValidMapCoord(mapId, x, y))
            {
                handler->PSendSysMessage(LANG_INVALID_TARGET_COORD, x, y, mapId);
                handler->SetSentErrorMessage(true);
                return false;
            }
            Map const* map = sMapMgr->CreateBaseMap(mapId);
            z = std::max(map->GetHeight(x, y, MAX_HEIGHT), map->GetWaterLevel(x, y));
        }

        // stop flight if need
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        // save only in non-flight case
        else
            player->SaveRecallPosition();

        player->TeleportTo(mapId, x, y, z, ort);
        return true;
    }

    static bool HandleGoTicketCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        char* id = strtok((char*)args, " ");
        if (!id)
            return false;

        uint32 ticketId = atoi(id);
        if (!ticketId)
            return false;

        GmTicket* ticket = sTicketMgr->GetTicket(ticketId);
        if (!ticket)
        {
            handler->SendSysMessage(LANG_COMMAND_TICKETNOTEXIST);
            return true;
        }

        Player* player = handler->GetSession()->GetPlayer();
        if (player->IsInFlight())
        {
            player->GetMotionMaster()->MovementExpired();
            player->CleanupAfterTaxiFlight();
        }
        else
            player->SaveRecallPosition();

        ticket->TeleportTo(player);
        return true;
    }
};

void AddSC_go_commandscript()
{
    new go_commandscript();
}
