INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1613512073209092300');

/* Commander Althea Ebonlocke Gossip
*/

UPDATE `creature_template` SET `gossip_menu_id`=57032 , `npcflag`=`npcflag`|1 WHERE `entry`=264;
DELETE FROM `npc_text` WHERE `ID`=50029;
INSERT INTO `npc_text` (`ID`, `text0_0`, `BroadcastTextID0`) VALUES
(50029,'At ease, $c. If you are just passing though I suggest you stick to the roads and only travel by day. If your business is here in Darkshire, consider lending your abilities to the Night Watch. Our skill is unquestionable but our numbers are small.',0);

DELETE FROM `gossip_menu` WHERE `MenuID` = 57032 AND `TextID` = 50029;
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(57032, 50029);

/* Councilman Millstipe orientation
*/

UPDATE `creature` SET `orientation` = 4.78421 WHERE `guid` = 4189;

/* Ambassador Berrybuck Text
*/

UPDATE `creature_text` SET `Text`='The news from Stormwind does not bode well....' WHERE  `CreatureID`=271 AND `GroupID`=0 AND `ID`=1;
UPDATE `broadcast_text` SET `MaleText`='The news from Stormwind does not bode well....' WHERE  `ID`=71;
