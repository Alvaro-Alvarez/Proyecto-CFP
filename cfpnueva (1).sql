-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-10-2016 a las 14:08:58
-- Versión del servidor: 5.5.36
-- Versión de PHP: 5.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `cfpnueva`
--

DELIMITER $$
--
-- Procedimientos
--
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarMateria`(in IdMateria int(10),in nom varchar(30),in obs varchar(1000))
BEGIN
update materias set nombre_materia=nom,observacion=obs where id_materia=idMateria;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarPersona`(in IdPersona int(10),in nom varchar(30),in ape varchar(30),in dn int(10),in sex varchar(20),in tel int(20),in dom varchar(30),in cor varchar(40),in fecha date,in loc varchar(30))
BEGIN

update personas set nombre=nom,apellido=ape,dni=dn,sexo=sex,telefono=tel,domicilio=dom,correo=cor,fechadenac=fecha,localidad=loc where id_persona=IdPersona;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarSede`(in nom varchar(50),in dom varchar(50),in obs varchar(50),in IdSede int(50))
BEGIN
update sedes set nombre_sede=nom,domicilio=dom,observacion=obs where id_sede=IdSede;
END$$

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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarMateria`(in nom varchar(50),in obs varchar(50),in IdCurso int(10))
BEGIN
insert materias (nombre_materia,observacion,id_curso,estado) values (nom,obs,IdCurso,"activo");
END$$

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
END$$

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


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarSede`(in nom varchar(50),in dom varchar(50),in obs varchar(50))
BEGIN
insert into sedes(nombre_sede,domicilio,estado,observacion) values(nom,dom,"activo",obs);

END$$

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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CursoDisponibleXSede`(in IdSede int(10))
BEGIN
select c.id_curso,c.nombre_curso from cursos c,cursosxsedes cxs where cxs.id_sede=IdSede and c.id_curso=cxs.id_curso;
END$$

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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DesactivarPersona`(in Id int(10),in IdSede int(10),in IdCurso int(10))
BEGIN
update personasxcursos set estado="inactivo" where id_persona=Id and id_cursoxsede=(select id_cursoxsede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo");
END$$

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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarCorregido`(in IdSede int(10),in IdCurso int(10))
BEGIN
select id_cursoxsede into @IdCursoXSede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo";


select p.nombre,p.apellido,m.nombre_materia,"Corregio" from personas p,profesoresxmaterias pxm,materias m,personasxcursos pxc where m.id_materia=pxm.id_materia and p.id_persona=pxc.id_persona and pxm.id_personaxcurso=pxc.id_personaxcurso and pxc.id_cursoxsede=@IdCursoXSede and pxc.estado="activo" and pxc.tipo_persona="profesor" and pxm.estado="activo" and m.estado="activo"; 


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarNotas`(IN `IdCurso` INT(10), IN `IdSede` INT(10), IN `IdMateria` INT(10))
BEGIN


select id_cursoxsede into @IdCursoXSede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo";

if IdMateria=0 then
select m.nombre_materia as 'Materias',p.nombre,p.apellido,axm.nota from personas p,alumnosxmaterias axm,materias m,personasxcursos pxc where m.id_materia=axm.id_materia and p.id_persona=pxc.id_persona and axm.id_personaxcurso=pxc.id_personaxcurso and pxc.id_cursoxsede=@IdCursoXSede and pxc.estado="activo" and pxc.tipo_persona="alumno" and m.estado="activo"; 
else
select p.nombre,p.apellido,axm.nota from personas p,alumnosxmaterias axm,materias m,personasxcursos pxc where m.id_materia=axm.id_materia and p.id_persona=pxc.id_persona and axm.id_personaxcurso=pxc.id_personaxcurso and pxc.id_cursoxsede=@IdCursoXSede and pxc.estado="activo" and pxc.tipo_persona="alumno" and m.estado="activo" and m.id_materia=IdMateria; 
end if;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SedesDisponible`(in Curso varchar(50))
BEGIN
select s.nombre_sede as sede from cursosxsedes cxs,cursos c,sedes s where s.id_sede=cxs.id_sede and c.id_curso=cxs.id_curso and c.nombre_curso=Curso and cxs.estado="activo" and s.estado="activo";
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TraerMateria`(in IdCurso int(10))
BEGIN
select nombre_materia from materias where Id_curso=IdCurso and estado="activo" order by nombre_materia;
END$$

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
END$$

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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TraerUnaNota`(in IdPersona int(10),in IdMateria int(10),in IdCurso int(10),in IdSede int(10))
BEGIN
set @IdCursoXSede=0;
set @IdPersonaXCurso=0;
select id_cursoxsede into @IdCursoXSede from cursosxsedes where id_curso=IdCurso and id_sede=IdSede and estado="activo";
select id_personaxcurso into @IdPersonaXCurso from personasxcursos where id_persona=IdPersona and id_cursoxsede=@IdCursoXSede and estado="activo" and tipo_persona="alumno";

