DELETE FROM `creature` WHERE `guid` = 85566;
DELETE FROM `creature_addon` WHERE `guid` IN (66759,66760,66761,66762,66763,66764,66765,66766,66767,66768,66769,66770,66771,66772,66773,66774,66775,66776,66777,66778,66779);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `isLarge`, `auras`)
VALUES
(66759,0,0,0,1,234,0,NULL),
(66760,0,0,0,1,234,0,NULL),
(66761,0,0,0,1,234,0,NULL),
(66762,0,0,0,1,234,0,NULL),
(66763,0,0,0,1,234,0,NULL),
(66764,0,0,0,1,234,0,NULL),
(66765,0,0,0,1,234,0,NULL),
(66766,0,0,0,1,234,0,NULL),
(66767,0,0,0,1,234,0,NULL),
(66768,0,0,0,1,234,0,NULL),
(66769,0,0,0,1,234,0,NULL),
(66770,0,0,0,1,234,0,NULL),
(66771,0,0,0,1,234,0,NULL),
(66772,0,0,0,1,234,0,NULL),
(66773,0,0,0,1,234,0,NULL),
(66774,0,0,0,1,234,0,NULL),
(66775,0,0,0,1,234,0,NULL),
(66776,0,0,0,1,234,0,NULL),
(66777,0,0,0,1,234,0,NULL),
(66778,0,0,0,1,234,0,NULL),
(66779,0,0,0,1,234,0,NULL);
