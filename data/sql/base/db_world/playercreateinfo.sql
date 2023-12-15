/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `playercreateinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playercreateinfo` (
  `race` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `class` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `map` smallint(5) unsigned NOT NULL DEFAULT 0,
  `zone` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `position_x` float NOT NULL DEFAULT 0,
  `position_y` float NOT NULL DEFAULT 0,
  `position_z` float NOT NULL DEFAULT 0,
  `orientation` float NOT NULL DEFAULT 0,
  PRIMARY KEY (`race`,`class`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `playercreateinfo` WRITE;
/*!40000 ALTER TABLE `playercreateinfo` DISABLE KEYS */;
INSERT INTO `playercreateinfo` VALUES
(1,1,0,12,-8949.95,-132.493,83.5312,0),
(1,2,0,12,-8949.95,-132.493,83.5312,0),
(1,4,0,12,-8949.95,-132.493,83.5312,0),
(1,5,0,12,-8949.95,-132.493,83.5312,0),
(1,6,609,4298,2355.84,-5664.77,426.028,3.65997),
(1,8,0,12,-8949.95,-132.493,83.5312,0),
(1,9,0,12,-8949.95,-132.493,83.5312,0),
(2,1,1,14,-618.518,-4251.67,38.718,0),
(2,3,1,14,-618.518,-4251.67,38.718,0),
(2,4,1,14,-618.518,-4251.67,38.718,0),
(2,6,609,4298,2358.44,-5666.9,426.023,3.65997),
(2,7,1,14,-618.518,-4251.67,38.718,0),
(2,9,1,14,-618.518,-4251.67,38.718,0),
(3,1,0,1,-6240.32,331.033,382.758,6.17716),
(3,2,0,1,-6240.32,331.033,382.758,6.17716),
(3,3,0,1,-6240.32,331.033,382.758,6.17716),
(3,4,0,1,-6240.32,331.033,382.758,6.17716),
(3,5,0,1,-6240.32,331.033,382.758,6.17716),
(3,6,609,4298,2358.44,-5666.9,426.023,3.65997),
(4,1,1,141,10311.3,832.463,1326.41,5.69632),
(4,3,1,141,10311.3,832.463,1326.41,5.69632),
(4,4,1,141,10311.3,832.463,1326.41,5.69632),
(4,5,1,141,10311.3,832.463,1326.41,5.69632),
(4,6,609,4298,2356.21,-5662.21,426.026,3.65997),
(4,11,1,141,10311.3,832.463,1326.41,5.69632),
(5,1,0,85,1676.71,1678.31,121.67,2.70526),
(5,4,0,85,1676.71,1678.31,121.67,2.70526),
(5,5,0,85,1676.71,1678.31,121.67,2.70526),
(5,6,609,4298,2356.21,-5662.21,426.026,3.65997),
(5,8,0,85,1676.71,1678.31,121.67,2.70526),
(5,9,0,85,1676.71,1678.31,121.67,2.70526),
(6,1,1,215,-2917.58,-257.98,52.9968,0),
(6,3,1,215,-2917.58,-257.98,52.9968,0),
(6,6,609,4298,2358.17,-5663.21,426.027,3.65997),
(6,7,1,215,-2917.58,-257.98,52.9968,0),
(6,11,1,215,-2917.58,-257.98,52.9968,0),
(7,1,0,1,-6240.32,331.033,382.758,0),
(7,4,0,1,-6240,331,383,0),
(7,6,609,4298,2355.05,-5661.7,426.026,3.65997),
(7,8,0,1,-6240,331,383,0),
(7,9,0,1,-6240,331,383,0),
(8,1,1,14,-618.518,-4251.67,38.718,0),
(8,3,1,14,-618.518,-4251.67,38.718,0),
(8,4,1,14,-618.518,-4251.67,38.718,0),
(8,5,1,14,-618.518,-4251.67,38.718,0),
(8,6,609,4298,2355.05,-5661.7,426.026,3.65997),
(8,7,1,14,-618.518,-4251.67,38.718,0),
(8,8,1,14,-618.518,-4251.67,38.718,0),
(10,2,530,3431,10349.6,-6357.29,33.4026,5.31605),
(10,3,530,3431,10349.6,-6357.29,33.4026,5.31605),
(10,4,530,3431,10349.6,-6357.29,33.4026,5.31605),
(10,5,530,3431,10349.6,-6357.29,33.4026,5.31605),
(10,6,609,4298,2355.84,-5664.77,426.028,3.65997),
(10,8,530,3431,10349.6,-6357.29,33.4026,5.31605),
(10,9,530,3431,10349.6,-6357.29,33.4026,5.31605),
(11,1,530,3526,-3961.64,-13931.2,100.615,2.08364),
(11,2,530,3526,-3961.64,-13931.2,100.615,2.08364),
(11,3,530,3526,-3961.64,-13931.2,100.615,2.08364),
(11,5,530,3526,-3961.64,-13931.2,100.615,2.08364),
(11,6,609,4298,2358.17,-5663.21,426.027,3.65997),
(11,7,530,3526,-3961.64,-13931.2,100.615,2.08364),
(11,8,530,3526,-3961.64,-13931.2,100.615,2.08364);
/*!40000 ALTER TABLE `playercreateinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

