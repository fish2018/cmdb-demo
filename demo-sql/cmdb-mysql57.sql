-- MySQL dump 10.13  Distrib 5.7.25, for Linux (x86_64)
--
-- Host: localhost    Database: cmdb
-- ------------------------------------------------------
-- Server version	5.7.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `cmdb`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `cmdb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `cmdb`;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `instance`
--

DROP TABLE IF EXISTS `instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) DEFAULT NULL,
  `instance_name` varchar(20) NOT NULL,
  `data_json` json NOT NULL,
  `create_time` datetime DEFAULT NULL,
  `involved_by` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `template_id` (`template_id`),
  CONSTRAINT `instance_ibfk_1` FOREIGN KEY (`template_id`) REFERENCES `template` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `instance`
--

LOCK TABLES `instance` WRITE;
/*!40000 ALTER TABLE `instance` DISABLE KEYS */;
INSERT INTO `instance` VALUES (4,3,'demo运维','{\"姓名\": \"张三\", \"联系方式\": \"zhangsan@qq.com\"}','2019-05-02 07:58:50','[5]'),(5,2,'登录单点','{\"管理员\": {\"demo运维\": 4}, \"开发语言\": \"php\"}','2019-05-02 08:52:00','[6]'),(6,1,'demo主机','{\"cpu\": \"2核4线程\", \"mem\": \"8G\", \"型号\": \"R730\", \"应用\": {\"登录单点\": 5}}','2019-05-02 08:54:09',NULL);
/*!40000 ALTER TABLE `instance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operation_history`
--

DROP TABLE IF EXISTS `operation_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operation_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) DEFAULT NULL,
  `instance_id` int(11) DEFAULT NULL,
  `old_json` json NOT NULL,
  `new_json` json NOT NULL,
  `performer` varchar(20) NOT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation_history`
--

LOCK TABLES `operation_history` WRITE;
/*!40000 ALTER TABLE `operation_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `operation_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'devops','2018-12-22 10:05:43');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template`
--

DROP TABLE IF EXISTS `template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `template_name` varchar(20) NOT NULL,
  `template_json` json NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `template_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `template_category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template`
--

LOCK TABLES `template` WRITE;
/*!40000 ALTER TABLE `template` DISABLE KEYS */;
INSERT INTO `template` VALUES (1,1,'服务器','{\"cpu\": {\"type\": \"STRING\", \"relate\": null, \"required\": true, \"logic_del\": false}, \"mem\": {\"type\": \"STRING\", \"relate\": null, \"required\": true, \"logic_del\": false}, \"型号\": {\"type\": \"STRING\", \"relate\": null, \"required\": true, \"logic_del\": false}, \"应用\": {\"type\": \"OBJECT\", \"relate\": [2], \"required\": false, \"logic_del\": false}}','','2018-12-22 10:39:06'),(2,2,'sso','{\"管理员\": {\"type\": \"OBJECT\", \"relate\": [3], \"required\": true, \"logic_del\": false}, \"开发语言\": {\"type\": \"STRING\", \"relate\": null, \"required\": true, \"logic_del\": false}}','','2018-12-22 11:00:15'),(3,3,'系统运维','{\"姓名\": {\"type\": \"STRING\", \"relate\": null, \"required\": false, \"logic_del\": false}, \"联系方式\": {\"type\": \"STRING\", \"relate\": null, \"required\": false, \"logic_del\": false}}','','2018-12-22 11:03:57');
/*!40000 ALTER TABLE `template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `template_category`
--

DROP TABLE IF EXISTS `template_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `template_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(20) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `template_category`
--

LOCK TABLES `template_category` WRITE;
/*!40000 ALTER TABLE `template_category` DISABLE KEYS */;
INSERT INTO `template_category` VALUES (1,'硬件','硬件设备','2018-12-22 10:30:00'),(2,'软件','软件应用','2018-12-22 10:58:39'),(3,'联系方','场景方，资金方，供应商，客户，管理员，项目经理，负责人。。。','2018-12-22 11:02:05');
/*!40000 ALTER TABLE `template_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(80) DEFAULT NULL,
  `password` varchar(200) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'fish2019','$6$rounds=656000$yl2.FD.7VFF.TmXV$oaN48xcHBhKjafiEIS37j6q8Vi5btBezzxP6CJd.40nc8ef7.HdJ0SLpY30riOlYkEMFDfBBOeU5wOfiMDTbe0',1,'2018-12-22 10:05:43');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `view_template`
--

DROP TABLE IF EXISTS `view_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `view_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) DEFAULT NULL,
  `name` varchar(20) NOT NULL,
  `view_prop` json NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `view_template`
--

LOCK TABLES `view_template` WRITE;
/*!40000 ALTER TABLE `view_template` DISABLE KEYS */;
INSERT INTO `view_template` VALUES (1,1,'服务器视图','[[\"型号\"], [\"cpu\"], [\"mem\"], [\"应用\", \"开发语言\"], [\"应用\", \"管理员\", \"姓名\"], [\"应用\", \"管理员\", \"联系方式\"]]'),(2,2,'sso视图','[[\"开发语言\"], [\"管理员\", \"姓名\"], [\"管理员\", \"联系方式\"]]'),(3,2,'','[[\"管理员\", \"联系方式\"]]');
/*!40000 ALTER TABLE `view_template` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-02 12:24:40
