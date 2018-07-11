DROP SERVER IF EXISTS esposito_orcl_rdaprd CASCADE;

CREATE SERVER esposito_orcl_rdaprd FOREIGN DATA WRAPPER oracle_fdw 
	OPTIONS(dbserver '//esposito.ies.jrc.it/esposito');

GRANT USAGE ON FOREIGN SERVER esposito_orcl_rdaprd TO postgres;

CREATE USER MAPPING FOR postgres SERVER esposito_orcl_rdaprd 
	OPTIONS (user 'RDAPRD', password 'pwd4rda');

CREATE SCHEMA IF NOT EXISTS firprd;
--credenziali RDAPRD
--RDAPRD
--pwd4rda

CREATE SCHEMA IF NOT EXISTS rdaprd;
IMPORT FOREIGN SCHEMA "RDAPRD" 
LIMIT TO(rob_Modis_HotSpots_since2006)
FROM SERVER esposito_orcl_rdaprd 
INTO rdaprd;