DELETE FROM `creature_text` WHERE `CreatureId` = 2530;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(2530,0,0,'%s is struck dumb by the Soul Gem!',16,0,100,0,0,0,681,0,'Yenniku');

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = 2530;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 2530;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 253000;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(2530,0,0,0,8,0,100,0,3607,0,30000,30000,0,80,253000,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Yenniku - On Spellhit ''Yenniku`s Release'' - Call Timed Action List'),

(253000,9,0,0,0,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Yenniku - On Script - Set Active On'),
(253000,9,1,0,0,0,100,0,0,0,0,0,0,101,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Yenniku - On Script - Set Home Position'),
(253000,9,2,0,0,0,100,0,0,0,0,0,0,2,35,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Yenniku - On Script - Set Faction ''Friendly'''),
(253000,9,3,0,0,0,100,0,500,500,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Yenniku - On Script - Say Line 0'),
(253000,9,4,0,0,0,100,0,0,0,0,0,0,75,18970,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Yenniku - On Script - Add Aura ''Self Stun - (Visual only)'''),
(253000,9,5,0,0,0,100,0,0,0,0,0,0,41,60000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Yenniku - On Script - Force Despawn');
