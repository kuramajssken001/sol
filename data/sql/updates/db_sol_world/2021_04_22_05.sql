-- DB update 2021_04_22_04 -> 2021_04_22_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2021_04_22_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2021_04_22_04 2021_04_22_05 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1619071166066876739'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1619071166066876739');

UPDATE `creature` SET `position_z` = 95.071 WHERE `guid` = 20534;
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE `guid` IN (20534,20508);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
