--
UPDATE `creature_template` SET `skinloot` = 0, `mingold` = 0, `maxgold` = 0 WHERE (`entry` = 11374);

UPDATE `creature_template` SET `skinloot` = 0 WHERE (`entry` = 10596);

UPDATE `creature_template` SET `lootid` = 0, `skinloot` = 0 WHERE (`entry` = 15101);
DELETE FROM `creature_loot_template` WHERE `entry` = 15101;

UPDATE `creature_template` SET `lootid` = 0, `skinloot` = 0 WHERE (`entry` = 15068);
DELETE FROM `creature_loot_template` WHERE `entry` = 15068;
