-- MySQL dump 10.17  Distrib 10.3.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: my_wiki
-- ------------------------------------------------------
-- Server version	10.3.13-MariaDB-1:10.3.13+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `my_wikiactor`
--

DROP TABLE IF EXISTS `my_wikiactor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiactor` (
  `actor_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `actor_user` int(10) unsigned DEFAULT NULL,
  `actor_name` varbinary(255) NOT NULL,
  PRIMARY KEY (`actor_id`),
  UNIQUE KEY `actor_name` (`actor_name`),
  UNIQUE KEY `actor_user` (`actor_user`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiactor`
--

LOCK TABLES `my_wikiactor` WRITE;
/*!40000 ALTER TABLE `my_wikiactor` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiactor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiarchive`
--

DROP TABLE IF EXISTS `my_wikiarchive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiarchive` (
  `ar_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ar_namespace` int(11) NOT NULL DEFAULT 0,
  `ar_title` varbinary(255) NOT NULL DEFAULT '',
  `ar_comment` varbinary(767) NOT NULL DEFAULT '',
  `ar_comment_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `ar_user` int(10) unsigned NOT NULL DEFAULT 0,
  `ar_user_text` varbinary(255) NOT NULL DEFAULT '',
  `ar_actor` bigint(20) unsigned NOT NULL DEFAULT 0,
  `ar_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `ar_minor_edit` tinyint(4) NOT NULL DEFAULT 0,
  `ar_rev_id` int(10) unsigned NOT NULL,
  `ar_text_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ar_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ar_len` int(10) unsigned DEFAULT NULL,
  `ar_page_id` int(10) unsigned DEFAULT NULL,
  `ar_parent_id` int(10) unsigned DEFAULT NULL,
  `ar_sha1` varbinary(32) NOT NULL DEFAULT '',
  `ar_content_model` varbinary(32) DEFAULT NULL,
  `ar_content_format` varbinary(64) DEFAULT NULL,
  PRIMARY KEY (`ar_id`),
  KEY `name_title_timestamp` (`ar_namespace`,`ar_title`,`ar_timestamp`),
  KEY `ar_usertext_timestamp` (`ar_user_text`,`ar_timestamp`),
  KEY `ar_actor_timestamp` (`ar_actor`,`ar_timestamp`),
  KEY `ar_revid` (`ar_rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiarchive`
--

LOCK TABLES `my_wikiarchive` WRITE;
/*!40000 ALTER TABLE `my_wikiarchive` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiarchive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikibot_passwords`
--

DROP TABLE IF EXISTS `my_wikibot_passwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikibot_passwords` (
  `bp_user` int(10) unsigned NOT NULL,
  `bp_app_id` varbinary(32) NOT NULL,
  `bp_password` tinyblob NOT NULL,
  `bp_token` binary(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `bp_restrictions` blob NOT NULL,
  `bp_grants` blob NOT NULL,
  PRIMARY KEY (`bp_user`,`bp_app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikibot_passwords`
--

LOCK TABLES `my_wikibot_passwords` WRITE;
/*!40000 ALTER TABLE `my_wikibot_passwords` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikibot_passwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikicategory`
--

DROP TABLE IF EXISTS `my_wikicategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikicategory` (
  `cat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_title` varbinary(255) NOT NULL,
  `cat_pages` int(11) NOT NULL DEFAULT 0,
  `cat_subcats` int(11) NOT NULL DEFAULT 0,
  `cat_files` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_title` (`cat_title`),
  KEY `cat_pages` (`cat_pages`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikicategory`
--

LOCK TABLES `my_wikicategory` WRITE;
/*!40000 ALTER TABLE `my_wikicategory` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikicategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikicategorylinks`
--

DROP TABLE IF EXISTS `my_wikicategorylinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikicategorylinks` (
  `cl_from` int(10) unsigned NOT NULL DEFAULT 0,
  `cl_to` varbinary(255) NOT NULL DEFAULT '',
  `cl_sortkey` varbinary(230) NOT NULL DEFAULT '',
  `cl_sortkey_prefix` varbinary(255) NOT NULL DEFAULT '',
  `cl_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `cl_collation` varbinary(32) NOT NULL DEFAULT '',
  `cl_type` enum('page','subcat','file') NOT NULL DEFAULT 'page',
  PRIMARY KEY (`cl_from`,`cl_to`),
  KEY `cl_sortkey` (`cl_to`,`cl_type`,`cl_sortkey`,`cl_from`),
  KEY `cl_timestamp` (`cl_to`,`cl_timestamp`),
  KEY `cl_collation_ext` (`cl_collation`,`cl_to`,`cl_type`,`cl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikicategorylinks`
--

LOCK TABLES `my_wikicategorylinks` WRITE;
/*!40000 ALTER TABLE `my_wikicategorylinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikicategorylinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikichange_tag`
--

DROP TABLE IF EXISTS `my_wikichange_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikichange_tag` (
  `ct_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ct_rc_id` int(11) DEFAULT NULL,
  `ct_log_id` int(10) unsigned DEFAULT NULL,
  `ct_rev_id` int(10) unsigned DEFAULT NULL,
  `ct_tag` varbinary(255) NOT NULL,
  `ct_params` blob DEFAULT NULL,
  PRIMARY KEY (`ct_id`),
  UNIQUE KEY `change_tag_rc_tag` (`ct_rc_id`,`ct_tag`),
  UNIQUE KEY `change_tag_log_tag` (`ct_log_id`,`ct_tag`),
  UNIQUE KEY `change_tag_rev_tag` (`ct_rev_id`,`ct_tag`),
  KEY `change_tag_tag_id` (`ct_tag`,`ct_rc_id`,`ct_rev_id`,`ct_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikichange_tag`
--

LOCK TABLES `my_wikichange_tag` WRITE;
/*!40000 ALTER TABLE `my_wikichange_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikichange_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikicomment`
--

DROP TABLE IF EXISTS `my_wikicomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikicomment` (
  `comment_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_hash` int(11) NOT NULL,
  `comment_text` blob NOT NULL,
  `comment_data` blob DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `comment_hash` (`comment_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikicomment`
--

LOCK TABLES `my_wikicomment` WRITE;
/*!40000 ALTER TABLE `my_wikicomment` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikicomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikicontent`
--

DROP TABLE IF EXISTS `my_wikicontent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikicontent` (
  `content_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `content_size` int(10) unsigned NOT NULL,
  `content_sha1` varbinary(32) NOT NULL,
  `content_model` smallint(5) unsigned NOT NULL,
  `content_address` varbinary(255) NOT NULL,
  PRIMARY KEY (`content_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikicontent`
--

LOCK TABLES `my_wikicontent` WRITE;
/*!40000 ALTER TABLE `my_wikicontent` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikicontent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikicontent_models`
--

DROP TABLE IF EXISTS `my_wikicontent_models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikicontent_models` (
  `model_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `model_name` varbinary(64) NOT NULL,
  PRIMARY KEY (`model_id`),
  UNIQUE KEY `model_name` (`model_name`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikicontent_models`
--

LOCK TABLES `my_wikicontent_models` WRITE;
/*!40000 ALTER TABLE `my_wikicontent_models` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikicontent_models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiexternallinks`
--

DROP TABLE IF EXISTS `my_wikiexternallinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiexternallinks` (
  `el_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `el_from` int(10) unsigned NOT NULL DEFAULT 0,
  `el_to` blob NOT NULL,
  `el_index` blob NOT NULL,
  `el_index_60` varbinary(60) NOT NULL DEFAULT '',
  PRIMARY KEY (`el_id`),
  KEY `el_from` (`el_from`,`el_to`(40)),
  KEY `el_to` (`el_to`(60),`el_from`),
  KEY `el_index` (`el_index`(60)),
  KEY `el_index_60` (`el_index_60`,`el_id`),
  KEY `el_from_index_60` (`el_from`,`el_index_60`,`el_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiexternallinks`
--

LOCK TABLES `my_wikiexternallinks` WRITE;
/*!40000 ALTER TABLE `my_wikiexternallinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiexternallinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikifilearchive`
--

DROP TABLE IF EXISTS `my_wikifilearchive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikifilearchive` (
  `fa_id` int(11) NOT NULL AUTO_INCREMENT,
  `fa_name` varbinary(255) NOT NULL DEFAULT '',
  `fa_archive_name` varbinary(255) DEFAULT '',
  `fa_storage_group` varbinary(16) DEFAULT NULL,
  `fa_storage_key` varbinary(64) DEFAULT '',
  `fa_deleted_user` int(11) DEFAULT NULL,
  `fa_deleted_timestamp` binary(14) DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `fa_deleted_reason` varbinary(767) DEFAULT '',
  `fa_deleted_reason_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `fa_size` int(10) unsigned DEFAULT 0,
  `fa_width` int(11) DEFAULT 0,
  `fa_height` int(11) DEFAULT 0,
  `fa_metadata` mediumblob DEFAULT NULL,
  `fa_bits` int(11) DEFAULT 0,
  `fa_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE','3D') DEFAULT NULL,
  `fa_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') DEFAULT 'unknown',
  `fa_minor_mime` varbinary(100) DEFAULT 'unknown',
  `fa_description` varbinary(767) DEFAULT '',
  `fa_description_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `fa_user` int(10) unsigned DEFAULT 0,
  `fa_user_text` varbinary(255) DEFAULT '',
  `fa_actor` bigint(20) unsigned NOT NULL DEFAULT 0,
  `fa_timestamp` binary(14) DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `fa_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `fa_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`fa_id`),
  KEY `fa_name` (`fa_name`,`fa_timestamp`),
  KEY `fa_storage_group` (`fa_storage_group`,`fa_storage_key`),
  KEY `fa_deleted_timestamp` (`fa_deleted_timestamp`),
  KEY `fa_user_timestamp` (`fa_user_text`,`fa_timestamp`),
  KEY `fa_actor_timestamp` (`fa_actor`,`fa_timestamp`),
  KEY `fa_sha1` (`fa_sha1`(10))
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikifilearchive`
--

LOCK TABLES `my_wikifilearchive` WRITE;
/*!40000 ALTER TABLE `my_wikifilearchive` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikifilearchive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiimage`
--

DROP TABLE IF EXISTS `my_wikiimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiimage` (
  `img_name` varbinary(255) NOT NULL DEFAULT '',
  `img_size` int(10) unsigned NOT NULL DEFAULT 0,
  `img_width` int(11) NOT NULL DEFAULT 0,
  `img_height` int(11) NOT NULL DEFAULT 0,
  `img_metadata` mediumblob NOT NULL,
  `img_bits` int(11) NOT NULL DEFAULT 0,
  `img_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE','3D') DEFAULT NULL,
  `img_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') NOT NULL DEFAULT 'unknown',
  `img_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `img_description` varbinary(767) NOT NULL DEFAULT '',
  `img_description_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `img_user` int(10) unsigned NOT NULL DEFAULT 0,
  `img_user_text` varbinary(255) NOT NULL DEFAULT '',
  `img_actor` bigint(20) unsigned NOT NULL DEFAULT 0,
  `img_timestamp` varbinary(14) NOT NULL DEFAULT '',
  `img_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`img_name`),
  KEY `img_user_timestamp` (`img_user`,`img_timestamp`),
  KEY `img_usertext_timestamp` (`img_user_text`,`img_timestamp`),
  KEY `img_actor_timestamp` (`img_actor`,`img_timestamp`),
  KEY `img_size` (`img_size`),
  KEY `img_timestamp` (`img_timestamp`),
  KEY `img_sha1` (`img_sha1`(10)),
  KEY `img_media_mime` (`img_media_type`,`img_major_mime`,`img_minor_mime`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiimage`
--

LOCK TABLES `my_wikiimage` WRITE;
/*!40000 ALTER TABLE `my_wikiimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiimage_comment_temp`
--

DROP TABLE IF EXISTS `my_wikiimage_comment_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiimage_comment_temp` (
  `imgcomment_name` varbinary(255) NOT NULL,
  `imgcomment_description_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`imgcomment_name`,`imgcomment_description_id`),
  UNIQUE KEY `imgcomment_name` (`imgcomment_name`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiimage_comment_temp`
--

LOCK TABLES `my_wikiimage_comment_temp` WRITE;
/*!40000 ALTER TABLE `my_wikiimage_comment_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiimage_comment_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiimagelinks`
--

DROP TABLE IF EXISTS `my_wikiimagelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiimagelinks` (
  `il_from` int(10) unsigned NOT NULL DEFAULT 0,
  `il_from_namespace` int(11) NOT NULL DEFAULT 0,
  `il_to` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`il_from`,`il_to`),
  KEY `il_to` (`il_to`,`il_from`),
  KEY `il_backlinks_namespace` (`il_from_namespace`,`il_to`,`il_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiimagelinks`
--

LOCK TABLES `my_wikiimagelinks` WRITE;
/*!40000 ALTER TABLE `my_wikiimagelinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiimagelinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiinterwiki`
--

DROP TABLE IF EXISTS `my_wikiinterwiki`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiinterwiki` (
  `iw_prefix` varbinary(32) NOT NULL,
  `iw_url` blob NOT NULL,
  `iw_api` blob NOT NULL,
  `iw_wikiid` varbinary(64) NOT NULL,
  `iw_local` tinyint(1) NOT NULL,
  `iw_trans` tinyint(4) NOT NULL DEFAULT 0,
  UNIQUE KEY `iw_prefix` (`iw_prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiinterwiki`
--

LOCK TABLES `my_wikiinterwiki` WRITE;
/*!40000 ALTER TABLE `my_wikiinterwiki` DISABLE KEYS */;
INSERT INTO `my_wikiinterwiki` VALUES ('acronym','https://www.acronymfinder.com/~/search/af.aspx?string=exact&Acronym=$1','','',0,0),('advogato','http://www.advogato.org/$1','','',0,0),('arxiv','https://www.arxiv.org/abs/$1','','',0,0),('c2find','http://c2.com/cgi/wiki?FindPage&value=$1','','',0,0),('cache','https://www.google.com/search?q=cache:$1','','',0,0),('commons','https://commons.wikimedia.org/wiki/$1','https://commons.wikimedia.org/w/api.php','',0,0),('dictionary','http://www.dict.org/bin/Dict?Database=*&Form=Dict1&Strategy=*&Query=$1','','',0,0),('doi','https://dx.doi.org/$1','','',0,0),('drumcorpswiki','http://www.drumcorpswiki.com/$1','http://drumcorpswiki.com/api.php','',0,0),('dwjwiki','http://www.suberic.net/cgi-bin/dwj/wiki.cgi?$1','','',0,0),('elibre','http://enciclopedia.us.es/index.php/$1','http://enciclopedia.us.es/api.php','',0,0),('emacswiki','https://www.emacswiki.org/cgi-bin/wiki.pl?$1','','',0,0),('foldoc','https://foldoc.org/?$1','','',0,0),('foxwiki','https://fox.wikis.com/wc.dll?Wiki~$1','','',0,0),('freebsdman','https://www.FreeBSD.org/cgi/man.cgi?apropos=1&query=$1','','',0,0),('gentoo-wiki','http://gentoo-wiki.com/$1','','',0,0),('google','https://www.google.com/search?q=$1','','',0,0),('googlegroups','https://groups.google.com/groups?q=$1','','',0,0),('hammondwiki','http://www.dairiki.org/HammondWiki/$1','','',0,0),('hrwiki','http://www.hrwiki.org/wiki/$1','http://www.hrwiki.org/w/api.php','',0,0),('imdb','http://www.imdb.com/find?q=$1&tt=on','','',0,0),('kmwiki','https://kmwiki.wikispaces.com/$1','','',0,0),('linuxwiki','http://linuxwiki.de/$1','','',0,0),('lojban','https://mw.lojban.org/papri/$1','','',0,0),('lqwiki','http://wiki.linuxquestions.org/wiki/$1','','',0,0),('meatball','http://www.usemod.com/cgi-bin/mb.pl?$1','','',0,0),('mediawikiwiki','https://www.mediawiki.org/wiki/$1','https://www.mediawiki.org/w/api.php','',0,0),('memoryalpha','http://en.memory-alpha.org/wiki/$1','http://en.memory-alpha.org/api.php','',0,0),('metawiki','http://sunir.org/apps/meta.pl?$1','','',0,0),('metawikimedia','https://meta.wikimedia.org/wiki/$1','https://meta.wikimedia.org/w/api.php','',0,0),('mozillawiki','https://wiki.mozilla.org/$1','https://wiki.mozilla.org/api.php','',0,0),('mw','https://www.mediawiki.org/wiki/$1','https://www.mediawiki.org/w/api.php','',0,0),('oeis','https://oeis.org/$1','','',0,0),('openwiki','http://openwiki.com/ow.asp?$1','','',0,0),('pmid','https://www.ncbi.nlm.nih.gov/pubmed/$1?dopt=Abstract','','',0,0),('pythoninfo','https://wiki.python.org/moin/$1','','',0,0),('rfc','https://tools.ietf.org/html/rfc$1','','',0,0),('s23wiki','http://s23.org/wiki/$1','http://s23.org/w/api.php','',0,0),('seattlewireless','http://seattlewireless.net/$1','','',0,0),('senseislibrary','https://senseis.xmp.net/?$1','','',0,0),('shoutwiki','http://www.shoutwiki.com/wiki/$1','http://www.shoutwiki.com/w/api.php','',0,0),('squeak','http://wiki.squeak.org/squeak/$1','','',0,0),('theopedia','https://www.theopedia.com/$1','','',0,0),('tmbw','http://www.tmbw.net/wiki/$1','http://tmbw.net/wiki/api.php','',0,0),('tmnet','http://www.technomanifestos.net/?$1','','',0,0),('twiki','http://twiki.org/cgi-bin/view/$1','','',0,0),('uncyclopedia','https://en.uncyclopedia.co/wiki/$1','https://en.uncyclopedia.co/w/api.php','',0,0),('unreal','https://wiki.beyondunreal.com/$1','https://wiki.beyondunreal.com/w/api.php','',0,0),('usemod','http://www.usemod.com/cgi-bin/wiki.pl?$1','','',0,0),('wiki','http://c2.com/cgi/wiki?$1','','',0,0),('wikia','http://www.wikia.com/wiki/$1','','',0,0),('wikibooks','https://en.wikibooks.org/wiki/$1','https://en.wikibooks.org/w/api.php','',0,0),('wikidata','https://www.wikidata.org/wiki/$1','https://www.wikidata.org/w/api.php','',0,0),('wikif1','http://www.wikif1.org/$1','','',0,0),('wikihow','https://www.wikihow.com/$1','https://www.wikihow.com/api.php','',0,0),('wikimedia','https://wikimediafoundation.org/wiki/$1','https://wikimediafoundation.org/w/api.php','',0,0),('wikinews','https://en.wikinews.org/wiki/$1','https://en.wikinews.org/w/api.php','',0,0),('wikinfo','http://wikinfo.co/English/index.php/$1','','',0,0),('wikipedia','https://en.wikipedia.org/wiki/$1','https://en.wikipedia.org/w/api.php','',0,0),('wikiquote','https://en.wikiquote.org/wiki/$1','https://en.wikiquote.org/w/api.php','',0,0),('wikisource','https://wikisource.org/wiki/$1','https://wikisource.org/w/api.php','',0,0),('wikispecies','https://species.wikimedia.org/wiki/$1','https://species.wikimedia.org/w/api.php','',0,0),('wikiversity','https://en.wikiversity.org/wiki/$1','https://en.wikiversity.org/w/api.php','',0,0),('wikivoyage','https://en.wikivoyage.org/wiki/$1','https://en.wikivoyage.org/w/api.php','',0,0),('wikt','https://en.wiktionary.org/wiki/$1','https://en.wiktionary.org/w/api.php','',0,0),('wiktionary','https://en.wiktionary.org/wiki/$1','https://en.wiktionary.org/w/api.php','',0,0);
/*!40000 ALTER TABLE `my_wikiinterwiki` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiip_changes`
--

DROP TABLE IF EXISTS `my_wikiip_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiip_changes` (
  `ipc_rev_id` int(10) unsigned NOT NULL DEFAULT 0,
  `ipc_rev_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `ipc_hex` varbinary(35) NOT NULL DEFAULT '',
  PRIMARY KEY (`ipc_rev_id`),
  KEY `ipc_rev_timestamp` (`ipc_rev_timestamp`),
  KEY `ipc_hex_time` (`ipc_hex`,`ipc_rev_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiip_changes`
--

LOCK TABLES `my_wikiip_changes` WRITE;
/*!40000 ALTER TABLE `my_wikiip_changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiip_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiipblocks`
--

DROP TABLE IF EXISTS `my_wikiipblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiipblocks` (
  `ipb_id` int(11) NOT NULL AUTO_INCREMENT,
  `ipb_address` tinyblob NOT NULL,
  `ipb_user` int(10) unsigned NOT NULL DEFAULT 0,
  `ipb_by` int(10) unsigned NOT NULL DEFAULT 0,
  `ipb_by_text` varbinary(255) NOT NULL DEFAULT '',
  `ipb_by_actor` bigint(20) unsigned NOT NULL DEFAULT 0,
  `ipb_reason` varbinary(767) NOT NULL DEFAULT '',
  `ipb_reason_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `ipb_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `ipb_auto` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_anon_only` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_create_account` tinyint(1) NOT NULL DEFAULT 1,
  `ipb_enable_autoblock` tinyint(1) NOT NULL DEFAULT 1,
  `ipb_expiry` varbinary(14) NOT NULL DEFAULT '',
  `ipb_range_start` tinyblob NOT NULL,
  `ipb_range_end` tinyblob NOT NULL,
  `ipb_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_block_email` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_allow_usertalk` tinyint(1) NOT NULL DEFAULT 0,
  `ipb_parent_block_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ipb_id`),
  UNIQUE KEY `ipb_address` (`ipb_address`(255),`ipb_user`,`ipb_auto`,`ipb_anon_only`),
  KEY `ipb_user` (`ipb_user`),
  KEY `ipb_range` (`ipb_range_start`(8),`ipb_range_end`(8)),
  KEY `ipb_timestamp` (`ipb_timestamp`),
  KEY `ipb_expiry` (`ipb_expiry`),
  KEY `ipb_parent_block_id` (`ipb_parent_block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiipblocks`
--

LOCK TABLES `my_wikiipblocks` WRITE;
/*!40000 ALTER TABLE `my_wikiipblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiipblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiiwlinks`
--

DROP TABLE IF EXISTS `my_wikiiwlinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiiwlinks` (
  `iwl_from` int(10) unsigned NOT NULL DEFAULT 0,
  `iwl_prefix` varbinary(20) NOT NULL DEFAULT '',
  `iwl_title` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`iwl_from`,`iwl_prefix`,`iwl_title`),
  KEY `iwl_prefix_title_from` (`iwl_prefix`,`iwl_title`,`iwl_from`),
  KEY `iwl_prefix_from_title` (`iwl_prefix`,`iwl_from`,`iwl_title`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiiwlinks`
--

LOCK TABLES `my_wikiiwlinks` WRITE;
/*!40000 ALTER TABLE `my_wikiiwlinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiiwlinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikijob`
--

DROP TABLE IF EXISTS `my_wikijob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikijob` (
  `job_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `job_cmd` varbinary(60) NOT NULL DEFAULT '',
  `job_namespace` int(11) NOT NULL,
  `job_title` varbinary(255) NOT NULL,
  `job_timestamp` varbinary(14) DEFAULT NULL,
  `job_params` blob NOT NULL,
  `job_random` int(10) unsigned NOT NULL DEFAULT 0,
  `job_attempts` int(10) unsigned NOT NULL DEFAULT 0,
  `job_token` varbinary(32) NOT NULL DEFAULT '',
  `job_token_timestamp` varbinary(14) DEFAULT NULL,
  `job_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`job_id`),
  KEY `job_sha1` (`job_sha1`),
  KEY `job_cmd_token` (`job_cmd`,`job_token`,`job_random`),
  KEY `job_cmd_token_id` (`job_cmd`,`job_token`,`job_id`),
  KEY `job_cmd` (`job_cmd`,`job_namespace`,`job_title`,`job_params`(128)),
  KEY `job_timestamp` (`job_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikijob`
--

LOCK TABLES `my_wikijob` WRITE;
/*!40000 ALTER TABLE `my_wikijob` DISABLE KEYS */;
INSERT INTO `my_wikijob` VALUES (1,'userGroupExpiry',0,'Pagina_principale','20190227164540','a:1:{s:9:\"requestId\";s:24:\"b8d5702b4184f6793606b416\";}',1200313848,0,'',NULL,'sd18g7vbwaqbb65htvac2ml86j85fub');
/*!40000 ALTER TABLE `my_wikijob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikil10n_cache`
--

DROP TABLE IF EXISTS `my_wikil10n_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikil10n_cache` (
  `lc_lang` varbinary(32) NOT NULL,
  `lc_key` varbinary(255) NOT NULL,
  `lc_value` mediumblob NOT NULL,
  PRIMARY KEY (`lc_lang`,`lc_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikil10n_cache`
--

LOCK TABLES `my_wikil10n_cache` WRITE;
/*!40000 ALTER TABLE `my_wikil10n_cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikil10n_cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikilanglinks`
--

DROP TABLE IF EXISTS `my_wikilanglinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikilanglinks` (
  `ll_from` int(10) unsigned NOT NULL DEFAULT 0,
  `ll_lang` varbinary(20) NOT NULL DEFAULT '',
  `ll_title` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ll_from`,`ll_lang`),
  KEY `ll_lang` (`ll_lang`,`ll_title`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikilanglinks`
--

LOCK TABLES `my_wikilanglinks` WRITE;
/*!40000 ALTER TABLE `my_wikilanglinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikilanglinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikilog_search`
--

DROP TABLE IF EXISTS `my_wikilog_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikilog_search` (
  `ls_field` varbinary(32) NOT NULL,
  `ls_value` varbinary(255) NOT NULL,
  `ls_log_id` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`ls_field`,`ls_value`,`ls_log_id`),
  KEY `ls_log_id` (`ls_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikilog_search`
--

LOCK TABLES `my_wikilog_search` WRITE;
/*!40000 ALTER TABLE `my_wikilog_search` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikilog_search` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikilogging`
--

DROP TABLE IF EXISTS `my_wikilogging`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikilogging` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_type` varbinary(32) NOT NULL DEFAULT '',
  `log_action` varbinary(32) NOT NULL DEFAULT '',
  `log_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  `log_user` int(10) unsigned NOT NULL DEFAULT 0,
  `log_user_text` varbinary(255) NOT NULL DEFAULT '',
  `log_actor` bigint(20) unsigned NOT NULL DEFAULT 0,
  `log_namespace` int(11) NOT NULL DEFAULT 0,
  `log_title` varbinary(255) NOT NULL DEFAULT '',
  `log_page` int(10) unsigned DEFAULT NULL,
  `log_comment` varbinary(767) NOT NULL DEFAULT '',
  `log_comment_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `log_params` blob NOT NULL,
  `log_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`log_id`),
  KEY `type_time` (`log_type`,`log_timestamp`),
  KEY `user_time` (`log_user`,`log_timestamp`),
  KEY `actor_time` (`log_actor`,`log_timestamp`),
  KEY `page_time` (`log_namespace`,`log_title`,`log_timestamp`),
  KEY `times` (`log_timestamp`),
  KEY `log_user_type_time` (`log_user`,`log_type`,`log_timestamp`),
  KEY `log_actor_type_time` (`log_actor`,`log_type`,`log_timestamp`),
  KEY `log_page_id_time` (`log_page`,`log_timestamp`),
  KEY `type_action` (`log_type`,`log_action`,`log_timestamp`),
  KEY `log_user_text_type_time` (`log_user_text`,`log_type`,`log_timestamp`),
  KEY `log_user_text_time` (`log_user_text`,`log_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikilogging`
--

LOCK TABLES `my_wikilogging` WRITE;
/*!40000 ALTER TABLE `my_wikilogging` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikilogging` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikimodule_deps`
--

DROP TABLE IF EXISTS `my_wikimodule_deps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikimodule_deps` (
  `md_module` varbinary(255) NOT NULL,
  `md_skin` varbinary(32) NOT NULL,
  `md_deps` mediumblob NOT NULL,
  PRIMARY KEY (`md_module`,`md_skin`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikimodule_deps`
--

LOCK TABLES `my_wikimodule_deps` WRITE;
/*!40000 ALTER TABLE `my_wikimodule_deps` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikimodule_deps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiobjectcache`
--

DROP TABLE IF EXISTS `my_wikiobjectcache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiobjectcache` (
  `keyname` varbinary(255) NOT NULL DEFAULT '',
  `value` mediumblob DEFAULT NULL,
  `exptime` datetime DEFAULT NULL,
  PRIMARY KEY (`keyname`),
  KEY `exptime` (`exptime`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiobjectcache`
--

LOCK TABLES `my_wikiobjectcache` WRITE;
/*!40000 ALTER TABLE `my_wikiobjectcache` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiobjectcache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikioldimage`
--

DROP TABLE IF EXISTS `my_wikioldimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikioldimage` (
  `oi_name` varbinary(255) NOT NULL DEFAULT '',
  `oi_archive_name` varbinary(255) NOT NULL DEFAULT '',
  `oi_size` int(10) unsigned NOT NULL DEFAULT 0,
  `oi_width` int(11) NOT NULL DEFAULT 0,
  `oi_height` int(11) NOT NULL DEFAULT 0,
  `oi_bits` int(11) NOT NULL DEFAULT 0,
  `oi_description` varbinary(767) NOT NULL DEFAULT '',
  `oi_description_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `oi_user` int(10) unsigned NOT NULL DEFAULT 0,
  `oi_user_text` varbinary(255) NOT NULL DEFAULT '',
  `oi_actor` bigint(20) unsigned NOT NULL DEFAULT 0,
  `oi_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `oi_metadata` mediumblob NOT NULL,
  `oi_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE','3D') DEFAULT NULL,
  `oi_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart','chemical') NOT NULL DEFAULT 'unknown',
  `oi_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `oi_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `oi_sha1` varbinary(32) NOT NULL DEFAULT '',
  KEY `oi_usertext_timestamp` (`oi_user_text`,`oi_timestamp`),
  KEY `oi_actor_timestamp` (`oi_actor`,`oi_timestamp`),
  KEY `oi_name_timestamp` (`oi_name`,`oi_timestamp`),
  KEY `oi_name_archive_name` (`oi_name`,`oi_archive_name`(14)),
  KEY `oi_sha1` (`oi_sha1`(10))
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikioldimage`
--

LOCK TABLES `my_wikioldimage` WRITE;
/*!40000 ALTER TABLE `my_wikioldimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikioldimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikipage`
--

DROP TABLE IF EXISTS `my_wikipage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikipage` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_namespace` int(11) NOT NULL,
  `page_title` varbinary(255) NOT NULL,
  `page_restrictions` tinyblob NOT NULL,
  `page_is_redirect` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `page_is_new` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `page_random` double unsigned NOT NULL,
  `page_touched` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `page_links_updated` varbinary(14) DEFAULT NULL,
  `page_latest` int(10) unsigned NOT NULL,
  `page_len` int(10) unsigned NOT NULL,
  `page_content_model` varbinary(32) DEFAULT NULL,
  `page_lang` varbinary(35) DEFAULT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `name_title` (`page_namespace`,`page_title`),
  KEY `page_random` (`page_random`),
  KEY `page_len` (`page_len`),
  KEY `page_redirect_namespace_len` (`page_is_redirect`,`page_namespace`,`page_len`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikipage`
--

LOCK TABLES `my_wikipage` WRITE;
/*!40000 ALTER TABLE `my_wikipage` DISABLE KEYS */;
INSERT INTO `my_wikipage` VALUES (1,0,'Pagina_principale','',0,1,0.534699648578,'20190227164540',NULL,1,770,'wikitext',NULL);
/*!40000 ALTER TABLE `my_wikipage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikipage_props`
--

DROP TABLE IF EXISTS `my_wikipage_props`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikipage_props` (
  `pp_page` int(11) NOT NULL,
  `pp_propname` varbinary(60) NOT NULL,
  `pp_value` blob NOT NULL,
  `pp_sortkey` float DEFAULT NULL,
  UNIQUE KEY `pp_page_propname` (`pp_page`,`pp_propname`),
  UNIQUE KEY `pp_propname_page` (`pp_propname`,`pp_page`),
  UNIQUE KEY `pp_propname_sortkey_page` (`pp_propname`,`pp_sortkey`,`pp_page`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikipage_props`
--

LOCK TABLES `my_wikipage_props` WRITE;
/*!40000 ALTER TABLE `my_wikipage_props` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikipage_props` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikipage_restrictions`
--

DROP TABLE IF EXISTS `my_wikipage_restrictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikipage_restrictions` (
  `pr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pr_page` int(11) NOT NULL,
  `pr_type` varbinary(60) NOT NULL,
  `pr_level` varbinary(60) NOT NULL,
  `pr_cascade` tinyint(4) NOT NULL,
  `pr_user` int(10) unsigned DEFAULT NULL,
  `pr_expiry` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`pr_id`),
  UNIQUE KEY `pr_pagetype` (`pr_page`,`pr_type`),
  KEY `pr_typelevel` (`pr_type`,`pr_level`),
  KEY `pr_level` (`pr_level`),
  KEY `pr_cascade` (`pr_cascade`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikipage_restrictions`
--

LOCK TABLES `my_wikipage_restrictions` WRITE;
/*!40000 ALTER TABLE `my_wikipage_restrictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikipage_restrictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikipagelinks`
--

DROP TABLE IF EXISTS `my_wikipagelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikipagelinks` (
  `pl_from` int(10) unsigned NOT NULL DEFAULT 0,
  `pl_from_namespace` int(11) NOT NULL DEFAULT 0,
  `pl_namespace` int(11) NOT NULL DEFAULT 0,
  `pl_title` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`pl_from`,`pl_namespace`,`pl_title`),
  KEY `pl_namespace` (`pl_namespace`,`pl_title`,`pl_from`),
  KEY `pl_backlinks_namespace` (`pl_from_namespace`,`pl_namespace`,`pl_title`,`pl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikipagelinks`
--

LOCK TABLES `my_wikipagelinks` WRITE;
/*!40000 ALTER TABLE `my_wikipagelinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikipagelinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiprotected_titles`
--

DROP TABLE IF EXISTS `my_wikiprotected_titles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiprotected_titles` (
  `pt_namespace` int(11) NOT NULL,
  `pt_title` varbinary(255) NOT NULL,
  `pt_user` int(10) unsigned NOT NULL,
  `pt_reason` varbinary(767) DEFAULT '',
  `pt_reason_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `pt_timestamp` binary(14) NOT NULL,
  `pt_expiry` varbinary(14) NOT NULL DEFAULT '',
  `pt_create_perm` varbinary(60) NOT NULL,
  UNIQUE KEY `pt_namespace_title` (`pt_namespace`,`pt_title`),
  KEY `pt_timestamp` (`pt_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiprotected_titles`
--

LOCK TABLES `my_wikiprotected_titles` WRITE;
/*!40000 ALTER TABLE `my_wikiprotected_titles` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiprotected_titles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiquerycache`
--

DROP TABLE IF EXISTS `my_wikiquerycache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiquerycache` (
  `qc_type` varbinary(32) NOT NULL,
  `qc_value` int(10) unsigned NOT NULL DEFAULT 0,
  `qc_namespace` int(11) NOT NULL DEFAULT 0,
  `qc_title` varbinary(255) NOT NULL DEFAULT '',
  KEY `qc_type` (`qc_type`,`qc_value`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiquerycache`
--

LOCK TABLES `my_wikiquerycache` WRITE;
/*!40000 ALTER TABLE `my_wikiquerycache` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiquerycache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiquerycache_info`
--

DROP TABLE IF EXISTS `my_wikiquerycache_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiquerycache_info` (
  `qci_type` varbinary(32) NOT NULL DEFAULT '',
  `qci_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  PRIMARY KEY (`qci_type`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiquerycache_info`
--

LOCK TABLES `my_wikiquerycache_info` WRITE;
/*!40000 ALTER TABLE `my_wikiquerycache_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiquerycache_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiquerycachetwo`
--

DROP TABLE IF EXISTS `my_wikiquerycachetwo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiquerycachetwo` (
  `qcc_type` varbinary(32) NOT NULL,
  `qcc_value` int(10) unsigned NOT NULL DEFAULT 0,
  `qcc_namespace` int(11) NOT NULL DEFAULT 0,
  `qcc_title` varbinary(255) NOT NULL DEFAULT '',
  `qcc_namespacetwo` int(11) NOT NULL DEFAULT 0,
  `qcc_titletwo` varbinary(255) NOT NULL DEFAULT '',
  KEY `qcc_type` (`qcc_type`,`qcc_value`),
  KEY `qcc_title` (`qcc_type`,`qcc_namespace`,`qcc_title`),
  KEY `qcc_titletwo` (`qcc_type`,`qcc_namespacetwo`,`qcc_titletwo`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiquerycachetwo`
--

LOCK TABLES `my_wikiquerycachetwo` WRITE;
/*!40000 ALTER TABLE `my_wikiquerycachetwo` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiquerycachetwo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikirecentchanges`
--

DROP TABLE IF EXISTS `my_wikirecentchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikirecentchanges` (
  `rc_id` int(11) NOT NULL AUTO_INCREMENT,
  `rc_timestamp` varbinary(14) NOT NULL DEFAULT '',
  `rc_user` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_user_text` varbinary(255) NOT NULL DEFAULT '',
  `rc_actor` bigint(20) unsigned NOT NULL DEFAULT 0,
  `rc_namespace` int(11) NOT NULL DEFAULT 0,
  `rc_title` varbinary(255) NOT NULL DEFAULT '',
  `rc_comment` varbinary(767) NOT NULL DEFAULT '',
  `rc_comment_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `rc_minor` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_bot` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_new` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_cur_id` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_this_oldid` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_last_oldid` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_type` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_source` varbinary(16) NOT NULL DEFAULT '',
  `rc_patrolled` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_ip` varbinary(40) NOT NULL DEFAULT '',
  `rc_old_len` int(11) DEFAULT NULL,
  `rc_new_len` int(11) DEFAULT NULL,
  `rc_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rc_logid` int(10) unsigned NOT NULL DEFAULT 0,
  `rc_log_type` varbinary(255) DEFAULT NULL,
  `rc_log_action` varbinary(255) DEFAULT NULL,
  `rc_params` blob DEFAULT NULL,
  PRIMARY KEY (`rc_id`),
  KEY `rc_timestamp` (`rc_timestamp`),
  KEY `rc_namespace_title_timestamp` (`rc_namespace`,`rc_title`,`rc_timestamp`),
  KEY `rc_cur_id` (`rc_cur_id`),
  KEY `new_name_timestamp` (`rc_new`,`rc_namespace`,`rc_timestamp`),
  KEY `rc_ip` (`rc_ip`),
  KEY `rc_ns_usertext` (`rc_namespace`,`rc_user_text`),
  KEY `rc_ns_actor` (`rc_namespace`,`rc_actor`),
  KEY `rc_user_text` (`rc_user_text`,`rc_timestamp`),
  KEY `rc_actor` (`rc_actor`,`rc_timestamp`),
  KEY `rc_name_type_patrolled_timestamp` (`rc_namespace`,`rc_type`,`rc_patrolled`,`rc_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikirecentchanges`
--

LOCK TABLES `my_wikirecentchanges` WRITE;
/*!40000 ALTER TABLE `my_wikirecentchanges` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikirecentchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiredirect`
--

DROP TABLE IF EXISTS `my_wikiredirect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiredirect` (
  `rd_from` int(10) unsigned NOT NULL DEFAULT 0,
  `rd_namespace` int(11) NOT NULL DEFAULT 0,
  `rd_title` varbinary(255) NOT NULL DEFAULT '',
  `rd_interwiki` varbinary(32) DEFAULT NULL,
  `rd_fragment` varbinary(255) DEFAULT NULL,
  PRIMARY KEY (`rd_from`),
  KEY `rd_ns_title` (`rd_namespace`,`rd_title`,`rd_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiredirect`
--

LOCK TABLES `my_wikiredirect` WRITE;
/*!40000 ALTER TABLE `my_wikiredirect` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiredirect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikirevision`
--

DROP TABLE IF EXISTS `my_wikirevision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikirevision` (
  `rev_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rev_page` int(10) unsigned NOT NULL,
  `rev_text_id` int(10) unsigned NOT NULL DEFAULT 0,
  `rev_comment` varbinary(767) NOT NULL DEFAULT '',
  `rev_user` int(10) unsigned NOT NULL DEFAULT 0,
  `rev_user_text` varbinary(255) NOT NULL DEFAULT '',
  `rev_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `rev_minor_edit` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rev_deleted` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `rev_len` int(10) unsigned DEFAULT NULL,
  `rev_parent_id` int(10) unsigned DEFAULT NULL,
  `rev_sha1` varbinary(32) NOT NULL DEFAULT '',
  `rev_content_model` varbinary(32) DEFAULT NULL,
  `rev_content_format` varbinary(64) DEFAULT NULL,
  PRIMARY KEY (`rev_id`),
  KEY `rev_page_id` (`rev_page`,`rev_id`),
  KEY `rev_timestamp` (`rev_timestamp`),
  KEY `page_timestamp` (`rev_page`,`rev_timestamp`),
  KEY `user_timestamp` (`rev_user`,`rev_timestamp`),
  KEY `usertext_timestamp` (`rev_user_text`,`rev_timestamp`),
  KEY `page_user_timestamp` (`rev_page`,`rev_user`,`rev_timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=binary MAX_ROWS=10000000 AVG_ROW_LENGTH=1024;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikirevision`
--

LOCK TABLES `my_wikirevision` WRITE;
/*!40000 ALTER TABLE `my_wikirevision` DISABLE KEYS */;
INSERT INTO `my_wikirevision` VALUES (1,1,1,'',0,'MediaWiki default','20190227164540',0,0,770,0,'la56yoklk77tfa3gwoisb2qquj9jbu1',NULL,NULL);
/*!40000 ALTER TABLE `my_wikirevision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikirevision_actor_temp`
--

DROP TABLE IF EXISTS `my_wikirevision_actor_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikirevision_actor_temp` (
  `revactor_rev` int(10) unsigned NOT NULL,
  `revactor_actor` bigint(20) unsigned NOT NULL,
  `revactor_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `revactor_page` int(10) unsigned NOT NULL,
  PRIMARY KEY (`revactor_rev`,`revactor_actor`),
  UNIQUE KEY `revactor_rev` (`revactor_rev`),
  KEY `actor_timestamp` (`revactor_actor`,`revactor_timestamp`),
  KEY `page_actor_timestamp` (`revactor_page`,`revactor_actor`,`revactor_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikirevision_actor_temp`
--

LOCK TABLES `my_wikirevision_actor_temp` WRITE;
/*!40000 ALTER TABLE `my_wikirevision_actor_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikirevision_actor_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikirevision_comment_temp`
--

DROP TABLE IF EXISTS `my_wikirevision_comment_temp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikirevision_comment_temp` (
  `revcomment_rev` int(10) unsigned NOT NULL,
  `revcomment_comment_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`revcomment_rev`,`revcomment_comment_id`),
  UNIQUE KEY `revcomment_rev` (`revcomment_rev`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikirevision_comment_temp`
--

LOCK TABLES `my_wikirevision_comment_temp` WRITE;
/*!40000 ALTER TABLE `my_wikirevision_comment_temp` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikirevision_comment_temp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikisearchindex`
--

DROP TABLE IF EXISTS `my_wikisearchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikisearchindex` (
  `si_page` int(10) unsigned NOT NULL,
  `si_title` varchar(255) NOT NULL DEFAULT '',
  `si_text` mediumtext NOT NULL,
  UNIQUE KEY `si_page` (`si_page`),
  FULLTEXT KEY `si_title` (`si_title`),
  FULLTEXT KEY `si_text` (`si_text`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikisearchindex`
--

LOCK TABLES `my_wikisearchindex` WRITE;
/*!40000 ALTER TABLE `my_wikisearchindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikisearchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikisite_identifiers`
--

DROP TABLE IF EXISTS `my_wikisite_identifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikisite_identifiers` (
  `si_site` int(10) unsigned NOT NULL,
  `si_type` varbinary(32) NOT NULL,
  `si_key` varbinary(32) NOT NULL,
  UNIQUE KEY `site_ids_type` (`si_type`,`si_key`),
  KEY `site_ids_site` (`si_site`),
  KEY `site_ids_key` (`si_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikisite_identifiers`
--

LOCK TABLES `my_wikisite_identifiers` WRITE;
/*!40000 ALTER TABLE `my_wikisite_identifiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikisite_identifiers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikisite_stats`
--

DROP TABLE IF EXISTS `my_wikisite_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikisite_stats` (
  `ss_row_id` int(10) unsigned NOT NULL,
  `ss_total_edits` bigint(20) unsigned DEFAULT NULL,
  `ss_good_articles` bigint(20) unsigned DEFAULT NULL,
  `ss_total_pages` bigint(20) unsigned DEFAULT NULL,
  `ss_users` bigint(20) unsigned DEFAULT NULL,
  `ss_active_users` bigint(20) unsigned DEFAULT NULL,
  `ss_images` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`ss_row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikisite_stats`
--

LOCK TABLES `my_wikisite_stats` WRITE;
/*!40000 ALTER TABLE `my_wikisite_stats` DISABLE KEYS */;
INSERT INTO `my_wikisite_stats` VALUES (1,0,0,0,0,0,0);
/*!40000 ALTER TABLE `my_wikisite_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikisites`
--

DROP TABLE IF EXISTS `my_wikisites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikisites` (
  `site_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_global_key` varbinary(32) NOT NULL,
  `site_type` varbinary(32) NOT NULL,
  `site_group` varbinary(32) NOT NULL,
  `site_source` varbinary(32) NOT NULL,
  `site_language` varbinary(32) NOT NULL,
  `site_protocol` varbinary(32) NOT NULL,
  `site_domain` varbinary(255) NOT NULL,
  `site_data` blob NOT NULL,
  `site_forward` tinyint(1) NOT NULL,
  `site_config` blob NOT NULL,
  PRIMARY KEY (`site_id`),
  UNIQUE KEY `sites_global_key` (`site_global_key`),
  KEY `sites_type` (`site_type`),
  KEY `sites_group` (`site_group`),
  KEY `sites_source` (`site_source`),
  KEY `sites_language` (`site_language`),
  KEY `sites_protocol` (`site_protocol`),
  KEY `sites_domain` (`site_domain`),
  KEY `sites_forward` (`site_forward`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikisites`
--

LOCK TABLES `my_wikisites` WRITE;
/*!40000 ALTER TABLE `my_wikisites` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikisites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikislot_roles`
--

DROP TABLE IF EXISTS `my_wikislot_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikislot_roles` (
  `role_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `role_name` varbinary(64) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikislot_roles`
--

LOCK TABLES `my_wikislot_roles` WRITE;
/*!40000 ALTER TABLE `my_wikislot_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikislot_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikislots`
--

DROP TABLE IF EXISTS `my_wikislots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikislots` (
  `slot_revision_id` bigint(20) unsigned NOT NULL,
  `slot_role_id` smallint(5) unsigned NOT NULL,
  `slot_content_id` bigint(20) unsigned NOT NULL,
  `slot_origin` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`slot_revision_id`,`slot_role_id`),
  KEY `slot_revision_origin_role` (`slot_revision_id`,`slot_origin`,`slot_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikislots`
--

LOCK TABLES `my_wikislots` WRITE;
/*!40000 ALTER TABLE `my_wikislots` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikislots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikitag_summary`
--

DROP TABLE IF EXISTS `my_wikitag_summary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikitag_summary` (
  `ts_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ts_rc_id` int(11) DEFAULT NULL,
  `ts_log_id` int(10) unsigned DEFAULT NULL,
  `ts_rev_id` int(10) unsigned DEFAULT NULL,
  `ts_tags` blob NOT NULL,
  PRIMARY KEY (`ts_id`),
  UNIQUE KEY `tag_summary_rc_id` (`ts_rc_id`),
  UNIQUE KEY `tag_summary_log_id` (`ts_log_id`),
  UNIQUE KEY `tag_summary_rev_id` (`ts_rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikitag_summary`
--

LOCK TABLES `my_wikitag_summary` WRITE;
/*!40000 ALTER TABLE `my_wikitag_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikitag_summary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikitemplatelinks`
--

DROP TABLE IF EXISTS `my_wikitemplatelinks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikitemplatelinks` (
  `tl_from` int(10) unsigned NOT NULL DEFAULT 0,
  `tl_from_namespace` int(11) NOT NULL DEFAULT 0,
  `tl_namespace` int(11) NOT NULL DEFAULT 0,
  `tl_title` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`tl_from`,`tl_namespace`,`tl_title`),
  KEY `tl_namespace` (`tl_namespace`,`tl_title`,`tl_from`),
  KEY `tl_backlinks_namespace` (`tl_from_namespace`,`tl_namespace`,`tl_title`,`tl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikitemplatelinks`
--

LOCK TABLES `my_wikitemplatelinks` WRITE;
/*!40000 ALTER TABLE `my_wikitemplatelinks` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikitemplatelinks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikitext`
--

DROP TABLE IF EXISTS `my_wikitext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikitext` (
  `old_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_text` mediumblob NOT NULL,
  `old_flags` tinyblob NOT NULL,
  PRIMARY KEY (`old_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=binary MAX_ROWS=10000000 AVG_ROW_LENGTH=10240;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikitext`
--

LOCK TABLES `my_wikitext` WRITE;
/*!40000 ALTER TABLE `my_wikitext` DISABLE KEYS */;
INSERT INTO `my_wikitext` VALUES (1,'<strong>MediaWiki è stato installato.</strong>\n\nConsulta la [https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Contents guida utente] per maggiori informazioni sull\'uso di questo software wiki.\n\n== Per iniziare ==\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Configuration_settings Impostazioni di configurazione]\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:FAQ Domande frequenti su MediaWiki]\n* [https://lists.wikimedia.org/mailman/listinfo/mediawiki-announce Mailing list annunci MediaWiki]\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Localisation#Translation_resources Trova MediaWiki nella tua lingua]\n* [https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Combating_spam Imparare a combattere lo spam sul tuo wiki]','utf-8');
/*!40000 ALTER TABLE `my_wikitext` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikitranscache`
--

DROP TABLE IF EXISTS `my_wikitranscache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikitranscache` (
  `tc_url` varbinary(255) NOT NULL,
  `tc_contents` blob DEFAULT NULL,
  `tc_time` binary(14) NOT NULL,
  PRIMARY KEY (`tc_url`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikitranscache`
--

LOCK TABLES `my_wikitranscache` WRITE;
/*!40000 ALTER TABLE `my_wikitranscache` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikitranscache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiupdatelog`
--

DROP TABLE IF EXISTS `my_wikiupdatelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiupdatelog` (
  `ul_key` varbinary(255) NOT NULL,
  `ul_value` blob DEFAULT NULL,
  PRIMARY KEY (`ul_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiupdatelog`
--

LOCK TABLES `my_wikiupdatelog` WRITE;
/*!40000 ALTER TABLE `my_wikiupdatelog` DISABLE KEYS */;
INSERT INTO `my_wikiupdatelog` VALUES ('filearchive-fa_major_mime-patch-fa_major_mime-chemical.sql',NULL),('image-img_major_mime-patch-img_major_mime-chemical.sql',NULL),('oldimage-oi_major_mime-patch-oi_major_mime-chemical.sql',NULL),('user_former_groups-ufg_group-patch-ufg_group-length-increase-255.sql',NULL),('user_groups-ug_group-patch-ug_group-length-increase-255.sql',NULL),('user_properties-up_property-patch-up_property.sql',NULL);
/*!40000 ALTER TABLE `my_wikiupdatelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiuploadstash`
--

DROP TABLE IF EXISTS `my_wikiuploadstash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiuploadstash` (
  `us_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `us_user` int(10) unsigned NOT NULL,
  `us_key` varbinary(255) NOT NULL,
  `us_orig_path` varbinary(255) NOT NULL,
  `us_path` varbinary(255) NOT NULL,
  `us_source_type` varbinary(50) DEFAULT NULL,
  `us_timestamp` varbinary(14) NOT NULL,
  `us_status` varbinary(50) NOT NULL,
  `us_chunk_inx` int(10) unsigned DEFAULT NULL,
  `us_props` blob DEFAULT NULL,
  `us_size` int(10) unsigned NOT NULL,
  `us_sha1` varbinary(31) NOT NULL,
  `us_mime` varbinary(255) DEFAULT NULL,
  `us_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE','3D') DEFAULT NULL,
  `us_image_width` int(10) unsigned DEFAULT NULL,
  `us_image_height` int(10) unsigned DEFAULT NULL,
  `us_image_bits` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`us_id`),
  UNIQUE KEY `us_key` (`us_key`),
  KEY `us_user` (`us_user`),
  KEY `us_timestamp` (`us_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiuploadstash`
--

LOCK TABLES `my_wikiuploadstash` WRITE;
/*!40000 ALTER TABLE `my_wikiuploadstash` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiuploadstash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiuser`
--

DROP TABLE IF EXISTS `my_wikiuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiuser` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varbinary(255) NOT NULL DEFAULT '',
  `user_real_name` varbinary(255) NOT NULL DEFAULT '',
  `user_password` tinyblob NOT NULL,
  `user_newpassword` tinyblob NOT NULL,
  `user_newpass_time` binary(14) DEFAULT NULL,
  `user_email` tinyblob NOT NULL,
  `user_touched` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `user_token` binary(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `user_email_authenticated` binary(14) DEFAULT NULL,
  `user_email_token` binary(32) DEFAULT NULL,
  `user_email_token_expires` binary(14) DEFAULT NULL,
  `user_registration` binary(14) DEFAULT NULL,
  `user_editcount` int(11) DEFAULT NULL,
  `user_password_expires` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `user_email_token` (`user_email_token`),
  KEY `user_email` (`user_email`(50))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiuser`
--

LOCK TABLES `my_wikiuser` WRITE;
/*!40000 ALTER TABLE `my_wikiuser` DISABLE KEYS */;
INSERT INTO `my_wikiuser` VALUES (1,'Ddtracer','DD Tracer',':pbkdf2:sha512:30000:64:wqIx2KRigj4guwtC9UhgKQ==:Xk4u2vsH232dKfR2LMOnmGsANz0zIeHWqPZdKjKR2nph3VZxM4mZ2Q7dsiwyh1YUPiHY/2Bj5LRD1jf1KXB78A==','',NULL,'l@g.it','20190227164547','5d606dfa9210b7569579d603aa0cbf15',NULL,NULL,NULL,'20190227164540',0,NULL);
/*!40000 ALTER TABLE `my_wikiuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiuser_former_groups`
--

DROP TABLE IF EXISTS `my_wikiuser_former_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiuser_former_groups` (
  `ufg_user` int(10) unsigned NOT NULL DEFAULT 0,
  `ufg_group` varbinary(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ufg_user`,`ufg_group`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiuser_former_groups`
--

LOCK TABLES `my_wikiuser_former_groups` WRITE;
/*!40000 ALTER TABLE `my_wikiuser_former_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiuser_former_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiuser_groups`
--

DROP TABLE IF EXISTS `my_wikiuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiuser_groups` (
  `ug_user` int(10) unsigned NOT NULL DEFAULT 0,
  `ug_group` varbinary(255) NOT NULL DEFAULT '',
  `ug_expiry` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`ug_user`,`ug_group`),
  KEY `ug_group` (`ug_group`),
  KEY `ug_expiry` (`ug_expiry`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiuser_groups`
--

LOCK TABLES `my_wikiuser_groups` WRITE;
/*!40000 ALTER TABLE `my_wikiuser_groups` DISABLE KEYS */;
INSERT INTO `my_wikiuser_groups` VALUES (1,'bureaucrat',NULL),(1,'sysop',NULL);
/*!40000 ALTER TABLE `my_wikiuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiuser_newtalk`
--

DROP TABLE IF EXISTS `my_wikiuser_newtalk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiuser_newtalk` (
  `user_id` int(10) unsigned NOT NULL DEFAULT 0,
  `user_ip` varbinary(40) NOT NULL DEFAULT '',
  `user_last_timestamp` varbinary(14) DEFAULT NULL,
  KEY `un_user_id` (`user_id`),
  KEY `un_user_ip` (`user_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiuser_newtalk`
--

LOCK TABLES `my_wikiuser_newtalk` WRITE;
/*!40000 ALTER TABLE `my_wikiuser_newtalk` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiuser_newtalk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiuser_properties`
--

DROP TABLE IF EXISTS `my_wikiuser_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiuser_properties` (
  `up_user` int(10) unsigned NOT NULL,
  `up_property` varbinary(255) NOT NULL,
  `up_value` blob DEFAULT NULL,
  PRIMARY KEY (`up_user`,`up_property`),
  KEY `user_properties_property` (`up_property`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiuser_properties`
--

LOCK TABLES `my_wikiuser_properties` WRITE;
/*!40000 ALTER TABLE `my_wikiuser_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiuser_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikivalid_tag`
--

DROP TABLE IF EXISTS `my_wikivalid_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikivalid_tag` (
  `vt_tag` varbinary(255) NOT NULL,
  PRIMARY KEY (`vt_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikivalid_tag`
--

LOCK TABLES `my_wikivalid_tag` WRITE;
/*!40000 ALTER TABLE `my_wikivalid_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikivalid_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `my_wikiwatchlist`
--

DROP TABLE IF EXISTS `my_wikiwatchlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `my_wikiwatchlist` (
  `wl_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `wl_user` int(10) unsigned NOT NULL,
  `wl_namespace` int(11) NOT NULL DEFAULT 0,
  `wl_title` varbinary(255) NOT NULL DEFAULT '',
  `wl_notificationtimestamp` varbinary(14) DEFAULT NULL,
  PRIMARY KEY (`wl_id`),
  UNIQUE KEY `wl_user` (`wl_user`,`wl_namespace`,`wl_title`),
  KEY `namespace_title` (`wl_namespace`,`wl_title`),
  KEY `wl_user_notificationtimestamp` (`wl_user`,`wl_notificationtimestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `my_wikiwatchlist`
--

LOCK TABLES `my_wikiwatchlist` WRITE;
/*!40000 ALTER TABLE `my_wikiwatchlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `my_wikiwatchlist` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-27 16:49:28