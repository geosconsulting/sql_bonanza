CREATE EXTENSION postgres_fdw;

DROP SERVER foreign_pg_osm CASCADE;

CREATE SERVER foreign_pg_osm
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS (host '139.191.147.16', port '5432', dbname 'osm');

DROP USER MAPPING FOR postgres SERVER foreign_pg_osm;

CREATE USER MAPPING FOR postgres
SERVER foreign_pg_osm
OPTIONS (user 'effisro', password 'Changeme!');

CREATE SCHEMA osm;

IMPORT FOREIGN SCHEMA public
FROM SERVER foreign_pg_osm
INTO osm;