/*
 * Copyright (C) 2020+     Project "Sol" <https://gitlab.com/opfesoft/sol>, released under the GNU GPLv2 license: https://gitlab.com/opfesoft/sol/-/blob/master/deps/gpl-2.0.md; you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2016-2020 AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Creature.h"
#include "CreatureGroups.h"
#include "ObjectMgr.h"

#include "CreatureAI.h"
#include "MoveSplineInit.h"

FormationMgr::~FormationMgr()
{
    for (CreatureGroupInfoType::iterator itr = CreatureGroupMap.begin(); itr != CreatureGroupMap.end(); ++itr)
        delete itr->second;
}

void FormationMgr::AddCreatureToGroup(uint32 groupId, Creature* member, float dist /*= 0.f*/, float angle /*= 0.f*/, uint32 groupAI /*= 0*/)
{
    Map* map = member->FindMap();
    if (!map)
        return;

    CreatureGroupHolderType::iterator itr = map->CreatureGroupHolder.find(groupId);

    //Add member to an existing group
    if (itr != map->CreatureGroupHolder.end())
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_UNITS, "Group found: %u, inserting creature GUID: %u (DB GUID %u), Group InstanceID %u", groupId, member->GetGUIDLow(), member->GetDBTableGUIDLow(), member->GetInstanceId());
#endif
        itr->second->AddMember(member, dist, angle, groupAI);
    }
    //Create new group
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_UNITS, "Group not found: %u. Creating new group.", groupId);
#endif
        CreatureGroup* group = new CreatureGroup(groupId);
        map->CreatureGroupHolder[groupId] = group;
        group->AddMember(member, dist, angle, groupAI);
    }
}

void FormationMgr::AddCreatureToGroup(Creature* leader, Creature* member, float dist /*= 0.f*/, float angle /*= 0.f*/, uint32 groupAI /*= 0*/)
{
    uint32 groupId = leader->GetDBTableGUIDLow() ? leader->GetDBTableGUIDLow() : leader->GetGUIDLow();
    AddCreatureToGroup(groupId, member, dist, angle, groupAI);
}

void FormationMgr::RemoveCreatureFromGroup(CreatureGroup* group, Creature* member)
{
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_UNITS, "Deleting member pointer to GUID: %u (DB GUID %u) from group %u", member->GetGUIDLow(), member->GetDBTableGUIDLow(), group->GetId());
#endif
    group->RemoveMember(member);

    if (group->isEmpty())
    {
        Map* map = member->FindMap();
        if (!map)
            return;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_UNITS, "Deleting group %u with InstanceID %u", group->GetId(), member->GetInstanceId());
#endif
        map->CreatureGroupHolder.erase(group->GetId());
        delete group;
    }
}

void FormationMgr::LoadCreatureFormations()
{
    uint32 oldMSTime = getMSTime();

    for (CreatureGroupInfoType::iterator itr = CreatureGroupMap.begin(); itr != CreatureGroupMap.end(); ++itr) // for reload case
        delete itr->second;
    CreatureGroupMap.clear();

    //Get group data
    QueryResult result = WorldDatabase.Query("SELECT leaderGUID, memberGUID, dist, angle, groupAI FROM creature_formations ORDER BY leaderGUID");

    if (!result)
    {
        sLog->outErrorDb(">> Loaded 0 creatures in formations. DB table `creature_formations` is empty!");
        sLog->outString();
        return;
    }

    uint32 count = 0;
    Field* fields;
    FormationInfo* group_member;

    do
    {
        fields = result->Fetch();

        //Load group member data
        group_member                        = new FormationInfo();
        group_member->leaderGUID            = fields[0].GetUInt32();
        uint32 memberGUID                   = fields[1].GetUInt32();
        group_member->groupAI               = fields[4].GetUInt32();
        //If creature is group leader we may skip loading of dist/angle
        if (group_member->leaderGUID != memberGUID)
        {
            group_member->follow_dist       = fields[2].GetFloat();
            group_member->follow_angle      = fields[3].GetFloat() * M_PI / 180.0f;
        }
        else
        {
            group_member->follow_dist       = 0;
            group_member->follow_angle      = 0;
        }

        // check data correctness
        {
            if (!sObjectMgr->GetCreatureData(group_member->leaderGUID))
            {
                sLog->outErrorDb("creature_formations table leader guid %u incorrect (not exist)", group_member->leaderGUID);
                delete group_member;
                continue;
            }

            if (!sObjectMgr->GetCreatureData(memberGUID))
            {
                sLog->outErrorDb("creature_formations table member guid %u incorrect (not exist)", memberGUID);
                delete group_member;
                continue;
            }
        }

        group_member->groupAI_init = group_member->groupAI;
        group_member->follow_dist_init = group_member->follow_dist;
        group_member->follow_angle_init = group_member->follow_angle;
        CreatureGroupMap[memberGUID] = group_member;
        ++count;
    }
    while (result->NextRow());

    sLog->outString(">> Loaded %u creatures in formations in %u ms", count, GetMSTimeDiffToNow(oldMSTime));
    sLog->outString();
}

