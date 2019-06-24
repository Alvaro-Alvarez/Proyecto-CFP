-- MySQL dump 10.13  Distrib 5.7.9, for Win32 (AMD64)
--
-- Host: localhost    Database: cfpnueva
-- ------------------------------------------------------
-- Server version	5.7.12-log

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
-- Table structure for table `alumnosxmaterias`
--

DROP TABLE IF EXISTS `alumnosxmaterias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alumnosxmaterias` (
  `id_alumnoxmateria` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_materia` int(10) unsigned NOT NULL,
  `nota` int(10) DEFAULT NULL,
  `id_personaxcurso` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_alumnoxmateria`),
  KEY `fk_AlumnosXMaterias_Materias1_idx` (`id_materia`),
  KEY `fk_AlumnosXMaterias_PersonasXMateria1_idx` (`id_personaxcurso`),
  KEY `fk_AlumnosXMaterias_idx` (`id_personaxcurso`),
  CONSTRAINT `fk_AlumnosXMaterias_Materias1` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alumnosxmaterias`
--

LOCK TABLES `alumnosxmaterias` WRITE;
/*!40000 ALTER TABLE `alumnosxmaterias` DISABLE KEYS */;
INSERT INTO `alumnosxmaterias` VALUES (13,2,6,7),(14,3,10,8),(15,5,10,8),(16,3,4,9),(17,1,10,1),(18,1,6,7),(19,2,10,1),(20,1,4,24),(21,2,4,24),(22,1,2,25),(23,2,2,25);
/*!40000 ALTER TABLE `alumnosxmaterias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursos`
--

DROP TABLE IF EXISTS `cursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cursos` (
  `id_curso` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_curso` varchar(45) DEFAULT NULL,
  `observacion` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_curso`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursos`
--

