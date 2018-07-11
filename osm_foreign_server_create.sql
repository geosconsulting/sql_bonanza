CREATE EXTENSION postgres_fdw;

CREATE SERVER osm_pg_foreign_server
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host 'species.jrc.it', port '5432', dbname 'osm_db');

CREATE USER MAPPING FOR postgres
SERVER osm_pg_foreign_server
OPTIONS (user 'effisro', password 'Changeme!');

CREATE SCHEMA osm;

IMPORT FOREIGN SCHEMA public
FROM SERVER osm_pg_foreign_server
INTO osm;