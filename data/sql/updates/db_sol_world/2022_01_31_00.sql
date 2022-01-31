-- DB update 2022_01_26_03 -> 2022_01_31_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2022_01_26_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2022_01_26_03 2022_01_31_00 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1643641558888325242'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1643641558888325242');

UPDATE `creature` SET `MovementType` = 2 WHERE `guid` IN (68311,68312,68313,68314);
UPDATE `creature_addon` SET `path_id` = 683110 WHERE `guid` = 68311;
UPDATE `creature_addon` SET `path_id` = 683120 WHERE `guid` = 68312;
UPDATE `creature_addon` SET `path_id` = 683130 WHERE `guid` = 68313;
UPDATE `creature_addon` SET `path_id` = 683140 WHERE `guid` = 68314;

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` IN (-68311,-68312,-68313,-68314,19005,18944);
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` IN (1900500,1900501,1900502,1900503);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(19005,0,0,0,11,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Set Active On'),
(19005,0,1,2,11,0,100,0,0,0,0,0,0,11,51347,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Respawn - Cast ''Teleport Visual Only'''),
(19005,0,2,0,61,0,100,0,0,0,0,0,0,80,1900500,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - Linked - Call Timed Action List'),
(19005,0,3,0,17,0,100,0,0,0,0,0,0,64,1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,'Wrath Master - On Summoned Unit - Store Target ID 1'),
(19005,0,4,5,6,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Death - Set Active On'),
(19005,0,5,0,61,0,100,0,0,0,0,0,0,41,15000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - Linked - Force Despawn After 15 Seconds'),
(19005,0,6,0,4,0,100,0,0,0,0,0,0,39,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Aggro - Call For Help'),
(19005,0,7,0,0,0,100,0,3000,13000,15000,31000,0,11,29574,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Wrath Master - IC - Cast ''Rend'''),
(19005,0,8,0,0,0,100,0,6000,19000,21000,36000,0,11,35871,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Wrath Master - IC - Cast ''Spellbreaker'''),

(1900500,9,0,0,0,0,100,0,0,0,0,0,0,41,900000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Wrath Master - On Script - Force Despawn After 15 Minutes'),
(1900500,9,1,0,0,0,100,0,0,0,0,0,0,12,18944,3,900000,0,0,0,1,0,0,0,0,6,0,0,0,'Wrath Master - On Script - Summon Creature ''Fel Soldier'''),
(1900500,9,2,0,0,0,100,0,0,0,0,0,0,45,1,1,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data 1 1 (Stored Target ID 1)'),
(1900500,9,3,0,0,0,100,0,0,0,0,0,0,12,18944,3,900000,0,0,0,1,0,0,0,0,-6,0,0,0,'Wrath Master - On Script - Summon Creature ''Fel Soldier'''),
(1900500,9,4,0,0,0,100,0,0,0,0,0,0,45,2,2,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data 2 2 (Stored Target ID 1)'),
(1900500,9,5,0,0,0,100,0,0,0,0,0,0,12,18944,3,900000,0,0,0,1,0,0,0,0,0,6,0,0,'Wrath Master - On Script - Summon Creature ''Fel Soldier'''),
(1900500,9,6,0,0,0,100,0,0,0,0,0,0,45,3,3,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data 3 3 (Stored Target ID 1)'),
(1900500,9,7,0,0,0,100,0,0,0,0,0,0,12,18944,3,900000,0,0,0,1,0,0,0,0,0,-6,0,0,'Wrath Master - On Script - Summon Creature ''Fel Soldier'''),
(1900500,9,8,0,0,0,100,0,0,0,0,0,0,45,4,4,0,0,0,0,12,1,0,0,0,0,0,0,0,'Wrath Master - On Script - Set Data 4 4 (Stored Target ID 1)'),

(18944,0,0,0,1,0,100,0,10000,10000,10000,10000,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fel Soldier - OOC - Force Despawn'),
(18944,0,1,2,54,0,100,0,0,0,0,0,0,48,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fel Soldier - On Just Summoned - Set Active On'),
(18944,0,2,0,61,0,100,0,0,0,0,0,0,11,51347,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fel Soldier - Linked - Cast ''Teleport Visual Only'''),
(18944,0,3,0,38,0,100,0,1,1,0,0,0,237,2,0,0,0,0,0,7,0,0,0,0,0,0,6.6,300,'Fel Soldier - On Data Set 1 1 - Creature Formation (Invoker)'),
(18944,0,4,0,38,0,100,0,2,2,0,0,0,237,2,0,0,0,0,0,7,0,0,0,0,0,0,11.6,300,'Fel Soldier - On Data Set 2 2 - Creature Formation (Invoker)'),
(18944,0,5,0,38,0,100,0,3,3,0,0,0,237,2,0,0,0,0,0,7,0,0,0,0,0,0,6.6,60,'Fel Soldier - On Data Set 3 3 - Creature Formation (Invoker)'),
(18944,0,6,0,38,0,100,0,4,4,0,0,0,237,2,0,0,0,0,0,7,0,0,0,0,0,0,11.6,60,'Fel Soldier - On Data Set 4 4 - Creature Formation (Invoker)'),
(18944,0,7,0,4,0,100,0,0,0,0,0,0,39,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Fel Soldier - On Aggro - Call For Help'),
(18944,0,8,0,0,0,100,0,3000,12000,9000,15000,0,11,15496,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Fel Soldier - IC - Cast ''Cleave'''),
(18944,0,9,0,0,0,100,0,6000,20000,16000,33000,0,11,32009,0,0,0,0,0,2,0,0,0,0,0,0,0,0,'Fel Soldier - IC - Cast ''Cutdown''');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 18944;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `Comment`)
VALUES
(22,1,18944,0,0,29,1,19005,25,0,1,0,0,'Fel Soldier - Group 0: Execute SAI ID 0 only if not near ''Wrath Master''');

DELETE FROM `waypoints` WHERE `entry` IN (68311,68312,68313,68314);

DELETE FROM `waypoint_data` WHERE `id` IN (683110,683120,683130,683140);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`)
VALUES
(683110,1,-270.735,1527.63,31.1836,0,0,0,0,100,0),
(683110,2,-260.567,1525.02,29.8034,0,0,0,0,100,0),
(683110,3,-253.926,1522.59,28.1088,0,0,0,0,100,0),
(683110,4,-249.349,1521.57,25.0041,0,0,0,0,100,0),
(683110,5,-240.034,1516.72,22.8203,0,0,0,0,100,0),
(683110,6,-232.184,1508.16,21.5413,0,0,0,0,100,0),
(683110,7,-230.872,1501.28,20.6535,0,0,0,0,100,0),
(683110,8,-233.41,1485.1,18.4649,0,0,0,0,100,0),
(683110,9,-236.188,1467.82,16.1683,0,0,0,0,100,0),
(683110,10,-242.961,1443.11,14.2698,0,0,0,0,100,0),
(683110,11,-248.129,1419.16,13.0837,0,0,0,0,100,0),
(683110,12,-251.718,1398.48,11.6931,0,0,0,0,100,0),
(683110,13,-251.572,1377.49,10.8303,0,0,0,0,100,0),
(683110,14,-250.61,1350.7,11.892,0,0,0,0,100,0),
(683110,15,-249.213,1325.08,15.3074,0,0,0,0,100,0),
(683110,16,-246.101,1309.06,18.0727,0,0,0,0,100,0),
(683110,17,-241.369,1288.6,21.4746,0,0,0,0,100,0),
(683110,18,-237.172,1270.45,24.8971,0,0,0,0,100,0),
(683110,19,-237.027,1250.64,28.2199,0,0,0,0,100,0),
(683110,20,-238.517,1229.74,31.7736,0,0,0,0,100,0),
(683110,21,-241.342,1213.6,35.8261,0,0,0,0,100,0),
(683110,22,-242.892,1198.11,42.0217,0,0,0,0,100,0),
(683110,23,-243.448,1186.46,42.3938,0,0,0,0,100,0),
(683110,24,-244.052,1171.28,41.5405,0,0,0,0,100,0),
(683110,25,-244.678,1153.82,41.6494,0,0,0,0,100,0),
(683110,26,-244.905,1139.83,41.6667,0,0,0,0,100,0),
(683110,27,-245.17,1123.45,42.1819,0,0,0,0,100,0),
(683110,28,-245.454,1105.95,41.6667,0,0,0,0,100,0),
(683110,29,-245.642,1094.33,41.6667,0,0,0,0,100,0),
(683110,30,-245.786,1085.48,47.0111,0,0,0,0,100,0),
(683110,31,-245.954,1075.11,53.9023,0,0,0,0,100,0),
(683110,32,-246.144,1063.42,54.3107,0,0,0,0,100,0),
(683110,33,-246.447,1044.73,54.3162,0,900000,0,0,100,0),

(683120,1,-180.01,1516.58,27.6035,0,0,0,0,100,0),
(683120,2,-188.161,1515.78,27.4855,0,0,0,0,100,0),
(683120,3,-194.709,1514.48,27.2184,0,0,0,0,100,0),
(683120,4,-203.528,1512.33,23.5807,0,0,0,0,100,0),
(683120,5,-209.201,1510.78,22.2023,0,0,0,0,100,0),
(683120,6,-213.606,1506.99,21.42,0,0,0,0,100,0),
(683120,7,-222.386,1499.38,20.397,0,0,0,0,100,0),
(683120,8,-228.273,1486.68,18.8159,0,0,0,0,100,0),
(683120,9,-232.004,1474.43,17.1083,0,0,0,0,100,0),
(683120,10,-232.004,1474.43,17.1083,0,0,0,0,100,0),
(683120,11,-240.088,1440.38,14.1734,0,0,0,0,100,0),
(683120,12,-247.414,1410.98,12.5468,0,0,0,0,100,0),
(683120,13,-248.588,1400.56,11.8825,0,0,0,0,100,0),
(683120,14,-248.808,1369.07,10.8148,0,0,0,0,100,0),
(683120,15,-248.808,1369.07,10.8148,0,0,0,0,100,0),
(683120,16,-245.535,1334.29,14.0067,0,0,0,0,100,0),
(683120,17,-245.535,1334.29,14.0067,0,0,0,0,100,0),
(683120,18,-241.99,1299.51,19.6667,0,0,0,0,100,0),
(683120,19,-241.99,1299.51,19.6667,0,0,0,0,100,0),
(683120,20,-238.526,1264.69,25.8431,0,0,0,0,100,0),
(683120,21,-238.904,1239.16,30.0995,0,0,0,0,100,0),
(683120,22,-238.904,1239.16,30.0995,0,0,0,0,100,0),
(683120,23,-243.629,1211.67,36.8028,0,0,0,0,100,0),
(683120,24,-245.399,1197.78,42.3701,0,0,0,0,100,0),
(683120,25,-245.493,1176.78,41.6676,0,0,0,0,100,0),
(683120,26,-245.586,1155.78,41.6338,0,0,0,0,100,0),
(683120,27,-245.69,1132.47,41.6998,0,0,0,0,100,0),
(683120,28,-247.551,1115.07,41.6792,0,0,0,0,100,0),
(683120,29,-248.829,1094.35,41.6669,0,0,0,0,100,0),
(683120,30,-248.929,1086.16,46.5319,0,0,0,0,100,0),
(683120,31,-248.935,1075.06,53.8996,0,0,0,0,100,0),
(683120,32,-248.941,1063.44,54.3106,0,0,0,0,100,0),
(683120,33,-248.95,1045.94,54.3171,0,900000,0,0,100,0),

(683130,1,-112.343,1891.33,80.0147,0,0,0,0,100,0),
(683130,2,-129.092,1880.62,83.4569,0,0,0,0,100,0),
(683130,3,-145.72,1872.24,86.5619,0,0,0,0,100,0),
(683130,4,-159.512,1869.84,89.052,0,0,0,0,100,0),
(683130,5,-177.777,1865.91,93.1582,0,0,0,0,100,0),
(683130,6,-189.585,1861.14,94.292,0,0,0,0,100,0),
(683130,7,-194.196,1859.96,92.3105,0,0,0,0,100,0),
(683130,8,-198.484,1858.43,91.6116,0,0,0,0,100,0),
(683130,9,-200.727,1857.64,90.8248,0,0,0,0,100,0),
(683130,10,-207.861,1851.66,90.1464,0,0,0,0,100,0),
(683130,11,-215.437,1841.33,88.974,0,0,0,0,100,0),
(683130,12,-215.021,1829.64,87.6314,0,0,0,0,100,0),
(683130,13,-214.322,1813.28,85.0578,0,0,0,0,100,0),
(683130,14,-212.8,1800.56,82.2836,0,0,0,0,100,0),
(683130,15,-210.241,1780.85,76.6338,0,0,0,0,100,0),
(683130,16,-207.241,1757.73,70.0961,0,0,0,0,100,0),
(683130,17,-204.692,1738.08,64.4382,0,0,0,0,100,0),
(683130,18,-204.353,1720.59,59.5464,0,0,0,0,100,0),
(683130,19,-203.371,1699.54,53.4667,0,0,0,0,100,0),
(683130,20,-202.608,1683.18,49.4984,0,0,0,0,100,0),
(683130,21,-201.737,1664.51,45.1893,0,0,0,0,100,0),
(683130,22,-200.81,1644.72,41.0282,0,0,0,0,100,0),
(683130,23,-199.93,1627.31,37.7967,0,0,0,0,100,0),
(683130,24,-199.93,1627.31,37.7967,0,0,0,0,100,0),
(683130,25,-203.923,1601.96,33.021,0,0,0,0,100,0),
(683130,26,-207.465,1588.42,30.7292,0,0,0,0,100,0),
(683130,27,-211.591,1572.64,28.6103,0,0,0,0,100,0),
(683130,28,-216.32,1554.56,26.5615,0,0,0,0,100,0),
(683130,29,-220.446,1538.78,24.9218,0,0,0,0,100,0),
(683130,30,-224.874,1521.85,23.0684,0,0,0,0,100,0),
(683130,31,-230.789,1499.23,20.3917,0,0,0,0,100,0),
(683130,32,-235.517,1481.15,17.8653,0,0,0,0,100,0),
(683130,33,-240.529,1461.98,15.4422,0,0,0,0,100,0),
(683130,34,-244.372,1447.29,14.5134,0,0,0,0,100,0),
(683130,35,-248.8,1430.35,13.8539,0,0,0,0,100,0),
(683130,36,-252.625,1415.73,12.7361,0,0,0,0,100,0),
(683130,37,-253.861,1404.17,11.9207,0,0,0,0,100,0),
(683130,38,-252.777,1387.83,11.1616,0,0,0,0,100,0),
(683130,39,-251.771,1372.67,10.7793,0,0,0,0,100,0),
(683130,40,-250.459,1352.89,11.6834,0,0,0,0,100,0),
(683130,41,-249.305,1335.49,13.7715,0,0,0,0,100,0),
(683130,42,-248.147,1318.03,16.5355,0,0,0,0,100,0),
(683130,43,-246.234,1306.5,18.4776,0,0,0,0,100,0),
(683130,44,-243.565,1290.41,21.1146,0,0,0,0,100,0),
(683130,45,-239.75,1267.41,25.3402,0,0,0,0,100,0),
(683130,46,-236.313,1246.7,28.9015,0,0,0,0,100,0),
(683130,47,-239.597,1224.71,32.8632,0,0,0,0,100,0),
(683130,48,-240.818,1210.69,37.0075,0,0,0,0,100,0),
(683130,49,-242.052,1196.54,42.1932,0,0,0,0,100,0),
(683130,50,-242.537,1181.36,41.8351,0,0,0,0,100,0),
(683130,51,-243.318,1156.93,41.6182,0,0,0,0,100,0),
(683130,52,-243.987,1135.98,41.6667,0,0,0,0,100,0),
(683130,53,-244.546,1118.49,42.0075,0,0,0,0,100,0),
(683130,54,-245.067,1102.19,41.6667,0,0,0,0,100,0),
(683130,55,-245.326,1094.07,41.6667,0,0,0,0,100,0),
(683130,56,-245.59,1083.3,48.4641,0,0,0,0,100,0),
(683130,57,-245.594,1074.58,54.2525,0,0,0,0,100,0),
(683130,58,-245.603,1058.27,54.3126,0,0,0,0,100,0),
(683130,59,-245.614,1037.27,54.3191,0,900000,0,0,100,0),

(683140,1,-404.061,1818.73,72.6499,0,0,0,0,100,0),
(683140,2,-389.501,1814.49,72.7857,0,0,0,0,100,0),
(683140,3,-370.481,1808.96,73.5055,0,0,0,0,100,0),
(683140,4,-352.539,1803.73,73.6972,0,0,0,0,100,0),
(683140,5,-338.685,1805.75,75.216,0,0,0,0,100,0),
(683140,6,-320.381,1809.53,79.0509,0,0,0,0,100,0),
(683140,7,-301.382,1815.28,82.8135,0,0,0,0,100,0),
(683140,8,-285.97,1820.62,85.9315,0,0,0,0,100,0),
(683140,9,-272.466,1827.48,88.2899,0,0,0,0,100,0),
(683140,10,-265.201,1831.11,89.7627,0,0,0,0,100,0),
(683140,11,-253.62,1832.71,91.8272,0,0,0,0,100,0),
(683140,12,-241.178,1841.39,92.7873,0,0,0,0,100,0),
(683140,13,-236.851,1842.14,90.2615,0,0,0,0,100,0),
(683140,14,-227.443,1837.47,89.0557,0,0,0,0,100,0),
(683140,15,-219.36,1827.54,87.4862,0,0,0,0,100,0),
(683140,16,-216.983,1813.74,85.215,0,0,0,0,100,0),
(683140,17,-213.051,1795.54,80.9159,0,0,0,0,100,0),
(683140,18,-208.664,1776.22,75.3269,0,0,0,0,100,0),
(683140,19,-203.564,1753.41,68.8117,0,0,0,0,100,0),
(683140,20,-201.937,1733.59,63.0754,0,0,0,0,100,0),
(683140,21,-200.196,1709.16,56.0166,0,0,0,0,100,0),
(683140,22,-199.037,1689.31,50.7389,0,0,0,0,100,0),
(683140,23,-199.125,1669.5,46.1424,0,0,0,0,100,0),
(683140,24,-199.234,1645,41.067,0,0,0,0,100,0),
(683140,25,-199.968,1621.71,36.7692,0,0,0,0,100,0),
(683140,26,-201.72,1601.97,33.0508,0,0,0,0,100,0),
(683140,27,-208.383,1578.4,29.3313,0,0,0,0,100,0),
(683140,28,-214.934,1551.17,26.2096,0,0,0,0,100,0),
(683140,29,-223.08,1519.51,22.738,0,0,0,0,100,0),
(683140,30,-230.058,1492.4,19.5117,0,0,0,0,100,0),
(683140,31,-236.163,1468.67,16.2668,0,0,0,0,100,0),
(683140,32,-242.269,1444.94,14.2877,0,0,0,0,100,0),
(683140,33,-247.799,1423.45,13.3939,0,0,0,0,100,0),
(683140,34,-251.61,1399.26,11.7349,0,0,0,0,100,0),
(683140,35,-252.834,1369.07,10.8068,0,0,0,0,100,0),
(683140,36,-251.446,1349.31,12.034,0,0,0,0,100,0),
(683140,37,-248.328,1326.21,15.1602,0,0,0,0,100,0),
(683140,38,-245.147,1303.12,19.0204,0,0,0,0,100,0),
(683140,39,-241.558,1277.81,23.4223,0,0,0,0,100,0),
(683140,40,-241.404,1256.81,27.0886,0,0,0,0,100,0),
(683140,41,-240.981,1234.62,30.8882,0,0,0,0,100,0),
(683140,42,-242.084,1214.77,35.4648,0,0,0,0,100,0),
(683140,43,-243.058,1197.23,42.2163,0,0,0,0,100,0),
(683140,44,-243.323,1180.92,41.8092,0,0,0,0,100,0),
(683140,45,-243.721,1156.42,41.6234,0,0,0,0,100,0),
(683140,46,-245.046,1137.85,41.668,0,0,0,0,100,0),
(683140,47,-248.701,1115.96,41.6755,0,0,0,0,100,0),
(683140,48,-250.761,1094.48,41.6669,0,0,0,0,100,0),
(683140,49,-250.516,1085.41,47.012,0,0,0,0,100,0),
(683140,50,-250.234,1074.91,53.9873,0,0,0,0,100,0),
(683140,51,-250.106,1057.41,54.3128,0,0,0,0,100,0),
(683140,52,-249.986,1041.03,54.318,0,900000,0,0,100,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
