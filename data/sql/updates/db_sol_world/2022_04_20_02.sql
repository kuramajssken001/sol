-- DB update 2022_04_20_01 -> 2022_04_20_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2022_04_20_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2022_04_20_01 2022_04_20_02 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1650489934743805769'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1650489934743805769');

DELETE FROM `gossip_menu` WHERE `MenuID` = 9676;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`)
VALUES
(9676,13287);

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 9676;
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`)
VALUES
(9676,0,0,'I''m ready to battle the dreadlord, sire.',28508,1,1,0,0,0,0,'',0,0);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
