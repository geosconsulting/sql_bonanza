CREATE EXTENSION hstore;

--Create the new user
CREATE USER osm_loader WITH PASSWORD 'osm_loader';

--create the schema
CREATE SCHEMA osm AUTHORIZATION osm_loader;

GRANT USAGE ON SCHEMA osm TO osm_loader;
GRANT SELECT,UPDATE,DELETE ON ALL TABLES IN SCHEMA osm TO osm_loader;
GRANT USAGE, SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA osm TO osm_loader;

--Change the search_path. 
ALTER ROLE osm_loader SET search_path TO osm, public;