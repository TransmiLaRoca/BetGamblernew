DROP DATABASE IF EXISTS 5to_BetGambler;
CREATE DATABASE 5to_BetGambler;
USE 5to_BetGambler;
CREATE TABLE Continente(
	idContinente TINYINT PRIMARY KEY,
	continente VARCHAR(30)
);

CREATE TABLE Pais(
	idPais TINYINT PRIMARY KEY,
	pais VARCHAR(30),
	idContinente TINYINT,
	CONSTRAINT FK_CONTINENTE_PAIS FOREIGN KEY (idContinente)
	REFERENCES Continente(idContinente)
);

CREATE TABLE Foto(
	idFoto INT PRIMARY KEY,
	nombreArchivo VARCHAR(300),
	tamaño INT,
	ubicacion VARCHAR(300)
);

CREATE TABLE Estadio(
	idEstadio TINYINT PRIMARY KEY,
	nombre VARCHAR(30),
	informacion VARCHAR(60)
);

CREATE TABLE Estado_Partido(
	idEstado SMALLINT UNSIGNED PRIMARY KEY,
	estado VARCHAR(30)
);

CREATE TABLE Temporada(
	idTemporada TINYINT PRIMARY KEY AUTO_INCREMENT,
	temporada VARCHAR(10)
);

CREATE TABLE Fecha_Partido(
	idFecha TINYINT PRIMARY KEY AUTO_INCREMENT,
	idTemporada TINYINT,
	fecha INT,
	CONSTRAINT FK_TEMPORADA_PARTIDO FOREIGN KEY (idTemporada)
	REFERENCES Temporada(idTemporada)
);

CREATE TABLE Liga(
	idLiga TINYINT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(30),
	idTemporada TINYINT,
	idPais TINYINT,
	CONSTRAINT FK_LIGA_TEMPORADA FOREIGN KEY (idTemporada)
	REFERENCES Temporada(idTemporada),
	CONSTRAINT FK_LIGA_PAIS FOREIGN KEY (idPais)
	REFERENCES Pais(idPais)
);

CREATE TABLE Copa(
	idCopa TINYINT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(30),
	idTemporada TINYINT,
	idContinente TINYINT,
	CONSTRAINT FK_COPA_TEMPORADA FOREIGN KEY (idTemporada)
	REFERENCES Temporada(idTemporada),
	CONSTRAINT FK_COPA_CONTINENTE FOREIGN KEY (idContinente)
	REFERENCES Continente(idContinente)
);

CREATE TABLE Equipo(
	idEquipo TINYINT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(30),
	idPais TINYINT,
	entrenador VARCHAR(20),
	CONSTRAINT FK_PAIS_EQUIPO FOREIGN KEY (idPais)
	REFERENCES Pais(idPais)
);

CREATE TABLE Jugador_Liga(
	idLiga TINYINT PRIMARY KEY,
	idEquipo TINYINT,
	CONSTRAINT FK_LIGA_JUGADOR FOREIGN KEY (idLiga)
	REFERENCES Liga(idLiga),
	CONSTRAINT FK_EQUIPO_JUGADOR FOREIGN KEY (idEquipo)
	REFERENCES Equipo(idEquipo)
);

CREATE TABLE Jugador_Copa(
	idCopa TINYINT PRIMARY KEY,
	idEquipo TINYINT,
	CONSTRAINT FK_COPA_JUGADOR FOREIGN KEY (idCopa)
	REFERENCES Copa(idCopa),
	CONSTRAINT FK_EQUIPO_JUGADOR1 FOREIGN KEY (idEquipo)
	REFERENCES Equipo(idEquipo)
);

CREATE TABLE Partido(
	idPartido TINYINT PRIMARY KEY AUTO_INCREMENT,
	equipo_local TINYINT,
	equipo_visitante TINYINT,
	idFecha TINYINT,
	idEstadio TINYINT,
	idEstado SMALLINT UNSIGNED,
	CONSTRAINT FK_EQUIPO_LOCAL FOREIGN KEY (equipo_local)
	REFERENCES Equipo(idEquipo),
	CONSTRAINT FK_EQUIPO_VISITANTE FOREIGN KEY (equipo_visitante)
	REFERENCES Equipo(idEquipo),
	CONSTRAINT FK_FECHA_PARTIDO FOREIGN KEY (idFecha)
	REFERENCES Fecha_Partido(idFecha),
	CONSTRAINT FK_ESTADIO_PARTIDO FOREIGN KEY (idEstadio)
	REFERENCES Estadio(idEstadio),
	CONSTRAINT FK_ESTADO_PARTIDO FOREIGN KEY (idEstado)
	REFERENCES Estado_Partido (idEstado)
);

