UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 17424;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 17424;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 1742400;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(17424,0,0,0,20,0,100,0,9557,0,0,0,0,80,1742400,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Anchorite Paetheus - On Quest ''Deciphering the Book'' Rewarded - Call Timed Action List'),

(1742400,9,0,0,0,0,100,0,0,0,0,0,0,83,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Anchorite Paetheus - On Script - Remove NPC Flags'),
(1742400,9,1,0,0,0,100,0,1000,1000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Anchorite Paetheus - On Script - Say Line 0'),
(1742400,9,2,0,0,0,100,0,4000,4000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Anchorite Paetheus - On Script - Say Line 1'),
(1742400,9,3,0,0,0,100,0,8000,8000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Anchorite Paetheus - On Script - Say Line 2'),
(1742400,9,4,0,0,0,100,0,9000,9000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Anchorite Paetheus - On Script - Say Line 3'),
(1742400,9,5,0,0,0,100,0,2000,2000,0,0,0,82,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Anchorite Paetheus - On Script - Reset NPC Flags');
