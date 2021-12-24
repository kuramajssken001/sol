-- DB update 2021_12_23_00 -> 2021_12_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2021_12_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2021_12_23_00 2021_12_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1640350416404134704'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1640350416404134704');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 2695;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 2695;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryorguid` = 269500;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(2695,0,0,0,20,0,100,0,637,0,0,0,0,80,269500,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sara Balloo - On Quest ''Sully Balloo''s Letter'' Rewarded - Call Timed Action List'),

(269500,9,0,0,0,0,100,0,0,0,0,0,0,83,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sara Balloo - On Script - Remove ''UNIT_NPC_FLAG_QUESTGIVER'''),
(269500,9,1,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sara Balloo - On Script - Say Line 0'),
(269500,9,2,0,0,0,100,0,5000,5000,0,0,0,1,1,0,1,0,0,0,7,0,0,0,0,0,0,0,0,'Sara Balloo - On Script - Say Line 1'),
(269500,9,3,0,0,0,100,0,6000,6000,0,0,0,82,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Sara Balloo - On Script - Add ''UNIT_NPC_FLAG_QUESTGIVER''');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
