DELETE FROM `command` WHERE `name` = 'go creature';
INSERT INTO `command` (`name`, `security`, `help`)
VALUES
('go creature',1,'Syntax: .go creature [db] #creature_guid\nTeleport your character to creature with guid #creature_guid (db: force DB position).\nSyntax: .go creature [db] #creature_name\nTeleport your character to creature with this name (db: force DB position).\nSyntax: .go creature id #creature_id\nTeleport your character to a creature that was spawned from the template with this entry.\nIf more than one creature is found, then you are teleported to the first that is found inside the database.\nSyntax: .go creature [ignore_orientation]\nTeleport to the selected creature.\nIf "ignore_orientation" is specified teleport to the selected creature without adjusting the player''s orientation.');
