CREATE EXTENSION IF NOT EXISTS oracle_fdw;

DROP SERVER IF EXISTS esposito_orcl CASCADE;

SELECT oracle_diag();

CREATE SERVER esposito_orcl FOREIGN DATA WRAPPER oracle_fdw 
	OPTIONS(dbserver '//esposito.ies.jrc.it/esposito')

GRANT USAGE ON FOREIGN SERVER esposito_orcl TO postgres;

CREATE USER MAPPING FOR postgres SERVER esposito_orcl 
	OPTIONS (user 'effis', password 'FF19may');

CREATE SCHEMA IF NOT EXISTS firprd;
--IMPORT FOREIGN SCHEMA "FIRPRD" FROM SERVER esposito_orcl INTO firprd;
DROP FOREIGN TABLE IF EXISTS firprd.grid_ecmwf014 CASCADE;

CREATE FOREIGN TABLE firprd.grid_ecmwf014 (
          ogr_id numeric(10,0)
	, shape public.geometry(POLYGON,4326)	
	, id numeric(10,0)
	, flag numeric(1,0)
	, min_x float8
	, max_x float8	
	, min_y float8
	, max_y float8	
	, xcen float8
	, ycen float8
	, rect public.geometry(POLYGON,4326)
	, centroid public.geometry(POINT,4326)		
        ) SERVER esposito_orcl 
OPTIONS (schema 'FIRPRD',table 'GRID_ECMWF014'); 

SELECT id,shape,xcen,ycen FROM firprd.grid_ecmwf014 LIMIT 10;

--credenziali RDAPRD
--RDAPRD
--pwd4rda

CREATE SCHEMA IF NOT EXISTS rdaprd;
IMPORT FOREIGN SCHEMA "RDAPRD" 
LIMIT TO(CURRENT_BURNTAREASPOLY,EMISSIONS,EMISSIONS_FIRES)
FROM SERVER esposito_orcl 
INTO rdaprd;

CREATE SCHEMA IF NOT EXISTS gwsprd;
IMPORT FOREIGN SCHEMA "GWSPRD" 
LIMIT TO(HOT_SPOTS_MODIS,HOT_SPOTS_VIIRS)
FROM SERVER esposito_orcl 
INTO gwsprd;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.burnt_areas_orcl AS
	SELECT id,
	shape AS geom 
FROM rdaprd.current_burntareaspoly;
	
CREATE UNIQUE INDEX burnt_area_idx ON public.burnt_areas_orcl(id);
REFRESH MATERIALIZED VIEW CONCURRENTLY public.burnt_areas_orcl;

--CREATE EXTENSION postgres_fdw;

--CREATE SERVER foreign_server
--        FOREIGN DATA WRAPPER postgres_fdw
--        OPTIONS (host 'e1-dev-effisdb.ies.jrc.it', port '5432', dbname 'effis');

--CREATE USER local_user;

--DROP USER MAPPING FOR local_user SERVER foreign_server;

--CREATE USER MAPPING FOR local_user
--        SERVER foreign_server
--        OPTIONS (user 'postgres', password 'Albertone_2017_1');

--DROP FOREIGN TABLE foreign_table;

--CREATE FOREIGN TABLE foreign_table (
--        id integer NOT NULL,
--        firedate date
--)
--        SERVER foreign_server
--        OPTIONS (schema_name 'public', table_name 'burnt_area');

--SELECT id, firedate
--  FROM public.foreign_table
--  LIMIT 15;

