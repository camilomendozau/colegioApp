-- -------------------------------------------------------------------------
-- PostgreSQL SQL create tables
-- exported at Thu Mar 16 06:26:36 BOT 2023 with easyDesigner
-- -------------------------------------------------------------------------

-- -------------------------------------------------------------------------
-- Table: Estudiante
-- -------------------------------------------------------------------------
CREATE TABLE "Estudiante" (
  "idEstudiante" bigserial NOT NULL,
  "nombres" VARCHAR NULL,
  "apellidos" VARCHAR NULL,
  "carnetIdentidad" INTEGER NOT NULL,
  "fechaNacimiento" VARCHAR NULL,
  "gestionYearIngreso" YEAR NULL,
  PRIMARY KEY ("idEstudiante")
);

-- -------------------------------------------------------------------------
-- Table: Laptop
-- -------------------------------------------------------------------------
CREATE TABLE "Laptop" (
  "numSerial" bigserial NOT NULL,
  "Marca_idMarca" INTEGER NOT NULL,
  "SistemaOperativo_idSistemaOperativo" INTEGER NOT NULL,
  "modelo" VARCHAR NULL,
  "fechaAdquisicion" DATE NULL,
  "descripcion" VARCHAR NULL,
  "estado" CHAR NULL,
  PRIMARY KEY ("numSerial")
);

-- -------------------------------------------------------------------------
-- Table: SistemaOperativo
-- -------------------------------------------------------------------------
CREATE TABLE "SistemaOperativo" (
  "idSistemaOperativo" bigserial NOT NULL,
  "nombre" VARCHAR NULL,
  "version" VARCHAR NULL,
  "publicacionYear" DATE NULL,
  "fabricante" INTEGER NULL,
  PRIMARY KEY ("idSistemaOperativo")
);

-- -------------------------------------------------------------------------
-- Table: Marca
-- -------------------------------------------------------------------------
CREATE TABLE "Marca" (
  "idMarca" bigserial NOT NULL,
  "nombreComercial" VARCHAR NULL,
  PRIMARY KEY ("idMarca")
);

-- -------------------------------------------------------------------------
-- Table: Pieza
-- -------------------------------------------------------------------------
CREATE TABLE "Pieza" (
  "serialPieza" bigserial NOT NULL,
  "Laptop_numSerial" INTEGER NOT NULL,
  "Marca_idMarca" INTEGER NOT NULL,
  "nombre" VARCHAR NULL,
  "modelo" VARCHAR NULL,
  "fechaFabricacion" DATE NULL,
  "estado" INTEGER NULL,
  PRIMARY KEY ("serialPieza", "Laptop_numSerial")
);

-- -------------------------------------------------------------------------
-- Table: Prestamo
-- -------------------------------------------------------------------------
CREATE TABLE "Prestamo" (
  "Laptop_numSerial" INTEGER NOT NULL,
  "Estudiante_idEstudiante" INTEGER NOT NULL,
  "fechaHoraPrestamo" DATETIME NULL,
  "fechaHoraDevolucion" DATETIME NULL,
  PRIMARY KEY ("Laptop_numSerial", "Estudiante_idEstudiante")
);

-- -------------------------------------------------------------------------
-- Relations for table: Laptop
-- -------------------------------------------------------------------------
ALTER TABLE "Laptop" ADD FOREIGN KEY ("SistemaOperativo_idSistemaOperativo") 
    REFERENCES "SistemaOperativo" ("idSistemaOperativo")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
ALTER TABLE "Laptop" ADD FOREIGN KEY ("Marca_idMarca") 
    REFERENCES "Marca" ("idMarca")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Pieza
-- -------------------------------------------------------------------------
ALTER TABLE "Pieza" ADD FOREIGN KEY ("Laptop_numSerial") 
    REFERENCES "Laptop" ("numSerial")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
ALTER TABLE "Pieza" ADD FOREIGN KEY ("Marca_idMarca") 
    REFERENCES "Marca" ("idMarca")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Prestamo
-- -------------------------------------------------------------------------
ALTER TABLE "Prestamo" ADD FOREIGN KEY ("Laptop_numSerial") 
    REFERENCES "Laptop" ("numSerial")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;
ALTER TABLE "Prestamo" ADD FOREIGN KEY ("Estudiante_idEstudiante") 
    REFERENCES "Estudiante" ("idEstudiante")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

