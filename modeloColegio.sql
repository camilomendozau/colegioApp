-- -------------------------------------------------------------------------
-- PostgreSQL SQL create tables
-- exported at Wed Mar 22 08:08:03 BOT 2023 with easyDesigner
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
  "numSerial" bigserial NOT NULL,
  "Marca_idMarca" INTEGER NOT NULL,
  "modelo" VARCHAR NULL,
  "SistemaOperativo_idSO" INTEGER NOT NULL,
  "fechaAdquisicion" DATE NULL,
  "descripcion" VARCHAR NULL,
  "estado" CHAR NULL,
  PRIMARY KEY ("numSerial")
);

-- -------------------------------------------------------------------------
-- Table: Prestamo
-- -------------------------------------------------------------------------
CREATE TABLE "Prestamo" (
  "Estudiante_idEstudiante" INTEGER NOT NULL,
  "Laptop_numSerial" INTEGER NOT NULL,
  "fechaHoraPrestamo" DATETIME NOT NULL,
  "fechaHoraDevolucion" DATETIME NULL,
  PRIMARY KEY ("Estudiante_idEstudiante", "Laptop_numSerial", "fechaHoraPrestamo")
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
  "Laptop_numSerial" INTEGER NOT NULL,
  "nombre" VARCHAR NULL,
  "modelo" VARCHAR NULL,
  "fechaFabricacion" DATE NULL,
  "estado" CHAR NULL,
  PRIMARY KEY ("serialPieza", "Laptop_numSerial")
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
ALTER TABLE "Prestamo" ADD FOREIGN KEY ("Laptop_numSerial") 
    REFERENCES "Laptop" ("numSerial")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

-- -------------------------------------------------------------------------
-- Relations for table: Pieza
-- -------------------------------------------------------------------------
ALTER TABLE "Pieza" ADD FOREIGN KEY ("Laptop_numSerial") 
    REFERENCES "Laptop" ("numSerial")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION;

