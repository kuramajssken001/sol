UPDATE `gameobject` SET `spawntimesecs` = 60, `animprogress` = 255 WHERE `id` = 184716;
DELETE FROM `gameobject` WHERE `guid` IN (29789,55261,55262,55264,55265,55266,55269,55270,55273,55274,55275,55276,55277,55278,55279,55280,55281,55282,55283,55284,55285,55286,55287,55288);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`)
VALUES
(29789,184716,530,0,0,1,1,-2989.42,1589.17,60.6604,1.88539,0,0,0,0,60,255,1,0),
(55261,184716,530,0,0,1,1,-2984.51,1594.48,58.4725,0.314158,0,0,0,0,60,255,1,0),
(55262,184716,530,0,0,1,1,-3096.33,1609.92,55.8824,-1.15192,0,0,0,0,60,255,1,0),
(55264,184716,530,0,0,1,1,-3027.25,1575.68,64.303,-2.74016,0,0,0,0,60,255,1,0),
(55265,184716,530,0,0,1,1,-3018.46,1579.75,60.6492,5.99039,0,0,0,0,60,255,1,0),
(55266,184716,530,0,0,1,1,-3105.58,1658.49,64.5913,6.14356,0,0,-0.0697555,0.997564,60,255,1,0),
(55269,184716,530,0,0,1,1,-2927.68,1684.24,67.8598,4.53786,0,0,-0.766044,0.642789,60,255,1,0),
(55270,184716,530,0,0,1,1,-2921.18,1720.17,66.7636,1.06334,0,0,0.484809,0.87462,60,255,1,0),
(55273,184716,530,0,0,1,1,-2784.61,1402.4,39.5078,4.32842,0,0,-0.829037,0.559194,60,255,1,0),
(55274,184716,530,0,0,1,1,-2777.03,1402.02,39.3734,4.85202,0,0,-0.656058,0.75471,60,255,1,0),
(55275,184716,530,0,0,1,1,-2940.44,1362.79,7.72196,0.785397,0,0,0.382683,0.92388,60,255,1,0),
(55276,184716,530,0,0,1,1,-2939.84,1351.81,6.61668,5.68977,0,0,-0.292372,0.956305,60,255,1,0),
(55277,184716,530,0,0,1,1,-2789,1146.54,7.50297,0.645772,0,0,0,0,60,255,1,0),
(55278,184716,530,0,0,1,1,-2749.75,1165.3,6.78112,3.83973,0,0,-0.939692,0.342021,60,255,1,0),
(55279,184716,530,0,0,1,1,-2711.34,1160.31,5.99704,3.14159,0,0,-1,0,60,255,1,0),
(55280,184716,530,0,0,1,1,-2672.26,1177.22,5.25043,2.75761,0,0,0.981627,0.190812,60,255,1,0),
(55281,184716,530,0,0,1,1,-2569.97,1386.19,41.1709,3.00195,0,0,0.997563,0.0697661,60,255,1,0),
(55282,184716,530,0,0,1,1,-2652.86,1338.09,34.4453,2.32129,0,0,0.91706,0.39875,60,255,1,0),
(55283,184716,530,0,0,1,1,-2630.52,1355.57,35.8475,4.17134,0,0,-0.870356,0.492424,60,255,1,0),
(55284,184716,530,0,0,1,1,-2649.87,1295.34,28.6827,4.01426,0,0,-0.906307,0.422619,60,255,1,0),
(55285,184716,530,0,0,1,1,-2694.7,1380.5,38.5802,4.60767,0,0,-0.743144,0.669132,60,255,1,0),
(55286,184716,530,0,0,1,1,-2732.59,1279.1,33.3244,4.04959,0,0,0,0,60,255,1,0),
(55287,184716,530,0,0,1,1,-2726.54,1253.44,33.7097,4.54309,0,0,0,0,60,255,1,0),
(55288,184716,530,0,0,1,1,-2842.13,1221.44,7.11321,0.59341,0,0,0.292371,0.956305,60,255,1,0);

DELETE FROM `pool_template` WHERE `entry` = 1047;
INSERT INTO `pool_template` (`entry`, `max_limit`, `description`)
VALUES
(1047,41,'Coilskar Chest (41 out of 108)');

DELETE FROM `pool_gameobject` WHERE `pool_entry` = 1047;
INSERT INTO `pool_gameobject` (`guid`, `pool_entry`, `chance`, `description`)
VALUES
(1009,1047,0,'Coilskar Chest'),
(1043,1047,0,'Coilskar Chest'),
(1060,1047,0,'Coilskar Chest'),
(1069,1047,0,'Coilskar Chest'),
(1076,1047,0,'Coilskar Chest'),
(1083,1047,0,'Coilskar Chest'),
(1111,1047,0,'Coilskar Chest'),
(1145,1047,0,'Coilskar Chest'),
(1174,1047,0,'Coilskar Chest'),
(1204,1047,0,'Coilskar Chest'),
(1211,1047,0,'Coilskar Chest'),
(1215,1047,0,'Coilskar Chest'),
(1244,1047,0,'Coilskar Chest'),
(1245,1047,0,'Coilskar Chest'),
(1348,1047,0,'Coilskar Chest'),
(1351,1047,0,'Coilskar Chest'),
(1364,1047,0,'Coilskar Chest'),
(1379,1047,0,'Coilskar Chest'),
(1388,1047,0,'Coilskar Chest'),
(1405,1047,0,'Coilskar Chest'),
(1409,1047,0,'Coilskar Chest'),
(1424,1047,0,'Coilskar Chest'),
(25528,1047,0,'Coilskar Chest'),
(25529,1047,0,'Coilskar Chest'),
(25530,1047,0,'Coilskar Chest'),
(25531,1047,0,'Coilskar Chest'),
(25532,1047,0,'Coilskar Chest'),
(25533,1047,0,'Coilskar Chest'),
(25534,1047,0,'Coilskar Chest'),
(25535,1047,0,'Coilskar Chest'),
(25536,1047,0,'Coilskar Chest'),
(25537,1047,0,'Coilskar Chest'),
(25538,1047,0,'Coilskar Chest'),
(25539,1047,0,'Coilskar Chest'),
(25540,1047,0,'Coilskar Chest'),
(25541,1047,0,'Coilskar Chest'),
(25542,1047,0,'Coilskar Chest'),
(25543,1047,0,'Coilskar Chest'),
(25544,1047,0,'Coilskar Chest'),
(25545,1047,0,'Coilskar Chest'),
(25546,1047,0,'Coilskar Chest'),
(25547,1047,0,'Coilskar Chest'),
(25548,1047,0,'Coilskar Chest'),
(25549,1047,0,'Coilskar Chest'),
(25550,1047,0,'Coilskar Chest'),
(25551,1047,0,'Coilskar Chest'),
(25552,1047,0,'Coilskar Chest'),
(25553,1047,0,'Coilskar Chest'),
(25554,1047,0,'Coilskar Chest'),
(25555,1047,0,'Coilskar Chest'),
(25556,1047,0,'Coilskar Chest'),
(25557,1047,0,'Coilskar Chest'),
(25558,1047,0,'Coilskar Chest'),
(25559,1047,0,'Coilskar Chest'),
(25560,1047,0,'Coilskar Chest'),
(25561,1047,0,'Coilskar Chest'),
(25562,1047,0,'Coilskar Chest'),
(25563,1047,0,'Coilskar Chest'),
(25564,1047,0,'Coilskar Chest'),
(25565,1047,0,'Coilskar Chest'),
(29786,1047,0,'Coilskar Chest'),
(29787,1047,0,'Coilskar Chest'),
(29788,1047,0,'Coilskar Chest'),
(29789,1047,0,'Coilskar Chest'),
(29790,1047,0,'Coilskar Chest'),
(29791,1047,0,'Coilskar Chest'),
(29792,1047,0,'Coilskar Chest'),
(29793,1047,0,'Coilskar Chest'),
(29794,1047,0,'Coilskar Chest'),
(29795,1047,0,'Coilskar Chest'),
(29796,1047,0,'Coilskar Chest'),
(29797,1047,0,'Coilskar Chest'),
(29798,1047,0,'Coilskar Chest'),
(29799,1047,0,'Coilskar Chest'),
(55261,1047,0,'Coilskar Chest'),
(55262,1047,0,'Coilskar Chest'),
(55264,1047,0,'Coilskar Chest'),
(55265,1047,0,'Coilskar Chest'),
(55266,1047,0,'Coilskar Chest'),
(55269,1047,0,'Coilskar Chest'),
(55270,1047,0,'Coilskar Chest'),
(55273,1047,0,'Coilskar Chest'),
(55274,1047,0,'Coilskar Chest'),
(55275,1047,0,'Coilskar Chest'),
(55276,1047,0,'Coilskar Chest'),
(55277,1047,0,'Coilskar Chest'),
(55278,1047,0,'Coilskar Chest'),
(55279,1047,0,'Coilskar Chest'),
(55280,1047,0,'Coilskar Chest'),
(55281,1047,0,'Coilskar Chest'),
(55282,1047,0,'Coilskar Chest'),
(55283,1047,0,'Coilskar Chest'),
(55284,1047,0,'Coilskar Chest'),
(55285,1047,0,'Coilskar Chest'),
(55286,1047,0,'Coilskar Chest'),
(55287,1047,0,'Coilskar Chest'),
(55288,1047,0,'Coilskar Chest'),
(100357,1047,0,'Coilskar Chest'),
(100358,1047,0,'Coilskar Chest'),
(100359,1047,0,'Coilskar Chest'),
(100360,1047,0,'Coilskar Chest'),
(100361,1047,0,'Coilskar Chest'),
(100362,1047,0,'Coilskar Chest'),
(100363,1047,0,'Coilskar Chest'),
(100364,1047,0,'Coilskar Chest'),
(100365,1047,0,'Coilskar Chest'),
(100366,1047,0,'Coilskar Chest'),
(100367,1047,0,'Coilskar Chest');
