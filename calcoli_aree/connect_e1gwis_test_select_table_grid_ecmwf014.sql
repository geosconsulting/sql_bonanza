CREATE SCHEMA IF NOT EXISTS firprd;

DROP FOREIGN TABLE IF EXISTS firprd.grid_ecmwf014 CASCADE;

IMPORT FOREIGN SCHEMA "FIRPRD" 
LIMIT TO(GRID_ECMWF014)
FROM SERVER dea_orcl 
INTO firprd;

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