void FormationMgr::UpdateFormationInfo(Creature* member, float dist, float angle, uint32 groupAI)
{
    uint32 guid = member->GetDBTableGUIDLow() ? member->GetDBTableGUIDLow() : member->GetGUIDLow();
    CreatureGroupInfoType::iterator itr = sFormationMgr->CreatureGroupMap.find(guid);
    if (itr != sFormationMgr->CreatureGroupMap.end())
    {
         itr->second->follow_dist = dist;
         itr->second->follow_angle = angle;
         itr->second->groupAI = groupAI;
    }
}

void FormationMgr::ResetFormationInfo(Creature* member)
{
    uint32 guid = member->GetDBTableGUIDLow() ? member->GetDBTableGUIDLow() : member->GetGUIDLow();
    CreatureGroupInfoType::iterator itr = sFormationMgr->CreatureGroupMap.find(guid);
    if (itr != sFormationMgr->CreatureGroupMap.end())
    {
         itr->second->follow_dist = itr->second->follow_dist_init;
         itr->second->follow_angle = itr->second->follow_angle_init;
         itr->second->groupAI = itr->second->groupAI_init;
    }
}

void CreatureGroup::AddMember(Creature* member, float dist, float angle, uint32 groupAI)
{
    if (m_members.find(member) != m_members.end())
        return;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
    sLog->outDebug(LOG_FILTER_UNITS, "CreatureGroup::AddMember: Adding unit GUID: %u (DB GUID %u).", member->GetGUIDLow(), member->GetDBTableGUIDLow());
#endif

    //Check if it is a leader
    uint32 guid = member->GetDBTableGUIDLow() ? member->GetDBTableGUIDLow() : member->GetGUIDLow();
    if (guid == m_groupID)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_UNITS, "Unit GUID: %u is formation leader. Adding group.", guid);
#endif
        m_leader = member;
    }

    CreatureGroupInfoType::iterator itr = sFormationMgr->CreatureGroupMap.find(guid);
    if (itr != sFormationMgr->CreatureGroupMap.end())
        m_members[member] = itr->second;
    else
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_UNITS, "No formation info found for unit GUID %u, create a new one", guid);
#endif
        FormationInfo* formationInfo = new FormationInfo();
        formationInfo->leaderGUID = m_groupID;
        formationInfo->groupAI = groupAI;

        if (member->GetGUIDLow() != m_groupID)
        {
            formationInfo->follow_dist = dist;
            formationInfo->follow_angle = angle;
        }
        else
        {
            formationInfo->follow_dist = 0.f;
            formationInfo->follow_angle = 0.f;
        }

        formationInfo->groupAI_init = formationInfo->groupAI;
        formationInfo->follow_dist_init = formationInfo->follow_dist;
        formationInfo->follow_angle_init = formationInfo->follow_angle;
        sFormationMgr->CreatureGroupMap[member->GetGUIDLow()] = formationInfo;
        m_members[member] = formationInfo;
    }

    member->SetFormation(this);
}

