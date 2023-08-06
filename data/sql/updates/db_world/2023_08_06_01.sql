DELETE FROM `gameobject` WHERE `guid` BETWEEN 3009187 AND 3009190;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`)
VALUES
(3009187,184614,530,0,0,1,1,4923.56,2990.45,93.9413,0.813699,0,0,0,0,-1,0,0,0),
(3009188,184614,530,0,0,1,1,4923.45,2991.21,93.9248,5.49404,0,0,0,0,-1,0,0,0),
(3009189,184614,530,0,0,1,1,4924.47,2990.35,93.8867,2.25067,0,0,0,0,-1,0,0,0),
(3009190,184614,530,0,0,1,1,4924.32,2991.21,93.8808,3.88003,0,0,0,0,-1,0,0,0);

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 20913;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 20913;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 2091300;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(20913,0,0,0,20,0,100,0,10436,0,0,0,0,80,2091300,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tashar - On Quest ''All Clear!'' Rewarded - Call Timed Action List'),

(2091300,9,0,0,0,0,100,0,0,0,0,0,0,83,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tashar - On Script - Remove NPC Flags'),
(2091300,9,1,0,0,0,100,0,1000,1000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tashar - On Script - Say Line 0'),
(2091300,9,2,0,0,0,100,0,0,0,0,0,0,59,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tashar - On Script - Set Run Off'),
(2091300,9,3,0,0,0,100,0,2000,2000,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,4921.52,2990.98,94.0293,0,'Tashar - On Script - Move To Point 0'),
(2091300,9,4,0,0,0,100,0,5000,5000,0,0,0,17,173,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tashar - On Script - Set Emote State ''STATE_WORK'''),
(2091300,9,5,0,0,0,100,0,4000,4000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tashar - On Script - Set Emote State ''ONESHOT_NONE'''),
(2091300,9,6,0,0,0,100,0,0,0,0,0,0,11,28730,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tashar - On Script - Cast ''Arcane Torrent'''),
(2091300,9,7,0,0,0,100,0,2000,2000,0,0,0,70,15,0,0,0,0,0,15,184614,15,0,0,0,0,0,0,'Tashar - On Script - Respawn Target (Ethereal Repair Kit)'),
(2091300,9,8,0,0,0,100,0,2000,2000,0,0,0,1,1,4000,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tashar - On Script - Say Line 1'),
(2091300,9,9,0,0,0,100,0,4000,4000,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,4914.74,2991.92,94.1138,0,'Tashar - On Script - Move To Point 0'),
(2091300,9,10,0,0,0,100,0,3000,3000,0,0,0,66,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tashar - On Script - Reset Orientation'),
(2091300,9,11,0,0,0,100,0,0,0,0,0,0,82,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Tashar - On Script - Reset NPC Flags');
