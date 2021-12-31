-- DB update 2021_12_30_00 -> 2022_01_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_30_00 2022_01_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640969804388366165'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640969804388366165');

-- removes loot id 7549 link from Tree Frog
UPDATE `creature_template` SET `lootid`=0 WHERE  `entry`=7549;

-- Removes Loot from creature Tree Frog NPC ID 7549
DELETE FROM `creature_loot_template` WHERE  `Entry`=7549;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
