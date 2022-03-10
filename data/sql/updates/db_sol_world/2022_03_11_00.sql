-- DB update 2022_03_10_03 -> 2022_03_11_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2022_03_10_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2022_03_10_03 2022_03_11_00 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1646953688224995067'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1646953688224995067');

UPDATE `creature` SET `wander_distance` = 20 WHERE `guid` IN (113362,113363);

DELETE FROM `waypoint_data` WHERE `id` = 1133640;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `pathfinding`, `action`, `action_chance`, `wpguid`)
VALUES
(1133640,1,5879.1,-3678.56,373.52,0,0,0,0,0,100,0),
(1133640,2,5875.97,-3673.35,372.683,0,0,0,0,0,100,0),
(1133640,3,5868.81,-3661.46,371.988,0,0,0,0,0,100,0),
(1133640,4,5861.94,-3650.03,373.11,0,3000,1,0,1194,100,0),
(1133640,5,5851.05,-3640.04,377.61,0,0,1,0,0,100,0),
(1133640,6,5842.73,-3643.48,379.49,0,0,1,0,0,100,0),
(1133640,7,5835.83,-3646.31,380.45,0,0,0,0,0,100,0),
(1133640,8,5829.69,-3652.21,380.224,0,0,0,0,0,100,0),
(1133640,9,5824.31,-3657.38,379.578,0,0,0,0,0,100,0),
(1133640,10,5819.04,-3665.07,375.778,0,0,0,0,0,100,0),
(1133640,11,5818.76,-3676.74,375.699,0,0,0,0,0,100,0),
(1133640,12,5828.38,-3682.69,371.987,0,0,0,0,0,100,0),
(1133640,13,5840.22,-3683.85,372.021,0,0,0,0,0,100,0),
(1133640,14,5849.61,-3684.85,372.001,0,0,0,0,0,100,0),
(1133640,15,5863.53,-3686.34,372.455,0,0,0,0,0,100,0),
(1133640,16,5869.57,-3686.98,373.493,0,0,0,0,0,100,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
