-- DB update 2020_10_31_01 -> 2020_11_01_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2020_10_31_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2020_10_31_01 2020_11_01_00 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1604242771550031717'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1604242771550031717');

DELETE FROM `waypoint_data` WHERE `id` IN (696470,696560,696570);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(696470,1,2386.26,6036.12,140.97,0,0,0,0,100,0),
(696470,2,2387.7,6029.99,142.214,0,0,0,0,100,0),
(696470,3,2389.6,6021.92,144.281,0,0,0,0,100,0),
(696470,4,2392.11,6011.24,146.837,0,0,0,0,100,0),
(696470,5,2394.84,5999.6,149.594,0,0,0,0,100,0),
(696470,6,2389.07,5995.24,150.769,0,0,0,0,100,0),
(696470,7,2382.1,5989.96,151.972,0,0,0,0,100,0),
(696470,8,2373.82,5983.7,152.167,0,0,0,0,100,0),
(696470,9,2366.01,5977.79,152.332,0,0,0,0,100,0),
(696470,10,2356.25,5970.39,152.526,0,0,0,0,100,0),
(696470,11,2348.1,5964.23,151.967,0,0,0,0,100,0),
(696470,12,2341.61,5965.67,150.982,0,0,0,0,100,0),
(696470,13,2335.11,5967.1,149.516,0,0,0,0,100,0),
(696470,14,2326.45,5969.01,146.998,0,0,0,0,100,0),
(696470,15,2319.39,5970.58,145.438,0,0,0,0,100,0),
(696470,16,2311.87,5972.24,144.192,0,0,0,0,100,0),
(696470,17,2304.43,5973.88,143.209,0,0,0,0,100,0),
(696470,18,2299.79,5980.17,142.742,0,0,0,0,100,0),
(696470,19,2293.91,5988.15,142.368,0,0,0,0,100,0),
(696470,20,2289.06,5994.72,142.269,0,0,0,0,100,0),
(696470,21,2289.49,6004.97,142.338,0,0,0,0,100,0),
(696470,22,2289.92,6015.11,142.47,0,0,0,0,100,0),
(696470,23,2290.42,6026.88,142.556,0,0,0,0,100,0),
(696470,24,2290.85,6037.17,142.402,0,0,0,0,100,0),
(696470,25,2297.89,6041.72,142.344,0,0,0,0,100,0),
(696470,26,2309.08,6042.85,142.42,0,0,0,0,100,0),
(696470,27,2317.94,6042.7,142.417,0,0,0,0,100,0),
(696470,28,2326.69,6042.55,142.552,0,0,0,0,100,0),
(696470,29,2336.02,6042.4,142.384,0,0,0,0,100,0),
(696470,30,2345.12,6042.24,141.796,0,0,0,0,100,0),
(696470,31,2355.38,6042.07,141.032,0,0,0,0,100,0),
(696470,32,2364.36,6041.92,140.432,0,0,0,0,100,0),
(696470,33,2373.69,6041.76,140.158,0,0,0,0,100,0),
(696470,34,2380.45,6041.65,140.064,0,0,0,0,100,0),