CREATE TABLE Gol(
	idGol TINYINT AUTO_INCREMENT,
	idEquipo TINYINT,
	idPartido TINYINT,
	minuto SMALLINT,
	PRIMARY KEY (idGol, idEquipo, idPartido),
	CONSTRAINT FK_EQUIPO_GOL FOREIGN KEY (idEquipo)
	REFERENCES Equipo(idEquipo),
	CONSTRAINT FK_PARTIDO_GOL FOREIGN KEY (idPartido)
	REFERENCES Partido(idPartido)
);
CREATE TABLE Partido_Copa(
idPartido TINYINT PRIMARY KEY,
idCopa TINYINT,
CONSTRAINT FK_COPA_PARTIDO FOREIGN KEY (idCopa)
REFERENCES Copa(idCopa),
CONSTRAINT FK_COPA_PARTIDO1 FOREIGN KEY (idPartido)
REFERENCES Partido(idPartido)
);
CREATE TABLE Partido_Liga(
idPartido TINYINT PRIMARY KEY,
idLiga TINYINT,
CONSTRAINT FK_LIGA_PARTIDO FOREIGN KEY (idLiga)
REFERENCES Liga(idLiga),
CONSTRAINT FK_LIGA_PARTIDO1 FOREIGN KEY (idPartido)
REFERENCES Partido(idPartido)
);
CREATE TABLE Ganador_Copa(
idEquipo TINYINT,
idCopa TINYINT,
idTemporada TINYINT,
PRIMARY KEY(idEquipo, idCopa, idTemporada),
CONSTRAINT FK_COPA_GANADOR FOREIGN KEY (idCopa)
REFERENCES Copa(idCopa),
CONSTRAINT FK_EQUIPO_GANADOR FOREIGN KEY (idEquipo)
REFERENCES Equipo(idEquipo),
CONSTRAINT FK_TEMPORADA_GANADOR FOREIGN KEY (idTemporada)
REFERENCES Temporada(idTemporada)
);
CREATE TABLE Ganador_Liga(
idEquipo TINYINT,
idLiga TINYINT,
idTemporada TINYINT,
PRIMARY KEY(idEquipo, idLiga, idTemporada),
CONSTRAINT FK_LIGA_GANADOR FOREIGN KEY (idLiga)
REFERENCES Liga(idLiga),
CONSTRAINT FK_EQUIPO_GANADOR1 FOREIGN KEY (idEquipo)
REFERENCES Equipo(idEquipo),
CONSTRAINT FK_TEMPORADA_GANADOR1 FOREIGN KEY (idTemporada)
REFERENCES Temporada(idTemporada)
);
CREATE TABLE Resultado_Partido(
idPartido TINYINT PRIMARY KEY,
resultado int,
CONSTRAINT FK_RESULTADO_PARTIDO FOREIGN KEY (idPartido)
REFERENCES Partido(idPartido)
);
CREATE TABLE Usuario(
	idUsuario TINYINT AUTO_INCREMENT,
	contra CHAR(20),
	nombre VARCHAR(20),
	apodo VARCHAR(30),
	DNI INT NOT NULL,
	mail VARCHAR(30),
	idFoto INT,
	saldo DOUBLE,
	fecha_registro DATE,
	idHistorial TINYINT,
	edad SMALLINT UNSIGNED,
	nacimiento DATE,
	CONSTRAINT UK_USUARIO_MAIL UNIQUE (mail),
	PRIMARY KEY (idUsuario, DNI),
	CONSTRAINT FK_USUARIO_FOTO FOREIGN KEY (idFoto)
	REFERENCES Foto (idFoto)
);
CREATE TABLE Tipo_Apuesta(
	tipoApuesta SMALLINT UNSIGNED PRIMARY KEY,
	apuesta VARCHAR(10)
);
CREATE TABLE Estado_Apuesta(
	idEstado SMALLINT UNSIGNED PRIMARY KEY,
	estado VARCHAR(10)
);
CREATE TABLE Apuesta(
	idApuesta INT PRIMARY KEY AUTO_INCREMENT,
	tipoApuesta SMALLINT UNSIGNED,
	idUsuario TINYINT,
	idEstado SMALLINT UNSIGNED,
	idPartido TINYINT,
	cantidadGol TINYINT,
	inicio DATE,
	monto DOUBLE,
	fin DATE,
	ganancia DOUBLE,
	cancelada BOOL,
	CONSTRAINT FK_TIPO_APUESTA FOREIGN KEY (tipoApuesta)
	REFERENCES Tipo_Apuesta(tipoApuesta),
	CONSTRAINT FK_USUARIO_APUESTA FOREIGN KEY (idUsuario)
	REFERENCES Usuario(idUsuario),
	CONSTRAINT FK_ESTADO_APUESTA FOREIGN KEY (idEstado)
	REFERENCES Estado_Apuesta(idEstado),
	CONSTRAINT FK_PARTIDO_APUESTA FOREIGN KEY (idPartido)
	REFERENCES Partido(idPartido),
	CONSTRAINT FK_GOL_APUESTA FOREIGN KEY (cantidadGol)
	REFERENCES Gol(idGol)
);
CREATE TABLE Historial_Usuario(
	idHistorial TINYINT PRIMARY KEY AUTO_INCREMENT,
	idUsuario TINYINT,
	idApuesta INT,
	tipoApuesta SMALLINT UNSIGNED,
	CONSTRAINT FK_USUARIO_HISTORIAL FOREIGN KEY (idUsuario)
	REFERENCES Usuario(idUsuario),
	CONSTRAINT FK_APUESTA_HISTORIAL FOREIGN KEY (idApuesta)
	REFERENCES Apuesta(idApuesta),
	CONSTRAINT FK_TIPOAPUESTA_HISTORIAL FOREIGN KEY (tipoApuesta)
	REFERENCES Apuesta(tipoApuesta)
);