-- DB update 2021_02_26_00 -> 2021_02_27_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2021_02_26_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2021_02_26_00 2021_02_27_00 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1614385967944870125'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1614385967944870125');

-- 7th Legion Infantryman, 7th Legion Sentinel: Adjust position & orientation
UPDATE `creature` SET `orientation` = 4.4746 WHERE `guid` = 133196;
UPDATE `creature` SET `position_x` = 3715.63, `position_y` = -842.19, `position_z` = 164.583, `orientation` = 4.29789 WHERE `guid` = 133195;
UPDATE `creature` SET `position_x` = 3720.85, `position_y` = -841.397, `position_z` = 164.611, `orientation` = 4.17222 WHERE `guid` = 133215;

-- Wintergarde Blacksmith: Remove obsolete waypoint scripts, equip templates and emote state (handled by SAI)
DELETE FROM `waypoint_scripts` WHERE `id` IN (480,481);
DELETE FROM `creature_equip_template` WHERE `CreatureID` = 27361;
UPDATE `creature_addon` SET `emote` = 0 WHERE `guid` = 133763;

-- Risen Gryphon Rider Target: Set large to get hit by the Risen Gryphon Riders more often
DELETE FROM `creature_template_addon` WHERE `entry` = 27375;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`)
VALUES
(27375,0,0,0,0,0,1,'');

-- Highlord Leoric Von Zeldig, Siege Engineer Quarterflash: Add missing creature text
DELETE FROM `creature_text` WHERE `CreatureID` IN (27156,27159);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(27156,0,0,'The mine is lost. All of our defenders have perished and the miners resurrected as Scourge aberrations!',12,7,100,1,0,0,26545,0,'Highlord Leoric Von Zeldig - Talk To Siege Engineer Quarterflash'),
(27156,1,0,'Grim news, my pint-sized companion. Should we suffer a defeat here the ramifications will be felt across this frozen wasteland. Lord Fordragon and our armies at the Wrathgate will be defenseless against an assault from Naxxramas.',12,7,100,1,0,0,26549,0,'Highlord Leoric Von Zeldig - Talk To Siege Engineer Quarterflash'),
(27156,2,0,'Yes, yes, I haven''t forgotten Hyjal, or Silithus, or the march of the Legion, or every other damnable confrontation the 7th Legion has faced. It... I don''t want the soldiers to hear this, Two-bit, but for the first time in my life...',12,7,100,273,0,0,26551,0,'Highlord Leoric Von Zeldig - Talk To Siege Engineer Quarterflash'),
(27156,3,0,'You are right, of course, old friend. Let us hope that these heroes arrive soon.',12,7,100,273,0,0,26554,0,'Highlord Leoric Von Zeldig - Talk To Siege Engineer Quarterflash'),

(27159,0,0,'It does get worse, old friend. According to my calculations, without suitable materials to repair our parapets, the walls protecting this keep will crumble in twelve hours.',12,7,100,1,0,0,26548,0,'Siege Engineer Quarterflash - Talk To Highlord Leoric Von Zeldig'),
(27159,1,0,'We have been through worse and survived, Leoric. Do not forget Hyjal...',12,7,100,274,0,0,26550,0,'Siege Engineer Quarterflash - Talk To Highlord Leoric Von Zeldig'),
(27159,2,0,'Say no more, Leoric. We all feel the chill in our bones. Yet, each day, heroes arrive from across the world - and beyond.',12,7,100,274,0,0,26552,0,'Siege Engineer Quarterflash - Talk To Highlord Leoric Von Zeldig'),
(27159,3,0,'I have heard whisperings from the east that our esteemed Scarab Lord has joined the battle, as have entire batallions from Shattrath: heroes blessed by A''dal himself, granted rank as Hand of A''dal!',12,7,100,1,0,0,26553,0,'Siege Engineer Quarterflash - Talk To Highlord Leoric Von Zeldig');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (27361,27156,27159);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (27361,27156);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 27161 AND `id` = 2;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 2715600;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(27361,0,0,1,34,0,100,0,2,1,0,0,0,71,0,0,35312,0,0,0,1,0,0,0,0,0,0,0,0,'Wintergarde Blacksmith - On WP 2 Reached - Equip Slot 1'),
(27361,0,1,0,61,0,100,0,0,0,0,0,0,17,133,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wintergarde Blacksmith - Linked - Set Emote State ''STATE_USESTANDING_NOSHEATHE'''),
(27361,0,2,3,34,0,100,0,2,2,0,0,0,71,0,0,1903,0,0,0,1,0,0,0,0,0,0,0,0,'Wintergarde Blacksmith - On WP 3 Reached - Equip Slot 1'),
(27361,0,3,0,61,0,100,0,0,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wintergarde Blacksmith - Linked - Set Emote State ''ONESHOT_NONE'''),
(27361,0,4,0,34,0,100,0,2,3,0,0,0,17,233,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wintergarde Blacksmith - On WP 4 Reached - Set Emote State ''STATE_WORK_MINING'''),
(27361,0,5,0,34,0,100,0,2,4,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wintergarde Blacksmith - On WP 5 Reached - Set Emote State ''ONESHOT_NONE'''),

(27156,0,0,0,1,0,100,0,10000,20000,300000,600000,0,80,2715600,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Highlord Leoric Von Zeldig - OOC - Call Timed Action List'),

(2715600,9,0,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Highlord Leoric Von Zeldig - On Script - Say Line 0'),
(2715600,9,1,0,0,0,100,0,5000,5000,0,0,0,1,0,0,0,0,0,0,10,131120,27159,0,0,0,0,0,0,'Highlord Leoric Von Zeldig - On Script - Say Line 0 (Siege Engineer Quarterflash)'),
(2715600,9,2,0,0,0,100,0,8000,8000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Highlord Leoric Von Zeldig - On Script - Say Line 1'),
(2715600,9,3,0,0,0,100,0,12000,12000,0,0,0,1,1,0,0,0,0,0,10,131120,27159,0,0,0,0,0,0,'Highlord Leoric Von Zeldig - On Script - Say Line 1 (Siege Engineer Quarterflash)'),
(2715600,9,4,0,0,0,100,0,4000,4000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Highlord Leoric Von Zeldig - On Script - Say Line 2'),
(2715600,9,5,0,0,0,100,0,12000,12000,0,0,0,1,2,0,0,0,0,0,10,131120,27159,0,0,0,0,0,0,'Highlord Leoric Von Zeldig - On Script - Say Line 2 (Siege Engineer Quarterflash)'),
(2715600,9,6,0,0,0,100,0,6000,6000,0,0,0,1,3,0,0,0,0,0,10,131120,27159,0,0,0,0,0,0,'Highlord Leoric Von Zeldig - On Script - Say Line 3 (Siege Engineer Quarterflash)'),
(2715600,9,7,0,0,0,100,0,10000,10000,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Highlord Leoric Von Zeldig - On Script - Say Line 3'),

(27161,0,2,0,11,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'7th Legion Cavalier - On Respawn - Set Active On');

DELETE FROM `waypoint_data` WHERE `id` IN (1332060,1332000,1331980,1311520,1331990,1331720,1337630);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
-- 7th Legion Cavalier
(1332060,1,3706.25,-735.152,211.581,0,0,0,0,100,0),
(1332060,2,3701.72,-729.735,212.836,0,0,0,0,100,0),
(1332060,3,3696.11,-723.022,212.96,0,0,0,0,100,0),
(1332060,4,3687.6,-712.845,212.601,0,0,0,0,100,0),
(1332060,5,3685.6,-699.699,214.125,0,0,0,0,100,0),
(1332060,6,3683.56,-686.351,217.434,0,0,0,0,100,0),
(1332060,7,3674.16,-677.109,223.05,0,0,0,0,100,0),
(1332060,8,3665.37,-668.465,230.72,0,0,0,0,100,0),
(1332060,9,3662.25,-667.417,232.062,0,1000,0,0,100,0),
(1332060,10,3665.37,-668.465,230.72,0,0,0,0,100,0),
(1332060,11,3674.16,-677.109,223.05,0,0,0,0,100,0),
(1332060,12,3683.56,-686.351,217.434,0,0,0,0,100,0),
(1332060,13,3685.6,-699.699,214.125,0,0,0,0,100,0),
(1332060,14,3687.6,-712.845,212.601,0,0,0,0,100,0),
(1332060,15,3696.11,-723.022,212.96,0,0,0,0,100,0),
(1332060,16,3701.72,-729.735,212.836,0,0,0,0,100,0),
(1332060,17,3706.25,-735.152,211.581,0,0,0,0,100,0),
(1332060,18,3710.11,-739.771,209.939,0,0,0,0,100,0),
(1332060,19,3717.95,-745.191,206.234,0,0,0,0,100,0),
(1332060,20,3728.77,-748.902,201.94,0,0,0,0,100,0),
(1332060,21,3738.69,-752.305,198.949,0,0,0,0,100,0),
(1332060,22,3747.37,-759.38,197.161,0,0,0,0,100,0),
(1332060,23,3757.03,-767.249,196.76,0,0,0,0,100,0),
(1332060,24,3771.4,-771.209,195.998,0,0,0,0,100,0),
(1332060,25,3785.27,-787.718,196.588,0,0,0,0,100,0),
(1332060,26,3794.77,-795.185,196.753,0,1000,0,0,100,0),
(1332060,27,3785.27,-787.718,196.588,0,0,0,0,100,0),
(1332060,28,3771.4,-771.209,195.998,0,0,0,0,100,0),
(1332060,29,3757.03,-767.249,196.76,0,0,0,0,100,0),
(1332060,30,3747.37,-759.38,197.161,0,0,0,0,100,0),
(1332060,31,3738.69,-752.305,198.949,0,0,0,0,100,0),
(1332060,32,3728.77,-748.902,201.94,0,0,0,0,100,0),
(1332060,33,3717.95,-745.191,206.234,0,0,0,0,100,0),
(1332060,34,3710.11,-739.771,209.939,0,0,0,0,100,0),
-- 7th Legion Cavalier
(1332000,1,3854.33,-756.317,218.844,0,0,0,0,100,0),
(1332000,2,3846.54,-756.995,218.612,0,0,0,0,100,0),
(1332000,3,3837.12,-757.814,217.524,0,0,0,0,100,0),
(1332000,4,3830.81,-760.292,215.449,0,0,0,0,100,0),
(1332000,5,3822.77,-763.45,211.797,0,0,0,0,100,0),
(1332000,6,3814.54,-766.684,207.751,0,0,0,0,100,0),
(1332000,7,3806.27,-766.999,203.272,0,0,0,0,100,0),
(1332000,8,3797.19,-767.346,198.998,0,0,0,0,100,0),
(1332000,9,3782.36,-774.971,195.992,0,1000,0,0,100,0),
(1332000,10,3797.19,-767.346,198.998,0,0,0,0,100,0),
(1332000,11,3806.27,-766.999,203.272,0,0,0,0,100,0),
(1332000,12,3814.54,-766.684,207.751,0,0,0,0,100,0),
(1332000,13,3822.77,-763.45,211.797,0,0,0,0,100,0),
(1332000,14,3830.81,-760.292,215.449,0,0,0,0,100,0),
(1332000,15,3837.12,-757.814,217.524,0,0,0,0,100,0),
(1332000,16,3846.54,-756.995,218.612,0,0,0,0,100,0),
(1332000,17,3854.33,-756.317,218.844,0,0,0,0,100,0),
(1332000,18,3866.65,-755.245,219.679,0,0,0,0,100,0),
(1332000,19,3875.59,-747.22,221.053,0,0,0,0,100,0),
(1332000,20,3883.65,-739.981,225.878,0,0,0,0,100,0),
(1332000,21,3887.74,-734.451,229.716,0,0,0,0,100,0),
(1332000,22,3891.75,-729.04,233.221,0,0,0,0,100,0),
(1332000,23,3898,-725.648,237.221,0,0,0,0,100,0),
(1332000,24,3903.54,-722.646,240.027,0,0,0,0,100,0),
(1332000,25,3909.09,-717.302,241.189,0,0,0,0,100,0),
(1332000,26,3915.25,-711.365,241.289,0,1000,0,0,100,0),
(1332000,27,3909.09,-717.302,241.189,0,0,0,0,100,0),
(1332000,28,3903.54,-722.646,240.027,0,0,0,0,100,0),
(1332000,29,3898,-725.648,237.221,0,0,0,0,100,0),
(1332000,30,3891.75,-729.04,233.221,0,0,0,0,100,0),
(1332000,31,3887.74,-734.451,229.716,0,0,0,0,100,0),
(1332000,32,3883.65,-739.981,225.878,0,0,0,0,100,0),
(1332000,33,3875.59,-747.22,221.053,0,0,0,0,100,0),
(1332000,34,3866.65,-755.245,219.679,0,0,0,0,100,0),
-- 7th Legion Cavalier
(1331980,1,3938.28,-660.419,241.187,0,0,0,0,100,0),
(1331980,2,3940.39,-649.455,241.494,0,0,0,0,100,0),
(1331980,3,3948.23,-639.228,241.75,0,0,0,0,100,0),
(1331980,4,3958.08,-626.369,240.776,0,0,0,0,100,0),
(1331980,5,3948.23,-639.228,241.75,0,0,0,0,100,0),
(1331980,6,3940.39,-649.455,241.494,0,0,0,0,100,0),
(1331980,7,3938.28,-660.419,241.187,0,0,0,0,100,0),
(1331980,8,3936.54,-669.472,241.037,0,0,0,0,100,0),
(1331980,9,3935.91,-677.259,241.029,0,0,0,0,100,0),
(1331980,10,3935.25,-685.42,241.052,0,0,0,0,100,0),
(1331980,11,3939.2,-694.883,241.151,0,0,0,0,100,0),
(1331980,12,3943.43,-705,241.517,0,0,0,0,100,0),
(1331980,13,3948.28,-716.617,241.812,0,0,0,0,100,0),
(1331980,14,3962.69,-723.77,241.369,0,0,0,0,100,0),
(1331980,15,3948.28,-716.617,241.812,0,0,0,0,100,0),
(1331980,16,3940.57,-708.178,241.596,0,0,0,0,100,0),
(1331980,17,3933.46,-700.395,241.355,0,0,0,0,100,0),
(1331980,18,3931.42,-690.802,241.134,0,0,0,0,100,0),
(1331980,19,3929.62,-682.32,240.878,0,0,0,0,100,0),
(1331980,20,3925.38,-676.028,240.833,0,0,0,0,100,0),
(1331980,21,3921.1,-669.678,240.959,0,0,0,0,100,0),
(1331980,22,3912.07,-667.104,241.193,0,0,0,0,100,0),
(1331980,23,3914.15,-664.76,241.312,0,0,0,0,100,0),
(1331980,24,3921.1,-669.678,240.959,0,0,0,0,100,0),
(1331980,25,3926.68,-675.47,240.683,0,0,0,0,100,0),
(1331980,26,3931.33,-680.295,240.695,0,0,0,0,100,0),
(1331980,27,3934.37,-673.988,240.983,0,0,0,0,100,0),
(1331980,28,3936.54,-669.472,241.037,0,0,0,0,100,0),
-- 7th Legion Cavalier
(1311520,1,3933.33,-764.948,241.327,0,0,0,0,100,0),
(1311520,2,3924.19,-758.909,240.624,0,0,0,0,100,0),
(1311520,3,3921.77,-752.963,240.868,0,0,0,0,100,0),
(1311520,4,3917.07,-741.407,240.952,0,0,0,0,100,0),
(1311520,5,3913.13,-731.705,241.332,0,1000,0,0,100,0),
(1311520,6,3917.07,-741.407,240.952,0,0,0,0,100,0),
(1311520,7,3921.77,-752.963,240.868,0,0,0,0,100,0),
(1311520,8,3924.19,-758.909,240.624,0,0,0,0,100,0),
(1311520,9,3933.33,-764.948,241.327,0,0,0,0,100,0),
(1311520,10,3940.83,-769.903,242.378,0,0,0,0,100,0),
(1311520,11,3944.34,-780.118,244.761,0,0,0,0,100,0),
(1311520,12,3949.06,-788.046,244.323,0,0,0,0,100,0),
(1311520,13,3955.38,-798.675,242.993,0,0,0,0,100,0),
(1311520,14,3961.24,-808.513,241.12,0,0,0,0,100,0),
(1311520,15,3965.66,-817.517,239.682,0,0,0,0,100,0),
(1311520,16,3969.4,-825.131,240.07,0,0,0,0,100,0),
(1311520,17,3970.4,-830.764,240.009,0,0,0,0,100,0),
(1311520,18,3972.11,-840.42,238.315,0,0,0,0,100,0),
(1311520,19,3973.8,-849.95,234.707,0,0,0,0,100,0),
(1311520,20,3973.4,-862.373,227.363,0,0,0,0,100,0),
(1311520,21,3973.02,-874.155,221.244,0,0,0,0,100,0),
(1311520,22,3972.66,-885.237,215.904,0,0,0,0,100,0),
(1311520,23,3972.15,-901.217,208.652,0,0,0,0,100,0),
(1311520,24,3971.57,-919.251,202.939,0,0,0,0,100,0),
(1311520,25,3960.85,-925.41,200.017,0,0,0,0,100,0),
(1311520,26,3949.63,-931.857,198.29,0,0,0,0,100,0),
(1311520,27,3945.18,-943.198,199.272,0,0,0,0,100,0),
(1311520,28,3945.34,-953.808,201.99,0,0,0,0,100,0),
(1311520,29,3945.5,-965.238,206.622,0,0,0,0,100,0),
(1311520,30,3946.09,-975.018,209.677,0,0,0,0,100,0),
(1311520,31,3949.76,-984.981,208.976,0,0,0,0,100,0),
(1311520,32,3953.9,-992.796,206.923,0,0,0,0,100,0),
(1311520,33,3956.09,-1000.01,205.57,0,0,0,0,100,0),
(1311520,34,3957.49,-1004.61,203.939,0,0,0,0,100,0),
(1311520,35,3959.77,-1012.12,200.057,0,1000,0,0,100,0),
(1311520,36,3957.49,-1004.61,203.939,0,0,0,0,100,0),
(1311520,37,3956.09,-1000.01,205.57,0,0,0,0,100,0),
(1311520,38,3953.9,-992.796,206.923,0,0,0,0,100,0),
(1311520,39,3949.76,-984.981,208.976,0,0,0,0,100,0),
(1311520,40,3946.09,-975.018,209.677,0,0,0,0,100,0),
(1311520,41,3945.5,-965.238,206.622,0,0,0,0,100,0),
(1311520,42,3945.34,-953.808,201.99,0,0,0,0,100,0),
(1311520,43,3945.18,-943.198,199.272,0,0,0,0,100,0),
(1311520,44,3949.63,-931.857,198.29,0,0,0,0,100,0),
(1311520,45,3960.85,-925.41,200.017,0,0,0,0,100,0),
(1311520,46,3971.57,-919.251,202.939,0,0,0,0,100,0),
(1311520,47,3972.15,-901.217,208.652,0,0,0,0,100,0),
(1311520,48,3972.66,-885.237,215.904,0,0,0,0,100,0),
(1311520,49,3973.02,-874.155,221.244,0,0,0,0,100,0),
(1311520,50,3973.4,-862.373,227.363,0,0,0,0,100,0),
(1311520,51,3973.8,-849.95,234.707,0,0,0,0,100,0),
(1311520,52,3972.11,-840.42,238.315,0,0,0,0,100,0),
(1311520,53,3970.4,-830.764,240.009,0,0,0,0,100,0),
(1311520,54,3969.4,-825.131,240.07,0,0,0,0,100,0),
(1311520,55,3965.66,-817.517,239.682,0,0,0,0,100,0),
(1311520,56,3961.24,-808.513,241.12,0,0,0,0,100,0),
(1311520,57,3955.38,-798.675,242.993,0,0,0,0,100,0),
(1311520,58,3949.06,-788.046,244.323,0,0,0,0,100,0),
(1311520,59,3944.34,-780.118,244.761,0,0,0,0,100,0),
(1311520,60,3940.83,-769.903,242.378,0,0,0,0,100,0),
-- 7th Legion Cavalier
(1331990,1,3601.56,-724.461,213.81,0,0,0,0,100,0),
(1331990,2,3587.45,-722.423,213.81,0,0,0,0,100,0),
(1331990,3,3569.79,-727.29,213.81,0,0,0,0,100,0),
(1331990,4,3555.9,-731.118,214.44,0,0,0,0,100,0),
(1331990,5,3548.26,-742.111,213.958,0,0,0,0,100,0),
(1331990,6,3539.47,-754.774,215.93,0,0,0,0,100,0),
(1331990,7,3532.15,-766.976,219.786,0,0,0,0,100,0),
(1331990,8,3528.03,-773.831,221.634,0,0,0,0,100,0),
(1331990,9,3523.98,-780.586,222.903,0,0,0,0,100,0),
(1331990,10,3528.03,-773.831,221.634,0,0,0,0,100,0),
(1331990,11,3532.15,-766.976,219.786,0,0,0,0,100,0),
(1331990,12,3539.47,-754.774,215.93,0,0,0,0,100,0),
(1331990,13,3548.26,-742.111,213.958,0,0,0,0,100,0),
(1331990,14,3555.9,-731.118,214.44,0,0,0,0,100,0),
(1331990,15,3569.79,-727.29,213.81,0,0,0,0,100,0),
(1331990,16,3587.45,-722.423,213.935,0,0,0,0,100,0),
(1331990,17,3601.56,-724.461,213.81,0,0,0,0,100,0),
(1331990,18,3612.65,-726.062,213.935,0,0,0,0,100,0),
-- 7th Legion Infantryman
(1331720,1,3630.04,-697.951,213.811,0,0,0,0,100,0),
(1331720,2,3617.23,-699.88,213.81,0,0,0,0,100,0),
(1331720,3,3600.05,-707.217,213.935,0,0,0,0,100,0),
(1331720,4,3587.96,-712.249,213.935,0,0,0,0,100,0),
(1331720,5,3571.83,-718.415,213.81,0,0,0,0,100,0),
(1331720,6,3557.36,-723.945,214.94,0,0,0,0,100,0),
(1331720,7,3549.13,-734.405,214.378,0,0,0,0,100,0),
(1331720,8,3540.53,-745.344,214.68,0,0,0,0,100,0),
(1331720,9,3531.58,-759.661,218.762,0,0,0,0,100,0),
(1331720,10,3540.53,-745.344,214.68,0,0,0,0,100,0),
(1331720,11,3549.13,-734.405,214.378,0,0,0,0,100,0),
(1331720,12,3557.36,-723.945,214.94,0,0,0,0,100,0),
(1331720,13,3571.83,-718.415,213.81,0,0,0,0,100,0),
(1331720,14,3587.96,-712.249,213.935,0,0,0,0,100,0),
(1331720,15,3600.05,-707.217,213.935,0,0,0,0,100,0),
(1331720,16,3617.23,-699.88,213.935,0,0,0,0,100,0),
(1331720,17,3630.04,-697.951,213.811,0,0,0,0,100,0),
(1331720,18,3641.11,-696.282,213.935,0,0,0,0,100,0),
-- Wintergarde Blacksmith
(1337630,1,3687.75,-740.122,213.389,0,0,0,0,100,0),
(1337630,2,3687.75,-740.122,213.389,4.2214,60000,0,0,100,0),
(1337630,3,3687.75,-740.122,213.389,0,2000,0,0,100,0),
(1337630,4,3691.5,-738.822,213.406,5.3582,60000,0,0,100,0),
(1337630,5,3691.5,-738.822,213.406,0,2000,0,0,100,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
