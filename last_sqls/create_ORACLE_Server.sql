DROP SERVER IF EXISTS esposito_orcl CASCADE;

CREATE SERVER esposito_orcl FOREIGN DATA WRAPPER oracle_fdw 
	OPTIONS(dbserver '//esposito.ies.jrc.it/esposito')

GRANT USAGE ON FOREIGN SERVER esposito_orcl TO postgres;

CREATE USER MAPPING FOR postgres SERVER esposito_orcl 
	OPTIONS (user 'effis', password 'FF19may');

CREATE SCHEMA IF NOT EXISTS firprd;

IMPORT FOREIGN SCHEMA "FIRPRD" FROM SERVER esposito_orcl INTO firprd;

CREATE SCHEMA IF NOT EXISTS rdaprd;
IMPORT FOREIGN SCHEMA "RDAPRD" FROM SERVER esposito_orcl INTO rdaprd;