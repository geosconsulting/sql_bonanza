SELECT oracle_diag();

CREATE EXTENSION IF NOT EXISTS oracle_fdw;

DROP SERVER IF EXISTS esposito_orcl CASCADE;

CREATE SERVER esposito_orcl FOREIGN DATA WRAPPER oracle_fdw 
	OPTIONS(dbserver '139.191.254.54/esposito')

GRANT USAGE ON FOREIGN SERVER esposito_orcl TO e1gwis;

--credenziali RDAPRD
--RDAPRD
--pwd4rda

CREATE USER MAPPING FOR e1gwis SERVER esposito_orcl 
	OPTIONS (user 'effis', password 'FF19may');

CREATE SCHEMA IF NOT EXISTS firprd;
--IMPORT FOREIGN SCHEMA "FIRPRD" FROM SERVER esposito_orcl INTO firprd;

CREATE SCHEMA IF NOT EXISTS firprd_esposito;
IMPORT FOREIGN SCHEMA "FIRPRD" 
LIMIT TO(EU_FIRES_MONTHS,EU_FIRES_YEARS)
FROM SERVER esposito_orcl 
INTO firprd_esposito;

CREATE SCHEMA IF NOT EXISTS rdaprd;

IMPORT FOREIGN SCHEMA "RDAPRD" 
LIMIT TO(CURRENT_BURNTAREASPOLY,EMISSIONS,EMISSIONS_FIRES,FROM2000_BURNTAREAS,CURRENT_FIRESEVOLUTION,FROM2009_FIRESEVOLUTION)
FROM SERVER esposito_orcl 
INTO rdaprd;

CREATE SCHEMA IF NOT EXISTS rdaprd_esposito;

IMPORT FOREIGN SCHEMA "RDAPRD" 
LIMIT TO(CURRENT_BURNTAREASPOLY,EMISSIONS,EMISSIONS_FIRES,FROM2000_BURNTAREAS,CURRENT_FIRESEVOLUTION,FROM2009_FIRESEVOLUTION)
FROM SERVER esposito_orcl 
INTO rdaprd_esposito;

--IMPORT FOREIGN SCHEMA "RDAPRD" FROM SERVER esposito_orcl INTO rdaprd;

--CREATE SERVER pg_h05_srv_dbp96_jrc_it_slow_lan
--        FOREIGN DATA WRAPPER postgres_fdw
--        OPTIONS (host 'h05-srv-dbp96.jrc.it', port '5432', dbname 'e1gwis');

--DROP USER MAPPING FOR local_user SERVER pg_h05_srv_dbp96_jrc_it_slow_lan;

--CREATE USER MAPPING FOR local_user
--        SERVER foreign_server
--        OPTIONS (user 'e1gwis', password 'ka4Zie4i');

--DROP FOREIGN TABLE foreign_table;

--CREATE FOREIGN TABLE foreign_table (
--        id integer NOT NULL,
--        firedate date
--)
--        SERVER foreign_server
--        OPTIONS (schema_name 'public', table_name 'burnt_area');

