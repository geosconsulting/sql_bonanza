-- EDEA server
DROP SERVER effis_oracle CASCADE;
CREATE SERVER effis_oracle
FOREIGN DATA WRAPPER oracle_fdw
OPTIONS (dbserver '//EDEA.IES.JRC.it/EDEA');

GRANT USAGE ON FOREIGN SERVER effis_oracle TO postgres;

CREATE USER MAPPING FOR postgres SERVER effis_oracle OPTIONS (user 'effis', password 'FF19may');


-- XE server
DROP SERVER oracle_locale CASCADE;
CREATE SERVER oracle_locale
FOREIGN DATA WRAPPER oracle_fdw
OPTIONS (dbserver '//localhost/xe');

GRANT USAGE ON FOREIGN SERVER oracle_locale TO postgres;

DROP USER MAPPING FOR postgres SERVER oracle_locale;
CREATE USER MAPPING FOR postgres SERVER oracle_locale OPTIONS (user 'hr', password 'hr');

DROP FOREIGN TABLE countries_oradb;
CREATE FOREIGN TABLE countries_oradb(country_id character(2), country_name varchar(40), region_id integer)
SERVER oracle_locale
OPTIONS (schema 'public',table 'countries');

SELECT * FROM countries_oradb;

SELECT oracle_diag();