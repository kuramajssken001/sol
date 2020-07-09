-- DB update 2020_07_09_00 -> 2020_07_09_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2020_07_09_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2020_07_09_00 2020_07_09_01 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1594276703375285187'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1594276703375285187');

-- Anaya Dawnrunner: Set active
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3667 AND `source_type` = 0 AND `id` = 2;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(3667,0,2,0,11,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Anaya Dawnrunner - On Respawn - Set Active On');

-- Anaya Dawnrunner: Waypoint movement
DELETE FROM `waypoint_data` WHERE `id` = 370710;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(370710,1,5680.94,203.747,26.8227,0,0,0,0,100,0),
(370710,2,5693.18,202.087,26.0062,0,0,0,0,100,0),
(370710,3,5703.5,206.533,26.3976,0,0,0,0,100,0),
(370710,4,5715.81,211.564,26.9171,0,0,0,0,100,0),
(370710,5,5728.41,209.91,27.8044,0,0,0,0,100,0),
(370710,6,5741.01,204.449,29.3765,0,0,0,0,100,0),
(370710,7,5746.89,197.466,30.1032,0,0,0,0,100,0),
(370710,8,5749.39,183.072,31.6527,0,0,0,0,100,0),
(370710,9,5749.75,165.358,32.6558,0,0,0,0,100,0),
(370710,10,5746.15,147.937,31.9564,0,0,0,0,100,0),
(370710,11,5741.01,132.449,31.44,0,0,0,0,100,0),
(370710,12,5737.21,118.746,31.6295,0,0,0,0,100,0),
(370710,13,5737.27,104.975,31.1923,0,0,0,0,100,0),
(370710,14,5747.27,94.4233,31.5384,0,0,0,0,100,0),
(370710,15,5760.08,87.8406,32.0738,0,0,0,0,100,0),
(370710,16,5771.24,87.1282,32.8466,0,0,0,0,100,0),
(370710,17,5784.76,87.8278,32.2285,0,0,0,0,100,0),
(370710,18,5796.61,94.6434,32.1337,0,0,0,0,100,0),
(370710,19,5805.06,104.272,31.0649,0,0,0,0,100,0),
(370710,20,5811.08,118.688,31.027,0,0,0,0,100,0),
(370710,21,5815.2,133.276,30.9419,0,0,0,0,100,0),
(370710,22,5815.07,148.106,30.9152,0,0,0,0,100,0),
(370710,23,5813.77,163.219,30.8309,0,0,0,0,100,0),
(370710,24,5812.32,180.074,30.8209,0,0,0,0,100,0),
(370710,25,5812.53,196.632,30.6814,0,0,0,0,100,0),
(370710,26,5810.79,210.036,30.2996,0,0,0,0,100,0),
(370710,27,5806.02,219.567,30.3511,0,0,0,0,100,0),
(370710,28,5798.32,225.002,30.0902,0,0,0,0,100,0),
(370710,29,5787.16,226.896,29.9394,0,0,0,0,100,0),
(370710,30,5776.18,219.049,29.9259,0,0,0,0,100,0),
(370710,31,5767.26,209.34,30.3018,0,0,0,0,100,0),
(370710,32,5756.4,206.257,30.0809,0,0,0,0,100,0),
(370710,33,5743.9,207.734,29.4887,0,0,0,0,100,0),
(370710,34,5729.99,212.016,27.9076,0,0,0,0,100,0),
(370710,35,5715.78,209.081,26.8055,0,0,0,0,100,0),
(370710,36,5702.54,201.016,26.3381,0,0,0,0,100,0),
(370710,37,5690.8,190.771,26.2839,0,0,0,0,100,0),
(370710,38,5685.78,175.918,27.8643,0,0,0,0,100,0),
(370710,39,5681.24,162.083,29.161,0,0,0,0,100,0),
(370710,40,5676.4,147.196,29.9354,0,0,0,0,100,0),
(370710,41,5666.69,139.036,30.6115,0,0,0,0,100,0),
(370710,42,5650.47,133.369,30.8467,0,0,0,0,100,0),
(370710,43,5635.73,131.037,30.106,0,0,0,0,100,0),
(370710,44,5629.98,125.184,28.9908,0,0,0,0,100,0),
(370710,45,5619.66,114.925,26.7356,0,0,0,0,100,0),
(370710,46,5604.99,121.417,25.7667,0,0,0,0,100,0),
(370710,47,5598.24,131.694,26.6801,0,0,0,0,100,0),
(370710,48,5593.16,144.531,28.0487,0,0,0,0,100,0),
(370710,49,5591.96,157.918,28.2676,0,0,0,0,100,0),
(370710,50,5591.2,172.062,27.8291,0,0,0,0,100,0),
(370710,51,5599.89,182.317,28.2093,0,0,0,0,100,0),
(370710,52,5609.15,192.019,27.6733,0,0,0,0,100,0),
(370710,53,5621.33,201.892,26.0223,0,0,0,0,100,0),
(370710,54,5629.1,212.851,25.2154,0,0,0,0,100,0),
(370710,55,5634.12,232.882,24.327,0,10000,0,0,100,0),
(370710,56,5627.68,201.562,25.9998,0,0,0,0,100,0),
(370710,57,5639.7,199.106,26.8455,0,0,0,0,100,0),
(370710,58,5652.64,200.325,26.9248,0,0,0,0,100,0),
(370710,59,5669.31,202.233,27.2184,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
