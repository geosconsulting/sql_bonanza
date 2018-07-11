DROP TABLE modis_viirs.modis CASCADE;

CREATE TABLE modis_viirs.modis(
	modis_id serial,
	latitude  numeric,
	longitude numeric,
	brightness numeric,
	scan  numeric,
	track  numeric,
	acq_date  date,
	acq_time  time without time zone,
	satellite varchar(5),
	instrument varchar(6),
	confidence integer,
	version numeric,
	bright_t31 numeric,
	frp  numeric);

-- Add a spatial column to the table
SELECT AddGeometryColumn ('modis_viirs','modis','geom',4326,'POINT',2);

ALTER TABLE modis_viirs.modis ADD CONSTRAINT modis_pk PRIMARY KEY(modis_id);
ALTER TABLE modis_viirs.modis ADD CONSTRAINT enforce_dims_geom CHECK(st_ndims(geom) = 2);
ALTER TABLE modis_viirs.modis ADD CONSTRAINT enforce_geotype_geom CHECK(geometrytype(geom) = 'POINT'::text OR geom IS NULL);
ALTER TABLE modis_viirs.modis ADD CONSTRAINT enforce_srid_geom CHECK(st_srid(geom) = 4326);

CREATE TABLE modis_viirs.modis_2017() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2017 ADD CHECK(acq_date >= '2017-01-01' AND acq_date <= '2017-12-31');

CREATE TABLE modis_viirs.modis_2016() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2016 ADD CHECK(acq_date >= '2016-01-01' AND acq_date <= '2016-12-31');

--fire_archive_M6_2448 <- read.csv("/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2448/fire_archive_M6_2448.csv")

CREATE TABLE modis_viirs.modis_2015() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2015 ADD CHECK(acq_date >= '2015-01-01' AND acq_date <= '2015-12-31');

CREATE TABLE modis_viirs.modis_2014() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2014 ADD CHECK(acq_date >= '2014-01-01' AND acq_date <= '2014-12-31');

CREATE TABLE modis_viirs.modis_2013() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2013 ADD CHECK(acq_date >= '2013-01-01' AND acq_date <= '2013-12-31');

CREATE TABLE modis_viirs.modis_2012() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2012 ADD CHECK(acq_date >= '2012-01-01' AND acq_date <= '2012-12-31');

CREATE TABLE modis_viirs.modis_2011() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2011 ADD CHECK(acq_date >= '2011-01-01' AND acq_date <= '2011-12-31');

CREATE TABLE modis_viirs.modis_2010() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2010 ADD CHECK(acq_date >= '2010-01-01' AND acq_date <= '2010-12-31');

CREATE TABLE modis_viirs.modis_2009() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2009 ADD CHECK(acq_date >= '2009-01-01' AND acq_date <= '2009-12-31');

CREATE TABLE modis_viirs.modis_2008() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2008 ADD CHECK(acq_date >= '2008-01-01' AND acq_date <= '2008-12-31');

CREATE TABLE modis_viirs.modis_2007() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2007 ADD CHECK(acq_date >= '2007-01-01' AND acq_date <= '2007-12-31');

CREATE TABLE modis_viirs.modis_2006() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2006 ADD CHECK(acq_date >= '2006-01-01' AND acq_date <= '2006-12-31');

CREATE TABLE modis_viirs.modis_2005() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2005 ADD CHECK(acq_date >= '2005-01-01' AND acq_date <= '2005-12-31');

CREATE TABLE modis_viirs.modis_2004() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2004 ADD CHECK(acq_date >= '2004-01-01' AND acq_date <= '2004-12-31');

CREATE TABLE modis_viirs.modis_2003() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2003 ADD CHECK(acq_date >= '2003-01-01' AND acq_date <= '2003-12-31');

CREATE TABLE modis_viirs.modis_2002() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2002 ADD CHECK(acq_date >= '2002-01-01' AND acq_date <= '2002-12-31');

CREATE TABLE modis_viirs.modis_2001() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2001 ADD CHECK(acq_date >= '2001-01-01' AND acq_date <= '2001-12-31');

CREATE TABLE modis_viirs.modis_2000() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2000 ADD CHECK(acq_date >= '2000-01-01' AND acq_date <= '2000-12-31');

CREATE TABLE modis_viirs.modis_2018() INHERITS(modis_viirs.modis);
ALTER TABLE modis_viirs.modis_2018 ADD CHECK(acq_date >= '2018-01-01' AND acq_date <= '2018-12-31');


--\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2448/fire_archive_M6_2448.csv'
--\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2448/fire_archive_M6_2448.csv'
--\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2448/fire_archive_M6_2448.csv'
--\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2448/fire_archive_M6_2448.csv'
--\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2448/fire_archive_M6_2448.csv' DELIMITER ',' csv header;
--\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2450/fire_archive_M6_2450.csv' DELIMITER ',' csv header;
--\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2454/fire_archive_M6_2454.csv' DELIMITER ',' csv header;
--\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2452/fire_archive_M6_2452.csv' DELIMITER ',' csv header;
--\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2456/fire_archive_M6_2456.csv' DELIMITER ',' csv header;
--\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2878/fire_archive_M6_2878.csv' DELIMITER ',' csv header;
--\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2880/fire_archive_M6_2880.csv' DELIMITER ',' csv header;
--\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_M6_2882/fire_archive_M6_2882.csv' DELIMITER ',' csv header;

\copy modis_viirs.modis(latitude ,longitude , brightness, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_t31,frp)
 FROM '/media/sf_Downloads/__effis/effis_ubuntu/modis_viirs/primo_download/DL_FIRE_M6_2448/fire_archive_M6_2448.csv' DELIMITER ',' csv header;