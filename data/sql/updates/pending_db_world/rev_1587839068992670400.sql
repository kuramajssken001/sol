INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1587839068992670400');

DELETE FROM `spell_script_names` WHERE `spell_id`=21149 AND `ScriptName`="spell_item_eggnog";
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(21149,'spell_item_eggnog');
