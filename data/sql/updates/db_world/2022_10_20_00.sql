UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 12473;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 12473;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(12473,0,0,0,0,0,100,0,0,0,8000,12000,0,11,9658,0,0,1,0,0,2,0,0,0,0,0,0,0,0,'Arcanite Dragonling - IC - Cast ''Flame Buffet'''),
(12473,0,1,0,0,0,100,0,8000,12000,16000,24000,0,11,8873,0,0,1,0,0,2,0,0,0,0,0,0,0,0,'Arcanite Dragonling - IC - Cast ''Flame Breath''');
