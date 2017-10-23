-- MySQL dump 10.9
--
-- Host: localhost    Database: phpmyadmin
-- ------------------------------------------------------
-- Server version	4.1.10-nt

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

--
-- Current Database: `phpmyadmin`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `phpmyadmin` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;

USE `phpmyadmin`;

--
-- Table structure for table `pma_bookmark`
--

DROP TABLE IF EXISTS `pma_bookmark`;
CREATE TABLE `pma_bookmark` (
  `id` int(11) NOT NULL auto_increment,
  `dbase` varchar(255) collate utf8_bin NOT NULL default '',
  `user` varchar(255) collate utf8_bin NOT NULL default '',
  `label` varchar(255) character set utf8 NOT NULL default '',
  `query` text collate utf8_bin NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

--
-- Dumping data for table `pma_bookmark`
--


/*!40000 ALTER TABLE `pma_bookmark` DISABLE KEYS */;
LOCK TABLES `pma_bookmark` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `pma_bookmark` ENABLE KEYS */;

--
-- Table structure for table `pma_column_info`
--

DROP TABLE IF EXISTS `pma_column_info`;
CREATE TABLE `pma_column_info` (
  `id` int(5) unsigned NOT NULL auto_increment,
  `db_name` varchar(64) collate utf8_bin NOT NULL default '',
  `table_name` varchar(64) collate utf8_bin NOT NULL default '',
  `column_name` varchar(64) collate utf8_bin NOT NULL default '',
  `comment` varchar(255) character set utf8 NOT NULL default '',
  `mimetype` varchar(255) character set utf8 NOT NULL default '',
  `transformation` varchar(255) collate utf8_bin NOT NULL default '',
  `transformation_options` varchar(255) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

--
-- Dumping data for table `pma_column_info`
--


/*!40000 ALTER TABLE `pma_column_info` DISABLE KEYS */;
LOCK TABLES `pma_column_info` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `pma_column_info` ENABLE KEYS */;

--
-- Table structure for table `pma_history`
--

DROP TABLE IF EXISTS `pma_history`;
CREATE TABLE `pma_history` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `username` varchar(64) collate utf8_bin NOT NULL default '',
  `db` varchar(64) collate utf8_bin NOT NULL default '',
  `table` varchar(64) collate utf8_bin NOT NULL default '',
  `timevalue` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `sqlquery` text collate utf8_bin NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `username` (`username`,`db`,`table`,`timevalue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

--
-- Dumping data for table `pma_history`
--


/*!40000 ALTER TABLE `pma_history` DISABLE KEYS */;
LOCK TABLES `pma_history` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `pma_history` ENABLE KEYS */;

--
-- Table structure for table `pma_pdf_pages`
--

DROP TABLE IF EXISTS `pma_pdf_pages`;
CREATE TABLE `pma_pdf_pages` (
  `db_name` varchar(64) collate utf8_bin NOT NULL default '',
  `page_nr` int(10) unsigned NOT NULL auto_increment,
  `page_descr` varchar(50) character set utf8 NOT NULL default '',
  PRIMARY KEY  (`page_nr`),
  KEY `db_name` (`db_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

--
-- Dumping data for table `pma_pdf_pages`
--


/*!40000 ALTER TABLE `pma_pdf_pages` DISABLE KEYS */;
LOCK TABLES `pma_pdf_pages` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `pma_pdf_pages` ENABLE KEYS */;

--
-- Table structure for table `pma_relation`
--

DROP TABLE IF EXISTS `pma_relation`;
CREATE TABLE `pma_relation` (
  `master_db` varchar(64) collate utf8_bin NOT NULL default '',
  `master_table` varchar(64) collate utf8_bin NOT NULL default '',
  `master_field` varchar(64) collate utf8_bin NOT NULL default '',
  `foreign_db` varchar(64) collate utf8_bin NOT NULL default '',
  `foreign_table` varchar(64) collate utf8_bin NOT NULL default '',
  `foreign_field` varchar(64) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`master_db`,`master_table`,`master_field`),
  KEY `foreign_field` (`foreign_db`,`foreign_table`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

--
-- Dumping data for table `pma_relation`
--


/*!40000 ALTER TABLE `pma_relation` DISABLE KEYS */;
LOCK TABLES `pma_relation` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `pma_relation` ENABLE KEYS */;

--
-- Table structure for table `pma_table_coords`
--

DROP TABLE IF EXISTS `pma_table_coords`;
CREATE TABLE `pma_table_coords` (
  `db_name` varchar(64) collate utf8_bin NOT NULL default '',
  `table_name` varchar(64) collate utf8_bin NOT NULL default '',
  `pdf_page_number` int(11) NOT NULL default '0',
  `x` float unsigned NOT NULL default '0',
  `y` float unsigned NOT NULL default '0',
  PRIMARY KEY  (`db_name`,`table_name`,`pdf_page_number`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

--
-- Dumping data for table `pma_table_coords`
--


/*!40000 ALTER TABLE `pma_table_coords` DISABLE KEYS */;
LOCK TABLES `pma_table_coords` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `pma_table_coords` ENABLE KEYS */;

--
-- Table structure for table `pma_table_info`
--

DROP TABLE IF EXISTS `pma_table_info`;
CREATE TABLE `pma_table_info` (
  `db_name` varchar(64) collate utf8_bin NOT NULL default '',
  `table_name` varchar(64) collate utf8_bin NOT NULL default '',
  `display_field` varchar(64) collate utf8_bin NOT NULL default '',
  PRIMARY KEY  (`db_name`,`table_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

--
-- Dumping data for table `pma_table_info`
--


/*!40000 ALTER TABLE `pma_table_info` DISABLE KEYS */;
LOCK TABLES `pma_table_info` WRITE;
UNLOCK TABLES;
/*!40000 ALTER TABLE `pma_table_info` ENABLE KEYS */;

--
-- Dumping data for table `user`
--


/*!40000 ALTER TABLE `user` DISABLE KEYS */;
LOCK TABLES `user` WRITE;
INSERT INTO `user` VALUES ('localhost','pma','','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0);
UNLOCK TABLES;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

--
-- Dumping data for table `db`
--


/*!40000 ALTER TABLE `db` DISABLE KEYS */;
LOCK TABLES `db` WRITE;
INSERT INTO `db` VALUES ('localhost','phpmyadmin','pma','Y','Y','Y','Y','N','N','N','N','N','N','N','N');
UNLOCK TABLES;
/*!40000 ALTER TABLE `db` ENABLE KEYS */;


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

