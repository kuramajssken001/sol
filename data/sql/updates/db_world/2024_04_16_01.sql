DELETE FROM `creature` WHERE `guid` IN (2688,43600);
UPDATE `creature` SET `position_x` = -10865.8, `position_y` = -3642.49, `position_z` = 13.6656, `orientation` = 3.29747, `wander_distance` = 0, `MovementType` = 2 WHERE `guid` = 43597;
UPDATE `creature` SET `position_x` = -10925.2, `position_y` = -3615.64, `position_z` = 18.9326, `orientation` = 2.86157, `wander_distance` = 0, `MovementType` = 2 WHERE `guid` = 43444;
UPDATE `creature` SET `position_x` = -10952.7, `position_y` = -3698.11, `position_z` = 26.9389, `orientation` = 5.18462, `wander_distance` = 0, `MovementType` = 2 WHERE `guid` = 43599;
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE `guid` = 43602;

DELETE FROM `creature_addon` WHERE `guid` IN (43597,43444,43599);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `maxAggroRadius`, `auras`)
VALUES
(43597,435970,0,0,1,0,0,NULL,NULL),
(43444,434440,0,0,1,0,0,NULL,NULL),
(43599,435990,0,0,1,0,0,NULL,NULL);

DELETE FROM `waypoint_data` WHERE `id` IN (435970,434440,435990);
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `pathfinding`, `action`, `action_chance`, `wpguid`)
VALUES
-- Marsh Inkspewer
(435990,1,-10952.7,-3698.11,26.9389,NULL,0,0,0,0,100,0),
(435990,2,-10950.8,-3701.75,26.8761,NULL,0,0,0,0,100,0),
(435990,3,-10948.3,-3706.74,26.0617,NULL,0,0,0,0,100,0),
(435990,4,-10946.1,-3711.1,25.6488,NULL,0,0,0,0,100,0),
(435990,5,-10943.6,-3716.37,25.1772,NULL,0,0,0,0,100,0),
(435990,6,-10940.2,-3723.32,24.7062,NULL,0,0,0,0,100,0),
(435990,7,-10937.7,-3728.59,24.3775,NULL,0,0,0,0,100,0),
(435990,8,-10935,-3734.39,23.8794,NULL,0,0,0,0,100,0),
(435990,9,-10932.1,-3740.39,23.8825,NULL,0,0,0,0,100,0),
(435990,10,-10929.8,-3745.13,23.6805,NULL,0,0,0,0,100,0),
(435990,11,-10927.9,-3749.24,23.5402,NULL,0,0,0,0,100,0),
(435990,12,-10922.6,-3748.47,23.4882,NULL,0,0,0,0,100,0),
(435990,13,-10917.1,-3747.68,23.4536,NULL,0,0,0,0,100,0),
(435990,14,-10911.3,-3746.83,23.435,NULL,0,0,0,0,100,0),
(435990,15,-10907,-3744.77,23.4347,NULL,0,0,0,0,100,0),
(435990,16,-10901.9,-3742.35,23.0027,NULL,0,0,0,0,100,0),
(435990,17,-10895.9,-3739.48,22.777,NULL,0,0,0,0,100,0),
(435990,18,-10889.9,-3736.61,23.0501,NULL,0,0,0,0,100,0),
(435990,19,-10884.9,-3734.19,22.998,NULL,0,0,0,0,100,0),
(435990,20,-10878.9,-3731.33,23.252,NULL,0,0,0,0,100,0),
(435990,21,-10874.4,-3732.67,23.3165,NULL,0,0,0,0,100,0),
(435990,22,-10868.8,-3734.36,23.6069,NULL,0,0,0,0,100,0),
(435990,23,-10863,-3736.11,23.6494,NULL,0,0,0,0,100,0),
(435990,24,-10858.6,-3737.42,23.6091,NULL,0,0,0,0,100,0),
(435990,25,-10852.8,-3739.17,22.6947,NULL,0,0,0,0,100,0),
(435990,26,-10847.4,-3740.81,22.8218,NULL,0,0,0,0,100,0),
(435990,27,-10841.1,-3742.7,23.0026,NULL,0,0,0,0,100,0),
(435990,28,-10836.1,-3742.57,23.1866,NULL,0,0,0,0,100,0),
(435990,29,-10829.2,-3742.39,22.9303,NULL,0,0,0,0,100,0),
(435990,30,-10823.9,-3742.25,24.1971,NULL,0,0,0,0,100,0),
(435990,31,-10819.5,-3742.14,25.1373,NULL,0,0,0,0,100,0),
(435990,32,-10813.2,-3741.98,25.5918,NULL,0,0,0,0,100,0),
(435990,33,-10808.9,-3742.25,25.9119,NULL,0,0,0,0,100,0),
(435990,34,-10802.9,-3742.64,24.6357,NULL,0,0,0,0,100,0),
(435990,35,-10797,-3743.01,25.1066,NULL,0,0,0,0,100,0),
(435990,36,-10792.1,-3743.32,25.4832,NULL,0,0,0,0,100,0),
(435990,37,-10785.8,-3743.73,24.3688,NULL,0,0,0,0,100,0),
(435990,38,-10792.1,-3743.32,25.4832,NULL,0,0,0,0,100,0),
(435990,39,-10797,-3743.01,25.1066,NULL,0,0,0,0,100,0),
(435990,40,-10802.9,-3742.64,24.6357,NULL,0,0,0,0,100,0),
(435990,41,-10808.9,-3742.25,25.9119,NULL,0,0,0,0,100,0),
(435990,42,-10813.2,-3741.98,25.5918,NULL,0,0,0,0,100,0),
(435990,43,-10819.5,-3742.14,25.1373,NULL,0,0,0,0,100,0),
(435990,44,-10823.9,-3742.25,24.1971,NULL,0,0,0,0,100,0),
(435990,45,-10829.2,-3742.39,22.9303,NULL,0,0,0,0,100,0),
(435990,46,-10836.1,-3742.57,23.1866,NULL,0,0,0,0,100,0),
(435990,47,-10841.1,-3742.7,23.0026,NULL,0,0,0,0,100,0),
(435990,48,-10847.4,-3740.81,22.8218,NULL,0,0,0,0,100,0),
(435990,49,-10852.8,-3739.17,22.6947,NULL,0,0,0,0,100,0),
(435990,50,-10858.6,-3737.42,23.6091,NULL,0,0,0,0,100,0),
(435990,51,-10863,-3736.11,23.6494,NULL,0,0,0,0,100,0),
(435990,52,-10868.8,-3734.36,23.6069,NULL,0,0,0,0,100,0),
(435990,53,-10874.4,-3732.67,23.3165,NULL,0,0,0,0,100,0),
(435990,54,-10878.9,-3731.33,23.252,NULL,0,0,0,0,100,0),
(435990,55,-10884.9,-3734.19,22.998,NULL,0,0,0,0,100,0),
(435990,56,-10889.9,-3736.61,23.0501,NULL,0,0,0,0,100,0),
(435990,57,-10895.9,-3739.48,22.777,NULL,0,0,0,0,100,0),
(435990,58,-10901.9,-3742.35,23.0027,NULL,0,0,0,0,100,0),
(435990,59,-10907,-3744.77,23.4347,NULL,0,0,0,0,100,0),
(435990,60,-10911.3,-3746.83,23.435,NULL,0,0,0,0,100,0),
(435990,61,-10917.1,-3747.68,23.4536,NULL,0,0,0,0,100,0),
(435990,62,-10922.6,-3748.47,23.4882,NULL,0,0,0,0,100,0),
(435990,63,-10927.9,-3749.24,23.5402,NULL,0,0,0,0,100,0),
(435990,64,-10929.8,-3745.13,23.6805,NULL,0,0,0,0,100,0),
(435990,65,-10932.1,-3740.39,23.8825,NULL,0,0,0,0,100,0),
(435990,66,-10935,-3734.39,23.8794,NULL,0,0,0,0,100,0),
(435990,67,-10937.7,-3728.59,24.3775,NULL,0,0,0,0,100,0),
(435990,68,-10940.2,-3723.32,24.7062,NULL,0,0,0,0,100,0),
(435990,69,-10943.6,-3716.37,25.1772,NULL,0,0,0,0,100,0),
(435990,70,-10946.1,-3711.1,25.6488,NULL,0,0,0,0,100,0),
(435990,71,-10948.3,-3706.74,26.0617,NULL,0,0,0,0,100,0),
(435990,72,-10950.8,-3701.75,26.8761,NULL,0,0,0,0,100,0),
-- Marsh Inkspewer
(434440,1,-10925.2,-3615.64,18.9326,NULL,0,0,0,0,100,0),
(434440,2,-10930.7,-3614.06,19.5464,NULL,0,0,0,0,100,0),
(434440,3,-10937.8,-3612.03,20.2521,NULL,0,0,0,0,100,0),
(434440,4,-10944.5,-3610.09,21.1937,NULL,0,0,0,0,100,0),
(434440,5,-10951.5,-3615.64,22.7161,NULL,0,0,0,0,100,0),
(434440,6,-10951.4,-3621.36,23.07,NULL,0,0,0,0,100,0),
(434440,7,-10951.3,-3628.36,23.7271,NULL,0,0,0,0,100,0),
(434440,8,-10951.2,-3635.46,24.3859,NULL,0,0,0,0,100,0),
(434440,9,-10952.1,-3642.76,24.8287,NULL,0,0,0,0,100,0),
(434440,10,-10953,-3650.37,25.484,NULL,0,0,0,0,100,0),
(434440,11,-10958.9,-3656.74,27.283,NULL,0,0,0,0,100,0),
(434440,12,-10963.9,-3662.09,27.8501,NULL,0,0,0,0,100,0),
(434440,13,-10970.6,-3663.21,27.8697,NULL,0,0,0,0,100,0),
(434440,14,-10978,-3664.45,27.4874,NULL,0,0,0,0,100,0),
(434440,15,-10984.2,-3664.2,26.6214,NULL,0,0,0,0,100,0),
(434440,16,-10991.1,-3663.92,25.27,NULL,0,0,0,0,100,0),
(434440,17,-10997.9,-3663.65,24.2867,NULL,0,0,0,0,100,0),
(434440,18,-11003.9,-3663.41,23.6812,NULL,0,0,0,0,100,0),
(434440,19,-11008.8,-3663.21,23.3453,NULL,0,0,0,0,100,0),
(434440,20,-11012.7,-3667.37,23.2605,NULL,0,0,0,0,100,0),
(434440,21,-11016.7,-3671.63,22.9721,NULL,0,0,0,0,100,0),
(434440,22,-11020.8,-3675.98,22.4321,NULL,0,0,0,0,100,0),
(434440,23,-11020.2,-3681.16,22.5965,NULL,0,0,0,0,100,0),
(434440,24,-11019.6,-3687.43,22.7742,NULL,0,0,0,0,100,0),
(434440,25,-11019,-3692.53,22.5571,NULL,0,0,0,0,100,0),
(434440,26,-11015.9,-3696.49,22.2709,NULL,0,0,0,0,100,0),
(434440,27,-11012.5,-3700.93,21.4106,NULL,0,0,0,0,100,0),
(434440,28,-11009.8,-3701.1,21.1785,NULL,0,0,0,0,100,0),
(434440,29,-11003.4,-3701.5,19.7469,NULL,0,0,0,0,100,0),
(434440,30,-10997,-3701.9,18.2102,NULL,0,0,0,0,100,0),
(434440,31,-10991.9,-3701.83,16.8078,NULL,0,0,0,0,100,0),
(434440,32,-10986,-3701.75,15.6474,NULL,0,0,0,0,100,0),
(434440,33,-10979.1,-3701.65,14.339,NULL,0,0,0,0,100,0),
(434440,34,-10974.8,-3698.21,13.2362,NULL,0,0,0,0,100,0),
(434440,35,-10969.3,-3693.74,11.2729,NULL,0,0,0,0,100,0),
(434440,36,-10961.7,-3687.62,8.55936,NULL,0,0,0,0,100,0),
(434440,37,-10956.8,-3685.26,8.40825,NULL,0,0,0,0,100,0),
(434440,38,-10951.3,-3682.64,8.35577,NULL,0,0,0,0,100,0),
(434440,39,-10945.2,-3679.72,8.38139,NULL,0,0,0,0,100,0),
(434440,40,-10939,-3676.77,8.52817,NULL,0,0,0,0,100,0),
(434440,41,-10945.2,-3679.72,8.38139,NULL,0,0,0,0,100,0),
(434440,42,-10951.3,-3682.64,8.35577,NULL,0,0,0,0,100,0),
(434440,43,-10956.8,-3685.26,8.40825,NULL,0,0,0,0,100,0),
(434440,44,-10961.7,-3687.62,8.55936,NULL,0,0,0,0,100,0),
(434440,45,-10969.3,-3693.74,11.2729,NULL,0,0,0,0,100,0),
(434440,46,-10974.8,-3698.21,13.2362,NULL,0,0,0,0,100,0),
(434440,47,-10979.1,-3701.65,14.339,NULL,0,0,0,0,100,0),
(434440,48,-10986,-3701.75,15.6474,NULL,0,0,0,0,100,0),
(434440,49,-10991.9,-3701.83,16.8078,NULL,0,0,0,0,100,0),
(434440,50,-10997,-3701.9,18.2102,NULL,0,0,0,0,100,0),
(434440,51,-11003.4,-3701.5,19.7469,NULL,0,0,0,0,100,0),
(434440,52,-11009.8,-3701.1,21.1785,NULL,0,0,0,0,100,0),
(434440,53,-11012.5,-3700.93,21.4106,NULL,0,0,0,0,100,0),
(434440,54,-11015.9,-3696.49,22.2709,NULL,0,0,0,0,100,0),
(434440,55,-11019,-3692.53,22.5571,NULL,0,0,0,0,100,0),
(434440,56,-11019.6,-3687.43,22.7742,NULL,0,0,0,0,100,0),
(434440,57,-11020.2,-3681.16,22.5965,NULL,0,0,0,0,100,0),
(434440,58,-11020.8,-3675.98,22.4321,NULL,0,0,0,0,100,0),
(434440,59,-11016.7,-3671.63,22.9721,NULL,0,0,0,0,100,0),
(434440,60,-11012.7,-3667.37,23.2605,NULL,0,0,0,0,100,0),
(434440,61,-11008.8,-3663.21,23.3453,NULL,0,0,0,0,100,0),
(434440,62,-11003.9,-3663.41,23.6812,NULL,0,0,0,0,100,0),
(434440,63,-10997.9,-3663.65,24.2867,NULL,0,0,0,0,100,0),
(434440,64,-10991.1,-3663.92,25.27,NULL,0,0,0,0,100,0),
(434440,65,-10984.2,-3664.2,26.6214,NULL,0,0,0,0,100,0),
(434440,66,-10978,-3664.45,27.4874,NULL,0,0,0,0,100,0),
(434440,67,-10970.6,-3663.21,27.8697,NULL,0,0,0,0,100,0),
(434440,68,-10963.9,-3662.09,27.8501,NULL,0,0,0,0,100,0),
(434440,69,-10958.9,-3656.74,27.283,NULL,0,0,0,0,100,0),
(434440,70,-10953,-3650.37,25.484,NULL,0,0,0,0,100,0),
(434440,71,-10952.1,-3642.76,24.8287,NULL,0,0,0,0,100,0),
(434440,72,-10951.2,-3635.46,24.3859,NULL,0,0,0,0,100,0),
(434440,73,-10951.3,-3628.36,23.7271,NULL,0,0,0,0,100,0),
(434440,74,-10951.4,-3621.36,23.07,NULL,0,0,0,0,100,0),
(434440,75,-10951.5,-3615.64,22.7161,NULL,0,0,0,0,100,0),
(434440,76,-10944.5,-3610.09,21.1937,NULL,0,0,0,0,100,0),
(434440,77,-10937.8,-3612.03,20.2521,NULL,0,0,0,0,100,0),
(434440,78,-10930.7,-3614.06,19.5464,NULL,0,0,0,0,100,0),
-- Marsh Inkspewer
(435970,1,-10865.8,-3642.49,13.6656,NULL,0,0,0,0,100,0),
(435970,2,-10875.1,-3643.96,12.3535,NULL,0,0,0,0,100,0),
(435970,3,-10881,-3644.88,11.9771,NULL,0,0,0,0,100,0),
(435970,4,-10886.9,-3646.75,12.5139,NULL,0,0,0,0,100,0),
(435970,5,-10891.8,-3648.34,12.7855,NULL,0,0,0,0,100,0),
(435970,6,-10896.2,-3650.55,11.891,NULL,0,0,0,0,100,0),
(435970,7,-10901,-3653,10.9138,NULL,0,0,0,0,100,0),
(435970,8,-10905.8,-3655.62,10.5922,NULL,0,0,0,0,100,0),
(435970,9,-10910.6,-3658.24,10.4043,NULL,0,0,0,0,100,0),
(435970,10,-10914.9,-3660.55,10.2779,NULL,0,0,0,0,100,0),
(435970,11,-10914.4,-3664.25,10.4388,NULL,0,0,0,0,100,0),
(435970,12,-10913.7,-3669.91,11.0116,NULL,0,0,0,0,100,0),
(435970,13,-10912.9,-3676.09,11.7908,NULL,0,0,0,0,100,0),
(435970,14,-10908.2,-3679.34,13.2851,NULL,0,0,0,0,100,0),
(435970,15,-10902.6,-3683.19,15.374,NULL,0,0,0,0,100,0),
(435970,16,-10896.6,-3687.37,17.0184,NULL,0,0,0,0,100,0),
(435970,17,-10891.2,-3690.6,17.9684,NULL,0,0,0,0,100,0),
(435970,18,-10884.7,-3694.49,19.0841,NULL,0,0,0,0,100,0),
(435970,19,-10877.8,-3698.62,20.2577,NULL,0,0,0,0,100,0),
(435970,20,-10870.9,-3702.72,22.0694,NULL,0,0,0,0,100,0),
(435970,21,-10867.3,-3701.68,22.8399,NULL,0,0,0,0,100,0),
(435970,22,-10859.8,-3699.5,22.8516,NULL,0,0,0,0,100,0),
(435970,23,-10853.1,-3697.55,22.8444,NULL,0,0,0,0,100,0),
(435970,24,-10846.6,-3694.3,22.5648,NULL,0,0,0,0,100,0),
(435970,25,-10840.2,-3691.05,22.4976,NULL,0,0,0,0,100,0),
(435970,26,-10842.3,-3685.23,21.983,NULL,0,0,0,0,100,0),
(435970,27,-10844.5,-3679.19,21.4552,NULL,0,0,0,0,100,0),
(435970,28,-10846.7,-3673.04,20.9951,NULL,0,0,0,0,100,0),
(435970,29,-10848.7,-3667.33,20.4615,NULL,0,0,0,0,100,0),
(435970,30,-10851.4,-3663.39,19.8091,NULL,0,0,0,0,100,0),
(435970,31,-10855,-3658.11,18.8203,NULL,0,0,0,0,100,0),
(435970,32,-10859.1,-3652.25,17.2648,NULL,0,0,0,0,100,0),
(435970,33,-10862.3,-3647.53,15.4903,NULL,0,0,0,0,100,0);
