-- DB update 2021_12_07_00 -> 2021_12_07_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_07_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_07_00 2021_12_07_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638446224179942600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638446224179942600');

UPDATE `creature_template` SET `gossip_menu_id`= 4721 WHERE `entry`= 11861;

DELETE FROM `gossip_menu`WHERE `MenuID` = 4721 AND `TextID` = 5773;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES (4721, 5773);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