(696560,1,2305.07,5974.35,143.271,0,0,0,0,100,0),
(696560,2,2299.92,5979.43,142.771,0,0,0,0,100,0),
(696560,3,2294.68,5984.58,142.465,0,0,0,0,100,0),
(696560,4,2290.05,5989.15,142.322,0,0,0,0,100,0),
(696560,5,2290.05,5999.3,142.282,0,0,0,0,100,0),
(696560,6,2290.05,6008.52,142.406,0,0,0,0,100,0),
(696560,7,2290.04,6017.02,142.508,0,0,0,0,100,0),
(696560,8,2290.04,6026.36,142.556,0,0,0,0,100,0),
(696560,9,2290.04,6036.98,142.416,0,0,0,0,100,0),
(696560,10,2299.56,6045.42,142.317,0,0,0,0,100,0),
(696560,11,2307.83,6045.01,142.373,0,0,0,0,100,0),
(696560,12,2318.09,6044.5,142.392,0,0,0,0,100,0),
(696560,13,2327.99,6044.01,142.517,0,0,0,0,100,0),
(696560,14,2337.43,6043.54,142.298,0,0,0,0,100,0),
(696560,15,2346.51,6043.09,141.598,0,0,0,0,100,0),
(696560,16,2355.38,6042.66,141.021,0,0,0,0,100,0),
(696560,17,2364.16,6042.22,140.419,0,0,0,0,100,0),
(696560,18,2372.14,6041.16,140.275,0,0,0,0,100,0),
(696560,19,2380.35,6040.06,140.334,0,0,0,0,100,0),
(696560,20,2388.06,6036.31,141.007,0,0,0,0,100,0),
(696560,21,2389.18,6029.52,142.373,0,0,0,0,100,0),
(696560,22,2390.61,6020.89,144.551,0,0,0,0,100,0),
(696560,23,2391.95,6012.72,146.484,0,0,0,0,100,0),
(696560,24,2393.04,6006.16,148.073,0,0,0,0,100,0),
(696560,25,2394.28,5998.62,149.825,0,0,0,0,100,0),
(696560,26,2388.37,5993.88,151.028,0,0,0,0,100,0),
(696560,27,2382.72,5989.36,151.97,0,0,0,0,100,0),
(696560,28,2376.8,5984.61,152.121,0,0,0,0,100,0),
(696560,29,2369.88,5979.06,152.214,0,0,0,0,100,0),
(696560,30,2364.24,5974.54,152.317,0,0,0,0,100,0),
(696560,31,2357.6,5969.21,152.448,0,0,0,0,100,0),
(696560,32,2350.66,5963.65,152.265,0,0,0,0,100,0),
(696560,33,2343.74,5965.27,151.291,0,0,0,0,100,0),
(696560,34,2337.48,5966.74,150.165,0,0,0,0,100,0),
(696560,35,2330.78,5968.32,148.281,0,0,0,0,100,0),
(696560,36,2323.52,5970.02,146.29,0,0,0,0,100,0),
(696560,37,2317.28,5971.48,145.074,0,0,0,0,100,0),
(696560,38,2310.35,5973.11,143.957,0,0,0,0,100,0),

(696570,1,2398.74,5926.2,151.466,0,0,0,0,100,0),
(696570,2,2388.1,5933.72,151.67,0,0,0,0,100,0),
(696570,3,2389.04,5941.25,151.741,0,0,0,0,100,0),
(696570,4,2390.33,5949.54,151.61,0,0,0,0,100,0),
(696570,5,2398.08,5957.34,151.782,0,0,0,0,100,0),
(696570,6,2403.62,5960.74,152.002,0,0,0,0,100,0),
(696570,7,2403.09,5968.07,152.007,0,0,0,0,100,0),
(696570,8,2402.53,5975.75,151.81,0,0,0,0,100,0),
(696570,9,2401.92,5984.02,151.789,0,0,0,0,100,0),
(696570,10,2401.35,5991.88,150.903,0,0,0,0,100,0),
(696570,11,2410.75,5992.23,151.287,0,0,0,0,100,0),
(696570,12,2419.26,5992.54,151.823,0,0,0,0,100,0),
(696570,13,2425.94,5988.73,152.513,0,0,0,0,100,0),
(696570,14,2434.15,5984.04,153.421,0,0,0,0,100,0),
(696570,15,2442.08,5979.51,153.683,0,0,0,0,100,0),
(696570,16,2446.82,5971.88,153.508,0,0,0,0,100,0),
(696570,17,2452.55,5962.67,153.268,0,0,0,0,100,0),
(696570,18,2457.45,5954.78,153.358,0,0,0,0,100,0),
(696570,19,2457.97,5946.87,153.385,0,0,0,0,100,0),
(696570,20,2458.43,5939.76,153.499,0,0,0,0,100,0),
(696570,21,2458.91,5932.41,153.512,0,0,0,0,100,0),
(696570,22,2451.75,5929.72,153.183,0,0,0,0,100,0),
(696570,23,2445.86,5931.13,152.843,0,0,0,0,100,0),
(696570,24,2437.47,5933.14,152.348,0,0,0,0,100,0),
(696570,25,2429.98,5934.94,152.038,0,0,0,0,100,0),
(696570,26,2421.25,5930.76,151.738,0,0,0,0,100,0),
(696570,27,2414.83,5927.69,151.679,0,0,0,0,100,0),
(696570,28,2406.47,5926.92,151.507,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
