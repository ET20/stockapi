-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: stock
-- ------------------------------------------------------
-- Server version	8.0.13

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
-- Table structure for table `almacen`
--

DROP TABLE IF EXISTS `almacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `almacen` (
  `idalmacen` int(11) NOT NULL AUTO_INCREMENT,
  `ubicacion` varchar(45) NOT NULL,
  `capacidad` decimal(10,2) NOT NULL,
  `tipo` int(11) NOT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`idalmacen`),
  KEY `fk_almacen_tipoalmacen3` (`tipo`),
  CONSTRAINT `fk_almacen_tipoalmacen3` FOREIGN KEY (`tipo`) REFERENCES `tipoalmacen` (`idtipoalmacen`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `almacen`
--

LOCK TABLES `almacen` WRITE;
/*!40000 ALTER TABLE `almacen` DISABLE KEYS */;
INSERT INTO `almacen` VALUES (1,'Perdernera 311',1000.00,1,'Armario'),(2,'Balcarce 222',2000.00,2,'Freezer'),(3,'Belgrano 444',3000.00,3,'Cajon');
/*!40000 ALTER TABLE `almacen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `costo`
--

DROP TABLE IF EXISTS `costo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `costo` (
  `idcosto` int(11) NOT NULL AUTO_INCREMENT,
  `idmaterial` int(11) NOT NULL,
  `unidad` int(11) NOT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `fechaactualizado` datetime DEFAULT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idcosto`,`unidad`),
  UNIQUE KEY `fechaactualizado_UNIQUE` (`fechaactualizado`),
  KEY `fk_costo_material_idx` (`idmaterial`),
  KEY `fk_costo_unidadmedida_idx` (`unidad`),
  CONSTRAINT `fk_costo_material` FOREIGN KEY (`idmaterial`) REFERENCES `material` (`idmaterial`),
  CONSTRAINT `fk_costo_unidadmedida` FOREIGN KEY (`unidad`) REFERENCES `unidadmedida` (`idunidadmedida`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `costo`
--

LOCK TABLES `costo` WRITE;
/*!40000 ALTER TABLE `costo` DISABLE KEYS */;
INSERT INTO `costo` VALUES (3,1,1,200.00,'1999-03-02 05:02:02',3.00),(4,2,1,300.00,'1999-01-02 04:02:02',4.00);
/*!40000 ALTER TABLE `costo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `envase`
--

DROP TABLE IF EXISTS `envase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `envase` (
  `idenvase` int(11) NOT NULL AUTO_INCREMENT,
  `idmaterial` int(11) DEFAULT NULL,
  `capacidad` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idenvase`),
  KEY `fk_materiaprima_material_idx` (`idmaterial`),
  CONSTRAINT `fk_materiaprima_material0` FOREIGN KEY (`idmaterial`) REFERENCES `material` (`idmaterial`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `envase`
--

LOCK TABLES `envase` WRITE;
/*!40000 ALTER TABLE `envase` DISABLE KEYS */;
INSERT INTO `envase` VALUES (1,5,1000.00),(2,5,500.00);
/*!40000 ALTER TABLE `envase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `herramienta`
--

DROP TABLE IF EXISTS `herramienta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `herramienta` (
  `idherramienta` int(11) NOT NULL AUTO_INCREMENT,
  `idmaterial` int(11) DEFAULT NULL,
  `marca` varchar(500) DEFAULT NULL,
  `modelo` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`idherramienta`),
  KEY `fk_herramienta_idx` (`idmaterial`),
  CONSTRAINT `fk_herramienta` FOREIGN KEY (`idmaterial`) REFERENCES `material` (`idmaterial`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `herramienta`
--

LOCK TABLES `herramienta` WRITE;
/*!40000 ALTER TABLE `herramienta` DISABLE KEYS */;
INSERT INTO `herramienta` VALUES (1,1,'tramontina','madera'),(2,2,'almandoz','grande'),(3,5,'Amanecer','largo');
/*!40000 ALTER TABLE `herramienta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `material` (
  `idmaterial` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(500) NOT NULL,
  `descripcion` varchar(2000) DEFAULT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  `unidad` int(11) DEFAULT NULL,
  `buenestado` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idmaterial`),
  KEY `fk_materiaprima_unidad_idx` (`unidad`),
  CONSTRAINT `fk_materiaprima_unidad1` FOREIGN KEY (`unidad`) REFERENCES `unidadmedida` (`idunidadmedida`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (1,'cuchara','sirve para mezclar',1.00,1,1),(2,'olla','sirve para calentar',1.00,1,1),(3,'batata','dulce',1.00,1,1),(4,'manzana','dulce',1.00,1,1),(5,'frasco','sirve para almacenar dulce',1.00,3,1);
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materialalmacen`
--

DROP TABLE IF EXISTS `materialalmacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `materialalmacen` (
  `idmaterial` int(11) NOT NULL,
  `idalmacen` int(11) NOT NULL,
  `idpersona` int(11) NOT NULL,
  `fechaingreso` datetime DEFAULT NULL,
  `movimientoingresoegreso` tinyint(4) DEFAULT NULL,
  `fechavencimiento` datetime DEFAULT NULL,
  PRIMARY KEY (`idmaterial`,`idalmacen`,`idpersona`),
  KEY `fk_almacenalmacen_idx` (`idalmacen`),
  KEY `fk_persona_persona_idx` (`idpersona`),
  CONSTRAINT `fk_almacenalmacen` FOREIGN KEY (`idalmacen`) REFERENCES `almacen` (`idalmacen`),
  CONSTRAINT `fk_materialmaterial` FOREIGN KEY (`idmaterial`) REFERENCES `material` (`idmaterial`),
  CONSTRAINT `fk_persona_persona2` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materialalmacen`
--

LOCK TABLES `materialalmacen` WRITE;
/*!40000 ALTER TABLE `materialalmacen` DISABLE KEYS */;
/*!40000 ALTER TABLE `materialalmacen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materiaprima`
--

DROP TABLE IF EXISTS `materiaprima`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `materiaprima` (
  `idmateriaprima` int(11) NOT NULL AUTO_INCREMENT,
  `idmaterial` int(11) DEFAULT NULL,
  PRIMARY KEY (`idmateriaprima`),
  KEY `fk_materiaprima_material_idx` (`idmaterial`),
  CONSTRAINT `fk_materiaprima_material` FOREIGN KEY (`idmaterial`) REFERENCES `material` (`idmaterial`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiaprima`
--

LOCK TABLES `materiaprima` WRITE;
/*!40000 ALTER TABLE `materiaprima` DISABLE KEYS */;
INSERT INTO `materiaprima` VALUES (3,3),(4,4);
/*!40000 ALTER TABLE `materiaprima` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) NOT NULL,
  `sexo` varchar(45) NOT NULL,
  `dni` decimal(10,0) NOT NULL,
  `Fecha_nac` date NOT NULL,
  `num_telefono` int(11) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`idpersona`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
INSERT INTO `persona` VALUES (1,'Juan','Leiva','M',11111,'0001-01-01',111111,'asdsd'),(2,'Emir','Busto','M',111113,'0001-02-02',222222,'asdsadsa');
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `precioventa`
--

DROP TABLE IF EXISTS `precioventa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `precioventa` (
  `idprecioventa` int(11) NOT NULL AUTO_INCREMENT,
  `idmaterial` int(11) DEFAULT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `fechaactualizado` datetime DEFAULT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  `unidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`idprecioventa`),
  KEY `fk_costo_material_idx` (`idmaterial`),
  KEY `fk_precioventa_unidad_idx` (`unidad`),
  CONSTRAINT `fk_costo_material0` FOREIGN KEY (`idmaterial`) REFERENCES `material` (`idmaterial`),
  CONSTRAINT `fk_precioventa_unidad` FOREIGN KEY (`unidad`) REFERENCES `unidadmedida` (`idunidadmedida`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `precioventa`
--

LOCK TABLES `precioventa` WRITE;
/*!40000 ALTER TABLE `precioventa` DISABLE KEYS */;
INSERT INTO `precioventa` VALUES (1,3,12.00,'1999-02-02 01:02:02',12.00,1),(2,4,20.00,'1999-02-03 03:02:02',10.00,1);
/*!40000 ALTER TABLE `precioventa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produccion`
--

DROP TABLE IF EXISTS `produccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `produccion` (
  `idproduccion` int(11) NOT NULL AUTO_INCREMENT,
  `idmaterial` int(11) NOT NULL,
  `lote` int(11) NOT NULL,
  `fechayhoradelaproduccion` datetime NOT NULL,
  PRIMARY KEY (`idproduccion`,`idmaterial`),
  KEY `fk_produccion_material_idx` (`idmaterial`),
  CONSTRAINT `fk_produccion_material` FOREIGN KEY (`idmaterial`) REFERENCES `material` (`idmaterial`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produccion`
--

LOCK TABLES `produccion` WRITE;
/*!40000 ALTER TABLE `produccion` DISABLE KEYS */;
INSERT INTO `produccion` VALUES (1,1,2,'1999-02-02 01:02:02'),(2,2,3,'1999-02-02 03:14:02');
/*!40000 ALTER TABLE `produccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoalmacen`
--

DROP TABLE IF EXISTS `tipoalmacen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `tipoalmacen` (
  `idtipoalmacen` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`idtipoalmacen`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoalmacen`
--

LOCK TABLES `tipoalmacen` WRITE;
/*!40000 ALTER TABLE `tipoalmacen` DISABLE KEYS */;
INSERT INTO `tipoalmacen` VALUES (1,'Armario '),(2,'Freezer'),(3,'Cajon');
/*!40000 ALTER TABLE `tipoalmacen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidadmedida`
--

DROP TABLE IF EXISTS `unidadmedida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `unidadmedida` (
  `idunidadmedida` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(500) DEFAULT NULL,
  `descripcion` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`idunidadmedida`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidadmedida`
--

LOCK TABLES `unidadmedida` WRITE;
/*!40000 ALTER TABLE `unidadmedida` DISABLE KEYS */;
INSERT INTO `unidadmedida` VALUES (1,'kilogramos','unidad de medicion'),(2,'cm3','unidad de medicion'),(3,'cantidad','unidad de medicion0'),(4,'litros','unidad de medicion');
/*!40000 ALTER TABLE `unidadmedida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `idpersona` int(11) NOT NULL,
  `usuario` varchar(45) NOT NULL,
  `contraseña` varchar(45) NOT NULL,
  PRIMARY KEY (`idusuario`),
  KEY `fk_persona_persona_idx` (`idpersona`),
  CONSTRAINT `fk_persona_persona` FOREIGN KEY (`idpersona`) REFERENCES `persona` (`idpersona`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,1,'Juana','123123'),(2,2,'Ivon','1232131');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-28  9:20:31
