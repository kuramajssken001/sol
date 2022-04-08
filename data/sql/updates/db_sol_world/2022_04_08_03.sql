-- DB update 2022_04_08_02 -> 2022_04_08_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2022_04_08_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2022_04_08_02 2022_04_08_03 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1649417291803834291'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1649417291803834291');

DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 16345;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(16345,0,0,0,0,0,100,0,5000,10000,20000,40000,0,11,28902,0,0,0,0,0,26,10,0,0,0,0,0,0,0,'Shadowpine Catlord - IC - Cast ''Bloodlust'''),
(16345,0,1,0,25,0,100,0,0,0,0,0,0,11,28904,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Shadowpine Catlord - On Reset - Cast ''Summon Ghostclaw Lynx'''),
(16345,0,2,0,17,0,100,0,16348,0,0,0,0,240,1,1,0,0,0,0,7,0,0,0,0,0,0,0,0,'Shadowpine Catlord - On Summoned Unit ''Ghostclaw Lynx'' - Disable Owner Death Despawn (Invoker)');

UPDATE `smart_scripts` SET `action_param2` = 1 WHERE `entryorguid` = 3265 AND `source_type` = 0 AND `id` = 3;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
