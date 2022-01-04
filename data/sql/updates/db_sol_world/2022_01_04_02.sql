-- DB update 2022_01_04_01 -> 2022_01_04_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_sol_world' AND COLUMN_NAME = '2022_01_04_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_sol_world CHANGE COLUMN 2022_01_04_01 2022_01_04_02 bit;
SELECT sql_rev INTO OK FROM version_db_sol_world WHERE sql_rev = '1641322730759006091'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_sol_world` (`sql_rev`) VALUES ('1641322730759006091');

DELETE FROM `creature_loot_template` WHERE `Item` IN (5263,18255,18266,18297) AND `Entry` IN (
416,11441,11441,11441,11444,11444,11444,11444,11448,11448,11448,11450,11450,11451,11451,11452,
11452,11453,11453,11454,11454,11455,11455,11456,11456,11456,11457,11457,11458,11461,11461,11462,
11462,11464,11464,11465,11480,11483,11484,13021,13021,13022,13022,13022,13022,13036,13036,13036,
13036,13160,13160,13160,13160,13196,13196,13197,13197,13276,13276,13285,13285,13285,14303,14351,
14385,14385);

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