select nota from alumnosxmaterias where id_materia=IdMateria and id_personaxcurso=@IdPersonaXCurso; 

END$$

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





END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnosxmaterias`
--

CREATE TABLE IF NOT EXISTS `alumnosxmaterias` (
  `id_alumnoxmateria` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_materia` int(10) unsigned NOT NULL,
  `nota` int(10) DEFAULT NULL,
  `id_personaxcurso` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_alumnoxmateria`),
  KEY `fk_AlumnosXMaterias_Materias1_idx` (`id_materia`),
  KEY `fk_AlumnosXMaterias_PersonasXMateria1_idx` (`id_personaxcurso`),
  KEY `fk_AlumnosXMaterias_idx` (`id_personaxcurso`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Volcado de datos para la tabla `alumnosxmaterias`
--

INSERT INTO `alumnosxmaterias` (`id_alumnoxmateria`, `id_materia`, `nota`, `id_personaxcurso`) VALUES
(13, 2, 6, 7),
(14, 3, 10, 8),
(15, 5, 5, 8),
(16, 3, 4, 9),
(17, 1, 10, 1),
(18, 1, 6, 7),
(19, 2, 10, 1),
(20, 1, 4, 24),
(21, 2, 4, 24),
(22, 1, 2, 25),
(23, 2, 2, 25),
(24, 5, 10, 21);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE IF NOT EXISTS `cursos` (
  `id_curso` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_curso` varchar(45) DEFAULT NULL,
  `observacion` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_curso`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id_curso`, `nombre_curso`, `observacion`, `estado`) VALUES
