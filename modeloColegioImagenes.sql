-- -------------------------------------------------------------------------
-- PostgreSQL SQL create tables
-- exported at Fri May 19 12:10:04 BOT 2023 with easyDesigner
-- -------------------------------------------------------------------------

-- -------------------------------------------------------------------------
-- Table: Estudiante
-- -------------------------------------------------------------------------
CREATE TABLE "Estudiante" (
  "idEstudiante" bigserial NOT NULL,
  "nombres" VARCHAR NULL,
  "apellidos" VARCHAR NULL,
  "carnetIdentidad" VARCHAR NULL,
  "fechaNacimiento" DATE NULL,
  "fechaIngreso" DATE NULL,
  "numTelefono" INTEGER NULL,
  "direccion" VARCHAR NULL,
  PRIMARY KEY ("idEstudiante")
);

-- -------------------------------------------------------------------------
-- Table: Laptop
-- -------------------------------------------------------------------------
CREATE TABLE "Laptop" (
  "idLaptop" bigserial NOT NULL,
  "numSerial" INTEGER NOT NULL,
  "Marca_idMarca" INTEGER NOT NULL,
  "modelo" VARCHAR NULL,
  "SistemaOperativo_idSO" INTEGER NOT NULL,
  "fechaAdquisicion" DATE NULL,
  "descripcion" VARCHAR NULL,
  "estado" CHAR NULL,
  PRIMARY KEY ("idLaptop")
);

-- -------------------------------------------------------------------------
-- Table: Prestamo
-- -------------------------------------------------------------------------
CREATE TABLE "Prestamo" (
  "Estudiante_idEstudiante" INTEGER NOT NULL,
  "fechaHoraPrestamo" DATETIME NOT NULL,
  "Laptop_idLaptop" INTEGER NOT NULL,
  "fechaHoraDevolucion" DATETIME NULL,
  PRIMARY KEY ("Estudiante_idEstudiante", "fechaHoraPrestamo", "Laptop_idLaptop")
);

-- -------------------------------------------------------------------------
-- Table: SistemaOperativo
-- -------------------------------------------------------------------------
CREATE TABLE "SistemaOperativo" (
  "idSO" bigserial NOT NULL,
  "nombre" VARCHAR NULL,
  "version" VARCHAR NULL,
  "publicationYear" YEAR NULL,
  "empresa" VARCHAR NULL,
  PRIMARY KEY ("idSO")
);

-- -------------------------------------------------------------------------
-- Table: Marca
-- -------------------------------------------------------------------------
CREATE TABLE "Marca" (
  "idMarca" bigserial NOT NULL,
  "nombreComercial" VARCHAR NULL,
  "paisOrigen" VARCHAR NULL,
  PRIMARY KEY ("idMarca")
);

-- -------------------------------------------------------------------------
-- Table: Pieza
-- -------------------------------------------------------------------------
CREATE TABLE "Pieza" (
  "serialPieza" VARCHAR NOT NULL,
  "Laptop_idLaptop" INTEGER NOT NULL,
  "nombre" VARCHAR NULL,
  "modelo" VARCHAR NULL,
  "fechaFabricacion" DATE NULL,
  "estado" CHAR NULL,
  PRIMARY KEY ("serialPieza", "Laptop_idLaptop")
);

-- -------------------------------------------------------------------------
-- Table: UserN
-- -------------------------------------------------------------------------
CREATE TABLE "UserN" (
  "idUserN" bigserial NOT NULL,
  "username" VARCHAR NULL,
  "password" VARCHAR NULL,
  PRIMARY KEY ("idUserN")
);

-- -------------------------------------------------------------------------
-- Table: Sesion
-- -------------------------------------------------------------------------
CREATE TABLE "Sesion" (
  "idSesion" bigserial NOT NULL,
  "fechaHoraLogin" TIMESTAMP NOT NULL,
  "processid" INTEGER NULL,
  "fechaHoraLogout" TIMESTAMP NULL,
  "usernameActual" VARCHAR NULL,
  PRIMARY KEY ("idSesion", "fechaHoraLogin")
);

-- -------------------------------------------------------------------------
-- Table: Rol
-- -------------------------------------------------------------------------
CREATE TABLE "Rol" (
  "idRol" bigserial NOT NULL,
  "nombreRol" VARCHAR NULL,
  PRIMARY KEY ("idRol")
);

-- -------------------------------------------------------------------------
-- Table: Funcion
-- -------------------------------------------------------------------------
CREATE TABLE "Funcion" (
  "idFuncion" bigserial NOT NULL,
  "nombreFuncion" VARCHAR NULL,
  "activoRU" BOOL NULL,
  PRIMARY KEY ("idFuncion")
);

