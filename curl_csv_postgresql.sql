create table modis_viirs.viirs_7d (like modis_viirs.viirs);

create table modis_viirs.modis_7d (like modis_viirs.modis);

copy modis_viirs.modis_7d from program 'curl "https://firms.modaps.eosdis.nasa.gov/active_fire/c6/text/MODIS_C6_Global_7d.csv"'  DELIMITER ',' CSV HEADER;

create extension plsh;

CREATE FUNCTION tmp.load_file_content (text) RETURNS text AS '
#!/bin/bash
curl $1 2>/dev/null
' LANGUAGE plsh;

select * from tmp.load_file_content('https://firms.modaps.eosdis.nasa.gov/active_fire/c6/text/MODIS_C6_Global_7d.csv');

CREATE EXTENSION file_fdw;
CREATE SERVER import_firms FOREIGN DATA WRAPPER file_fdw;
DROP SERVER import_firms;