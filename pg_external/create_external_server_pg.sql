CREATE EXTENSION postgres_fdw;

CREATE SERVER effis_pg_server FOREIGN DATA WRAPPER postgres_fdw 
OPTIONS (host 'localhost', dbname 'effis', port '5432');

CREATE USER MAPPING FOR postgres SERVER effis_pg_server 
OPTIONS (user 'postgres', password 'antarone');

CREATE SCHEMA IF NOT EXISTS effis_ext;
IMPORT FOREIGN SCHEMA "effis" FROM SERVER effis_pg_server INTO effis_ext;

CREATE SCHEMA IF NOT EXISTS effis_ext_public;
IMPORT FOREIGN SCHEMA "public" FROM SERVER effis_pg_server INTO effis_ext_public;