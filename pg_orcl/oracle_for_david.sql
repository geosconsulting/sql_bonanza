CREATE EXTENSION IF NOT EXISTS oracle_fdw;

DROP SERVER IF EXISTS esposito_orcl CASCADE;

CREATE SERVER esposito_orcl FOREIGN DATA WRAPPER oracle_fdw 
	OPTIONS(dbserver '//esposito.ies.jrc.it/esposito')

GRANT USAGE ON FOREIGN SERVER esposito_orcl TO e1gwis;

CREATE USER MAPPING FOR e1gwis SERVER esposito_orcl 
	OPTIONS (user 'effis', password 'FF19may');

CREATE USER MAPPING FOR e1gwisro SERVER esposito_orcl 
	OPTIONS (user 'effis', password 'FF19may');

grant select on effis.archived_ba to e1gwisro;

CREATE SCHEMA IF NOT EXISTS firprd;

IMPORT FOREIGN SCHEMA "FIRPRD" FROM SERVER esposito_orcl INTO firprd;

SELECT oracle_diag();

CREATE SCHEMA IF NOT EXISTS rdaprd;
--IMPORT FOREIGN SCHEMA "RDAPRD" FROM SERVER esposito_orcl INTO rdaprd;

CREATE SERVER foreign_server
        FOREIGN DATA WRAPPER postgres_fdw
        OPTIONS (host 'e1-dev-effisdb.ies.jrc.it', port '5432', dbname 'effis');

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

IMPORT FOREIGN SCHEMA "RDAPRD" 
LIMIT TO(CURRENT_BURNTAREASPOLY,EMISSIONS,EMISSIONS_FIRES,FROM2000_BURNTAREAS)
--LIMIT TO(FROM2000_BURNTAREAS)
--LIMIT TO(FROM2000_BURNTAREAS)
FROM SERVER esposito_orcl 
INTO rdaprd;