LOCK TABLES `cursos` WRITE;
/*!40000 ALTER TABLE `cursos` DISABLE KEYS */;
INSERT INTO `cursos` VALUES (1,'programador','se basa en programacion','activo'),(2,'operador','se basa en operaciones','activo'),(28,'nada','feo','inactivo');
/*!40000 ALTER TABLE `cursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cursosxsedes`
--

DROP TABLE IF EXISTS `cursosxsedes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cursosxsedes` (
  `id_cursoxsede` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_sede` int(10) unsigned NOT NULL,
  `id_curso` int(10) unsigned NOT NULL,
  `estado` varchar(700) DEFAULT NULL,
  PRIMARY KEY (`id_cursoxsede`),
  KEY `fk_CursosXSedes_Sedes_idx` (`id_sede`),
  KEY `fk_CursosXSedes_Cursos1_idx` (`id_curso`),
  CONSTRAINT `fk_CursosXSedes_Cursos1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CursosXSedes_Sedes` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`id_sede`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cursosxsedes`
--

LOCK TABLES `cursosxsedes` WRITE;
/*!40000 ALTER TABLE `cursosxsedes` DISABLE KEYS */;
INSERT INTO `cursosxsedes` VALUES (1,1,1,'activo'),(2,2,1,'activo'),(3,1,2,'activo'),(4,2,2,'activo'),(5,3,1,'activo'),(6,4,1,'activo');
/*!40000 ALTER TABLE `cursosxsedes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materias`
--

DROP TABLE IF EXISTS `materias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `materias` (
  `id_materia` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_materia` varchar(45) DEFAULT NULL,
  `id_curso` int(10) unsigned NOT NULL,
  `observacion` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_materia`),
  KEY `fk_Materias_Cursos1_idx` (`id_curso`),
  CONSTRAINT `fk_Materias_Cursos1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materias`
--

LOCK TABLES `materias` WRITE;
/*!40000 ALTER TABLE `materias` DISABLE KEYS */;
INSERT INTO `materias` VALUES (1,'c',1,'c++','activo'),(2,'html',1,'cc','activo'),(3,'matematica',2,'calculos','activo'),(4,'lengua',2,'literatura','inactivo'),(5,'economia',2,'numeros','activo');
/*!40000 ALTER TABLE `materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `materiass`
--

DROP TABLE IF EXISTS `materiass`;
/*!50001 DROP VIEW IF EXISTS `materiass`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `materiass` AS SELECT 
 1 AS `nombre_materia`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `personas`
--

DROP TABLE IF EXISTS `personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personas` (
  `id_persona` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `dni` int(11) DEFAULT NULL,
  `sexo` varchar(45) DEFAULT NULL,
  `telefono` int(11) DEFAULT NULL,
  `domicilio` varchar(45) DEFAULT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `fechadenac` date DEFAULT NULL,
  `localidad` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_persona`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personas`
--

LOCK TABLES `personas` WRITE;
/*!40000 ALTER TABLE `personas` DISABLE KEYS */;
INSERT INTO `personas` VALUES (6,'adan','kevin',12,'Hombre',323,'caba12','adan23','2016-10-10','CABA','activo'),(7,'andy','lleeld',31,'Hombre',44,'don12','andu','2016-10-11','San Martin','activo'),(8,'andaa','lleeldds',31,'Hombre',44,'don12sd','andu','2016-10-11','San Martin','activo'),(9,'andy','lleeld',3,'Hombre',44,'don12','andu','2016-10-11','San Martin','activo'),(10,'andy','lleeld',3,'Hombre',44,'don12','andu','2016-10-11','San Martin','activo'),(11,'andy','lleeld',76,'Hombre',44,'don12','andu','2016-10-11','San Martin','activo'),(12,'andy','lleeld',79,'Hombre',44,'don12','andu','2016-10-11','San Martin','activo'),(13,'andydsgff','lleeldsd',1,'Hombre',44,'don12','andu','2016-10-11','CABA','activo'),(14,'adan','kevins',121443,'Hombre',323,'caba12','adan23','1990-01-30','CABA','activo'),(16,'leandro','perez',98,'Hombre',3123,'leandro12','leandro','2016-10-20','CABA','activo'),(18,'koly','sdsd',2345,'Hombre',12,'dss','ada','2016-10-07','CABA','activo'),(22,'adan','kevin',6765,'Mujer',2334,'sd43','asdsd','2016-10-11','CABA','activo'),(23,'mou','ham',23948,'Hombre',4345,'dom23','ada','2016-10-12','CABA','activo'),(24,'aca','ham',34894,'Hombre',4345,'dom23','ada','2016-10-12','CABA','activo'),(25,'acam','ham',34894,'Hombre',4345,'dom23','ada','2016-10-12','CABA','activo'),(26,'gonzalo','qwe',98435,'Hombre',2334,'sd43','asdsd','2016-10-11','CABA','activo'),(27,'tomas ','mierdini',43289,'Mujer',4343,'fdjid434','adssd','1811-03-13','Quilmes','activo'),(28,'dsoif','kevins',1254,'Hombre',323,'caba12','adan23','1990-01-30','CABA','activo'),(29,'Alicia','Ayma',23983442,'Mujer',46935117,'Calle Faldsa 123','aliciaayma@hotmail.com','1998-03-10','Lomas de zamora','activo'),(30,'sandro','pod',8923849,'Hombre',4343443,'fosd34','adakjf','2009-02-03','Alimirante Brown','activo'),(31,'jose','lopez',123,'Hombre',4343,'domi123','jose_el','2016-10-15','CABA','activo'),(32,'portacus','ge',32434,'Hombre',34,'asd12','asd','2016-10-04','CABA','activo');
/*!40000 ALTER TABLE `personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personasxcursos`
--

DROP TABLE IF EXISTS `personasxcursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `personasxcursos` (
  `id_personaxcurso` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_persona` int(10) unsigned NOT NULL,
  `tipo_persona` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `observacion` varchar(45) DEFAULT NULL,
  `id_cursoxsede` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_personaxcurso`),
  KEY `fk_alumnosxcursos_personas1_idx` (`id_persona`),
  KEY `fk_personasxcursos_cursosxsedes1_idx` (`id_cursoxsede`),
  CONSTRAINT `fk_alumnosxcursos_personas1` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_personasxcursos_cursosxsedes1` FOREIGN KEY (`id_cursoxsede`) REFERENCES `cursosxsedes` (`id_cursoxsede`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personasxcursos`
--

LOCK TABLES `personasxcursos` WRITE;
/*!40000 ALTER TABLE `personasxcursos` DISABLE KEYS */;
INSERT INTO `personasxcursos` VALUES (1,6,'alumno','activo','iniciando',1),(2,7,'alumno','activo','iniciando',2),(3,9,'alumno','activo','iniciando',2),(4,11,'alumno','activo','iniciando',2),(5,12,'alumno','activo','iniciando',2),(6,13,'alumno','inactivo','iniciando',2),(7,14,'alumno','inactivo','iniciando',1),(8,16,'alumno','activo','iniciando',3),(9,18,'alumno','activo','iniciando',3),(10,22,'alumno','inactivo','iniciando',3),(11,22,'Alumno','activo','iniciando',2),(12,22,'Alumno','inactivo','iniciando',1),(15,23,'profesor','activo','iniciando',1),(16,24,'profesor','activo','iniciando',3),(17,25,'profesor','inactivo','iniciando',3),(18,26,'alumno','activo','iniciando',3),(19,27,'alumno','activo','iniciando',4),(20,28,'alumno','inactivo','iniciando',1),(21,29,'alumno','activo','iniciando',3),(22,30,'alumno','inactivo','iniciando',3),(23,31,'profesor','activo','iniciando',3),(24,16,'Alumno','activo','iniciando',1),(25,32,'alumno','activo','iniciando',1);
/*!40000 ALTER TABLE `personasxcursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profesoresxmaterias`
--

DROP TABLE IF EXISTS `profesoresxmaterias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profesoresxmaterias` (
  `id_profesorxmateria` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_materia` int(10) unsigned NOT NULL,
  `id_personaxcurso` int(10) unsigned NOT NULL,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_profesorxmateria`),
  KEY `fk_profesoresxmaterias_materias1_idx` (`id_materia`),
  KEY `fk_profesoresxmaterias_personasxcursos1_idx` (`id_personaxcurso`),
  CONSTRAINT `fk_profesoresxmaterias_materias1` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_profesoresxmaterias_personasxcursos1` FOREIGN KEY (`id_personaxcurso`) REFERENCES `personasxcursos` (`id_personaxcurso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profesoresxmaterias`
--

LOCK TABLES `profesoresxmaterias` WRITE;
/*!40000 ALTER TABLE `profesoresxmaterias` DISABLE KEYS */;
INSERT INTO `profesoresxmaterias` VALUES (1,1,15,'activo'),(2,2,15,'activo'),(4,3,23,'inactivo'),(5,5,16,'activo'),(6,3,16,'activo');
/*!40000 ALTER TABLE `profesoresxmaterias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sedes`
--

DROP TABLE IF EXISTS `sedes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sedes` (
  `id_sede` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_sede` varchar(45) DEFAULT NULL,
  `domicilio` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `observacion` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id_sede`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sedes`
--

LOCK TABLES `sedes` WRITE;
/*!40000 ALTER TABLE `sedes` DISABLE KEYS */;
INSERT INTO `sedes` VALUES (1,'DoloresLaValle','calle123','activo','buena'),(2,'San Juan','lospatos','activo',''),(3,'San Fran','pedro echague','activo',NULL),(4,'cambio','123','activo','buenaa'),(5,'san benito','los nogales','activo','dos'),(6,'timoteo','1221','inactivo','sin observar'),(7,'hapo','4321','inactivo','sin observar'),(8,'ad','323','inactivo','sads'),(9,'hola','por12s','inactivo','muy buenad'),(10,'sanmartin','dsd34','inactivo','bueno'),(11,'belgrano','colo1','inactivo','s');
/*!40000 ALTER TABLE `sedes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'cfpnueva'
--
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarCurso`(in IdCurso int(10),in nom varchar(50),in obs varchar(300),in IdSede int(10),in Emp int(10))
BEGIN



if Emp=1 then
	update cursosxsedes set estado="inactivo" where id_curso=IdCurso;
else
	update cursos set nombre_curso=nom,observacion=obs where id_curso=IdCurso;
	set @existe=0;
	select count(*) into @existe from cursosxsedes where id_curso=IdCurso and id_sede=IdSede;
	if @existe=0 then

		insert into cursosxsedes (id_curso,id_sede,estado) values (IdCurso,IdSede,"activo");
	else
		update cursosxsedes set estado="activo" where id_curso=IdCurso and id_sede=IdSede;
	end if;
	
	
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarMateria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarMateria`(in IdMateria int(10),in nom varchar(30),in obs varchar(1000))
BEGIN
update materias set nombre_materia=nom,observacion=obs where id_materia=idMateria;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarPersona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarPersona`(in IdPersona int(10),in nom varchar(30),in ape varchar(30),in dn int(10),in sex varchar(20),in tel int(20),in dom varchar(30),in cor varchar(40),in fecha date,in loc varchar(30))
BEGIN

update personas set nombre=nom,apellido=ape,dni=dn,sexo=sex,telefono=tel,domicilio=dom,correo=cor,fechadenac=fecha,localidad=loc where id_persona=IdPersona;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarSede` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarSede`(in nom varchar(50),in dom varchar(50),in obs varchar(50),in IdSede int(50))
BEGIN
update sedes set nombre_sede=nom,domicilio=dom,observacion=obs where id_sede=IdSede;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AgregarCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarCurso`(in nom varchar(50),in obs varchar(50),in IdSede int(10),in ningunasede int(10))
BEGIN
set @existe=0;
select count(*) into @existe from cursos where nombre_curso=nom;
if @existe=0 then
insert cursos(nombre_curso,observacion,estado) values (nom,obs,"activo");
end if;
set @id=0;
select max(id_curso) into @id from cursos;
if ningunasede=0 then
insert cursosxsedes (id_sede,id_curso,estado) values (IdSede,@id,"activo");
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AgregarMateria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarMateria`(in nom varchar(50),in obs varchar(50),in IdCurso int(10))
BEGIN
insert materias (nombre_materia,observacion,id_curso,estado) values (nom,obs,IdCurso,"activo");
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AgregarNota` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarNota`(in IdPersona int(10),in IdMateria int(10),in IdCurso int(10),in IdSede int(10),in anota int(10))
BEGIN
set @IdCursoXSede=0;
set @existe=0;
set @IdPersonaXCurso=0;
select id_cursoxsede into @IdCursoXSede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo";

select id_personaxcurso into @IdPersonaXCurso from personasxcursos where id_persona=IdPersona and id_cursoxsede=@IdCursoXSede and estado="activo" and tipo_persona="alumno";

select count(*) into @existe from alumnosxmaterias where id_materia=IdMateria and id_personaxcurso=@IdPersonaXCurso; 
if @existe=0 then
insert alumnosxmaterias (id_materia,id_personaxcurso,nota) values (IdMateria,@IdPersonaXCurso,anota);
else
update alumnosxmaterias set nota=anota where id_materia=IdMateria and id_personaxcurso=@IdPersonaXCurso;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AgregarPersonas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarPersonas`(in nom varchar(30),in ape varchar(30),in dn int(10),in sex varchar(20),in tel int(20),in dom varchar(30),in cor varchar(40),in fecha date,in loc varchar(30),in tipo varchar(20),in IdSede int(10),in IdCurso int(10))
BEGIN

set @existe=0;
set @idp=0;

select count(*) into @existe from personas where dni=dn;
select id_persona into @idp from personas where dni=dn; 





if @existe=1 then
insert into personasxcursos(id_persona,id_cursoxsede,estado,tipo_persona,observacion) values (@idp,(select id_cursoxsede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo"),"activo",tipo,"iniciando");


else
	insert into personas (nombre,apellido,dni,sexo,telefono,domicilio,correo,fechadenac,localidad,estado) values(nom,ape,dn,sex,tel,dom,cor,fecha,loc,"activo");


	set @id=0;
	select max(id_persona) into @id from personas;

		if tipo="profesor" then
		insert into personasxcursos(id_persona,id_cursoxsede,estado,tipo_persona,observacion) values (@id,(select id_cursoxsede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo"),"activo","profesor","iniciando");
		else
		insert into personasxcursos(id_persona,id_cursoxsede,estado,tipo_persona,observacion) values (@id,(select id_cursoxsede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo"),"activo","alumno","iniciando");
	end if;

end if;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AgregarSede` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarSede`(in nom varchar(50),in dom varchar(50),in obs varchar(50))
BEGIN
insert into sedes(nombre_sede,domicilio,estado,observacion) values(nom,dom,"activo",obs);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Corrigido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Corrigido`(in IdPersona int(10),in IdMateria int(10),in IdCurso int(10),in IdSede int(10))
BEGIN
set @IdPersonaXCurso=0;
set @existe=0;
set @IdCursoXSede=0;

select id_cursoxsede into @IdCursoXSede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo";
select id_personaxcurso into @IdPersonaXCurso from personasxcursos where id_persona=IdPersona and id_cursoxsede=@IdCursoXSede and estado="activo" and tipo_persona="profesor";
update profesoresxmaterias set estado="inactivo" where id_personaxcurso=any(select id_personaxcurso from personasxcursos where id_cursoxsede=@IdCursoXSede and estado="activo") and id_materia=IdMateria;
select count(*) into @existe from profesoresxmaterias where id_materia=IdMateria and id_personaxcurso=@IdPersonaXCurso;
if @existe=0 then
insert profesoresxmaterias (id_materia,id_personaxcurso,estado) values (IdMateria,@IdPersonaXCurso,"activo");
else
update profesoresxmaterias set estado="activo" where id_materia=IdMateria and id_personaxcurso=@IdPersonaXCurso;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CursoDisponibleXSede` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CursoDisponibleXSede`(in IdSede int(10))
BEGIN
select c.id_curso,c.nombre_curso from cursos c,cursosxsedes cxs where cxs.id_sede=IdSede and c.id_curso=cxs.id_curso;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Desactivar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Desactivar`(in Id int(10),in Tabla varchar(30))
BEGIN
if Tabla="sedes" then
update sedes set estado='inactivo' where id_sede=Id;
end if;
if Tabla="cursos" then
update cursos set estado='inactivo' where id_curso=Id;
end if;
if Tabla="materias" then
update materias set estado='inactivo' where id_materia=Id;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DesactivarPersona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DesactivarPersona`(in Id int(10),in IdSede int(10),in IdCurso int(10))
BEGIN
update personasxcursos set estado="inactivo" where id_persona=Id and id_cursoxsede=(select id_cursoxsede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo");
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ExisteNombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ExisteNombre`(in nom varchar(50),in tabla varchar(50))
BEGIN
if tabla="sedes" then
select*from sedes where nombre_sede=nom;
end if;
if tabla="cursos" then
select*from cursos where nombre_curso=nom;
end if;

if tabla="materias" then
select*from materias where nombre_materia=nom;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MostrarCorregido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCorregido`(in IdSede int(10),in IdCurso int(10))
BEGIN
select id_cursoxsede into @IdCursoXSede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo";


select p.nombre,p.apellido,m.nombre_materia,"Corregio" from personas p,profesoresxmaterias pxm,materias m,personasxcursos pxc where m.id_materia=pxm.id_materia and p.id_persona=pxc.id_persona and pxm.id_personaxcurso=pxc.id_personaxcurso and pxc.id_cursoxsede=@IdCursoXSede and pxc.estado="activo" and pxc.tipo_persona="profesor" and pxm.estado="activo" and m.estado="activo"; 


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MostrarNotas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarNotas`(in IdCurso int(10),in IdSede int(10))
BEGIN


select id_cursoxsede into @IdCursoXSede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo";


select p.nombre,p.apellido from personas p,alumnosxmaterias axm,materias m,personasxcursos pxc where m.id_materia=axm.id_materia and p.id_persona=pxc.id_persona and axm.id_personaxcurso=pxc.id_personaxcurso and pxc.id_cursoxsede=@IdCursoXSede and pxc.estado="activo" and pxc.tipo_persona="alumno" and m.estado="activo"; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SedesDisponible` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SedesDisponible`(in Curso varchar(50))
BEGIN
select s.nombre_sede as sede from cursosxsedes cxs,cursos c,sedes s where s.id_sede=cxs.id_sede and c.id_curso=cxs.id_curso and c.nombre_curso=Curso and cxs.estado="activo" and s.estado="activo";
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TraerMateria` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TraerMateria`(in IdCurso int(10))
BEGIN
select nombre_materia from materias where Id_curso=IdCurso and estado="activo" order by nombre_materia;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TraerPersona` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TraerPersona`(in IdCurso int(10),in IdSede int(10),in Tpersona varchar(30))
BEGIN
if (IdCurso=0 and IdSede=0) then
select p.id_persona,p.nombre,p.apellido,p.sexo,p.dni,p.telefono,p.localidad,p.domicilio,p.correo,p.fechadenac as 'Fecha de nacimiento' from personas p,personasxcursos pxc where p.id_persona=pxc.id_persona and pxc.estado="activo" and pxc.tipo_persona=Tpersona;
end if;
if IdSede>0 && IdCurso=0 then
select p.id_persona,p.nombre,p.apellido,p.sexo,p.dni,p.telefono,p.localidad,p.domicilio,p.correo,p.fechadenac as 'Fecha de nacimiento' from personas p,personasxcursos pxc where p.id_persona=pxc.id_persona and pxc.estado="activo" and pxc.tipo_persona=Tpersona and pxc.id_cursoxsede=any(select id_cursoxsede from cursosxsedes where id_sede=Idsede and estado="activo");
end if;

if (IdCurso>0 and IdSede>0) then
select p.id_persona,p.nombre,p.apellido,p.sexo,p.dni,p.telefono,p.localidad,p.domicilio,p.correo,p.fechadenac as 'Fecha de nacimiento' from personas p,personasxcursos pxc where p.id_persona=pxc.id_persona and pxc.estado="activo" and pxc.tipo_persona=Tpersona and pxc.id_cursoxsede=any(select id_cursoxsede from cursosxsedes where id_sede=Idsede and id_curso=Idcurso and estado="activo");
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TraerTodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TraerTodo`(in tabla varchar(50),in IdMcurso int(10))
BEGIN
if tabla="sedes" then
select*from sedes where estado="activo";
end if;
if tabla="Lsedes" then
select nombre_sede as Nombre,domicilio,observacion from sedes where estado="activo";
end if;
if tabla="cursos" then
select*from cursos where estado="activo";
end if;
if tabla="Lcursos" then
select nombre_curso as Nombre,observacion from cursos where estado="activo";
end if;
if tabla="materias" then
select*from materias where estado="activo" and id_curso=IdMcurso;
end if;

if tabla="Lmaterias" then
select nombre_materia,observacion from materias where estado="activo" and id_curso=IdMcurso;
end if;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TraerUnaNota` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TraerUnaNota`(in IdPersona int(10),in IdMateria int(10),in IdCurso int(10),in IdSede int(10))
BEGIN
set @IdCursoXSede=0;
set @IdPersonaXCurso=0;
select id_cursoxsede into @IdCursoXSede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo";
select id_personaxcurso into @IdPersonaXCurso from personasxcursos where id_persona=IdPersona and id_cursoxsede=@IdCursoXSede and estado="activo" and tipo_persona="alumno";

select nota from alumnosxmaterias where id_materia=IdMateria and id_personaxcurso=@IdPersonaXCurso; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `TraerUno` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `TraerUno`(in Id int(10),in tabla varchar(50))
BEGIN
if tabla="sedes" then
select*from sedes where id_sede=Id;
end if;
if tabla="cursos" then
select*from cursos where id_curso=Id;
end if;
if tabla="materias" then
select*from materias where id_materia=Id;
end if;





END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `materiass`
--

/*!50001 DROP VIEW IF EXISTS `materiass`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `materiass` AS select `materias`.`nombre_materia` AS `nombre_materia` from `materias` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-24  6:43:29
