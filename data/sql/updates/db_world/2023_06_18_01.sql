DELETE FROM `spell_proc_event` WHERE `entry` IN (24256,27997,33510,33511,33522);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`)
VALUES
(24256,0,0,0,0,0,0,0,0,0,240000),
(27997,0,0,0,0,0,0,0,0,0,50000),
(33510,0,0,0,0,0,0,0,0,0,25000),
(33511,0,0,0,0,0,0,0,0,0,17000),
(33522,0,0,0,0,0,0,0,0,0,25000);
