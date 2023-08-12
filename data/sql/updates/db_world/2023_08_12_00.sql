UPDATE `creature_template` SET `unit_flags2` = `unit_flags2` | 32768, `flags_extra` = `flags_extra` | 8388608 WHERE `entry` = 22355;

UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE `guid` IN (66317,66318,66320,66321,66322);
UPDATE `creature` SET `position_z` = -14.3339 WHERE `guid` = 78618;
UPDATE `creature` SET `position_z` = 6.16448 WHERE `guid` = 78619;
UPDATE `creature` SET `position_z` = 8.58876 WHERE `guid` = 78623;
UPDATE `creature` SET `position_z` = 2.80507 WHERE `guid` = 78627;

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 22355 AND `id` > 7;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(22355,0,8,9,25,0,100,0,0,0,0,0,0,103,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Netherweb Victim - On Respawn - Set Root On'),
(22355,0,9,10,61,0,100,0,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Netherweb Victim - Linked - Set React State ''Passive'''),
(22355,0,10,0,61,0,100,0,0,0,0,0,0,116,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Netherweb Victim - Linked - Set Corpse Delay');
