CREATE DATABASE  IF NOT EXISTS `stocktestdb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `stocktestdb`;
-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: localhost    Database: stocktestdb
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `familygroup`
--

DROP TABLE IF EXISTS `familygroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `familygroup` (
  `parentmember` int(11) NOT NULL,
  `childmember` int(11) NOT NULL,
  `relationship` int(11) NOT NULL,
  `datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`childmember`,`parentmember`),
  KEY `familygroup_parentmember_idx` (`parentmember`),
  KEY `familygroup_relationship_idx` (`relationship`),
  CONSTRAINT `familygroup_chilmember` FOREIGN KEY (`childmember`) REFERENCES `member` (`idmember`),
  CONSTRAINT `familygroup_parentmember` FOREIGN KEY (`parentmember`) REFERENCES `member` (`idmember`),
  CONSTRAINT `familygroup_relationship` FOREIGN KEY (`relationship`) REFERENCES `memberrelationship` (`idmemberrelationship`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `familygroup`
--

LOCK TABLES `familygroup` WRITE;
/*!40000 ALTER TABLE `familygroup` DISABLE KEYS */;
INSERT INTO `familygroup` VALUES (606,607,1,NULL),(606,608,3,NULL),(606,609,3,NULL);
/*!40000 ALTER TABLE `familygroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fee`
--

DROP TABLE IF EXISTS `fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `fee` (
  `idfee` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` datetime NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `expirationdate` datetime NOT NULL,
  `idmember` int(11) NOT NULL,
  `year` int(11) NOT NULL,
  `month` int(11) NOT NULL,
  `paydate` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`idfee`),
  KEY `fk_fee_member_idx` (`idmember`),
  CONSTRAINT `fk_fee_member` FOREIGN KEY (`idmember`) REFERENCES `member` (`idmember`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fee`
--

LOCK TABLES `fee` WRITE;
/*!40000 ALTER TABLE `fee` DISABLE KEYS */;
INSERT INTO `fee` VALUES (1,'2018-01-01 00:00:00',200.00,'2018-02-02 00:00:00',1,2019,1,'2019-04-01 00:00:00','2019-04-16 12:34:39'),(2,'2019-04-02 17:50:03',112.00,'2019-03-21 00:00:00',4,2019,1,NULL,'2019-04-02 17:51:05'),(3,'2019-04-15 13:22:50',203.00,'2019-04-10 00:00:00',1,2019,4,'2019-04-05 00:00:00','2019-04-16 12:35:56'),(7,'2019-04-16 11:22:56',0.00,'2019-11-10 00:00:00',1,2019,11,NULL,NULL),(8,'2019-04-16 11:22:56',0.00,'2019-11-10 00:00:00',2,2019,11,NULL,NULL),(9,'2019-04-16 11:22:56',0.00,'2019-11-10 00:00:00',4,2019,11,NULL,NULL),(10,'2019-04-16 14:27:23',0.00,'2019-01-10 00:00:00',1,2019,1,NULL,NULL),(11,'2019-04-16 14:27:23',0.00,'2019-01-10 00:00:00',3,2019,1,NULL,NULL),(12,'2019-04-16 14:27:23',0.00,'2019-01-10 00:00:00',2,2019,1,NULL,NULL),(13,'2019-04-16 22:41:41',0.00,'2019-09-10 00:00:00',1,2019,9,NULL,NULL),(14,'2019-04-16 22:41:41',0.00,'2019-09-10 00:00:00',2,2019,9,NULL,NULL),(15,'2019-04-16 22:41:41',0.00,'2019-09-10 00:00:00',3,2019,9,NULL,NULL),(16,'2019-04-16 22:41:41',0.00,'2019-09-10 00:00:00',4,2019,9,NULL,NULL),(17,'2019-04-16 22:41:41',0.00,'2019-09-10 00:00:00',5,2019,9,NULL,NULL),(18,'2019-04-16 22:41:41',0.00,'2019-09-10 00:00:00',6,2019,9,NULL,NULL),(19,'2019-04-16 22:41:41',0.00,'2019-09-10 00:00:00',348,2019,9,NULL,NULL),(20,'2019-04-16 22:41:41',0.00,'2019-09-10 00:00:00',447,2019,9,NULL,NULL);
/*!40000 ALTER TABLE `fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gender`
--

DROP TABLE IF EXISTS `gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `gender` (
  `idgender` int(11) NOT NULL AUTO_INCREMENT,
  `gendername` varchar(100) NOT NULL,
  `genderdesc` varchar(2000) DEFAULT NULL,
  `gendericon` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idgender`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gender`
--

LOCK TABLES `gender` WRITE;
/*!40000 ALTER TABLE `gender` DISABLE KEYS */;
INSERT INTO `gender` VALUES (1,'Masculino',NULL,'gender-male'),(2,'Femenino',NULL,'gender-female'),(3,'Otro',NULL,'gender-male-female');
/*!40000 ALTER TABLE `gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maritalstatus`
--

DROP TABLE IF EXISTS `maritalstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `maritalstatus` (
  `idmaritalstatus` int(11) NOT NULL,
  `maritalstatus` varchar(100) NOT NULL,
  PRIMARY KEY (`idmaritalstatus`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maritalstatus`
--

LOCK TABLES `maritalstatus` WRITE;
/*!40000 ALTER TABLE `maritalstatus` DISABLE KEYS */;
/*!40000 ALTER TABLE `maritalstatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member`
--

DROP TABLE IF EXISTS `member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `member` (
  `idmember` int(11) NOT NULL AUTO_INCREMENT,
  `membernumber` int(11) DEFAULT NULL,
  `lastname` varchar(250) NOT NULL,
  `firstname` varchar(250) NOT NULL,
  `dni` int(11) DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  `birthplace` varchar(500) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL,
  `address` varchar(500) DEFAULT NULL,
  `maritalstatus` int(11) DEFAULT NULL,
  `employment` int(11) DEFAULT NULL,
  `parentMember` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`idmember`),
  KEY `fk_member_gender_idx` (`gender`),
  KEY `fk_member_maritalstatus_idx` (`maritalstatus`),
  KEY `fk_member_parentmember_idx` (`parentMember`),
  CONSTRAINT `fk_member_gender` FOREIGN KEY (`gender`) REFERENCES `gender` (`idgender`),
  CONSTRAINT `fk_member_maritalstatus` FOREIGN KEY (`maritalstatus`) REFERENCES `maritalstatus` (`idmaritalstatus`),
  CONSTRAINT `fk_member_parentmember` FOREIGN KEY (`parentMember`) REFERENCES `member` (`idmember`)
) ENGINE=InnoDB AUTO_INCREMENT=612 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member`
--

LOCK TABLES `member` WRITE;
/*!40000 ALTER TABLE `member` DISABLE KEYS */;
INSERT INTO `member` VALUES (1,1000,'Molina','Walter Rubén',NULL,'1988-11-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(2,1001,'Molina','Olivia',NULL,'2010-06-06 00:00:00',NULL,2,NULL,NULL,NULL,NULL,NULL),(3,1002,'Flintstone','Fred',NULL,'2013-05-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(4,1003,'Hotimsky','Sheila Tatiana',NULL,'1989-05-23 00:00:00',NULL,2,NULL,NULL,NULL,NULL,NULL),(5,1004,'Hotimsky','Luz',NULL,'2001-04-06 00:00:00',NULL,2,NULL,NULL,NULL,NULL,NULL),(6,1005,'Molina','Luna',NULL,'1954-02-03 00:00:00',NULL,2,NULL,NULL,NULL,NULL,NULL),(345,NULL,'Alcantara',' Catriel Ignacio',52355501,'2012-10-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(346,NULL,'Angel',' Thiago Benjamin',52049128,'2012-01-19 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(347,NULL,'Arias',' Santino Jair',52357147,'2012-10-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(348,NULL,'Carrizo',' Luka Bautista',52181991,'2012-07-24 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(349,NULL,'Ferreyra',' Daniel Ignacio',52049956,'2012-03-12 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(350,NULL,'Flores',' Pedro Maximiliano',52048193,'2012-01-24 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(351,NULL,'Funes-Cutuk',' Genaro',52053058,'2012-03-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(352,NULL,'Godoy',' Santiago Ariel',52048486,'2012-02-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(353,NULL,'Lucero',' Alex Fernando',52355571,'2012-10-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(354,NULL,'Mardonec',' Maycol Nahuel',52048126,'2012-01-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(355,NULL,'Martin',' Tadeo Agustín',52181626,'2012-12-18 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(356,NULL,'Pereira',' Andres Ignacio',52181626,'2012-08-06 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(357,NULL,'Ragosta',' Santiago Alejandro',52048776,'2012-02-23 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(358,NULL,'Rizzo',' Lucas Santino',52357334,'2012-12-18 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(359,NULL,'Rodriguez-Del Castillo',' Francisco',53178030,'2013-08-21 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(360,NULL,'Silva-Martinuk',' Maximo Alejandro',53179161,'2013-11-23 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(361,NULL,'Altaba-De Los Santos',' Santiago',51239254,'2011-09-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(362,NULL,'Audrito-Ramos',' Victorio',51275117,'2011-09-10 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(363,NULL,'Barbeito',' Thiago Nicolás',50821293,'2011-02-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(364,NULL,'Cabrera',' Lucas Ramiro',51466504,'2011-02-11 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(365,NULL,' Chavez',' Bautista',50916889,'2011-04-02 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(366,NULL,'Flores',' Teo Paul',51239117,'2011-07-23 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(367,NULL,'Fonzar',' Tomás',51239113,'2011-07-12 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(368,NULL,'Gauna',' Dylan',51466819,'2011-10-29 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(369,NULL,'Mandiles',' Thiago Mateo',50917023,'2011-04-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(370,NULL,'Manissero',' Lautaro',52048272,'2012-02-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(371,NULL,'Marinucci',' Vittorino',50820934,'2011-01-25 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(372,NULL,'Monardi',' Lisandro Benjamín',51239121,'2011-07-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(373,NULL,'Pelliza',' Giuliano Uriel',50821305,'2011-02-14 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(374,NULL,'Pontin',' Enzo Lautaro',50820934,'2011-01-25 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(375,NULL,'Rajnar',' Matías',50026139,'2011-07-02 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(376,NULL,'Rocha',' Tobias Benjamín',50917040,'2011-04-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(377,NULL,'Bautista-Rolon',' Octavio Joaquin',50117525,'2010-03-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(378,NULL,'Bergara',' Santino',50714050,'2010-12-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(379,NULL,'Caredio-Ferrer',' Julian',50117505,'2010-03-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(380,NULL,'Carranza',' Tobias',50117530,'2010-03-19 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(381,NULL,'Castillo-Vargas',' Facundo Geremías',50194062,'2010-06-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(382,NULL,'Galvan',' Emanuel Roy',50508407,'2010-09-25 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(383,NULL,'Gurruchaga',' Luciano Daniel',49802451,'2010-06-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(384,NULL,'Jofre-Escudero',' Facundo',50117971,'2010-05-29 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(385,NULL,'Magallanes-Torres',' Heber',50117558,'2010-03-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(386,NULL,'Maldonado',' Francisco',50117558,'2010-03-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(387,NULL,'Manzur',' Josué',50479915,'2010-06-12 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(388,NULL,'Mendoza-Chirino',' Joaquin',49995004,'2010-01-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(389,NULL,'Moyano',' Mateo Tomás',50369526,'2010-06-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(390,NULL,'Paez',' Hector Jeremías',50473783,'2010-10-12 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(391,NULL,'Palmero-Giantomassi',' Jose Benjamín',50194021,'2010-06-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(392,NULL,'Pereira',' Lucas  Romai',49802450,'2010-05-05 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(393,NULL,'Ponzoni',' Tiago Ismael',49965295,'2010-04-02 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(394,NULL,'Reartes-Maldonado',' Elían Nahuel',49937991,'2010-01-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(395,NULL,'Agonese',' Bruno Vladimir',49494053,'2009-08-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(396,NULL,'Alcaraz',' Francesco Uriel',49695654,'2009-09-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(397,NULL,'Audrito-Ramos',' Faustino',49587650,'2009-08-20 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(398,NULL,'Benavente',' Elías Damián',49102670,'2009-02-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(399,NULL,'Collado',' Lautaro',49695648,'2009-09-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(400,NULL,'Carrizo-Palmero',' Marko Valentín',49103196,'2009-04-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(401,NULL,'Castillo',' Luciano Jesús',49346386,'2009-07-31 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(402,NULL,'Delgado',' Valentín Manuel',49867942,'2009-11-18 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(403,NULL,'Dominguez',' Juan Pablo Daniel',49051788,'2009-02-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(404,NULL,'Gerez',' Benjamín',49051788,'2009-02-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(405,NULL,'Isaguirre',' Lorenzo',49052116,'2009-01-10 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(406,NULL,'Leyes',' Exequiel',49051658,'2009-01-14 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(407,NULL,'Luna',' Francisco Jesus',49352189,'2009-05-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(408,NULL,'Nicolussi',' Santiago',49550907,'2009-06-18 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(409,NULL,'Nuñez',' Juanjo',49493996,'2009-07-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(410,NULL,'Paredes',' Bautista Emanuel',49493943,'2009-06-19 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(411,NULL,'Pascual',' Valentín',49802369,'2009-10-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(412,NULL,'Ramazzotti',' Mateo',49867906,'2009-10-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(413,NULL,'Siliano',' Juan Ignacio',49866403,'2009-10-06 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(414,NULL,'Silvera',' Mateo',49219426,'2009-06-02 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(415,NULL,'Suarez',' Maximo Ivan',49867906,'2009-11-11 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(416,NULL,'Vallica',' Bautista',49052228,'2009-01-20 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(417,NULL,'Nicolussi',' Santiago',49550907,'2009-02-18 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(418,NULL,'Orozco',' Gonzalo Adrian',49493996,'2009-12-23 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(419,NULL,'Paez',' Benjamín Nicolas',49219331,'2009-04-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(420,NULL,'Pascual',' Valentino',49802369,'2009-10-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(421,NULL,'Ramazzotti',' Mater',49867906,'2009-10-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(422,NULL,'Acheriteguy',' Benjamin Alejandro',48410799,'2008-04-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(423,NULL,'Aguilar',' Elias Emanuel',48353179,'2008-01-29 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(424,NULL,'Alegroni',' Ignacio',48410220,'2008-04-09 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(425,NULL,'Altaba-De Los Santos',' Martín Alejandro',48589786,'2008-03-18 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(426,NULL,'Becerra-Bastarrica',' Agustín Ruben',48865733,'2008-09-29 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(427,NULL,'Bertrand',' Agustín José',48675961,'2008-05-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(428,NULL,'Boan',' Santiago Alejandro',48353113,'2008-01-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(429,NULL,'Cabrera',' Thomas Benjamín',48865019,'2008-08-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(430,NULL,'Castillo-Vargas',' Emanuel Nicolas',48353450,'2008-05-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(431,NULL,'Cecilia-Moreno',' Jerónimo',48620407,'2008-06-26 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(432,NULL,'Cejas',' Thiago Martin',48410358,'2008-05-30 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(433,NULL,'Chacon',' Tomás Claudio',48670610,'2008-02-12 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(434,NULL,'Desgens-Lorea',' Matías Nicolas',48353142,'2008-01-29 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(435,NULL,'Diaz',' Federico Nicolas',48468813,'2008-03-26 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(436,NULL,'Gonella-Diaz',' Juan Ignacio',48865809,'2008-10-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(437,NULL,'Manissero',' Santino Jesus',48865965,'2008-12-25 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(438,NULL,'Merlo-Scavarda',' Manolo',48410215,'2008-04-25 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(439,NULL,'Morales',' Tomás',48660950,'2008-08-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(440,NULL,'Morel',' Aquiles Sebastían',48410435,'2008-06-18 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(441,NULL,'Novillo-Janssen',' Maximo',48410221,'2008-04-24 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(442,NULL,'Palacios',' Angel Lautaro Benjamin',48410464,'2008-06-06 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(443,NULL,'Piccolo-Orellano',' Tiziano Emmanuel',48620006,'2008-07-09 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(444,NULL,'Ramazzotti',' Mateo',48270753,'2008-01-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(445,NULL,'Rizzo',' Lautaro Martín',48660930,'2008-08-16 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(446,NULL,'Rosales',' Gastón Alejandro',48865013,'2008-09-01 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(447,NULL,'Rudi-Scavarda',' Simón',48865976,'2008-12-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(448,NULL,'Scolari-Gallo',' Felipe',48601133,'2008-02-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(449,NULL,'Urquiza',' Isaias Brandon',48410344,'2008-05-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(450,NULL,'Corvalan-Petrini',' Benjamín',48150452,'2007-10-21 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(451,NULL,'Gonzalez',' Santiago',49901934,'2007-05-04 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(452,NULL,'Gutierrez',' Santino Angel',48269153,'2007-11-11 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(453,NULL,'Hörl',' Lucas',48387221,'2007-12-27 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(454,NULL,'Lozano-Munoz',' Josué Eduardo',47799051,'2007-03-18 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(455,NULL,'Orozco',' David Alejandro',48150376,'2007-10-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(456,NULL,'Sanchez',' Ezequiel Gabriel',47799560,'2007-03-31 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(457,NULL,'Torres-Pollio',' Bautista',47805659,'2007-04-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(458,NULL,'Varona-Garbarino',' Santiago Jesus',48270533,'2007-11-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(459,NULL,'Morales',' Thomás David',48660950,'2008-08-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(460,NULL,'Palacios',' Angel Lautaro Benjamín',48410464,'2008-06-06 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(461,NULL,'Scolari-Gallo',' Felipe ',48601133,'2008-02-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(462,NULL,'Aguirre',' Salvador',47267600,'2006-06-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(463,NULL,'Alcaraz',' Mateo Emiliano',46933616,'2006-02-21 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(464,NULL,'Aleksandroff',' Mateo',47267413,'2006-05-20 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(465,NULL,'Arauz',' Jesus Jeremías',47487783,'2006-07-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(466,NULL,'Barrera-Gatica',' Nicolas',47592395,'2006-10-14 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(467,NULL,'Fidalgo',' Nicolas Ezequiel',47669888,'2006-11-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(468,NULL,'Gil',' Mateo Emiliano',47592329,'2006-10-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(469,NULL,'Lascano',' Juan Andres',47154645,'2006-05-06 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(470,NULL,'Lopez',' Federico Maximiliano',46934003,'2006-03-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(471,NULL,'Lucero',' Alejadro Nicolas',47592271,'2006-10-01 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(472,NULL,'Lucero',' Luciano Emanuel',46934168,'2006-05-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(473,NULL,'Mahon',' Lucas Andres',46807446,'2006-01-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(474,NULL,'Morales-Medina',' Lautaro Valentín',46807473,'2006-01-14 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(475,NULL,'Nuñez',' Tomás',46933527,'2006-01-21 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(476,NULL,'Perez',' Alexis Gabriel',47267331,'2006-04-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(477,NULL,'Rios',' Lucas Evaristo',47267435,'2006-05-29 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(478,NULL,'Rodriguez-Del Castillo',' Santiago',47592112,'2006-09-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(479,NULL,'Rudi-Scavarda',' Francisco',47592311,'2006-10-02 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(480,NULL,'Salinas',' Gonzalo Bautista',47798811,'2006-11-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(481,NULL,'Varona-Gargiulo',' Agustin                 ',46807424,'2006-01-04 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(482,NULL,'Horl',' Lucas',48387221,'2007-12-27 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(483,NULL,'Lozano-Muñoz',' Josué Eduardo',47799051,'2007-03-18 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(484,NULL,'Aguilera',' Joaquin Lucas',46260914,'2005-08-31 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(485,NULL,'Alvarez-Bosco',' Maurizio Ezequiel',46617422,'2005-08-19 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(486,NULL,'Ballestero',' Juan Pablo',46617409,'2005-09-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(487,NULL,'Barchetta',' Thomás',46409293,'2005-04-09 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(488,NULL,'Bustos',' Santiago Nahuel',46332696,'2005-05-02 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(489,NULL,'Diaz-Velez',' Benjamín',46617492,'2005-10-01 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(490,NULL,'Frontera',' Joaquin Ramón Ricardo',46260445,'2005-02-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(491,NULL,'Gay',' Eliel Yair',46409368,'2005-05-21 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(492,NULL,'Giannone',' Franco',46494819,'2005-03-31 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(493,NULL,'Inacio',' Mateo Simón',46405683,'2005-04-12 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(494,NULL,'Lattes',' Silvano Nicolas',46485643,'2005-07-04 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(495,NULL,'Llambias',' Santiago Emiliano',46332527,'2005-03-04 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(496,NULL,'Merlo-Scavarda',' Gregorio',46617489,'2005-01-30 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(497,NULL,'Morel',' Sergio Lautaro',46542697,'2005-04-27 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(498,NULL,'Rosales',' Angel Nicolas',46409041,'2005-03-11 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(499,NULL,'Rinaudo-Mongano',' Tiziano',46260440,'2005-01-25 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(500,NULL,'Rojo',' Felipe',46486112,'2005-08-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(501,NULL,'Suarez',' Nicolas Agustín',46409041,'2005-06-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(502,NULL,'Schemith',' Bruno Tomás',46332558,'2005-03-10 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(503,NULL,'Torres-Esteban',' Benjamín',46617457,'2005-09-14 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(504,NULL,'Torres-Gimenez',' Santiago Nicolas',46617457,'2005-09-26 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(505,NULL,'Aguilar-Gutierrez',' Yair Dylan',45117390,'2004-01-04 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(506,NULL,'Balerdi',' Mateo',45982183,'2004-11-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(507,NULL,'Benega-Tabaco',' Angel Agustín',46072221,'2004-11-01 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(508,NULL,'Carrizo-Zanon',' Marcos',45886175,'2004-09-16 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(509,NULL,'Desgens-Lorea',' Juan Pablo',46072292,'2004-11-29 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(510,NULL,'Fernandez-Quevedo',' Joaquin Nicolas',46072151,'2004-10-12 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(511,NULL,'Gomez',' Matias Nicolas',45886902,'2004-07-26 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(512,NULL,'Gomez',' Gastón',45801448,'2004-08-12 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(513,NULL,'Gonzalez',' Alejo Ezequiel',45626342,'2004-02-05 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(514,NULL,'Herrera',' Cristian José Nahuel',45335823,'2004-09-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(515,NULL,'Heredia-Castro',' Rodolfo Ramiro Emanuel',45474655,'2004-03-12 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(516,NULL,'Jaime',' Gonzalo Benjamín',45474605,'2004-03-06 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(517,NULL,'Lopez',' Jesus Matías',46181393,'2004-12-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(518,NULL,'Olguin',' Gabriel Ali',45886987,'2004-09-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(519,NULL,'Olguin',' Nicolas',45886142,'2004-09-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(520,NULL,'Oviedo',' Marcos Ignacio',45474022,'2004-02-10 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(521,NULL,'Palacios',' Facundo Daniel',45886045,'2004-08-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(522,NULL,'Pessot',' Joaquin',45800600,'2004-05-20 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(523,NULL,'Ponce',' Lisandro Mateo',46072353,'2004-12-20 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(524,NULL,'Quevedo',' Octavio Gastón',45801030,'2004-05-31 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(525,NULL,'Rodriguez-Del Castillo',' Matías',45474652,'2004-03-21 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(526,NULL,'Salina-Paez',' Alvaro Gabriel',46072130,'2004-09-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(527,NULL,'Zeballos',' Julian',45886029,'2004-08-05 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(528,NULL,'Rodriguez',' Lautaro Benjamin',46617538,'2005-10-26 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(529,NULL,'Rojo',' Felipe',46486116,'2005-08-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(530,NULL,'Torres-Esteban',' Lauraro Benjamin',46617457,'2005-09-14 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(531,NULL,'Agüero',' Maximo Lisandro',44845852,'2003-06-24 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(532,NULL,'Aguilera',' Juan Jose Manuel',44753184,'2003-04-25 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(533,NULL,'Afionis-Libaak',' Franco',44954230,'2003-08-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(534,NULL,'Alfonso',' Lautaro Emanuel',44753092,'2003-06-01 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(535,NULL,'Benito',' Lucas Agustín',44753132,'2003-03-31 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(536,NULL,'Bustos',' Joaquín Luciano',44753006,'2003-04-27 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(537,NULL,'Diaz-Oroz',' Juan Francisco',44994354,'2003-09-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(538,NULL,'Diaz-Ramos',' Juan Cruz',44686048,'2003-02-14 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(539,NULL,'Garbero',' Raul Oscar',44954221,'2003-08-11 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(540,NULL,'Gonzalez',' Gonzalo Lautaro',44718351,'2003-04-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(541,NULL,'Guilmart',' Benjamín Alexis',44954579,'2003-09-05 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(542,NULL,'Gurruchaga',' Fernando Ariel',44954568,'2003-09-05 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(543,NULL,'Land',' Thiago',44994406,'2003-10-09 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(544,NULL,'Lucero',' Bruno Nicolás',44531452,'2003-02-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(545,NULL,'Maure',' Agustín Nicolás',44954158,'2003-07-16 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(546,NULL,'Ponce',' Maximo Lautaro',44531374,'2003-01-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(547,NULL,'Psenda',' Benjamín',44954314,'2003-05-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(548,NULL,'Romero',' Joaquín Nicolás',44752893,'2003-03-14 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(549,NULL,'Sanchez',' Pedro Ignacio',44994360,'2003-09-18 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(550,NULL,'Torres',' Matías Martín',44643450,'2003-03-02 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(551,NULL,'Villegas',' Elías Paulo',44753031,'2003-04-18 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(552,NULL,'Benega-Tabaco',' Angel Agustín',46072292,'2004-11-29 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(553,NULL,'Desgens',' Juan Pablo',46072292,'2004-11-29 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(554,NULL,'Pessot',' Joaquín',45800600,'2004-05-20 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(555,NULL,'Salinas-Paez',' Alvaro Gabriel',46072130,'2004-09-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(556,NULL,'Albornoz-Britos',' Nicolas Baltazar',43222134,'2001-01-06 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(557,NULL,'Benega-Tabacco',' Nicolas',42423581,'2001-04-05 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(558,NULL,'Bertolini',' Marcelo Facundo',43839741,'2001-12-12 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(559,NULL,'Chaparro',' Alan David',43222146,'2000-12-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(560,NULL,'Flores',' Matías',39797717,'1996-11-30 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(561,NULL,'Garcia',' Diego Facundo',43072708,'2000-10-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(562,NULL,'Juanteguy',' Federico',40823511,'1996-11-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(563,NULL,'Leguizamon',' Alexis Nicolas',42407665,'2000-02-02 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(564,NULL,'Lopez-Cardone',' Francisco',43551309,'2001-05-09 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(565,NULL,'Maya',' Franco Luciano',39994189,'1996-05-11 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(566,NULL,'Molina',' Santiago Manuel',43621448,'2001-07-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(567,NULL,'Morel',' Alan Ivan',39397395,'1996-10-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(568,NULL,'Ochoa',' Leandro Ariel',44020039,'2002-02-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(569,NULL,'Ortiz',' Ezequiel',43282268,'2001-01-16 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(570,NULL,'Periale',' Aaron Joel',42326979,'2001-01-17 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(571,NULL,'Principi',' Nazareno',43343047,'2000-12-27 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(572,NULL,'Rodriguez',' Facundo Nicolas',44359443,'2002-09-25 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(573,NULL,'Rojo',' Emiliano Jose',43690598,'2001-09-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(574,NULL,'Suarez',' Ezequiel Gustavo',43839516,'2001-10-14 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(575,NULL,'Velazquez',' Leandro Hebert',43423532,'2001-03-12 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(576,NULL,'Albelo',' Juan Pablo',44480321,'2002-10-31 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(577,NULL,'Cartasegna',' Luis Francisco',44075507,'2002-03-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(578,NULL,'Ciriza-Amitrano',' Manuel',44531108,'2002-12-03 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(579,NULL,'Contreras-Batiche',' Tomás Eliseo',44531111,'2002-11-29 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(580,NULL,'Gomez',' Cristian Eduardo',44480432,'2002-09-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(581,NULL,'Lalinde',' Emiliano Mauricio',44075624,'2002-03-20 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(582,NULL,'Lucero',' Enzo Gustavo',44531201,'2002-11-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(583,NULL,'Mariani',' Ignacio Valentín',44020023,'2002-02-20 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(584,NULL,'Monasterolo',' Ignacio',44219095,'2002-07-02 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(585,NULL,'Ochoa',' Ariel Leandro',44020039,'2002-02-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(586,NULL,'Ojeda',' Nicolas Nadie',44219024,'2002-06-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(587,NULL,'Salinas',' Federico Sebastían',44020124,'2002-02-26 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(588,NULL,'Silvestre',' Luciano',43866494,'2002-01-04 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(589,NULL,'Juantegui',' Diego Alejandro',44954520,'2003-03-16 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(590,NULL,'Lucero',' Bruno Nicolas',44531452,'2003-02-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(591,NULL,'Ponce',' Maximom Lautaro',44531374,'2003-01-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(592,NULL,'Aguilar',' Eduardo',37717201,'1995-02-24 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(593,NULL,'Bellon',' Benjamin',42744140,'1999-11-24 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(594,NULL,'Inostroza',' Brian',39395994,'1996-04-24 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(595,NULL,'Juantegui',' Federico',40823511,'1996-11-22 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(596,NULL,'Leyes',' David',34879717,'1990-01-10 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(597,NULL,'Medina',' Ariel',40938415,'1998-03-07 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(598,NULL,'Mendoza',' Diego Martín',41919897,'1999-05-04 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(599,NULL,'Montenegro',' Hugo',31347171,'1985-07-28 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(600,NULL,'Presedo',' Fernando',35316782,'1990-10-01 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(601,NULL,'Rodriguez',' Exequiel',39137658,'1996-02-01 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(602,NULL,'Suarez',' Federico',35884097,'1991-12-12 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(603,NULL,'Vega. Ezequiel','',42142449,'1999-08-14 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(604,NULL,'Veneciano',' Diego',37641467,'1995-03-08 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(605,1010,'Navarro','Roberto',NULL,'2000-05-09 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(606,1500,'Stark','Ned',92000000,'1989-11-13 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(607,1501,'Tully','Catelyn',92000001,'1989-11-14 00:00:00',NULL,2,NULL,NULL,NULL,NULL,NULL),(608,NULL,'Stark','Robb',92000002,'2010-11-15 00:00:00',NULL,1,NULL,NULL,NULL,NULL,NULL),(609,NULL,'Stark','Arya',92000003,'2015-11-16 00:00:00',NULL,2,NULL,NULL,NULL,NULL,NULL),(610,NULL,'Stark','Walter',34127118,'2009-11-13 00:00:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(611,NULL,'Stark','Walter',34127118,'2009-11-13 00:00:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_phone`
--

DROP TABLE IF EXISTS `member_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `member_phone` (
  `idmember` int(11) NOT NULL,
  `idphone` int(11) NOT NULL,
  `datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`idmember`,`idphone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_phone`
--

LOCK TABLES `member_phone` WRITE;
/*!40000 ALTER TABLE `member_phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `memberrelationship`
--

DROP TABLE IF EXISTS `memberrelationship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `memberrelationship` (
  `idmemberrelationship` int(11) NOT NULL AUTO_INCREMENT,
  `relation` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`idmemberrelationship`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `memberrelationship`
--

LOCK TABLES `memberrelationship` WRITE;
/*!40000 ALTER TABLE `memberrelationship` DISABLE KEYS */;
INSERT INTO `memberrelationship` VALUES (1,'Cónyuge'),(2,'Concubino/a'),(3,'Hijo/a'),(4,'Hermano/a'),(5,'Nieto/a'),(6,'Sobrino/a');
/*!40000 ALTER TABLE `memberrelationship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone`
--

DROP TABLE IF EXISTS `phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `phone` (
  `idphone` int(11) NOT NULL,
  `phonenumber` varchar(45) NOT NULL,
  `phonetype` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idphone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone`
--

LOCK TABLES `phone` WRITE;
/*!40000 ALTER TABLE `phone` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `iduser` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(255) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created` date NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`iduser`),
  UNIQUE KEY `iduser_unique` (`iduser`),
  UNIQUE KEY `user_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-04 12:36:38