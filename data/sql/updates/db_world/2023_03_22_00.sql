--
DELETE FROM `npc_trainer` WHERE `SpellID`=60969 AND `ID` IN (201040, 201041);
INSERT INTO `npc_trainer` (`ID`, `SpellID`, `MoneyCost`, `ReqSkillLine`, `ReqSkillRank`, `ReqLevel`) VALUES
(201040, 60969, 105000, 197, 300, 0);
