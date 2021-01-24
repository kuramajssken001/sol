-- DB update 2021_01_24_00 -> 2021_01_24_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2021_01_24_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2021_01_24_00 2021_01_24_01 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1611495248263478680'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1611495248263478680');

UPDATE `gameobject_template` SET `Data3` = 1, `Data5` = 1 WHERE `entry` = 182196; -- Consumable and disappear after use
UPDATE `event_scripts` SET `x` = -108.252, `y` = -510.302, `z` = 21.4761, `o` = 2.44346 WHERE `id` = 14592 AND `command` = 10 AND `datalong` = 22890;

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 22890;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 22890 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(22890,0,0,0,54,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,21,50,0,0,0,0,0,0,0,'First Fragment Guardian - On Just Summoned - Attack Closest Player');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
