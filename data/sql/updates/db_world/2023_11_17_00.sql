-- Underbog Colossus
UPDATE `creature_template` SET `unit_flags` = `unit_flags`|64|32768, `mechanic_immune_mask` = `mechanic_immune_mask`|2|16|64|256|512|1024|2048|4096|8192|131072|8388608|33554432 WHERE (`entry` = 21251);
