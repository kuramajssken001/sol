-- DB update 2020_02_17_00 -> 2020_03_02_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_02_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_02_17_00 2020_03_02_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1581974554600178400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1581974554600178400');
UPDATE `creature_template` SET `faction` = 35 WHERE `entry` = 4787;
UPDATE `creature_template_locale` SET `Name` = 'Argentumwache Thaelrid', `Title` = 'Die Argentumdämmerung' WHERE `entry` = 4787 AND `locale` = 'deDE';
UPDATE `creature_template_locale` SET `Name` = 'Guardia Argenta Thaelrid', `Title` = 'El Alba Argenta' WHERE `entry` = 4787 AND `locale` = 'esES';
UPDATE `creature_template_locale` SET `Name` = 'Guardia Argenta Thaelrid', `Title` = 'El Alba Argenta' WHERE `entry` = 4787 AND `locale` = 'esMX';
UPDATE `creature_template_locale` SET `Name` = 'Garde d’argent Thaelrid', `Title` = 'L''Aube d''argent' WHERE `entry` = 4787 AND `locale` = 'frFR';

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
