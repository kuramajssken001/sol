INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1615980645222325242');

-- Mass change respawns of various fishing pools
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180751; -- Floating Wreckage
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180901; -- Bloodsail Wreckage
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180655; -- Floating Debris
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180661; -- Oil Spill
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180657; -- Sparse Firefin Snapper School   
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180683; -- Firefin Snapper School          
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180752; -- Teeming Firefin Snapper School  
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180902; -- Abundant Firefin Snapper School 
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180684; -- Greater Sagefish School
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180582; -- Lesser Oily Blackmouth School
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180664; -- Sparse Oily Blackmouth School
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180682; -- Oily Blackmouth School 
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180750; -- Teeming Oily Blackmouth School
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180900; -- Abundant Oily Blackmouth School
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180656; -- Lesser Sagefish School
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180663; -- Sagefish School
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180658; -- School of Deviate Fish
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=180712; -- Stonescale Eel Swarm
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=182957; -- Highland Mixed School
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=182951; -- Pure Water
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=182959; -- Bluefish School
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=182954; -- Brackish Mixed School
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=182958; -- Mudfish School
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=182956; -- School of Darter
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=182953; -- Sporefish School
UPDATE `gameobject` SET `spawntimesecs`=3600 WHERE `id`=182952; -- Steam Pump Flotsam
-- UPDATE `gameobject` SET `spawntimesecs`=300 WHERE `id`=180248; -- School of Tastyfish
