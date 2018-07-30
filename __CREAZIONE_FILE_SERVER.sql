-- Foreign Data Wrapper: effis_countries_file_fdw

-- DROP FOREIGN DATA WRAPPER effis_countries_file_fdw;

CREATE FOREIGN DATA WRAPPER effis_countries_file_fdw
  HANDLER file_fdw_handler
  VALIDATOR file_fdw_validator;
  
ALTER FOREIGN DATA WRAPPER effis_countries_file_fdw
  OWNER TO postgres;

CREATE SERVER countries_oracle_fdw_server
   FOREIGN DATA WRAPPER effis_countries_file_fdw;
   
ALTER SERVER countries_oracle_fdw_server
  OWNER TO postgres;

CREATE FOREIGN TABLE tmp.countries_effis_oracle
   (iso2 character varying(2),
    name_en character varying)
   SERVER countries_oracle_fdw_server
   OPTIONS (format 'csv', header 'true', filename '/media/sf_Downloads/country_list_cambiata.csv', delimiter ',', null '');
ALTER FOREIGN TABLE tmp.countries_effis_oracle
  OWNER TO postgres;