DELETE FROM `smart_scripts` WHERE `entryorguid` IN (15651,15652) AND `source_type` = 0;
UPDATE `creature_template` SET `AIName` = '' WHERE `entry` IN (15651,15652);
