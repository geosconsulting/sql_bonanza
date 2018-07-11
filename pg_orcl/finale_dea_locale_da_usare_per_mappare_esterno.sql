DROP SERVER IF EXISTS dea_orcl CASCADE;

CREATE SERVER dea_orcl FOREIGN DATA WRAPPER oracle_fdw 
	OPTIONS(dbserver 'dea.ies.jrc.it:1521/dea.ies.jrc.it');

GRANT USAGE ON FOREIGN SERVER dea_orcl TO postgres;

CREATE USER MAPPING FOR postgres SERVER dea_orcl 
	OPTIONS (user 'FIR_RO', password 'f1r0nly2read');

CREATE SCHEMA IF NOT EXISTS firprd;

IMPORT FOREIGN SCHEMA "FIRPRD" 
LIMIT TO(GRID_ECMWF014)
FROM SERVER dea_orcl 
INTO firprd;

-- INCOMPATIBILE CAMPO
CREATE SCHEMA IF NOT EXISTS gwsprd;
IMPORT FOREIGN SCHEMA "GWSPRD" 
LIMIT TO(HOT_SPOTS_MODIS,HOT_SPOTS_VIIRS)
FROM SERVER dea_orcl 
INTO gwsprd;

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
        ) SERVER dea_orcl 
OPTIONS (schema 'FIRPRD',table 'GRID_ECMWF014'); 

SELECT id,shape,xcen,ycen FROM firprd.grid_ecmwf014 LIMIT 10;

CREATE SCHEMA IF NOT EXISTS gwsprd;

IMPORT FOREIGN SCHEMA "GWSPRD" 
LIMIT TO(HOT_SPOTS_MODIS,HOT_SPOTS_VIIRS)
FROM SERVER dea_orcl 
INTO gwsprd;

CREATE USER MAPPING FOR e1gwis SERVER dea_orcl 
	OPTIONS (user 'FIR_RO', password 'f1r0nly2read');

GRANT USAGE ON FOREIGN SERVER dea_orcl TO e1gwis;

CREATE SCHEMA IF NOT EXISTS rdaprd;

IMPORT FOREIGN SCHEMA "RDAPRD" 
LIMIT TO(ROB_BURNTAREAS,ROB_BURNTAREAS_HISTORY,ROB_FIRESEVOLUTION)
FROM SERVER dea_orcl 
INTO rdaprd;

