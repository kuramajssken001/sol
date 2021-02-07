-- DB update 2021_02_06_00 -> 2021_02_07_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2021_02_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2021_02_06_00 2021_02_07_00 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1612722643671378506'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1612722643671378506');

DELETE FROM `gossip_menu` WHERE `MenuID` IN (2405,2406,2407,2408);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`)
VALUES
(2405,3077),
(2405,3097),
(2405,3098),
(2405,3099),
(2406,3100),
(2407,3101),
(2408,3102);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` IN (14,15) AND `SourceGroup` = 2405;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
(14,2405,3097,0,0,47,0,4512,64,0,0,0,0,'','Show gossip text 3097 if quest ''A Little Slime Goes a Long Way (Part 1)'' is rewarded'),
(14,2405,3097,0,0,47,0,4513,1,0,0,0,0,'','Show gossip text 3097 if quest ''A Little Slime Goes a Long Way (Part 2)'' is not taken'),
(14,2405,3098,0,0,47,0,4513,64,0,0,0,0,'','Show gossip text 3098 if quest ''A Little Slime Goes a Long Way (Part 2)'' is rewarded'),
(14,2405,3099,0,0,47,0,4513,10,0,0,0,0,'','Show gossip text 3099 if quest ''A Little Slime Goes a Long Way (Part 2)'' is taken'),
(15,2405,0,0,0,47,0,4513,64,0,1,0,0,'','Show gossip option 0 if quest ''A Little Slime Goes a Long Way (Part 2)'' is not rewarded');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
