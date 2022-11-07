UPDATE `gameobject` SET `spawntimesecs` = 120 WHERE `guid` IN (24782,24783,24784,24785,24786);
DELETE FROM `gameobject` WHERE `guid` IN (63493,63495,63496,63497,63500,63501,63502);
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `VerifiedBuild`)
VALUES
(63493,183934,530,0,0,1,1,74.2638,3039.5,-0.616187,4.41568,0,0,0.803858,-0.594822,120,100,1,0),
(63495,183934,530,0,0,1,1,193.659,3062.06,-0.588734,2.04204,0,0,0.852641,0.522496,120,100,1,0),
(63496,183934,530,0,0,1,1,263.389,3016.84,-0.839023,6.00393,0,0,0.139174,-0.990268,120,100,1,0),
(63497,183934,530,0,0,1,1,44.8782,3077.43,-1.22251,0.0523589,0,0,0.0261765,0.999657,120,100,1,0),
(63500,183934,530,0,0,1,1,26.9473,3130.27,-0.856446,4.76475,0,0,0.688354,-0.725375,120,100,1,0),
(63501,183934,530,0,0,1,1,101.729,3043.01,-1.22253,5.48033,0,0,0.390733,-0.920504,120,100,1,0),
(63502,183934,530,0,0,1,1,174.773,3039.32,-0.794917,0.680677,0,0,0.333806,0.942642,120,100,1,0);
