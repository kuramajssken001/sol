DELETE FROM `gameobject` WHERE `guid` IN (91,93,97,99,101,103,105,107,111,113,115,388,390,392,394,396,400,402,403,405,407);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`)
VALUES
(91,193616,571,0,0,1,1,6884.59,1573.85,389.033,0.0523589,0,0,-0.0348994,0.999391,300,0,1,0),
(93,193616,571,0,0,1,1,6888.82,1541.54,389.033,3.03684,0,0,-0.0348994,0.999391,300,0,1,0),
(97,193616,571,0,0,1,1,6884.59,1582,389.033,-3.12412,0,0,-0.0348994,0.999391,300,0,1,0),
(99,193616,571,0,0,1,1,6883.65,1540.26,389.033,1.13446,0,0,-0.0348994,0.999391,300,0,1,0),
(101,193616,571,0,0,1,1,6880.13,1540.48,389.033,-2.82743,0,0,-0.0348994,0.999391,300,0,1,0),
(103,193616,571,0,0,1,1,6876.56,1539.62,389.033,-0.0698117,0,0,-0.0348994,0.999391,300,0,1,0),
(105,193617,571,0,0,1,1,6875.71,1601.95,389.033,-2.67035,0,0,-0.965567,0.260156,300,0,1,0),
(107,193617,571,0,0,1,1,6879.49,1578.34,389.033,-3.10665,0,0,-0.999552,0.0299169,300,0,1,0),
(111,193617,571,0,0,1,1,6912.05,1560.12,389.033,1.29154,0,0,-0.0348994,0.999391,300,0,1,0),
(113,193617,571,0,0,1,1,6907.6,1567.49,389.033,-0.122173,0,0,-0.0348994,0.999391,300,0,1,0),
(115,193617,571,0,0,1,1,6903.12,1554.92,389.033,2.28638,0,0,-0.0348994,0.999391,300,0,1,0),
(388,193618,571,0,0,1,1,6906.19,1579.29,389.033,0.610864,0,0,-0.0348994,0.999391,300,0,1,0),
(390,193618,571,0,0,1,1,6906.3,1589.43,389.033,1.15192,0,0,-0.0348994,0.999391,300,0,1,0),
(392,193618,571,0,0,1,1,6881.86,1578.11,389.033,0.0523589,0,0,-0.0348994,0.999391,300,0,1,0),
(394,193619,571,0,0,1,1,6872.97,1600.56,389.033,-2.61799,0,0,-0.965567,0.260156,300,0,1,0),
(396,193619,571,0,0,1,1,6875.82,1580.98,389.033,3.10665,0,0,-0.999552,0.0299169,300,0,1,0),
(400,193619,571,0,0,1,1,6875.76,1577.95,389.033,-3.05433,0,0,-0.999552,0.0299169,300,0,1,0),
(402,193619,571,0,0,1,1,6874.19,1598.21,389.033,-2.61799,0,0,-0.965567,0.260156,300,0,1,0),
(403,193619,571,0,0,1,1,6876.02,1575.36,389.033,-2.9496,0,0,-0.999552,0.0299169,300,0,1,0),
(405,193619,571,0,0,1,1,6872.22,1602.76,389.033,-2.60054,0,0,-0.965567,0.260156,300,0,1,0),
(407,193620,571,0,0,1,1,6885.62,1578.17,389.033,-3.10665,0,0,-0.0348994,0.999391,300,0,1,0);

DELETE FROM `creature` WHERE `guid` BETWEEN 3009046 AND 3009093;
INSERT INTO `creature` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `VerifiedBuild`)
VALUES
(3009046,31152,571,0,0,1,1,0,1,6799.83,1433.43,390.812,6.28299,300,0,12600,0,0,0,0,0,0),
(3009047,31152,571,0,0,1,1,0,1,6799.42,1426.43,390.812,0.0389925,300,0,12600,0,0,0,0,0,0),
(3009048,31152,571,0,0,1,1,0,1,6799.22,1420.2,390.812,0.0487044,300,0,12600,0,0,0,0,0,0),
(3009049,31152,571,0,0,1,1,0,1,6797.68,1420.19,390.891,6.27572,300,0,12600,0,0,0,0,0,0),
(3009050,31152,571,0,0,1,1,0,1,6793.23,1420,390.713,0.195387,300,0,12600,0,0,0,0,0,0),
(3009051,31152,571,0,0,1,1,0,1,6794.84,1420.09,390.713,0.0775749,300,0,12600,0,0,0,0,0,0),
(3009052,31152,571,0,0,1,1,0,1,6795.89,1426.27,390.891,0.0536161,300,0,12600,0,0,0,0,0,0),
(3009053,31152,571,0,0,1,1,0,1,6797.39,1426.33,390.891,0.0492338,300,0,12600,0,0,0,0,0,0),
(3009054,31152,571,0,0,1,1,0,1,6794.39,1426.2,390.891,0.0581036,300,0,12600,0,0,0,0,0,0),
(3009055,31152,571,0,0,1,1,0,1,6792.89,1426.13,390.891,0.0623682,300,0,12600,0,0,0,0,0,0),
(3009056,31152,571,0,0,1,1,0,1,6793.83,1432.9,390.921,0.440551,300,0,12600,0,0,0,0,0,0),
(3009057,31152,571,0,0,1,1,0,1,6798.33,1432.92,390.921,0.424234,300,0,12600,0,0,0,0,0,0),
(3009058,31152,571,0,0,1,1,0,1,6795.33,1432.91,390.921,0.435067,300,0,12600,0,0,0,0,0,0),
(3009059,31152,571,0,0,1,1,0,1,6796.83,1432.92,390.921,0.4288,300,0,12600,0,0,0,0,0,0),
(3009060,32164,571,0,0,1,1,0,1,6873.45,1596.78,389.217,1.50098,300,0,11770,0,0,0,0,0,0),
(3009061,32164,571,0,0,1,1,0,1,6870.81,1603.06,389.217,0.10472,300,0,11770,0,0,0,0,0,0),
(3009062,32164,571,0,0,1,1,0,1,6873.86,1577.83,389.217,0.349066,300,0,11770,0,0,0,0,0,0),
(3009063,32164,571,0,0,1,1,0,1,6903.14,1551.82,389.217,2.68781,300,0,11770,0,0,0,0,0,0),
(3009064,32164,571,0,0,1,1,0,1,6886.85,1539.82,389.217,1.0821,300,0,11770,0,0,0,0,0,0),
(3009065,32164,571,0,0,1,1,0,1,6905.55,1564.58,389.217,1.11701,300,0,11770,0,0,0,0,0,0),
(3009066,32164,571,0,0,1,1,0,1,6884.67,1571.42,389.217,1.6057,300,0,11770,0,0,0,0,0,0),
(3009067,32164,571,0,0,1,1,0,1,6878.18,1541.64,389.217,5.75959,300,0,11770,0,0,0,0,0,0),
(3009068,32164,571,0,0,1,1,0,1,6885.35,1584.62,389.217,4.85202,300,0,11770,0,0,0,0,0,0),
(3009069,32164,571,0,0,1,1,0,1,6908.27,1591.38,389.217,4.55531,300,0,11770,0,0,0,0,0,0),
(3009070,32164,571,0,0,1,1,0,1,6904.24,1578.02,389.217,0.663225,300,0,11770,0,0,0,0,0,0),
(3009071,31150,571,0,0,1,1,0,0,6812.83,1449.62,390.896,4.64258,300,0,12600,0,0,0,0,0,0),
(3009072,31150,571,0,0,1,1,0,0,6857.69,1557.02,389.133,0.117134,300,0,12600,0,2,0,0,0,0),
(3009073,31150,571,0,0,1,1,0,0,6764.16,1555.59,389.217,0.575959,300,0,12600,0,0,0,0,0,0),
(3009074,31150,571,0,0,1,1,0,0,6847.13,1450.28,390.896,4.62512,300,0,12600,0,0,0,0,0,0),
(3009075,31150,571,0,0,1,1,0,0,6849.24,1583.35,389.133,0.0689424,300,0,12600,0,2,0,0,0,0),
(3009076,31145,571,0,0,1,1,0,0,6805.28,1426.08,390.896,3.31613,300,0,10080,8814,0,0,0,0,0),
(3009077,31145,571,0,0,1,1,0,0,6776.43,1446.4,390.712,4.50521,300,0,10080,8814,0,0,0,0,0),
(3009078,31281,571,0,0,1,1,0,0,6773.39,1439.27,390.712,1.40995,300,0,12600,0,0,0,0,0,0),
(3009079,31281,571,0,0,1,1,0,0,6775,1439.01,390.712,1.40995,300,0,12600,0,0,0,0,0,0),
(3009080,31281,571,0,0,1,1,0,0,6774.78,1440.47,390.712,1.93538,300,0,12600,0,0,0,0,0,0),
(3009081,31281,571,0,0,1,1,0,0,6773.8,1440.1,390.712,1.93538,300,0,12600,0,0,0,0,0,0),
(3009082,31281,571,0,0,1,1,0,0,6774.71,1437.71,390.712,1.93538,300,0,12600,0,0,0,0,0,0),
(3009083,31281,571,0,0,1,1,0,0,6774.17,1439.13,390.712,1.93538,300,0,12600,0,0,0,0,0,0),
(3009084,31281,571,0,0,1,1,0,0,6775.48,1439.63,390.712,1.93538,300,0,12600,0,0,0,0,0,0),
(3009085,31281,571,0,0,1,1,0,0,6775.77,1438.86,390.712,1.93538,300,0,12600,0,0,0,0,0,0),
(3009086,31281,571,0,0,1,1,0,0,6775.93,1437.79,390.712,1.93538,300,0,12600,0,0,0,0,0,0),
(3009087,31281,571,0,0,1,1,0,0,6775.68,1440.77,390.712,2.84566,300,0,12600,0,0,0,0,0,0),
(3009088,31281,571,0,0,1,1,0,0,6776.52,1439.91,390.712,2.84566,300,0,12600,0,0,0,0,0,0),
(3009089,31281,571,0,0,1,1,0,0,6776.86,1438.46,390.712,2.84566,300,0,12600,0,0,0,0,0,0),
(3009090,31281,571,0,0,1,1,0,0,6777.74,1439.04,390.712,2.84566,300,0,12600,0,0,0,0,0,0),
(3009091,31281,571,0,0,1,1,0,0,6777.41,1440.29,390.712,4.12619,300,0,12600,0,0,0,0,0,0),
(3009092,31281,571,0,0,1,1,0,0,6776.19,1441.2,390.712,4.12619,300,0,12600,0,0,0,0,0,0),
(3009093,31281,571,0,0,1,1,0,0,6773.62,1438.18,390.712,0.830504,300,0,12600,0,0,0,0,0,0);

UPDATE `creature` SET `position_x` = 6648.01, `position_y` = 1282.8, `position_z` = 291.6626, `wander_distance` = 0, `MovementType` = 0 WHERE `guid` = 121653;
UPDATE `creature` SET `wander_distance` = 0, `MovementType` = 0 WHERE `guid` = 123928;
DELETE FROM `creature_addon` WHERE `guid` = 121653;
DELETE FROM `creature_template_addon` WHERE `entry` = 31281;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`)
VALUES
(31281,0,0,0,1,0,0,'58951');

