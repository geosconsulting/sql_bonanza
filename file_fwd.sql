CREATE SERVER file_fdw_server FOREIGN DATA WRAPPER file_fdw;

DROP FOREIGN TABLE tmp.modis_2018;

CREATE foreign TABLE tmp.modis_2018
(
  --modis_id serial NOT NULL,
  latitude numeric,
  longitude numeric,
  brightness numeric,
  scan numeric,
  track numeric,
  acq_date date,
  acq_time time without time zone,
  satellite character varying(5),
  instrument character varying(6),
  confidence integer,
  version varchar,
  bright_t31 numeric,
  frp numeric,
  daynight char(1)
) SERVER file_fdw_server
options (format 'csv', header 'true' , filename '/media/sf_Downloads/__effis/effis_ubuntu/modis_viirs/secondo_download/DL_FIRE_M6_4882_12Mar2018/fire_nrt_M6_4882.csv',
delimiter E',', null '');

--You can change the location of a file as well. For example, the query above will not work if you are on windows. You'll need to specify the drive letter as well. You can do this:
--ALTER FOREIGN TABLE staging.aircraft OPTIONS ( SET filename 'C:/fdw_data/aircraft.txt' ); 

SELECT * FROM tmp.modis_2018 LIMIT 10;