-- DB update 2021_07_05_01 -> 2021_07_05_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_05_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_05_01 2021_07_05_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624689676324157623'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624689676324157623');

-- Removes Civilian flag from Nazzivus Summoners
UPDATE `creature_template` SET `flags_extra` = `flags_extra`&~(2) WHERE `entry` = 17524;

-- Set MovementType to 1 for spawn 86538 to match all other Nazzivus Summoners
UPDATE `creature` SET `wander_distance` = 5, `MovementType` = 1 WHERE `guid` = 86538;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
