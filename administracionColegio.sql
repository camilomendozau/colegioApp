-- -------------------------------------------------------------------------
-- PostgreSQL SQL create tables
-- exported at Mon Apr 03 05:22:18 BOT 2023 with easyDesigner

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
  PRIMARY KEY ("idFuncion")
);

-- -------------------------------------------------------------------------
-- Table: UI
-- -------------------------------------------------------------------------
CREATE TABLE "UI" (
  "idUI" bigserial NOT NULL,
  "nombreUI" VARCHAR NULL,
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

