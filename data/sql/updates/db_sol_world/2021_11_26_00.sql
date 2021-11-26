-- DB update 2021_11_25_03 -> 2021_11_26_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2021_11_25_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2021_11_25_03 2021_11_26_00 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1637952996339039262'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1637952996339039262');

UPDATE `creature_template` SET `InhabitType` = 1 WHERE `entry` IN (7044,7045,7046);

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` = 5505;
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 2 WHERE `guid` = 3301;
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 2 WHERE `guid` = 3303;
UPDATE `creature_addon` SET `path_id` = 55050, `bytes2` = 0 WHERE `guid` = 5505;
UPDATE `creature_addon` SET `path_id` = 33010, `bytes2` = 0 WHERE `guid` = 3301;
UPDATE `creature_addon` SET `path_id` = 33030, `bytes2` = 0 WHERE `guid` = 3303;

DELETE FROM `creature` WHERE `guid` = 3551;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`)
VALUES
(3551,7045,0,0,0,1,1,9585,0,-8277.21,-1375.26,170.341,5.67462,500,0,3066,0,2,0,0,0,0);

DELETE FROM `creature_addon` WHERE `guid` = 3551;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`)
VALUES
(3551,35510,0,0,0,0,0,NULL);

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (7044,7046) AND `id` = 1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(7044,0,1,0,11,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Black Drake - On Respawn - Set Active On'),
(7046,0,1,0,11,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Searscale Drake - On Respawn - Set Active On');

DELETE FROM `waypoint_data` WHERE `id` IN (32980,32990,55050,32970,33010,33030,35510);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
-- Black Drake
(32980,1,-7887.52,-2901.83,133.315,0,30000,0,0,100,0),
(32980,2,-7896.48,-2902.29,133.728,0,0,0,0,100,0),
(32980,3,-7904.57,-2902.71,133.755,0,0,0,0,100,0),
(32980,4,-7916.45,-2903.5,133.262,0,0,0,0,100,0),
(32980,5,-7927.91,-2904.26,132.717,0,0,0,0,100,0),
(32980,6,-7937.02,-2904.86,132.602,0,0,0,0,100,0),
(32980,7,-7950.04,-2903.77,133.335,0,0,0,0,100,0),
(32980,8,-7964.27,-2902.58,134.338,0,0,0,0,100,0),
(32980,9,-7977.45,-2901.48,134.907,0,0,0,0,100,0),
(32980,10,-7986.3,-2907.54,135.481,0,0,0,0,100,0),
(32980,11,-7995.38,-2913.77,135.81,0,0,0,0,100,0),
(32980,12,-8002.48,-2918.63,135.621,0,0,0,0,100,0),
(32980,13,-8011.94,-2920.44,133.958,0,0,0,0,100,0),
(32980,14,-8020.77,-2922.13,132.556,0,0,0,0,100,0),
(32980,15,-8031.92,-2922.52,132.464,0,0,0,0,100,0),
(32980,16,-8040.16,-2922.81,133.084,0,0,0,0,100,0),
(32980,17,-8051.83,-2922.39,134.811,0,0,0,0,100,0),
(32980,18,-8060.55,-2922.08,135.276,0,0,0,0,100,0),
(32980,19,-8063.54,-2916.16,134.501,0,0,0,0,100,0),
(32980,20,-8069.98,-2903.44,133.912,0,0,0,0,100,0),
(32980,21,-8072.13,-2893.03,135.722,0,0,0,0,100,0),
(32980,22,-8074.87,-2879.73,138.258,0,0,0,0,100,0),
(32980,23,-8077.13,-2868.77,139.619,0,30000,0,0,100,0),
(32980,24,-8065.48,-2869.92,139.13,0,0,0,0,100,0),
(32980,25,-8054.94,-2870.96,138.455,0,0,0,0,100,0),
(32980,26,-8042.85,-2872.16,137.609,0,0,0,0,100,0),
(32980,27,-8031.77,-2873.26,136.181,0,0,0,0,100,0),
(32980,28,-8019.29,-2874.49,135.584,0,0,0,0,100,0),
(32980,29,-8008.68,-2876.55,136.03,0,0,0,0,100,0),
(32980,30,-7995.48,-2879.11,136.263,0,0,0,0,100,0),
(32980,31,-7983.28,-2882.3,135.635,0,0,0,0,100,0),
(32980,32,-7965.53,-2886.95,135.314,0,0,0,0,100,0),
(32980,33,-7955.15,-2884.24,135.69,0,0,0,0,100,0),
(32980,34,-7944.04,-2881.33,136.275,0,0,0,0,100,0),
(32980,35,-7934.05,-2878.2,136.194,0,0,0,0,100,0),
(32980,36,-7921.68,-2874.33,135.123,0,0,0,0,100,0),
(32980,37,-7914.41,-2881.24,134.753,0,0,0,0,100,0),
(32980,38,-7905.97,-2889.25,134.633,0,0,0,0,100,0),
(32980,39,-7899.43,-2893.4,134.648,0,0,0,0,100,0),
(32980,40,-7892.15,-2898.02,134.113,0,0,0,0,100,0),
-- Black Drake
(32990,1,-7587.71,-2753.68,133.177,0,30000,0,0,100,0),
(32990,2,-7592.37,-2761.88,133.355,0,0,0,0,100,0),
(32990,3,-7598.58,-2772.81,133.401,0,0,0,0,100,0),
(32990,4,-7604.32,-2782.9,133.335,0,0,0,0,100,0),
(32990,5,-7611.69,-2795.86,133.625,0,0,0,0,100,0),
(32990,6,-7616.92,-2805.05,133.727,0,0,0,0,100,0),
(32990,7,-7623.45,-2816.54,133.562,0,0,0,0,100,0),
(32990,8,-7631.85,-2831.3,133.494,0,0,0,0,100,0),
(32990,9,-7635.43,-2841.51,133.797,0,0,0,0,100,0),
(32990,10,-7639.25,-2852.41,134.402,0,0,0,0,100,0),
(32990,11,-7642.93,-2862.9,135.072,0,0,0,0,100,0),
(32990,12,-7645.65,-2870.67,135.292,0,0,0,0,100,0),
(32990,13,-7651.03,-2880.86,134.983,0,0,0,0,100,0),
(32990,14,-7657.31,-2892.75,134.415,0,0,0,0,100,0),
(32990,15,-7668.31,-2901.76,133.759,0,0,0,0,100,0),
(32990,16,-7679.54,-2910.96,133.451,0,0,0,0,100,0),
(32990,17,-7687.59,-2915.02,132.957,0,0,0,0,100,0),
(32990,18,-7699.81,-2921.18,132.51,0,0,0,0,100,0),
(32990,19,-7709.09,-2917.86,133.288,0,0,0,0,100,0),
(32990,20,-7717.89,-2914.71,133.436,0,0,0,0,100,0),
(32990,21,-7725.8,-2911.88,133.441,0,0,0,0,100,0),
(32990,22,-7731.43,-2901.38,133.079,0,30000,0,0,100,0),
(32990,23,-7724.99,-2890.05,131.849,0,0,0,0,100,0),
(32990,24,-7717.45,-2884.23,132.634,0,0,0,0,100,0),
(32990,25,-7709.12,-2877.8,133.325,0,0,0,0,100,0),
(32990,26,-7700.2,-2870.91,133.438,0,0,0,0,100,0),
(32990,27,-7689.72,-2862.52,133.431,0,0,0,0,100,0),
(32990,28,-7678.88,-2853.85,133.437,0,0,0,0,100,0),
(32990,29,-7667.1,-2844.42,133.642,0,0,0,0,100,0),
(32990,30,-7658.22,-2837.32,133.63,0,0,0,0,100,0),
(32990,31,-7652,-2829.36,133.457,0,0,0,0,100,0),
(32990,32,-7642.21,-2816.84,133.145,0,0,0,0,100,0),
(32990,33,-7634.87,-2807.44,134.014,0,0,0,0,100,0),
(32990,34,-7632.43,-2796.36,135.101,0,0,0,0,100,0),
(32990,35,-7630.23,-2786.38,135.317,0,0,0,0,100,0),
(32990,36,-7623.1,-2781.65,134.973,0,0,0,0,100,0),
(32990,37,-7614.07,-2775.65,133.969,0,0,0,0,100,0),
(32990,38,-7605.01,-2767.99,133.504,0,0,0,0,100,0),
(32990,39,-7595.53,-2759.98,133.383,0,0,0,0,100,0),
-- Black Drake
(55050,1,-8153.3,-2874.13,135.436,0,0,0,0,100,0),
(55050,2,-8158.59,-2864.95,135.029,0,0,0,0,100,0),
(55050,3,-8165.49,-2852.97,134.234,0,0,0,0,100,0),
(55050,4,-8173.46,-2839.14,134.98,0,0,0,0,100,0),
(55050,5,-8176.84,-2828.11,136.427,0,0,0,0,100,0),
(55050,6,-8180.89,-2814.9,137.014,0,0,0,0,100,0),
(55050,7,-8182.53,-2805.93,136.655,0,0,0,0,100,0),
(55050,8,-8184.71,-2793.91,136.516,0,0,0,0,100,0),
(55050,9,-8187.5,-2778.63,136.857,0,0,0,0,100,0),
(55050,10,-8186.47,-2768.08,136.37,0,0,0,0,100,0),
(55050,11,-8185.32,-2756.38,135.924,0,0,0,0,100,0),
(55050,12,-8182.7,-2742.41,136.56,0,0,0,0,100,0),
(55050,13,-8180.05,-2728.25,136.828,0,0,0,0,100,0),
(55050,14,-8177.15,-2719.74,136.521,0,0,0,0,100,0),
(55050,15,-8173.73,-2709.68,135.751,0,0,0,0,100,0),
(55050,16,-8171.51,-2694.18,134.422,0,0,0,0,100,0),
(55050,17,-8179.31,-2681.29,133.785,0,0,0,0,100,0),
(55050,18,-8188.07,-2674.85,134.335,0,0,0,0,100,0),
(55050,19,-8197.54,-2667.88,135.563,0,0,0,0,100,0),
(55050,20,-8209.85,-2667.54,135.958,0,0,0,0,100,0),
(55050,21,-8217.19,-2673.32,135.682,0,0,0,0,100,0),
(55050,22,-8222.87,-2677.79,135.297,0,0,0,0,100,0),
(55050,23,-8228.39,-2687.87,134.783,0,0,0,0,100,0),
(55050,24,-8230.31,-2701.77,134.818,0,0,0,0,100,0),
(55050,25,-8228.65,-2711.97,134.747,0,0,0,0,100,0),
(55050,26,-8227.13,-2721.26,134.608,0,0,0,0,100,0),
(55050,27,-8225.35,-2731.58,134.389,0,0,0,0,100,0),
(55050,28,-8223.57,-2741.88,134.794,0,0,0,0,100,0),
(55050,29,-8222.04,-2751.28,135.805,0,0,0,0,100,0),
(55050,30,-8220.71,-2759.39,136.797,0,0,0,0,100,0),
(55050,31,-8218.41,-2765.48,137.334,0,0,0,0,100,0),
(55050,32,-8216.1,-2771.61,137.482,0,0,0,0,100,0),
(55050,33,-8209.5,-2781.42,137.785,0,0,0,0,100,0),
(55050,34,-8203.16,-2790.85,137.323,0,0,0,0,100,0),
(55050,35,-8198.63,-2800.88,136.922,0,0,0,0,100,0),
(55050,36,-8194.6,-2809.8,137.17,0,0,0,0,100,0),
(55050,37,-8188.81,-2822.62,137.583,0,0,0,0,100,0),
(55050,38,-8186.23,-2828.33,137.181,0,0,0,0,100,0),
(55050,39,-8183.18,-2836.64,135.892,0,0,0,0,100,0),
(55050,40,-8178.75,-2848.74,134.149,0,0,0,0,100,0),
(55050,41,-8174.69,-2859.81,133.849,0,0,0,0,100,0),
(55050,42,-8170.56,-2871.08,134.081,0,0,0,0,100,0),
(55050,43,-8167.22,-2880.17,134.097,0,0,0,0,100,0),
(55050,44,-8164.35,-2888.01,133.985,0,0,0,0,100,0),
(55050,45,-8164.89,-2898.74,133.526,0,0,0,0,100,0),
(55050,46,-8165.45,-2909.6,133.334,0,0,0,0,100,0),
(55050,47,-8165.96,-2919.78,133.334,0,0,0,0,100,0),
(55050,48,-8166.43,-2929.01,133.334,0,0,0,0,100,0),
(55050,49,-8167.69,-2938.29,133.334,0,0,0,0,100,0),
(55050,50,-8169.1,-2948.66,133.334,0,0,0,0,100,0),
(55050,51,-8170.41,-2958.3,133.349,0,0,0,0,100,0),
(55050,52,-8168.52,-2967.91,133.975,0,0,0,0,100,0),
(55050,53,-8166.74,-2976.99,135.276,0,0,0,0,100,0),
(55050,54,-8164.83,-2986.74,135.809,0,0,0,0,100,0),
(55050,55,-8163.14,-2995.35,135.791,0,0,0,0,100,0),
(55050,56,-8155.85,-3004.12,134.947,0,0,0,0,100,0),
(55050,57,-8148.71,-3012.72,134.425,0,0,0,0,100,0),
(55050,58,-8141.62,-3015.69,134.422,0,0,0,0,100,0),
(55050,59,-8131.51,-3016.78,134.423,0,0,0,0,100,0),
(55050,60,-8119.16,-3011.6,134.491,0,0,0,0,100,0),
(55050,61,-8111.26,-3005.37,134.597,0,0,0,0,100,0),
(55050,62,-8104.84,-3000.31,134.754,0,0,0,0,100,0),
(55050,63,-8098.59,-2994.83,134.881,0,0,0,0,100,0),
(55050,64,-8093.87,-2990.69,134.723,0,0,0,0,100,0),
(55050,65,-8087.72,-2982.73,134.182,0,0,0,0,100,0),
(55050,66,-8081.98,-2975.3,134.29,0,0,0,0,100,0),
(55050,67,-8077.5,-2969.51,134.486,0,30000,0,0,100,0),
(55050,68,-8066.4,-2959.89,134.769,0,0,0,0,100,0),
(55050,69,-8059.79,-2953.8,135.33,0,0,0,0,100,0),
(55050,70,-8057.67,-2946.18,135.45,0,0,0,0,100,0),
(55050,71,-8055.65,-2938.94,135.143,0,0,0,0,100,0),
(55050,72,-8058.61,-2931.03,135.391,0,0,0,0,100,0),
(55050,73,-8061.08,-2924.45,135.34,0,0,0,0,100,0),
(55050,74,-8066.72,-2920.12,134.619,0,0,0,0,100,0),
(55050,75,-8074.06,-2914.48,133.588,0,0,0,0,100,0),
(55050,76,-8084.48,-2906.48,133.623,0,0,0,0,100,0),
(55050,77,-8093.47,-2899.57,134.066,0,0,0,0,100,0),
(55050,78,-8102.83,-2897.81,134.029,0,0,0,0,100,0),
(55050,79,-8110.15,-2896.43,134.398,0,0,0,0,100,0),
(55050,80,-8118.89,-2893.38,134.959,0,0,0,0,100,0),
(55050,81,-8127.5,-2890.37,135.515,0,0,0,0,100,0),
(55050,82,-8134.7,-2887.86,135.774,0,0,0,0,100,0),
(55050,83,-8141.39,-2882.92,135.92,0,0,0,0,100,0),
(55050,84,-8147.65,-2878.3,135.738,0,0,0,0,100,0),
-- Searscale Drake
(32970,1,-8059.18,-774.112,131.168,0,0,0,0,100,0),
(32970,2,-8068.54,-769.358,131.483,0,0,0,0,100,0),
(32970,3,-8077.03,-765.049,132.502,0,0,0,0,100,0),
(32970,4,-8087.29,-765.262,132.723,0,0,0,0,100,0),
(32970,5,-8097.32,-765.47,132.863,0,0,0,0,100,0),
(32970,6,-8109.11,-765.714,132.708,0,0,0,0,100,0),
(32970,7,-8118.4,-768.421,131.678,0,0,0,0,100,0),
(32970,8,-8130.06,-771.815,130.351,0,0,0,0,100,0),
(32970,9,-8143.5,-775.73,128.987,0,0,0,0,100,0),
(32970,10,-8150.69,-777.653,129.311,0,0,0,0,100,0),
(32970,11,-8156.52,-779.215,129.565,0,0,0,0,100,0),
(32970,12,-8164.57,-787.16,129.791,0,0,0,0,100,0),
(32970,13,-8171.35,-793.847,129.808,0,0,0,0,100,0),
(32970,14,-8174.75,-800.422,129.627,0,0,0,0,100,0),
(32970,15,-8177.26,-805.262,129.752,0,0,0,0,100,0),
(32970,16,-8182.33,-815.056,129.446,0,0,0,0,100,0),
(32970,17,-8186.61,-824.108,129.374,0,0,0,0,100,0),
(32970,18,-8190.69,-832.757,129.758,0,0,0,0,100,0),
(32970,19,-8192.93,-841.249,131.094,0,0,0,0,100,0),
(32970,20,-8193.93,-845.047,131.393,0,30000,0,0,100,0),
(32970,21,-8192.62,-840.682,130.953,0,0,0,0,100,0),
(32970,22,-8190.64,-834.078,129.915,0,0,0,0,100,0),
(32970,23,-8187.92,-825.021,129.36,0,0,0,0,100,0),
(32970,24,-8183.83,-818.495,129.459,0,0,0,0,100,0),
(32970,25,-8179,-810.782,129.538,0,0,0,0,100,0),
(32970,26,-8175.83,-805.72,129.606,0,0,0,0,100,0),
(32970,27,-8171.74,-799.188,129.268,0,0,0,0,100,0),
(32970,28,-8168.4,-793.843,129.829,0,0,0,0,100,0),
(32970,29,-8165.35,-788.977,129.856,0,0,0,0,100,0),
(32970,30,-8159.71,-785.038,129.776,0,0,0,0,100,0),
(32970,31,-8154.26,-781.235,129.596,0,0,0,0,100,0),
(32970,32,-8148.53,-777.234,129.072,0,0,0,0,100,0),
(32970,33,-8138.53,-776.39,129.272,0,0,0,0,100,0),
(32970,34,-8130.31,-775.697,129.976,0,0,0,0,100,0),
(32970,35,-8121.34,-775.198,130.432,0,0,0,0,100,0),
(32970,36,-8108.76,-774.499,131.287,0,0,0,0,100,0),
(32970,37,-8097.52,-773.875,131.584,0,0,0,0,100,0),
(32970,38,-8089.23,-777.016,131.896,0,0,0,0,100,0),
(32970,39,-8077.47,-781.475,132.323,0,0,0,0,100,0),
(32970,40,-8066.15,-785.764,132.747,0,0,0,0,100,0),
(32970,41,-8056.97,-788.033,132.658,0,0,0,0,100,0),
(32970,42,-8042.24,-791.671,132.046,0,0,0,0,100,0),
(32970,43,-8030.65,-794.536,131.447,0,0,0,0,100,0),
(32970,44,-8019.63,-789.749,129.64,0,0,0,0,100,0),
(32970,45,-8006.25,-783.941,127.087,0,0,0,0,100,0),
(32970,46,-7992.99,-778.182,125.303,0,0,0,0,100,0),
(32970,47,-7980.9,-781.731,124.985,0,0,0,0,100,0),
(32970,48,-7968.4,-785.401,125.061,0,0,0,0,100,0),
(32970,49,-7959.57,-791.505,125.694,0,0,0,0,100,0),
(32970,50,-7951.23,-797.274,127.059,0,0,0,0,100,0),
(32970,51,-7949.08,-804.42,127.961,0,0,0,0,100,0),
(32970,52,-7947.09,-811.039,128.986,0,30000,0,0,100,0),
(32970,53,-7956.53,-815.511,128.158,0,0,0,0,100,0),
(32970,54,-7963.52,-816.812,129.853,0,0,0,0,100,0),
(32970,55,-7968.68,-817.772,131.062,0,0,0,0,100,0),
(32970,56,-7973.12,-818.599,132.056,0,0,0,0,100,0),
(32970,57,-7977.56,-818.926,131.309,0,0,0,0,100,0),
(32970,58,-7982.52,-819.291,129.307,0,0,0,0,100,0),
(32970,59,-7993.02,-819.742,130.554,0,0,0,0,100,0),
(32970,60,-8001.88,-820.122,131.905,0,0,0,0,100,0),
(32970,61,-8010.37,-814.148,132.285,0,0,0,0,100,0),
(32970,62,-8020.72,-806.863,132.384,0,0,0,0,100,0),
(32970,63,-8027.76,-800.561,132.133,0,0,0,0,100,0),
(32970,64,-8038.09,-791.317,131.622,0,0,0,0,100,0),
(32970,65,-8047.69,-782.727,131.246,0,0,0,0,100,0),
(32970,66,-8054.04,-777.969,131.313,0,0,0,0,100,0),
-- Searscale Drake
(33010,1,-8240.78,-1209.91,142.557,0,0,0,0,100,0),
(33010,2,-8240.78,-1225.54,142.558,0,0,0,0,100,0),
(33010,3,-8237.48,-1241.32,142.557,0,0,0,0,100,0),
(33010,4,-8234.02,-1257.07,142.79,0,30000,0,0,100,0),
(33010,5,-8237.48,-1241.32,142.557,0,0,0,0,100,0),
(33010,6,-8240.78,-1225.54,142.558,0,0,0,0,100,0),
(33010,7,-8240.78,-1209.91,142.557,0,0,0,0,100,0),
(33010,8,-8240.77,-1192.64,142.558,0,0,0,0,100,0),
(33010,9,-8223.62,-1182.31,142.557,0,0,0,0,100,0),
(33010,10,-8214.57,-1170.56,142.557,0,0,0,0,100,0),
(33010,11,-8209.18,-1161.82,142.657,0,0,0,0,100,0),
(33010,12,-8208.74,-1148.29,143.278,0,0,0,0,100,0),
(33010,13,-8208.28,-1134.16,144.414,0,0,0,0,100,0),
(33010,14,-8207.92,-1123.08,145.856,0,0,0,0,100,0),
(33010,15,-8207.51,-1110.46,147.778,0,0,0,0,100,0),
(33010,16,-8211.34,-1101.27,148.208,0,0,0,0,100,0),
(33010,17,-8214.94,-1092.66,147.474,0,0,0,0,100,0),
(33010,18,-8219.24,-1082.34,145.264,0,0,0,0,100,0),
(33010,19,-8229.04,-1071.07,143.146,0,0,0,0,100,0),
(33010,20,-8230.14,-1060.53,142.717,0,0,0,0,100,0),
(33010,21,-8231.45,-1047.89,142.891,0,0,0,0,100,0),
(33010,22,-8232.87,-1034.32,143.442,0,0,0,0,100,0),
(33010,23,-8234.23,-1021.24,144.027,0,0,0,0,100,0),
(33010,24,-8239.73,-1009.39,143.41,0,0,0,0,100,0),
(33010,25,-8244.22,-999.402,143.081,0,0,0,0,100,0),
(33010,26,-8249.09,-988.546,141.433,0,0,0,0,100,0),
(33010,27,-8249.18,-981.998,138.633,0,0,0,0,100,0),
(33010,28,-8248.41,-975.625,136.552,0,0,0,0,100,0),
(33010,29,-8236.13,-969.977,135.431,0,0,0,0,100,0),
(33010,30,-8224.87,-964.599,134.015,0,0,0,0,100,0),
(33010,31,-8213.25,-959.05,133.334,0,0,0,0,100,0),
(33010,32,-8204.97,-955.095,133.361,0,0,0,0,100,0),
(33010,33,-8195.36,-964.788,133.758,0,0,0,0,100,0),
(33010,34,-8186.89,-973.323,134.395,0,0,0,0,100,0),
(33010,35,-8177.19,-983.105,135.177,0,0,0,0,100,0),
(33010,36,-8168.36,-992.015,135.996,0,0,0,0,100,0),
(33010,37,-8161.5,-998.936,136.123,0,0,0,0,100,0),
(33010,38,-8152.28,-1008.23,134.64,0,0,0,0,100,0),
(33010,39,-8149.31,-1019.99,133.596,0,0,0,0,100,0),
(33010,40,-8145.14,-1036.5,133.036,0,0,0,0,100,0),
(33010,41,-8140.16,-1058.49,132.41,0,0,0,0,100,0),
(33010,42,-8140.2,-1073.19,131.697,0,0,0,0,100,0),
(33010,43,-8140.24,-1089,131.806,0,0,0,0,100,0),
(33010,44,-8143.17,-1103.52,133.131,0,0,0,0,100,0),
(33010,45,-8146.06,-1118.03,134.608,0,0,0,0,100,0),
(33010,46,-8148.86,-1132.12,135.755,0,0,0,0,100,0),
(33010,47,-8151.69,-1146.32,136.249,0,0,0,0,100,0),
(33010,48,-8154.5,-1160.46,137.051,0,0,0,0,100,0),
(33010,49,-8154.46,-1172.92,135.534,0,0,0,0,100,0),
(33010,50,-8154.42,-1184.36,135.185,0,0,0,0,100,0),
(33010,51,-8154.39,-1196.51,136.704,0,0,0,0,100,0),
(33010,52,-8146.58,-1208.7,133.238,0,0,0,0,100,0),
(33010,53,-8137.84,-1222.35,133.059,0,0,0,0,100,0),
(33010,54,-8130,-1234.59,133.141,0,30000,0,0,100,0),
(33010,55,-8137.84,-1222.35,133.059,0,0,0,0,100,0),
(33010,56,-8146.58,-1208.7,133.238,0,0,0,0,100,0),
(33010,57,-8154.39,-1196.51,136.704,0,0,0,0,100,0),
(33010,58,-8154.42,-1184.36,135.185,0,0,0,0,100,0),
(33010,59,-8154.46,-1172.92,135.534,0,0,0,0,100,0),
(33010,60,-8154.5,-1160.46,137.051,0,0,0,0,100,0),
(33010,61,-8151.69,-1146.32,136.249,0,0,0,0,100,0),
(33010,62,-8148.86,-1132.12,135.755,0,0,0,0,100,0),
(33010,63,-8146.06,-1118.03,134.608,0,0,0,0,100,0),
(33010,64,-8143.17,-1103.52,133.131,0,0,0,0,100,0),
(33010,65,-8140.24,-1089,131.806,0,0,0,0,100,0),
(33010,66,-8140.2,-1073.19,131.697,0,0,0,0,100,0),
(33010,67,-8140.16,-1058.49,132.41,0,0,0,0,100,0),
(33010,68,-8145.14,-1036.5,133.036,0,0,0,0,100,0),
(33010,69,-8149.31,-1019.99,133.596,0,0,0,0,100,0),
(33010,70,-8152.28,-1008.23,134.64,0,0,0,0,100,0),
(33010,71,-8161.5,-998.936,136.123,0,0,0,0,100,0),
(33010,72,-8168.36,-992.015,135.996,0,0,0,0,100,0),
(33010,73,-8177.19,-983.105,135.177,0,0,0,0,100,0),
(33010,74,-8186.89,-973.323,134.395,0,0,0,0,100,0),
(33010,75,-8195.36,-964.788,133.758,0,0,0,0,100,0),
(33010,76,-8204.97,-955.095,133.361,0,0,0,0,100,0),
(33010,77,-8213.25,-959.05,133.334,0,0,0,0,100,0),
(33010,78,-8224.87,-964.599,134.015,0,0,0,0,100,0),
(33010,79,-8236.13,-969.977,135.431,0,0,0,0,100,0),
(33010,80,-8248.41,-975.625,136.552,0,0,0,0,100,0),
(33010,81,-8249.18,-981.998,138.633,0,0,0,0,100,0),
(33010,82,-8249.09,-988.546,141.433,0,0,0,0,100,0),
(33010,83,-8244.22,-999.402,143.081,0,0,0,0,100,0),
(33010,84,-8239.73,-1009.39,143.41,0,0,0,0,100,0),
(33010,85,-8234.23,-1021.24,144.027,0,0,0,0,100,0),
(33010,86,-8232.87,-1034.32,143.442,0,0,0,0,100,0),
(33010,87,-8231.45,-1047.89,142.891,0,0,0,0,100,0),
(33010,88,-8230.14,-1060.53,142.717,0,0,0,0,100,0),
(33010,89,-8229.04,-1071.07,143.146,0,0,0,0,100,0),
(33010,90,-8219.24,-1082.34,145.264,0,0,0,0,100,0),
(33010,91,-8214.94,-1092.66,147.474,0,0,0,0,100,0),
(33010,92,-8211.34,-1101.27,148.208,0,0,0,0,100,0),
(33010,93,-8207.51,-1110.46,147.778,0,0,0,0,100,0),
(33010,94,-8207.92,-1123.08,145.856,0,0,0,0,100,0),
(33010,95,-8208.28,-1134.16,144.414,0,0,0,0,100,0),
(33010,96,-8208.74,-1148.29,143.278,0,0,0,0,100,0),
(33010,97,-8209.18,-1161.82,142.657,0,0,0,0,100,0),
(33010,98,-8214.57,-1170.56,142.557,0,0,0,0,100,0),
(33010,99,-8223.62,-1182.31,142.557,0,0,0,0,100,0),
(33010,100,-8240.77,-1192.64,142.558,0,0,0,0,100,0),
-- Searscale Drake
(33030,1,-8343.92,-982.414,183.892,0,0,0,0,100,0),
(33030,2,-8356.43,-972.19,187.21,0,0,0,0,100,0),
(33030,3,-8371.51,-965.374,190.409,0,0,0,0,100,0),
(33030,4,-8386.62,-958.549,195.742,0,0,0,0,100,0),
(33030,5,-8403.44,-951.619,202.745,0,0,0,0,100,0),
(33030,6,-8420.13,-944.613,209.773,0,0,0,0,100,0),
(33030,7,-8429.71,-940.592,213.784,0,0,0,0,100,0),
(33030,8,-8436.38,-937.791,216.266,5.80842,30000,0,0,100,0),
(33030,9,-8429.71,-940.592,213.784,0,0,0,0,100,0),
(33030,10,-8420.13,-944.613,209.773,0,0,0,0,100,0),
(33030,11,-8403.44,-951.619,202.745,0,0,0,0,100,0),
(33030,12,-8386.62,-958.549,195.742,0,0,0,0,100,0),
(33030,13,-8371.51,-965.374,190.409,0,0,0,0,100,0),
(33030,14,-8356.43,-972.19,187.21,0,0,0,0,100,0),
(33030,15,-8343.92,-982.414,183.892,0,0,0,0,100,0),
(33030,16,-8331.53,-992.73,181.109,0,0,0,0,100,0),
(33030,17,-8317.38,-1000.24,176.414,0,0,0,0,100,0),
(33030,18,-8303.2,-1007.62,172.387,0,0,0,0,100,0),
(33030,19,-8295.65,-1011.82,168.283,0,0,0,0,100,0),
(33030,20,-8291.78,-1013.97,164.279,0,0,0,0,100,0),
(33030,21,-8280.37,-1020.23,155.476,0,0,0,0,100,0),
(33030,22,-8266.96,-1030.16,150.092,0,0,0,0,100,0),
(33030,23,-8253.74,-1040.01,147.142,0,0,0,0,100,0),
(33030,24,-8238.5,-1028.7,144.282,0,0,0,0,100,0),
(33030,25,-8226.03,-1019.44,144.933,0,0,0,0,100,0),
(33030,26,-8216.24,-1008.78,145.943,0,0,0,0,100,0),
(33030,27,-8209.48,-1001.43,144.998,0,0,0,0,100,0),
(33030,28,-8202.62,-993.957,143.333,0,0,0,0,100,0),
(33030,29,-8195.72,-986.492,139.294,0,0,0,0,100,0),
(33030,30,-8187.2,-977.394,134.704,0,0,0,0,100,0),
(33030,31,-8190.01,-959.582,133.973,0,0,0,0,100,0),
(33030,32,-8192.8,-941.825,133.55,0,0,0,0,100,0),
(33030,33,-8195.58,-924.219,132.932,0,0,0,0,100,0),
(33030,34,-8193.44,-908.781,132.9,0,0,0,0,100,0),
(33030,35,-8190.92,-890.569,132.913,0,0,0,0,100,0),
(33030,36,-8189.43,-879.844,132.55,0,0,0,0,100,0),
(33030,37,-8190.97,-865.199,132.269,0,0,0,0,100,0),
(33030,38,-8192.66,-849.097,131.56,0,30000,0,0,100,0),
(33030,39,-8190.97,-865.199,132.269,0,0,0,0,100,0),
(33030,40,-8189.43,-879.844,132.55,0,0,0,0,100,0),
(33030,41,-8190.92,-890.569,132.913,0,0,0,0,100,0),
(33030,42,-8193.44,-908.781,132.9,0,0,0,0,100,0),
(33030,43,-8195.58,-924.219,132.932,0,0,0,0,100,0),
(33030,44,-8192.8,-941.825,133.55,0,0,0,0,100,0),
(33030,45,-8190.01,-959.582,133.973,0,0,0,0,100,0),
(33030,46,-8187.2,-977.394,134.704,0,0,0,0,100,0),
(33030,47,-8195.72,-986.492,139.294,0,0,0,0,100,0),
(33030,48,-8202.62,-993.957,143.333,0,0,0,0,100,0),
(33030,49,-8209.48,-1001.43,144.998,0,0,0,0,100,0),
(33030,50,-8216.24,-1008.78,145.943,0,0,0,0,100,0),
(33030,51,-8226.03,-1019.44,144.933,0,0,0,0,100,0),
(33030,52,-8238.5,-1028.7,144.282,0,0,0,0,100,0),
(33030,53,-8253.74,-1040.01,147.142,0,0,0,0,100,0),
(33030,54,-8266.96,-1030.16,150.092,0,0,0,0,100,0),
(33030,55,-8280.37,-1020.23,155.476,0,0,0,0,100,0),
(33030,56,-8291.78,-1013.97,164.279,0,0,0,0,100,0),
(33030,57,-8295.65,-1011.82,168.283,0,0,0,0,100,0),
(33030,58,-8303.2,-1007.62,172.387,0,0,0,0,100,0),
(33030,59,-8317.38,-1000.24,176.414,0,0,0,0,100,0),
(33030,60,-8331.53,-992.73,181.109,0,0,0,0,100,0),
-- Scalding Drake
(35510,1,-8277.21,-1375.26,170.341,5.67462,30000,0,0,100,0),
(35510,2,-8273.9,-1377.44,167.036,0,0,0,0,100,0),
(35510,3,-8261.8,-1385.25,160.163,0,0,0,0,100,0),
(35510,4,-8253.32,-1390.73,159.066,0,0,0,0,100,0),
(35510,5,-8245.22,-1392.57,156.291,0,0,0,0,100,0),
(35510,6,-8237.22,-1390.29,153.305,0,0,0,0,100,0),
(35510,7,-8231.86,-1389.59,151.409,0,0,0,0,100,0),
(35510,8,-8225.06,-1388.82,148.418,0,0,0,0,100,0),
(35510,9,-8215.9,-1387.79,145.47,0,0,0,0,100,0),
(35510,10,-8206.84,-1379.41,142.727,0,0,0,0,100,0),
(35510,11,-8197.48,-1370.74,143.157,0,0,0,0,100,0),
(35510,12,-8188.87,-1362.77,139.7,0,0,0,0,100,0),
(35510,13,-8179.62,-1354.21,135.245,0,0,0,0,100,0),
(35510,14,-8170.94,-1346.18,137.233,0,0,0,0,100,0),
(35510,15,-8166.11,-1342.13,137.527,0,0,0,0,100,0),
(35510,16,-8157.11,-1334.57,137.089,0,0,0,0,100,0),
(35510,17,-8145.1,-1324.49,135.296,0,0,0,0,100,0),
(35510,18,-8133.24,-1315.3,133.52,0,0,0,0,100,0),
(35510,19,-8121.75,-1306.4,133.52,0,0,0,0,100,0),
(35510,20,-8110.75,-1299.01,133.687,0,0,0,0,100,0),
(35510,21,-8101.16,-1292.57,134.619,0,0,0,0,100,0),
(35510,22,-8092.07,-1286.47,137.857,0,0,0,0,100,0),
(35510,23,-8083.96,-1281.01,141.163,0,30000,0,0,100,0),
(35510,24,-8092.07,-1286.47,137.857,0,0,0,0,100,0),
(35510,25,-8101.16,-1292.57,134.619,0,0,0,0,100,0),
(35510,26,-8110.75,-1299.01,133.687,0,0,0,0,100,0),
(35510,27,-8121.75,-1306.4,133.52,0,0,0,0,100,0),
(35510,28,-8133.24,-1315.3,133.52,0,0,0,0,100,0),
(35510,29,-8145.1,-1324.49,135.296,0,0,0,0,100,0),
(35510,30,-8157.11,-1334.57,137.089,0,0,0,0,100,0),
(35510,31,-8166.11,-1342.13,137.527,0,0,0,0,100,0),
(35510,32,-8170.94,-1346.18,137.233,0,0,0,0,100,0),
(35510,33,-8179.62,-1354.21,135.245,0,0,0,0,100,0),
(35510,34,-8188.87,-1362.77,139.7,0,0,0,0,100,0),
(35510,35,-8197.48,-1370.74,143.157,0,0,0,0,100,0),
(35510,36,-8206.84,-1379.41,142.727,0,0,0,0,100,0),
(35510,37,-8215.9,-1387.79,145.47,0,0,0,0,100,0),
(35510,38,-8225.06,-1388.82,148.418,0,0,0,0,100,0),
(35510,39,-8231.86,-1389.59,151.409,0,0,0,0,100,0),
(35510,40,-8237.22,-1390.29,153.305,0,0,0,0,100,0),
(35510,41,-8245.22,-1392.57,156.291,0,0,0,0,100,0),
(35510,42,-8253.32,-1390.73,159.066,0,0,0,0,100,0),
(35510,43,-8261.8,-1385.25,160.163,0,0,0,0,100,0),
(35510,44,-8273.9,-1377.44,167.036,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
