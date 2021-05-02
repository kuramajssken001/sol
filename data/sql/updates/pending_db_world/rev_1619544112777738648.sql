INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1619544112777738648');

SET
@POOL            = 11655,
@POOLSIZE        = 5,
@POOLDESC        = 'Treasures - Arathi Highlands',
@RESPAWN         = 900,
@GUID = '16648,100067,16950,100068,16946,87385,85710,16794,16949,100070,16978,16789,16977';

-- Create pool(s)
DELETE FROM `pool_template` WHERE `entry`=@POOL;
INSERT INTO `pool_template` (`entry`,`max_limit`,`description`) VALUES (@POOL,@POOLSIZE,@POOLDESC);

-- Add gameobjects to pools
DELETE FROM `pool_gameobject` WHERE FIND_IN_SET (`guid`,@GUID);
INSERT INTO `pool_gameobject` (`guid`,`pool_entry`,`chance`,`description`) VALUES
(16648,@POOL,0,'Solid Chest, Arathi Highlands, node 1'),
(100067,@POOL,0,'Solid Chest, Arathi Highlands, node 2'),
(16950,@POOL,0,'Solid Chest, Arathi Highlands, node 3'),
(100068,@POOL,0,'Solid Chest, Arathi Highlands, node 5'),
(16946,@POOL,0,'Solid Chest, Arathi Highlands, node 6'),
(87385,@POOL,0,'Solid Chest, Arathi Highlands, node 7'),
(85710,@POOL,0,'Solid Chest, Arathi Highlands, node 8'),
(16794,@POOL,0,'Solid Chest, Arathi Highlands, node 9'),
(16949,@POOL,0,'Solid Chest, Arathi Highlands, node 10'),
(100070,@POOL,0,'Solid Chest, Arathi Highlands, node 11'),
(16978,@POOL,0,'Solid Chest, Arathi Highlands, node 12'),
(16789,@POOL,0,'Solid Chest, Arathi Highlands, node 13'),
(16977,@POOL,0,'Solid Chest, Arathi Highlands, node 14');

-- Respawn rates of gameobjects
UPDATE `gameobject` SET `spawntimesecs`=@RESPAWN WHERE FIND_IN_SET (`guid`,@GUID);

