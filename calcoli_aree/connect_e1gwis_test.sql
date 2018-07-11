﻿DROP SERVER IF EXISTS dea_orcl CASCADE;

CREATE SERVER dea_orcl FOREIGN DATA WRAPPER oracle_fdw 
	--OPTIONS(dbserver '//dea.ies.jrc.it:1521/dea');
	--OPTIONS(dbserver '//dea.ies.jrc.it:1521/dea.ies.jrc.it');
	OPTIONS(dbserver 'dea.ies.jrc.it:1521/dea.ies.jrc.it');

GRANT USAGE ON FOREIGN SERVER dea_orcl TO postgres;

CREATE USER MAPPING FOR postgres SERVER dea_orcl 
	OPTIONS (user 'FIR_RO', password 'f1r0nly2read');

CREATE SCHEMA IF NOT EXISTS firprd;
IMPORT FOREIGN SCHEMA "FIRPRD" 
LIMIT TO(GRID_ECMWF014)
FROM SERVER dea_orcl 
INTO firprd;

CREATE SCHEMA IF NOT EXISTS gwsprd;
IMPORT FOREIGN SCHEMA "GWSPRD" 
LIMIT TO(HOT_SPOTS_MODIS,HOT_SPOTS_VIIRS)
FROM SERVER dea_orcl 
INTO gwsprd;

CREATE SCHEMA IF NOT EXISTS rdaprd;
IMPORT FOREIGN SCHEMA "RDAPRD" 
LIMIT TO(ROB_BURNTAREAS,ROB_BURNTAREAS_HISTORY,ROB_FIRESEVOLUTION)
FROM SERVER dea_orcl 
INTO rdaprd;

