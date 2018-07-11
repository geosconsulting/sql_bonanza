--CREATE EXTENSION oracle_fdw;
--CREATE EXTENSION IF NOT EXISTS oracle_fdw;

DROP SERVER IF EXISTS foreign_server CASCADE;

DROP SERVER IF EXISTS esposito_orcl CASCADE;

CREATE SERVER esposito_orcl FOREIGN DATA WRAPPER oracle_fdw 
	OPTIONS(dbserver '//esposito.ies.jrc.it/esposito')

GRANT USAGE ON FOREIGN SERVER esposito_orcl TO postgres;

CREATE USER MAPPING FOR postgres SERVER esposito_orcl 
	OPTIONS (user 'effis', password 'FF19may');

CREATE SCHEMA IF NOT EXISTS firprd;

IMPORT FOREIGN SCHEMA "FIRPRD" FROM SERVER esposito_orcl INTO firprd;

DROP FOREIGN TABLE IF EXISTS firprd.nuts2006_dwd025 CASCADE;

CREATE FOREIGN TABLE firprd.nuts2006_dwd025 (
          NUTS_CODE character varying(8) NOT NULL 
	, STAT_LEVL_ integer NOT NULL 
	, ID integer NOT NULL
        ) SERVER esposito_orcl 
OPTIONS (schema 'FIRPRD',table 'NUTS2006_DWD025'); 

SELECT count(*) FROM firprd.nuts2006_dwd025;

SELECT * FROM firprd.nuts2006_dwd025 LIMIT 10;
SELECT * FROM firprd.nuts2006_dwd025;

SELECT oracle_diag();

--credenziali RDAPRD
--RDAPRD
--pwd4rda

CREATE FOREIGN TABLE firprd.current_burnt_areas (
	objectid numeric,
	id numeric,
	country VARCHAR(2),
	countryful VARCHAR(100),
	province VARCHAR(60),
	commune VARCHAR(50),
	firedate VARCHAR(10),
	area_ha decimal(9,0),
	broadlea decimal(38,8),
	conifer decimal(38,8),
	mixed decimal(38,8),
	scleroph decimal(38,8),
	transit decimal(38,8),
	othernatlc decimal(38,8),
	agriareas decimal(38,8),
	artifsurf decimal(38,8),
	otherlc decimal(38,8),
	percna2k decimal(38,8),
	lastupdate VARCHAR(10),
	class VARCHAR(6),
	mic VARCHAR(5),
	se_anno_cad_data bytea,
	shape geometry(Polygon,4326),
	critech VARCHAR(3)
) SERVER esposito_orcl 
OPTIONS (schema 'RDAPRD',table 'CURRENT_BURNTAREASPOLY');

SELECT count(*) FROM firprd.current_burnt_areas;

SELECT id, firedate,shape FROM firprd.current_burnt_areas LIMIT 10;

CREATE SCHEMA IF NOT EXISTS rdaprd;
IMPORT FOREIGN SCHEMA "RDAPRD" FROM SERVER esposito_orcl INTO rdaprd;

CREATE MATERIALIZED VIEW IF NOT EXISTS public.burnt_areas_orcl AS
	SELECT id,
	shape AS geom 
FROM firprd.current_burnt_areas;
	
CREATE UNIQUE INDEX burnt_area_idx ON public.burnt_areas_orcl(id);
REFRESH MATERIALIZED VIEW CONCURRENTLY public.burnt_areas_orcl;

--CREATE EXTENSION dblink;
--CREATE EXTENSION osm_fdw;
--CREATE EXTENSION postgres_fdw;

CREATE SERVER foreign_server
        FOREIGN DATA WRAPPER postgres_fdw
        OPTIONS (host 'e1-dev-effisdb.ies.jrc.it', port '5432', dbname 'effis');

CREATE USER local_user;

DROP USER MAPPING FOR local_user SERVER foreign_server;

CREATE USER MAPPING FOR local_user
        SERVER foreign_server
        OPTIONS (user 'postgres', password 'Albertone_2017_1');

DROP FOREIGN TABLE foreign_table;

CREATE FOREIGN TABLE foreign_table (
        id integer NOT NULL,
        firedate date
)
        SERVER foreign_server
        OPTIONS (schema_name 'public', table_name 'burnt_area');

SELECT id, firedate
  FROM public.foreign_table
  LIMIT 15;

