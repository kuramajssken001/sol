DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 19779;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(19779,0,0,0,0,0,100,0,0,0,2300,3900,0,11,36645,64,0,0,0,0,2,0,0,0,0,0,0,0,0,'Sunfury Geologist - IC - Cast ''Throw Rock'''),
(19779,0,1,0,9,0,100,0,0,5,5000,9000,0,11,35918,32,0,0,0,0,2,0,0,0,0,0,0,0,0,'Sunfury Geologist - Within 0-5 Range - Cast ''Puncture Armor'''),
(19779,0,2,0,2,0,100,1,0,15,0,0,0,25,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'Sunfury Geologist - Between 0-15% Health - Flee For Assist (No Repeat)');