void CreatureGroup::RemoveMember(Creature* member)
{
    if (m_leader == member)
        m_leader = NULL;

    if (!member->GetDBTableGUIDLow())
    {
        CreatureGroupInfoType::iterator itr = sFormationMgr->CreatureGroupMap.find(member->GetGUIDLow());
        if (itr != sFormationMgr->CreatureGroupMap.end())
        {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_UNITS, "Formation info for unit GUID %u not needed anymore, delete it", member->GetGUIDLow());
#endif
            delete itr->second;
            sFormationMgr->CreatureGroupMap.erase(itr);
        }
    }

    m_members.erase(member);
    member->SetFormation(NULL);
}

void CreatureGroup::MemberAttackStart(Creature* member, Unit* target)
{
    uint32 guid = member->GetDBTableGUIDLow() ? member->GetDBTableGUIDLow() : member->GetGUIDLow();
    uint8 groupAI = sFormationMgr->CreatureGroupMap[guid]->groupAI;
    if (!groupAI)
        return;

    if (groupAI == 1 && member != m_leader)
        return;

    for (CreatureGroupMemberType::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        if (m_leader) // avoid crash if leader was killed and reset.
            sLog->outDebug(LOG_FILTER_UNITS, "GROUP ATTACK: group instance id %u calls member instid %u", m_leader->GetInstanceId(), member->GetInstanceId());
#endif

        //Skip one check
        if (itr->first == member)
            continue;

        if (!itr->first->IsAlive())
            continue;

        if (itr->first->GetVictim())
            continue;

        if (itr->first->IsValidAttackTarget(target) && itr->first->AI())
            itr->first->AI()->AttackStart(target);
    }
}

void CreatureGroup::FormationReset(bool dismiss)
{
    if (m_members.size() && m_members.begin()->second->groupAI == 5)
        return;

    for (CreatureGroupMemberType::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
        if (itr->first != m_leader && itr->first->IsAlive())
        {
            if (dismiss)
                itr->first->GetMotionMaster()->Initialize();
            else
                itr->first->GetMotionMaster()->MoveIdle();
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDebug(LOG_FILTER_UNITS, "Set %s movement for member GUID: %u", dismiss ? "default" : "idle", itr->first->GetGUIDLow());
#endif
        }
    }
    m_Formed = !dismiss;
}