DELETE FROM `creature_addon` WHERE `guid` IN (3009072,3009075);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`)
VALUES
(3009072,30090720,0,0,0,0,0,'50106'),
(3009075,30090750,0,0,0,0,0,'50106');

DELETE FROM `waypoint_data` WHERE `id` IN (30090720,30090750);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `pathfinding`, `action`, `action_chance`, `wpguid`)
VALUES
(30090720,1,6857.69,1557.02,389.033,NULL,0,0,0,0,100,0),
(30090720,2,6842.64,1557.27,389.033,NULL,0,0,0,0,100,0),
(30090720,3,6828.88,1557.5,389.033,NULL,0,0,0,0,100,0),
(30090720,4,6811.49,1557.79,389.033,NULL,0,0,0,0,100,0),
(30090720,5,6790.14,1558.15,389.033,NULL,15000,0,0,0,100,0),
(30090720,6,6811.49,1557.79,389.033,NULL,0,0,0,0,100,0),
(30090720,7,6828.88,1557.5,389.033,NULL,0,0,0,0,100,0),
(30090720,8,6842.64,1557.27,389.033,NULL,0,0,0,0,100,0),
(30090720,9,6857.69,1557.02,389.033,NULL,0,0,0,0,100,0),
(30090720,10,6870.92,1557.59,389.033,NULL,15000,0,0,0,100,0),

(30090750,1,6849.24,1583.35,389.033,NULL,0,0,0,0,100,0),
(30090750,2,6868.68,1587.01,389.032,NULL,15000,0,0,0,100,0),
(30090750,3,6849.24,1583.35,389.033,NULL,0,0,0,0,100,0),
(30090750,4,6834.54,1583.64,389.033,NULL,0,0,0,0,100,0),
(30090750,5,6821.82,1583.89,389.033,NULL,0,0,0,0,100,0),
(30090750,6,6805.26,1584.22,389.033,NULL,0,0,0,0,100,0),
(30090750,7,6786.14,1584.6,389.032,NULL,15000,0,0,0,100,0),
(30090750,8,6805.26,1584.22,389.033,NULL,0,0,0,0,100,0),
(30090750,9,6821.82,1583.89,389.033,NULL,0,0,0,0,100,0),
(30090750,10,6834.54,1583.64,389.033,NULL,0,0,0,0,100,0);

-- Frostbrood Skytalon: Fix WP path
UPDATE `waypoint_data` SET `position_x` = 6688.88, `position_y` = 1329.78, `position_z` = 434.222 WHERE `id` = 1234960 AND `point` = 1;
