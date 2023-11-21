CREATE OR REPLACE FUNCTION public."insertNewLaptop"(
	IN "nSerial" character varying DEFAULT NULL::character varying,
	IN marca character varying DEFAULT  NULL::character varying,
	IN modelo character varying DEFAULT  NULL::character varying,
	IN so character varying DEFAULT  NULL::character varying,
	IN "fechaAdq" date DEFAULT  NULL::date,
	IN "imagen" bytea,
	IN "desc" text DEFAULT  'ninguna'::text,
	IN est character varying DEFAULT  'Nuevo'::character varying
)
    RETURNS text
    LANGUAGE 'plpgsql'
    VOLATILE
    PARALLEL UNSAFE
    COST 100
AS $BODY$
DECLARE idM INTEGER;
DECLARE idS INTEGER;
BEGIN
	 SELECT "idMarca" INTO idM FROM public."Marca" WHERE "nombreComercial" = "marca";
	 SELECT "idSO" INTO idS FROM public."SistemaOperativo" WHERE "nombre" = "so";
	 INSERT INTO public."Laptop"("numSerial","Marca_idMarca","modelo","SistemaOperativo_idSO","fechaAdquisicion","descripcion","estado") 
     VALUES ("nSerial",idM,"modelo",idS,"fechaAdq","desc","est");
	 RETURN 'Laptop guardada exitosamente';
END;
$BODY$;
