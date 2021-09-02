-- DB update 2021_09_02_02 -> 2021_09_02_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2021_09_02_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2021_09_02_02 2021_09_02_03 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1630594808799804295'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1630594808799804295');

UPDATE `quest_template` SET `TimeAllowed` = 602 WHERE `ID` = 1699;

DELETE FROM `spell_script_names` WHERE `spell_id` = 8553;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`)
VALUES
(8553,'spell_gen_barleybrew_scalder');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
