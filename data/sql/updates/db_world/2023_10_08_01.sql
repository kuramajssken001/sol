-- Banner of Provocation
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceGroup` = 0 AND `SourceEntry` = 27517;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `Comment`) VALUES
(17, 0, 27517, 0, 0, 30, 0, 181058, 20, 0, 1, 25, 0, 'Spell ''Summon Thelrin DND'' - Group 0: Can cast if not nearby GO ''Banner of Provocation''');
