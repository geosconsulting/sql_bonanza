CREATE TABLE modis_viirs.viirs
(
  modis_id serial NOT NULL,
  latitude numeric,
  longitude numeric,
  bright_ti4 numeric,
  scan numeric,
  track numeric,
  acq_date date,
  acq_time time without time zone,
  satellite boolean,
  instrument character varying(6),
  confidence character varying,
  version_tf boolean,
  bright_ti5 numeric,
  frp numeric,
  geom geometry(Point,4326),
  CONSTRAINT viirs_pk PRIMARY KEY (modis_id),
  CONSTRAINT enforce_dims_geom CHECK (st_ndims(geom) = 2),
  CONSTRAINT enforce_geotype_geom CHECK (geometrytype(geom) = 'POINT'::text OR geom IS NULL),
  CONSTRAINT enforce_srid_geom CHECK (st_srid(geom) = 4326)
)
WITH (
  OIDS=FALSE
);

CREATE TRIGGER hotspots_viirs_insert
  BEFORE INSERT
  ON modis_viirs.viirs
  FOR EACH ROW
  EXECUTE PROCEDURE modis_viirs.on_hotspot_viirs_insert();
  
 CREATE TABLE modis_viirs.viirs_2012() INHERITS(modis_viirs.viirs);
ALTER TABLE modis_viirs.viirs_2012 ADD CHECK(acq_date >= '2012-01-01' AND acq_date <= '2012-12-31');

CREATE TABLE modis_viirs.viirs_2013() INHERITS(modis_viirs.viirs);
ALTER TABLE modis_viirs.viirs_2013 ADD CHECK(acq_date >= '2013-01-01' AND acq_date <= '2013-12-31');

CREATE TABLE modis_viirs.viirs_2014() INHERITS(modis_viirs.viirs);
ALTER TABLE modis_viirs.viirs_2014 ADD CHECK(acq_date >= '2014-01-01' AND acq_date <= '2014-12-31');

CREATE TABLE modis_viirs.viirs_2015() INHERITS(modis_viirs.viirs);
ALTER TABLE modis_viirs.viirs_2015 ADD CHECK(acq_date >= '2015-01-01' AND acq_date <= '2015-12-31');

CREATE TABLE modis_viirs.viirs_2016() INHERITS(modis_viirs.viirs);
ALTER TABLE modis_viirs.viirs_2016 ADD CHECK(acq_date >= '2016-01-01' AND acq_date <= '2016-12-31');

CREATE TABLE modis_viirs.viirs_2017() INHERITS(modis_viirs.viirs);
ALTER TABLE modis_viirs.viirs_2017 ADD CHECK(acq_date >= '2017-01-01' AND acq_date <= '2017-12-31');

CREATE TABLE modis_viirs.viirs_2018() INHERITS(modis_viirs.viirs);
ALTER TABLE modis_viirs.viirs_2018 ADD CHECK(acq_date >= '2018-01-01' AND acq_date <= '2018-12-31');

\copy modis_viirs.modis(latitude ,longitude , bright_ti4, scan, track , acq_date,acq_time,satellite,instrument,confidence,version,bright_ti5,frp) FROM '/media/sf_E_DRIVE/lanalfa/Documents/Downloads/modis_viirs/DL_FIRE_V1_4965/fire_archive_V1_4965.csv'