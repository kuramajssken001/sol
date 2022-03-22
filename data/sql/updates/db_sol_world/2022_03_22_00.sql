-- DB update 2022_03_18_04 -> 2022_03_22_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2022_03_18_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2022_03_18_04 2022_03_22_00 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1647959932229810673'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1647959932229810673');

UPDATE `creature` SET `position_x` = -5.00423, `position_y` = 6.2922, `position_z` = 6.06386 WHERE `guid` = 52018;
UPDATE `creature` SET `position_x` = 2.95417, `position_y` = 5.62268, `position_z` = 11.4588, `orientation` = 3.32513 WHERE `guid` = 52013;
UPDATE `creature` SET `position_x` = 33.8088, `position_y` = 0.0680723, `position_z` = 18.2875, `orientation` = 3.09629 WHERE `guid` = 52015;
UPDATE `creature` SET `position_x` = -2.21688, `position_y` = 2.61149, `position_z` = 6.05655, `orientation` = 4.10104 WHERE `guid` = 52014;
UPDATE `creature` SET `position_x` = 6.11694, `position_y` = -6.60889, `position_z` = 6.09714, `orientation` = 2.28638 WHERE `guid` = 52020;
UPDATE `creature` SET `orientation` = 3.14159 WHERE `guid` = 52016;
UPDATE `creature` SET `MovementType` = 0 WHERE `guid` IN (52011,52013,52015,52016);
UPDATE `creature_addon` SET `bytes2` = 0 WHERE `guid` IN (52011,52013,52016,52018,52017,52014);
UPDATE `creature_addon` SET `path_id` = 0 WHERE `guid` IN (52011,52013,52015,52016);
UPDATE `creature_text` SET `Emote` = 21 WHERE `CreatureID` = 24833 AND `GroupID` = 1 AND `ID` = 0;

UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = 24838;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` IN (24840,24839);
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (24840,24833,24835,24837,24838,24839);
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` IN (2484000,2483300,2483500,2483700,2483701,2483900);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(24840,0,0,0,34,0,100,0,2,1,0,0,0,80,2484000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sailor Vines - On WP 2 Reached - Call Timed Action List'),
(24840,0,1,0,34,0,100,0,2,6,0,0,0,80,2484000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sailor Vines - On WP 7 Reached - Call Timed Action List'),

(2484000,9,0,0,0,0,100,0,1000,1000,0,0,0,17,69,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sailor Vines - On Script - Set Emote State ''STATE_USESTANDING'''),
(2484000,9,1,0,0,0,100,0,10000,10000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sailor Vines - On Script - Set Emote State ''ONESHOT_NONE'''),

(24839,0,0,0,34,0,100,0,2,2,0,0,0,80,2483900,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sailor Wicks - On WP 3 Reached - Call Timed Action List'),
(24839,0,1,0,34,0,100,0,2,4,0,0,0,80,2483900,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sailor Wicks - On WP 5 Reached - Call Timed Action List'),
(24839,0,2,0,34,0,100,0,2,8,0,0,0,80,2483900,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sailor Wicks - On WP 9 Reached - Call Timed Action List'),
(24839,0,3,0,34,0,100,0,2,11,0,0,0,80,2483900,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sailor Wicks - On WP 12 Reached - Call Timed Action List'),

(2483900,9,0,0,0,0,100,0,1000,1000,0,0,0,17,69,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sailor Wicks - On Script - Set Emote State ''STATE_USESTANDING'''),
(2483900,9,1,0,0,0,100,0,10000,10000,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sailor Wicks - On Script - Set Emote State ''ONESHOT_NONE'''),

(24833,0,0,0,11,0,100,0,0,0,0,0,0,80,2483300,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Captain "Stash" Torgoley - On Respawn - Call Timed Action List'),

(2483300,9,0,0,0,0,100,0,33000,33000,0,0,0,91,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Captain "Stash" Torgoley - On Script - Remove ''UNIT_STAND_STATE_SIT'''),
(2483300,9,1,0,0,0,100,0,2000,2000,0,0,0,53,0,24833,0,0,0,0,1,0,0,0,0,0,0,0,0,'Captain "Stash" Torgoley - On Script - Start WP Movement'),
(2483300,9,2,0,0,0,100,0,51000,51000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Captain "Stash" Torgoley - On Script - Say Line 1'),

(24835,0,0,0,11,0,100,0,0,0,0,0,0,80,2483500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'First Mate Kowalski - On Respawn - Call Timed Action List'),
(24835,0,1,0,40,0,100,0,2,24835,0,0,0,54,7000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'First Mate Kowalski - On WP 2 Reached - Pause WP Movement'),
(24835,0,2,0,58,0,100,0,0,24835,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,3.24629,'First Mate Kowalski - On WP Path Ended - Set Orientation'),

(2483500,9,0,0,0,0,100,0,2000,2000,0,0,0,1,0,0,0,0,0,0,19,24838,40,0,0,0,0,0,0,'First Mate Kowalski- On Script - Say Line 0 (Sailor Henders)'),
(2483500,9,1,0,0,0,100,0,2000,2000,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'First Mate Kowalski- On Script - Say Line 0'),
(2483500,9,2,0,0,0,100,0,1000,1000,0,0,0,53,0,24835,0,0,0,0,1,0,0,0,0,0,0,0,0,'First Mate Kowalski- On Script - Start WP Movement'),
(2483500,9,3,0,0,0,100,0,3000,3000,0,0,0,1,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'First Mate Kowalski - On Script - Say Line 1'),
(2483500,9,4,0,0,0,100,0,3000,3000,0,0,0,1,0,0,0,0,0,0,19,24837,40,0,0,0,0,0,0,'First Mate Kowalski- On Script - Say Line 0 (Navigator Mehran)'),
(2483500,9,5,0,0,0,100,0,3000,3000,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'First Mate Kowalski - On Script - Say Line 2'),
(2483500,9,6,0,0,0,100,0,4000,4000,0,0,0,1,0,0,0,0,0,0,19,24833,40,0,0,0,0,0,0,'First Mate Kowalski - On Script - Say Line 0 (Captain "Stash" Torgoley)'),

(24837,0,0,0,11,0,100,0,0,0,0,0,0,80,2483700,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Navigator Mehran - On Respawn - Call Timed Action List'),
(24837,0,1,0,40,0,100,0,14,24837,0,0,0,80,2483701,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Navigator Mehran - On WP 14 Reached - Call Timed Action List'),
(24837,0,2,0,58,0,100,0,0,24837,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,3.09629,'Navigator Mehran - On WP Path Ended - Set Orientation'),

(2483700,9,0,0,0,0,100,0,30000,30000,0,0,0,53,0,24837,0,0,0,0,1,0,0,0,0,0,0,0,0,'Navigator Mehran - On Script - Start WP Movement'),

(2483701,9,0,0,0,0,100,0,0,0,0,0,0,54,6000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Navigator Mehran - On Script - Pause WP Movement'),
(2483701,9,1,0,0,0,100,0,1000,1000,0,0,0,71,0,0,2705,0,0,0,1,0,0,0,0,0,0,0,0,'Navigator Mehran - On Script - Equip Mug'),
(2483701,9,2,0,0,0,100,0,0,0,0,0,0,5,92,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Navigator Mehran - On Script - Play Emote ''ONESHOT_EAT_NOSHEATHE'''),
(2483701,9,3,0,0,0,100,0,4000,4000,0,0,0,71,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Navigator Mehran - On Script - Unequip Mug');

DELETE FROM `waypoint_data` WHERE `id` IN (520180,520110,520130,520150,520160,520170,520140,520200);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `pathfinding`, `action`, `action_chance`, `wpguid`)
VALUES
-- Sailor Vines
(520180,1,-5.00423,6.2922,6.06386,0,0,0,0,0,100,0),
(520180,2,-12.6119,7.01457,6.09917,3.35526,12000,0,0,0,100,0),
(520180,3,-5.0301,6.34493,6.03202,0,0,0,0,0,100,0),
(520180,4,2.75709,5.56695,6.09874,0,0,0,0,0,100,0),
(520180,5,10.4526,5.92169,6.09844,0,0,0,0,0,100,0),
(520180,6,19.1946,6.29684,6.09704,0,0,0,0,0,100,0),
(520180,7,28.7417,6.70654,6.09605,0.70931,12000,0,0,0,100,0),
(520180,8,19.1946,6.29684,6.09704,0,0,0,0,0,100,0),
(520180,9,10.4526,5.92169,6.09844,0,0,0,0,0,100,0),
(520180,10,2.7667,5.59186,6.09844,0,0,0,0,0,100,0),
-- Sailor Wicks
(520170,1,9.59588,-1.21492,11.801,0.005729,15000,0,0,0,100,0),
(520170,2,10.8062,1.98193,11.8412,0,0,0,0,0,100,0),
(520170,3,9.38631,3.85644,11.7495,3.92005,12000,0,0,0,100,0),
(520170,4,10.7953,1.93005,11.842,0,0,0,0,0,100,0),
(520170,5,9.33737,-2.56899,11.7649,3.13858,12000,0,0,0,100,0),
(520170,6,9.54511,-4.65869,11.7357,0,0,0,0,0,100,0),
(520170,7,6.11803,-7.59311,11.5596,0,0,0,0,0,100,0),
(520170,8,6.11164,-9.6331,11.4645,4.70937,15000,0,0,0,100,0),
(520170,9,6.65472,-4.86817,11.6175,1.64239,12000,0,0,0,100,0),
(520170,10,10.3588,-4.94676,11.7634,0,0,0,0,0,100,0),
(520170,11,10.4669,0.00697304,11.8626,0,0,0,0,0,100,0),
(520170,12,8.95193,-0.00909011,11.8001,3.13554,12000,0,0,0,100,0),
-- Abe the Cabin Boy
(520140,1,-2.21688,2.61149,6.05655,4.10104,15000,0,0,0,100,0),
(520140,2,1.23568,4.18721,6.09768,0,0,0,0,0,100,0),
(520140,3,3.92275,4.11672,6.09768,0,0,0,0,0,100,0),
(520140,4,7.11704,0.401638,6.09768,0,0,0,0,0,100,0),
(520140,5,10.8876,-3.8983,6.09806,0,0,0,0,0,100,0),
(520140,6,17.289,-4.26774,6.09831,0,0,0,0,0,100,0),
(520140,7,26.2231,-4.78334,6.09793,0,0,0,0,0,100,0),
(520140,8,26.809,-0.608077,8.23749,0,0,0,0,0,100,0),
(520140,9,27.4913,3.62681,11.0662,0,0,0,0,0,100,0),
(520140,10,30.3661,4.88942,11.1497,0,15000,0,0,0,100,0),
(520140,11,24.9437,5.78543,11.1497,0,0,0,0,0,100,0),
(520140,12,21.2734,6.33249,12.2014,0,0,0,0,0,100,0),
(520140,13,18.0099,1.95173,12.1382,0,0,0,0,0,100,0),
(520140,14,14.1983,-3.05564,11.9492,0,0,0,0,0,100,0),
(520140,15,10.374,-8.07972,11.7389,0,15000,0,0,0,100,0),
(520140,16,2.00212,-4.5177,11.4219,0,0,0,0,0,100,0),
(520140,17,-3.57309,-4.96342,6.09813,0,0,0,0,0,100,0),
(520140,18,-4.74006,-1.97581,6.09813,0,0,0,0,0,100,0),
(520140,19,-4.27666,3.40472,6.09754,0,0,0,0,0,100,0),
-- Marine Anderson
(520200,1,6.11694,-6.60889,6.09714,2.28638,30000,0,0,0,100,0),
(520200,2,13.7731,-6.33803,6.09825,0,0,0,0,0,100,0),
(520200,3,21.6109,-5.99197,6.09685,0,0,0,0,0,100,0),
(520200,4,26.638,-5.77001,6.09726,0,0,0,0,0,100,0),
(520200,5,26.7409,-1.22817,7.82309,0,0,0,0,0,100,0),
(520200,6,26.8537,3.75555,11.1497,0,0,0,0,0,100,0),
(520200,7,24.5621,5.57903,11.1497,0,0,0,0,0,100,0),
(520200,8,21.0637,5.68124,12.2013,0,0,0,0,0,100,0),
(520200,9,16.2074,3.89981,12.0268,0,0,0,0,0,100,0),
(520200,10,13.8817,0.0162482,12.0034,3.14645,30000,0,0,0,100,0),
(520200,11,16.2074,3.89981,12.0268,0,0,0,0,0,100,0),
(520200,12,21.0637,5.68124,12.2013,0,0,0,0,0,100,0),
(520200,13,24.5621,5.57903,11.1497,0,0,0,0,0,100,0),
(520200,14,26.8537,3.75555,11.1497,0,0,0,0,0,100,0),
(520200,15,26.7409,-1.22817,7.82309,0,0,0,0,0,100,0),
(520200,16,26.638,-5.77001,6.09726,0,0,0,0,0,100,0),
(520200,17,21.6109,-5.99197,6.09685,0,0,0,0,0,100,0),
(520200,18,13.7731,-6.33803,6.09825,0,0,0,0,0,100,0);

DELETE FROM `waypoints` WHERE `entry` IN (24833,24835,24837);
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `point_comment`)
VALUES
(24833,1,34.9923,2.5455,6.09568,'Captain "Stash" Torgoley'),
(24833,2,30.1242,1.95084,6.09706,NULL),
(24833,3,26.3753,5.2431,6.09694,NULL),
(24833,4,17.1103,5.06528,6.0969,NULL),
(24833,5,8.41655,4.91918,6.07784,NULL),
(24833,6,7.90706,0.511436,6.10001,NULL),
(24833,7,11.1319,-4.53895,6.09912,NULL),
(24833,8,19.097,-4.84751,6.09761,NULL),
(24833,9,26.6733,-5.14004,6.09706,NULL),
(24833,10,26.6661,-3.59631,6.24177,NULL),
(24833,11,26.5742,0.362754,8.88638,NULL),
(24833,12,26.5105,4.08925,11.1501,NULL),
(24833,13,26.5119,5.52099,11.15,NULL),
(24833,14,24.1445,5.37906,11.168,NULL),
(24833,15,22.8177,5.50623,11.4848,NULL),
(24833,16,20.9025,5.62148,12.1954,NULL),
(24833,17,13.3153,5.73102,11.8802,NULL),
(24833,18,5.52823,5.85123,11.5602,NULL),

(24835,1,12.904,5.70626,11.7788,'First Mate Kowalski'),
(24835,2,20.6851,5.68537,12.1856,NULL),
(24835,3,16.8418,1.97447,12.0888,NULL),
(24835,4,17.0854,-2.68116,12.0745,NULL),
(24835,5,19.7316,-5.78791,12.1342,NULL),
(24835,6,23.5578,-5.40382,15.8888,NULL),
(24835,7,25.2988,-5.16777,16.1476,NULL),
(24835,8,24.8819,0.999151,16.1325,NULL),
(24835,9,24.5354,5.35213,16.0231,NULL),

(24837,1,35.5704,-2.76658,18.3435,'Navigator Mehran'),
(24837,2,31.566,-4.37693,17.3737,NULL),
(24837,3,23.3425,-5.41807,15.8953,NULL),
(24837,4,19.785,-5.64038,12.1392,NULL),
(24837,5,17.6733,-1.5999,12.1247,NULL),
(24837,6,17.5062,2.0143,12.1152,NULL),
(24837,7,20.8636,4.79993,12.2046,NULL),
(24837,8,24.2651,4.60988,11.1497,NULL),
(24837,9,26.5015,3.93806,11.1497,NULL),
(24837,10,26.4379,0.0415743,8.67149,NULL),
(24837,11,26.3733,-3.9199,6.09805,NULL),
(24837,12,26.3442,-5.69088,6.09665,NULL),
(24837,13,21.3011,-6.43658,6.09739,NULL),
(24837,14,19.3756,-7.30936,6.0335,NULL),
(24837,15,21.3011,-6.43658,6.09739,NULL),
(24837,16,26.3442,-5.69088,6.09665,NULL),
(24837,17,26.3733,-3.9199,6.09805,NULL),
(24837,18,26.4379,0.0415743,8.67149,NULL),
(24837,19,26.5015,3.93806,11.1497,NULL),
(24837,20,24.2651,4.60988,11.1497,NULL),
(24837,21,20.8636,4.79993,12.2046,NULL),
(24837,22,17.5062,2.0143,12.1152,NULL),
(24837,23,17.6733,-1.5999,12.1247,NULL),
(24837,24,19.785,-5.64038,12.1392,NULL),
(24837,25,23.3425,-5.41807,15.8953,NULL),
(24837,26,31.566,-4.37693,17.3737,NULL),
(24837,27,35.5704,-2.76658,18.3435,NULL),
(24837,28,33.8088,0.0680723,18.2875,NULL);

/*
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(24833,0,0,'Thank you, Mr. Kowalski! You may return to your post to oversee docking!',12,7,100,0,0,0,23945,0,'Captain \"Stash\" Torgoley'),
(24833,1,0,'Well done, all. Please bring us safely to our next port. ',12,7,100,0,0,0,23946,0,'Captain \"Stash\" Torgoley'),
(24835,0,0,'Thank you, Mr. Henders.',12,7,100,0,0,0,23942,0,'First Mate Kowalski'),
(24835,1,0,'Bring us into port, please, Mr. Mehran.',12,7,100,0,0,0,23943,0,'First Mate Kowalski'),
(24835,2,0,'Captain Stash! We\'ll be arriving shortly, sir!',12,7,100,0,0,0,23944,0,'First Mate Kowalski'),
(24838,0,0,'Land ho, Mr. Kowalski! Port is in sight, sir!',12,7,100,0,0,0,23941,0,'Sailor Henders');

(24838,0,0,0,25,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sailor - on reset - Say Line 0');
*/

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
