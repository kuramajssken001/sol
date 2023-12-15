/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `prospecting_loot_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prospecting_loot_template` (
  `Entry` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `Item` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `Reference` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `Chance` float NOT NULL DEFAULT 100,
  `QuestRequired` tinyint(1) NOT NULL DEFAULT 0,
  `LootMode` smallint(5) unsigned NOT NULL DEFAULT 1,
  `GroupId` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinCount` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `MaxCount` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `Comment` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Entry`,`Item`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci ROW_FORMAT=FIXED COMMENT='Loot System';
/*!40101 SET character_set_client = @saved_cs_client */;

LOCK TABLES `prospecting_loot_template` WRITE;
/*!40000 ALTER TABLE `prospecting_loot_template` DISABLE KEYS */;
INSERT INTO `prospecting_loot_template` VALUES
(2770,774,0,0,0,1,1,1,1,NULL),
(2770,818,0,0,0,1,1,1,1,NULL),
(2770,1210,0,10,0,1,0,1,1,NULL),
(2771,1,13000,10,0,1,0,1,1,NULL),
(2771,1206,0,0,0,1,1,1,2,NULL),
(2771,1210,0,0,0,1,1,1,2,NULL),
(2771,1705,0,0,0,1,1,1,2,NULL),
(2772,1529,0,30,0,1,1,1,2,NULL),
(2772,1705,0,30,0,1,1,1,2,NULL),
(2772,3864,0,30,0,1,1,1,2,NULL),
(2772,7909,0,5,0,1,1,1,1,NULL),
(2772,7910,0,5,0,1,1,1,1,NULL),
(3858,3864,0,30,0,1,1,1,2,NULL),
(3858,7909,0,30,0,1,1,1,2,NULL),
(3858,7910,0,30,0,1,1,1,2,NULL),
(3858,12361,0,2.5,0,1,1,1,1,NULL),
(3858,12364,0,2.5,0,1,1,1,1,NULL),
(3858,12799,0,2.5,0,1,1,1,1,NULL),
(3858,12800,0,2.5,0,1,1,1,1,NULL),
(10620,1,13001,10,0,1,1,1,1,NULL),
(10620,7910,0,32,0,1,1,1,2,NULL),
(10620,12361,0,17,0,1,1,1,2,NULL),
(10620,12364,0,17,0,1,1,1,2,NULL),
(10620,12799,0,17,0,1,1,1,2,NULL),
(10620,12800,0,17,0,1,1,1,2,NULL),
(23424,1,1000,100,0,1,1,1,1,NULL),
(23425,1,13001,100,0,1,1,1,1,NULL),
(23425,2,13002,24,0,1,1,1,1,NULL),
(23425,3,13001,15,0,1,1,1,1,NULL),
(23425,24243,0,100,0,1,0,1,1,NULL),
(36909,1,1001,100,0,1,1,1,1,NULL),
(36910,1,13005,20,0,1,0,1,1,NULL),
(36910,2,1002,100,0,1,1,1,1,NULL),
(36910,3,1003,75,0,1,1,1,1,NULL),
(36910,46849,0,75,0,1,0,1,1,NULL),
(36912,1,1003,85,0,1,0,1,1,NULL),
(36912,2,1004,100,0,1,1,1,1,NULL);
/*!40000 ALTER TABLE `prospecting_loot_template` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

