UPDATE `gameobject` SET `id` = 181279 WHERE `guid` IN (28264,28276,32805,32812);

UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 181279;
DELETE FROM `smart_scripts` WHERE `source_type` = 1 AND `entryorguid` = 181279;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(181279,1,0,0,70,0,100,1,2,0,0,0,0,85,28702,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Netherbloom - On GO State Changed ''GO_ACTIVATED'' - Invoker Cast ''Netherbloom''');
