-- DB update 2021_09_21_01 -> 2021_09_21_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_09_21_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_09_21_01 2021_09_21_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1631944525344217322'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1631944525344217322');

-- Deletes Plaguebloom from all NPC loot tables 
DELETE FROM `creature_loot_template` WHERE `item` = 13466;

-- Remove loot from Crimson Bodyguard
UPDATE `creature_template` SET `lootid` = 0 WHERE `Entry` = 13118;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