-- -------------------------------------------------------------------------
-- Table: UI
-- -------------------------------------------------------------------------
CREATE TABLE "UI" (
  "idUI" bigserial NOT NULL,
  "nombreUI" VARCHAR NULL,
  "activoRU" BOOL NULL,
  PRIMARY KEY ("idUI")
);

-- -------------------------------------------------------------------------
-- Table: User_rol
-- -------------------------------------------------------------------------
CREATE TABLE "User_rol" (
  "UserN_idUserN" INTEGER NOT NULL,
  "Rol_idRol" INTEGER NOT NULL,
  "fechaInicio" DATE NOT NULL,
  "fechaFin" DATE NULL,
  PRIMARY KEY ("UserN_idUserN", "Rol_idRol", "fechaInicio")
);

-- -------------------------------------------------------------------------
-- Table: Rol_funcion
-- -------------------------------------------------------------------------
CREATE TABLE "Rol_funcion" (
  "Rol_idRol" INTEGER NOT NULL,
  "Funcion_idFuncion" INTEGER NOT NULL,
  PRIMARY KEY ("Rol_idRol", "Funcion_idFuncion")
);

-- -------------------------------------------------------------------------
-- Table: Funcion_ui
-- -------------------------------------------------------------------------
CREATE TABLE "Funcion_ui" (
  "Funcion_idFuncion" INTEGER NOT NULL,
  "UI_idUI" INTEGER NOT NULL,
  PRIMARY KEY ("Funcion_idFuncion", "UI_idUI")
);

-- -------------------------------------------------------------------------
-- Table: Bitacora
-- -------------------------------------------------------------------------
CREATE TABLE "Bitacora" (
  "idAccion" bigserial NOT NULL,
  "datoNuevo" VARCHAR NULL,
  "datoViejo" VARCHAR NULL,
  "fechaAccion" DATE NULL,
  "horaAccion" TIME NULL,
  "usuario" VARCHAR NULL,
  "accion" VARCHAR NULL,
  PRIMARY KEY ("idAccion")
);

-- -------------------------------------------------------------------------
-- Table: Laptop_Imagenes
-- -------------------------------------------------------------------------
CREATE TABLE "Laptop_Imagenes" (
  "Laptop_idLaptop" INTEGER NOT NULL,
  "extension" VARCHAR NULL,
  "datos_dibujo" BLOB NULL
);

-- -------------------------------------------------------------------------
-- Relations for table: Laptop
-- -------------------------------------------------------------------------
ALTER TABLE "Laptop" ADD FOREIGN KEY ("SistemaOperativo_idSO") 
    REFERENCES "SistemaOperativo" ("idSO")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
ALTER TABLE "Laptop" ADD FOREIGN KEY ("Marca_idMarca") 
    REFERENCES "Marca" ("idMarca")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Prestamo
-- -------------------------------------------------------------------------
ALTER TABLE "Prestamo" ADD FOREIGN KEY ("Estudiante_idEstudiante") 
    REFERENCES "Estudiante" ("idEstudiante")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
ALTER TABLE "Prestamo" ADD FOREIGN KEY ("Laptop_idLaptop") 
    REFERENCES "Laptop" ("idLaptop")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Pieza
-- -------------------------------------------------------------------------
ALTER TABLE "Pieza" ADD FOREIGN KEY ("Laptop_idLaptop") 
    REFERENCES "Laptop" ("idLaptop")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: User_rol
-- -------------------------------------------------------------------------
ALTER TABLE "User_rol" ADD FOREIGN KEY ("UserN_idUserN") 
    REFERENCES "UserN" ("idUserN")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
ALTER TABLE "User_rol" ADD FOREIGN KEY ("Rol_idRol") 
    REFERENCES "Rol" ("idRol")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Rol_funcion
-- -------------------------------------------------------------------------
ALTER TABLE "Rol_funcion" ADD FOREIGN KEY ("Rol_idRol") 
    REFERENCES "Rol" ("idRol")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
ALTER TABLE "Rol_funcion" ADD FOREIGN KEY ("Funcion_idFuncion") 
    REFERENCES "Funcion" ("idFuncion")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Funcion_ui
-- -------------------------------------------------------------------------
ALTER TABLE "Funcion_ui" ADD FOREIGN KEY ("Funcion_idFuncion") 
    REFERENCES "Funcion" ("idFuncion")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
ALTER TABLE "Funcion_ui" ADD FOREIGN KEY ("UI_idUI") 
    REFERENCES "UI" ("idUI")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Laptop_Imagenes
-- -------------------------------------------------------------------------
ALTER TABLE "Laptop_Imagenes" ADD FOREIGN KEY ("Laptop_idLaptop") 
    REFERENCES "Laptop" ("idLaptop")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