(1, 'programador', 'se basa en programacion', 'activo'),
(2, 'operador', 'se basa en operaciones', 'activo'),
(28, 'nada', 'feo', 'inactivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursosxsedes`
--

CREATE TABLE IF NOT EXISTS `cursosxsedes` (
  `id_cursoxsede` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_sede` int(10) unsigned NOT NULL,
  `id_curso` int(10) unsigned NOT NULL,
  `estado` varchar(700) DEFAULT NULL,
  PRIMARY KEY (`id_cursoxsede`),
  KEY `fk_CursosXSedes_Sedes_idx` (`id_sede`),
  KEY `fk_CursosXSedes_Cursos1_idx` (`id_curso`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `cursosxsedes`
--

INSERT INTO `cursosxsedes` (`id_cursoxsede`, `id_sede`, `id_curso`, `estado`) VALUES
(1, 1, 1, 'activo'),
(2, 2, 1, 'activo'),
(3, 1, 2, 'activo'),
(4, 2, 2, 'activo'),
(5, 3, 1, 'activo'),
(6, 4, 1, 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materias`
--

CREATE TABLE IF NOT EXISTS `materias` (
  `id_materia` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_materia` varchar(45) DEFAULT NULL,
  `id_curso` int(10) unsigned NOT NULL,
  `observacion` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_materia`),
  KEY `fk_Materias_Cursos1_idx` (`id_curso`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `materias`
--

INSERT INTO `materias` (`id_materia`, `nombre_materia`, `id_curso`, `observacion`, `estado`) VALUES
(1, 'c', 1, 'c++', 'activo'),
(2, 'html', 1, 'cc', 'activo'),
(3, 'matematica', 2, 'calculos', 'activo'),
(4, 'lengua', 2, 'literatura', 'inactivo'),
(5, 'economia', 2, 'numeros', 'activo');

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `materiass`
--
CREATE TABLE IF NOT EXISTS `materiass` (
`nombre_materia` varchar(45)
);
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE IF NOT EXISTS `personas` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=33 ;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id_persona`, `nombre`, `apellido`, `dni`, `sexo`, `telefono`, `domicilio`, `correo`, `fechadenac`, `localidad`, `estado`) VALUES
(6, 'adan', 'kevin', 12, 'Hombre', 323, 'caba12', 'adan23', '2016-10-10', 'CABA', 'activo'),
(7, 'andy', 'lleeld', 31, 'Hombre', 44, 'don12', 'andu', '2016-10-11', 'San Martin', 'activo'),
(8, 'andaa', 'lleeldds', 31, 'Hombre', 44, 'don12sd', 'andu', '2016-10-11', 'San Martin', 'activo'),
(9, 'andy', 'lleeld', 3, 'Hombre', 44, 'don12', 'andu', '2016-10-11', 'San Martin', 'activo'),
(10, 'andy', 'lleeld', 3, 'Hombre', 44, 'don12', 'andu', '2016-10-11', 'San Martin', 'activo'),
(11, 'andy', 'lleeld', 76, 'Hombre', 44, 'don12', 'andu', '2016-10-11', 'San Martin', 'activo'),
(12, 'andy', 'lleeld', 79, 'Hombre', 44, 'don12', 'andu', '2016-10-11', 'San Martin', 'activo'),
(13, 'andydsgff', 'lleeldsd', 1, 'Hombre', 44, 'don12', 'andu', '2016-10-11', 'CABA', 'activo'),
(14, 'adan', 'kevins', 121443, 'Hombre', 323, 'caba12', 'adan23', '1990-01-30', 'CABA', 'activo'),
(16, 'leandro', 'perez', 98, 'Hombre', 3123, 'leandro12', 'leandro', '2016-10-20', 'CABA', 'activo'),
(18, 'koly', 'sdsd', 2345, 'Hombre', 12, 'dss', 'ada', '2016-10-07', 'CABA', 'activo'),
(22, 'adan', 'kevin', 6765, 'Mujer', 2334, 'sd43', 'asdsd', '2016-10-11', 'CABA', 'activo'),
(23, 'mou', 'ham', 23948, 'Hombre', 4345, 'dom23', 'ada', '2016-10-12', 'CABA', 'activo'),
(24, 'aca', 'ham', 34894, 'Hombre', 4345, 'dom23', 'ada', '2016-10-12', 'CABA', 'activo'),
(25, 'acam', 'ham', 34894, 'Hombre', 4345, 'dom23', 'ada', '2016-10-12', 'CABA', 'activo'),
(26, 'gonzalo', 'qwe', 98435, 'Hombre', 2334, 'sd43', 'asdsd', '2016-10-11', 'CABA', 'activo'),
(27, 'tomas ', 'mierdini', 43289, 'Mujer', 4343, 'fdjid434', 'adssd', '1811-03-13', 'Quilmes', 'activo'),
(28, 'dsoif', 'kevins', 1254, 'Hombre', 323, 'caba12', 'adan23', '1990-01-30', 'CABA', 'activo'),
(29, 'Alicia', 'Ayma', 23983442, 'Mujer', 46935117, 'Calle Faldsa 123', 'aliciaayma@hotmail.com', '1998-03-10', 'Lomas de zamora', 'activo'),
(30, 'sandro', 'pod', 8923849, 'Hombre', 4343443, 'fosd34', 'adakjf', '2009-02-03', 'Alimirante Brown', 'activo'),
(31, 'jose', 'lopez', 123, 'Hombre', 4343, 'domi123', 'jose_el', '2016-10-15', 'CABA', 'activo'),
(32, 'portacus', 'ge', 32434, 'Hombre', 34, 'asd12', 'asd', '2016-10-04', 'CABA', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personasxcursos`
--

CREATE TABLE IF NOT EXISTS `personasxcursos` (
  `id_personaxcurso` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_persona` int(10) unsigned NOT NULL,
  `tipo_persona` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `observacion` varchar(45) DEFAULT NULL,
  `id_cursoxsede` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_personaxcurso`),
  KEY `fk_alumnosxcursos_personas1_idx` (`id_persona`),
  KEY `fk_personasxcursos_cursosxsedes1_idx` (`id_cursoxsede`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=26 ;

--
-- Volcado de datos para la tabla `personasxcursos`
--

INSERT INTO `personasxcursos` (`id_personaxcurso`, `id_persona`, `tipo_persona`, `estado`, `observacion`, `id_cursoxsede`) VALUES
(1, 6, 'alumno', 'activo', 'iniciando', 1),
(2, 7, 'alumno', 'activo', 'iniciando', 2),
(3, 9, 'alumno', 'activo', 'iniciando', 2),
(4, 11, 'alumno', 'activo', 'iniciando', 2),
(5, 12, 'alumno', 'activo', 'iniciando', 2),
(6, 13, 'alumno', 'inactivo', 'iniciando', 2),
(7, 14, 'alumno', 'inactivo', 'iniciando', 1),
(8, 16, 'alumno', 'activo', 'iniciando', 3),
(9, 18, 'alumno', 'activo', 'iniciando', 3),
(10, 22, 'alumno', 'inactivo', 'iniciando', 3),
(11, 22, 'Alumno', 'activo', 'iniciando', 2),
(12, 22, 'Alumno', 'inactivo', 'iniciando', 1),
(15, 23, 'profesor', 'activo', 'iniciando', 1),
(16, 24, 'profesor', 'activo', 'iniciando', 3),
(17, 25, 'profesor', 'inactivo', 'iniciando', 3),
(18, 26, 'alumno', 'activo', 'iniciando', 3),
(19, 27, 'alumno', 'activo', 'iniciando', 4),
(20, 28, 'alumno', 'inactivo', 'iniciando', 1),
(21, 29, 'alumno', 'activo', 'iniciando', 3),
(22, 30, 'alumno', 'inactivo', 'iniciando', 3),
(23, 31, 'profesor', 'activo', 'iniciando', 3),
(24, 16, 'Alumno', 'activo', 'iniciando', 1),
(25, 32, 'alumno', 'activo', 'iniciando', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesoresxmaterias`
--

CREATE TABLE IF NOT EXISTS `profesoresxmaterias` (
  `id_profesorxmateria` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_materia` int(10) unsigned NOT NULL,
  `id_personaxcurso` int(10) unsigned NOT NULL,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_profesorxmateria`),
  KEY `fk_profesoresxmaterias_materias1_idx` (`id_materia`),
  KEY `fk_profesoresxmaterias_personasxcursos1_idx` (`id_personaxcurso`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `profesoresxmaterias`
--

INSERT INTO `profesoresxmaterias` (`id_profesorxmateria`, `id_materia`, `id_personaxcurso`, `estado`) VALUES
(1, 1, 15, 'activo'),
(2, 2, 15, 'activo'),
(4, 3, 23, 'inactivo'),
(5, 5, 16, 'inactivo'),
(6, 3, 16, 'activo'),
(7, 5, 23, 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sedes`
--

CREATE TABLE IF NOT EXISTS `sedes` (
  `id_sede` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nombre_sede` varchar(45) DEFAULT NULL,
  `domicilio` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `observacion` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id_sede`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Volcado de datos para la tabla `sedes`
--

INSERT INTO `sedes` (`id_sede`, `nombre_sede`, `domicilio`, `estado`, `observacion`) VALUES
(1, 'DoloresLaValle', 'calle123', 'activo', 'buena'),
(2, 'San Juan', 'lospatos', 'activo', ''),
(3, 'San Fran', 'pedro echague', 'activo', NULL),
(4, 'cambio', '123', 'activo', 'buenaa'),
(5, 'san benito', 'los nogales', 'activo', 'dos'),
(6, 'timoteo', '1221', 'inactivo', 'sin observar'),
(7, 'hapo', '4321', 'inactivo', 'sin observar'),
(8, 'ad', '323', 'inactivo', 'sads'),
(9, 'hola', 'por12s', 'inactivo', 'muy buenad'),
(10, 'sanmartin', 'dsd34', 'inactivo', 'bueno'),
(11, 'belgrano', 'colo1', 'inactivo', 's');

-- --------------------------------------------------------

--
-- Estructura para la vista `materiass`
--
DROP TABLE IF EXISTS `materiass`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `materiass` AS select `materias`.`nombre_materia` AS `nombre_materia` from `materias`;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumnosxmaterias`
--
ALTER TABLE `alumnosxmaterias`
  ADD CONSTRAINT `fk_AlumnosXMaterias_Materias1` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cursosxsedes`
--
ALTER TABLE `cursosxsedes`
  ADD CONSTRAINT `fk_CursosXSedes_Cursos1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_CursosXSedes_Sedes` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`id_sede`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `materias`
--
ALTER TABLE `materias`
  ADD CONSTRAINT `fk_Materias_Cursos1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `personasxcursos`
--
ALTER TABLE `personasxcursos`
  ADD CONSTRAINT `fk_alumnosxcursos_personas1` FOREIGN KEY (`id_persona`) REFERENCES `personas` (`id_persona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_personasxcursos_cursosxsedes1` FOREIGN KEY (`id_cursoxsede`) REFERENCES `cursosxsedes` (`id_cursoxsede`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `profesoresxmaterias`
--
ALTER TABLE `profesoresxmaterias`
  ADD CONSTRAINT `fk_profesoresxmaterias_materias1` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_profesoresxmaterias_personasxcursos1` FOREIGN KEY (`id_personaxcurso`) REFERENCES `personasxcursos` (`id_personaxcurso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
