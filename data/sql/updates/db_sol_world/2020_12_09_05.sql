-- DB update 2020_12_09_04 -> 2020_12_09_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2020_12_09_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2020_12_09_04 2020_12_09_05 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1607498400938071539'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1607498400938071539');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 7137;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 7137 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(7137,0,0,0,11,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Immolatus - On Respawn - Set Active On');

DELETE FROM `waypoint_data` WHERE `id` = 396240;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(396240,1,5549.68,-840.514,359.402,2.1894,20000,0,0,100,0),
(396240,2,5542.71,-836.157,355.891,0,0,0,0,100,0),
(396240,3,5532.83,-831.703,354.789,0,0,0,0,100,0),
(396240,4,5520.52,-838.345,354.74,0,0,0,0,100,0),
(396240,5,5508.33,-845.186,356.734,0,0,0,0,100,0),
(396240,6,5498.46,-850.944,359.236,0,0,0,0,100,0),
(396240,7,5489.66,-856.072,361.636,0,0,0,0,100,0),
(396240,8,5478.37,-866.771,363.469,0,0,0,0,100,0),
(396240,9,5481.89,-880.323,363.071,0,0,0,0,100,0),
(396240,10,5484.58,-899.967,363.181,0,0,0,0,100,0),
(396240,11,5485.26,-913.928,364.029,0,0,0,0,100,0),
(396240,12,5488.02,-933.908,364.529,0,0,0,0,100,0),
(396240,13,5496.16,-947.73,366.818,0,0,0,0,100,0),
(396240,14,5504.58,-958.918,369.606,0,0,0,0,100,0),
(396240,15,5509.97,-965.793,370.938,0,0,0,0,100,0),
(396240,16,5533.07,-979.722,370.834,0,0,0,0,100,0),
(396240,17,5550.57,-980.389,370.885,0,0,0,0,100,0),
(396240,18,5560,-977.326,372.401,0,0,0,0,100,0),
(396240,19,5562.15,-969.787,375.501,0,0,0,0,100,0),
(396240,20,5560.47,-962.127,376.558,0,0,0,0,100,0),
(396240,21,5555.92,-947.519,376.701,0,0,0,0,100,0),
(396240,22,5564.73,-931.947,376.778,0,0,0,0,100,0),
(396240,23,5569.37,-920.568,378.232,0,0,0,0,100,0),
(396240,24,5571.72,-911.95,379.876,0,0,0,0,100,0),
(396240,25,5572.08,-901.884,378.923,0,0,0,0,100,0),
(396240,26,5572.81,-894.05,377.641,0,0,0,0,100,0),
(396240,27,5580.26,-877.34,377.476,0,0,0,0,100,0),
(396240,28,5586.86,-869.257,379.443,0,0,0,0,100,0),
(396240,29,5592.7,-863.539,380.52,0,0,0,0,100,0),
(396240,30,5603.35,-852.397,378.051,0,0,0,0,100,0),
(396240,31,5610.45,-843.737,378.238,0,0,0,0,100,0),
(396240,32,5625.29,-841.917,378.562,0,0,0,0,100,0),
(396240,33,5640.93,-840.783,378.575,0,0,0,0,100,0),
(396240,34,5654.63,-839.337,378.547,0,0,0,0,100,0),
(396240,35,5665.12,-836.621,377.669,0,0,0,0,100,0),
(396240,36,5668.63,-820.593,376.278,0,0,0,0,100,0),
(396240,37,5678.6,-814.041,378.099,0,0,0,0,100,0),
(396240,38,5688.61,-807.559,381.391,0,0,0,0,100,0),
(396240,39,5700.84,-796.715,382.915,0,0,0,0,100,0),
(396240,40,5703.85,-789.476,382.508,0,0,0,0,100,0),
(396240,41,5706.57,-781.323,380.318,0,0,0,0,100,0),
(396240,42,5707.66,-773.164,382.166,0,0,0,0,100,0),
(396240,43,5706.55,-766.631,381.511,0,0,0,0,100,0),
(396240,44,5709.39,-757.37,378.232,0,0,0,0,100,0),
(396240,45,5706.94,-743.758,377.183,0,0,0,0,100,0),
(396240,46,5712.87,-732.114,377.226,0,0,0,0,100,0),
(396240,47,5720.86,-714.671,376.912,0,0,0,0,100,0),
(396240,48,5717.5,-703.872,377.003,0,0,0,0,100,0),
(396240,49,5714.32,-693.628,376.856,0,0,0,0,100,0),
(396240,50,5708.77,-679.422,374.512,0,0,0,0,100,0),
(396240,51,5701.11,-669.311,372.133,0,0,0,0,100,0),
(396240,52,5693.64,-659.514,372.156,0,0,0,0,100,0),
(396240,53,5689.24,-652.491,369.991,0,0,0,0,100,0),
(396240,54,5685.05,-645.803,366.552,0,0,0,0,100,0),
(396240,55,5676.16,-649.635,361.745,0,0,0,0,100,0),
(396240,56,5669.62,-651.046,357.536,0,0,0,0,100,0),
(396240,57,5663.02,-652.333,351.436,0,0,0,0,100,0),
(396240,58,5658.77,-654.522,347.6,0,0,0,0,100,0),
(396240,59,5654.68,-657.119,345.368,0,0,0,0,100,0),
(396240,60,5643.33,-664.307,344.942,0,0,0,0,100,0),
(396240,61,5634.09,-670.645,345.163,0,0,0,0,100,0),
(396240,62,5625.09,-681.619,343.377,0,0,0,0,100,0),
(396240,63,5612.52,-693.264,343.875,0,0,0,0,100,0),
(396240,64,5597.38,-701.346,342.515,0,0,0,0,100,0),
(396240,65,5587.14,-706.573,341.171,0,0,0,0,100,0),
(396240,66,5574.14,-710.605,340.33,0,0,0,0,100,0),
(396240,67,5567.48,-714.733,340.56,0,0,0,0,100,0),
(396240,68,5555.28,-723.237,341.504,0,0,0,0,100,0),
(396240,69,5553.53,-738.075,343.025,0,0,0,0,100,0),
(396240,70,5553.02,-757.824,342.597,0,0,0,0,100,0),
(396240,71,5551.23,-773.771,345.025,0,0,0,0,100,0),
(396240,72,5550.14,-787.478,347.103,0,0,0,0,100,0),
(396240,73,5548.92,-802.745,349.058,0,0,0,0,100,0),
(396240,74,5545.93,-813.505,352.271,0,0,0,0,100,0),
(396240,75,5542.16,-821.2,354.516,0,0,0,0,100,0),
(396240,76,5543.59,-829.653,355.482,0,0,0,0,100,0),
(396240,77,5547.43,-834.719,356.579,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
