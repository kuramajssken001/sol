DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` IN (3047700,3048700);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(3047700,9,0,0,0,0,100,0,0,0,0,0,0,75,61204,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'D16 Propelled Delivery Device - On Script - Add Aura ''Stun (Permanent)'''),
(3047700,9,1,0,0,0,100,0,3000,3000,0,0,0,28,61204,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'D16 Propelled Delivery Device - On Script - Remove Aura ''Stun (Permanent)'''),
(3047700,9,2,0,0,0,100,0,0,0,0,0,0,53,1,30477,0,0,0,0,1,0,0,0,0,0,0,0,0,'D16 Propelled Delivery Device - On Script - Start WP Movement'),

(3048700,9,0,0,0,0,100,0,0,0,0,0,0,75,61204,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'D16 Propelled Delivery Device - On Script - Add Aura ''Stun (Permanent)'''),
(3048700,9,1,0,0,0,100,0,3000,3000,0,0,0,28,61204,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'D16 Propelled Delivery Device - On Script - Remove Aura ''Stun (Permanent)'''),
(3048700,9,2,0,0,0,100,0,0,0,0,0,0,53,1,30487,0,0,0,0,1,0,0,0,0,0,0,0,0,'D16 Propelled Delivery Device - On Script - Start WP Movement');