void CreatureGroup::LeaderMoveTo(float x, float y, float z, bool run, bool generatePath, Movement::PointsArray* intermediatePath /*= NULL*/)
{
    //! To do: This should probably get its own movement generator or use WaypointMovementGenerator.
    //! If the leader's path is known, member's path can be plotted as well using formation offsets.
    if (!m_leader)
        return;

    uint32 guid = m_leader->GetDBTableGUIDLow() ? m_leader->GetDBTableGUIDLow() : m_leader->GetGUIDLow();
    uint8 groupAI = sFormationMgr->CreatureGroupMap[guid]->groupAI;
    if (groupAI == 5)
        return;

    float pathDist = m_leader->GetExactDist(x, y, z);
    float pathAngle = m_leader->GetAngle(x, y);
    bool transportPath = m_leader->HasUnitMovementFlag(MOVEMENTFLAG_ONTRANSPORT) && m_leader->GetTransGUID();

    // Xinef: this should be automatized, if turn angle is greater than PI/2 (90°) we should swap formation angle
    bool swapFormation = m_leader->GetOrientation() && (M_PI - fabs(fabs(m_leader->GetOrientation() - pathAngle) - M_PI) > M_PI * 0.5f);

    for (CreatureGroupMemberType::iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
        Creature* member = itr->first;
        if (member == m_leader)
            continue;

        if (!member->IsAlive() || member->GetVictim() ||
            member->HasUnitState(UNIT_STATE_NOT_MOVE)) // Xinef: If member is stunned / rooted etc don't allow to move him
        {
            member->SetLeaderMoveFailed(true);
            continue;
        }

        if (swapFormation)
            itr->second->follow_angle = (2 * M_PI) - itr->second->follow_angle;

        float followAngle = itr->second->follow_angle + M_PI; // for some reason, someone thought it was a great idea to invert relative angles...
        float followDist = itr->second->follow_dist;

        Position p = {x, y, z, 0.0f};

        Movement::PointsArray path;
        float memberPathDist = 0.f;

        if (!intermediatePath || intermediatePath->size() < 2)
        {
            if (m_leader->IsFlying() && member->CanFly())
                Position::GetNearPoint2D(x, y, p.m_positionX, p.m_positionY, followDist, pathAngle + followAngle);
            else
                member->MovePosition(p, followDist, pathAngle + followAngle - member->GetOrientation());

            memberPathDist = member->GetExactDist(&p);
        }
        else
        {
            pathDist = 0.f;
            Position oldPos = { member->GetPositionX(), member->GetPositionY(), member->GetPositionZ(), 0.f };
            path.push_back(G3D::Vector3(oldPos.m_positionX, oldPos.m_positionY, oldPos.m_positionZ));

            for (unsigned int i = 1; i < intermediatePath->size(); i++)
            {
                Position previousPoint = { intermediatePath->at(i - 1).x, intermediatePath->at(i - 1).y, intermediatePath->at(i - 1).z, 0.f };
                p = { intermediatePath->at(i).x, intermediatePath->at(i).y, intermediatePath->at(i).z, 0.f };

                if (transportPath)
                    if (TransportBase* trans = m_leader->GetDirectTransport())
                    {
                        trans->CalculatePassengerPosition(previousPoint.m_positionX, previousPoint.m_positionY, previousPoint.m_positionZ, &previousPoint.m_orientation);
                        trans->CalculatePassengerPosition(p.m_positionX, p.m_positionY, p.m_positionZ, &p.m_orientation);
                    }

                pathDist += previousPoint.GetExactDist(p.m_positionX, p.m_positionY, p.m_positionZ);
                pathAngle = previousPoint.GetAngle(p.m_positionX, p.m_positionY);

                if (m_leader->IsFlying() && member->CanFly())
                    Position::GetNearPoint2D(p.m_positionX, p.m_positionY, p.m_positionX, p.m_positionY, followDist, pathAngle + followAngle);
                else
                    member->MovePosition(p, followDist, pathAngle + followAngle - member->GetOrientation());

                memberPathDist += oldPos.GetExactDist(&p);
                oldPos = p;
                path.push_back(G3D::Vector3(p.m_positionX, p.m_positionY, p.m_positionZ));
            }
        }

        if (member->IsLeaderMoveFailed())
            memberPathDist += member->GetExactDist(m_leader);

        p.m_orientation = pathAngle;

        member->SetUnitMovementFlags(m_leader->GetUnitMovementFlags());
        // pussywizard: setting the same movementflags is not enough, spline decides whether leader walks/runs, so spline param is now passed as "run" parameter to this function
        if (run && member->IsWalking())
            member->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
        else if (!run && !member->IsWalking())
            member->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);

        // xinef: if we move members to position without taking care of sizes, we should compare distance without sizes
        // xinef: change members speed basing on distance - if too far speed up, if too close slow down
        UnitMoveType mtype = Movement::SelectSpeedType(member->GetUnitMovementFlags());
        float speedRate = m_leader->GetSpeedRate(mtype) * memberPathDist / pathDist;

        if (speedRate > 0.01f) // don't move if speed rate is too low
        {
            if (path.empty() || member->IsLeaderMoveFailed())
            {
                member->SetSpeedRate(mtype, speedRate);
                member->GetMotionMaster()->MovePoint(0, p, generatePath || member->IsLeaderMoveFailed());
                member->SetHomePosition(p);
            }
            else
            {
                member->SetSpeedRate(mtype, speedRate);
                member->GetMotionMaster()->MoveSplinePath(&path, false);
                member->SetHomePosition(p);
            }

            if (TransportBase* trans = m_leader->GetDirectTransport())
            {
                trans->CalculatePassengerOffset(p.m_positionX, p.m_positionY, p.m_positionZ, &p.m_orientation);
                member->SetTransportHomePosition(p.m_positionX, p.m_positionY, p.m_positionZ, p.m_orientation);
            }
        }

        member->SetLeaderMoveFailed(false);
    }
}

bool CreatureGroup::IsFollowing(Creature* member)
{
    if (!m_leader || !member || m_leader == member)
        return false;

    uint32 guid = member->GetDBTableGUIDLow() ? member->GetDBTableGUIDLow() : member->GetGUIDLow();
    if (FormationInfo* fi = sFormationMgr->CreatureGroupMap[guid])
        return fi->groupAI != 5;

    return false;
}
