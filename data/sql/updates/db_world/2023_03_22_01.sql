--
UPDATE `smart_scripts` SET `action_param1`=16380, `comment` = REGEXP_REPLACE(`comment`, 'Stealth', 'Greater Invisibility') WHERE `entryorguid` IN (8539,8538) AND `source_type`=0 AND `id`=2;
