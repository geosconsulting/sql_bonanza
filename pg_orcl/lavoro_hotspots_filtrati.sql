DROP MATERIALIZED VIEW rdaprd.hotspot_filtered CASCADE;

--CREATE MATERIALIZED VIEW rdaprd.hotspot_filtered AS (
--SELECT * FROM rdaprd.rob_modis_hotspots_since2006);

CREATE MATERIALIZED VIEW rdaprd.hotspot_filtered AS (
	SELECT objectid,
	    lea_longit,
	    lea_latitu,
	    fp_confide,
	    fp_t21,
	    fp_t31,
	    fp_power,
	    file_name,
	    hs_date,
	    hs_time,
	    t_a,
	    code_00,
	    nucncd,
	    corinweb,
	    origine,
	    speccase,
	    shape AS geom
	FROM rdaprd.rob_modis_hotspots_since2006);

DROP TABLE rdaprd.filtered_modis_hotspots CASCADE;

CREATE TABLE rdaprd.filtered_modis_hotspots
   (id serial NOT NULL,
    gid integer,
    objectid varchar,
    lea_longitude numeric,
    lea_latitude numeric,
    fp_confidence bigint,
    fp_t21 numeric,
    fp_t31 numeric,
    fp_power numeric,
    file_name varchar,
    hs_date date,
    hs_time varchar,
    t_a varchar,
    code_00 varchar,
    nucncd varchar,
    geom geometry('MULTIPOINT',4326));
    
ALTER TABLE rdaprd.filtered_modis_hotspots OWNER TO postgres;
ALTER TABLE rdaprd.filtered_modis_hotspots ADD CONSTRAINT filtered_modis_pk PRIMARY KEY(id);
ALTER TABLE rdaprd.filtered_modis_hotspots ADD CONSTRAINT enforce_dims_geom_fmh CHECK(st_ndims(geom) = 2);
ALTER TABLE rdaprd.filtered_modis_hotspots ADD CONSTRAINT enforce_geotype_geom_fmh CHECK(geometrytype(geom) = 'MULTIPOINT'::text OR geom IS NULL);
ALTER TABLE rdaprd.filtered_modis_hotspots ADD CONSTRAINT enforce_srid_geom_fmh CHECK(st_srid(geom) = 4326);

-- DROP TABLE rdaprd.filtered_modis_hotspots_2017;

CREATE TABLE rdaprd.filtered_modis_hotspots_2017() INHERITS(rdaprd.filtered_modis_hotspots);
ALTER TABLE rdaprd.filtered_modis_hotspots_2017 ADD CHECK(hs_date >= '2017-01-01' AND hs_date <= '2017-12-31');

CREATE TABLE rdaprd.filtered_modis_hotspots_2016() INHERITS(rdaprd.filtered_modis_hotspots);
ALTER TABLE rdaprd.filtered_modis_hotspots_2016 ADD CHECK(hs_date >= '2016-01-01' AND hs_date <= '2016-12-31');

CREATE TABLE rdaprd.filtered_modis_hotspots_2015() INHERITS(rdaprd.filtered_modis_hotspots);
ALTER TABLE rdaprd.filtered_modis_hotspots_2015 ADD CHECK(hs_date >= '2015-01-01' AND hs_date <= '2015-12-31');

CREATE TABLE rdaprd.filtered_modis_hotspots_2014() INHERITS(rdaprd.filtered_modis_hotspots);
ALTER TABLE rdaprd.filtered_modis_hotspots_2014 ADD CHECK(hs_date >= '2014-01-01' AND hs_date <= '2014-12-31');

CREATE TABLE rdaprd.filtered_modis_hotspots_2013() INHERITS(rdaprd.filtered_modis_hotspots);
ALTER TABLE rdaprd.filtered_modis_hotspots_2013 ADD CHECK(hs_date >= '2013-01-01' AND hs_date <= '2013-12-31');

CREATE TABLE rdaprd.filtered_modis_hotspots_2012() INHERITS(rdaprd.filtered_modis_hotspots);
ALTER TABLE rdaprd.filtered_modis_hotspots_2012 ADD CHECK(hs_date >= '2012-01-01' AND hs_date <= '2012-12-31');

CREATE TABLE rdaprd.filtered_modis_hotspots_2011() INHERITS(rdaprd.filtered_modis_hotspots);
ALTER TABLE rdaprd.filtered_modis_hotspots_2011 ADD CHECK(hs_date >= '2011-01-01' AND hs_date <= '2011-12-31');

CREATE TABLE rdaprd.filtered_modis_hotspots_2010() INHERITS(rdaprd.filtered_modis_hotspots);
ALTER TABLE rdaprd.filtered_modis_hotspots_2010 ADD CHECK(hs_date >= '2010-01-01' AND hs_date <= '2010-12-31');

CREATE TABLE rdaprd.filtered_modis_hotspots_2009() INHERITS(rdaprd.filtered_modis_hotspots);
ALTER TABLE rdaprd.filtered_modis_hotspots_2009 ADD CHECK(hs_date >= '2009-01-01' AND hs_date <= '2009-12-31');

CREATE TABLE rdaprd.filtered_modis_hotspots_2008() INHERITS(rdaprd.filtered_modis_hotspots);
ALTER TABLE rdaprd.filtered_modis_hotspots_2008 ADD CHECK(hs_date >= '2008-01-01' AND hs_date <= '2008-12-31');

CREATE TABLE rdaprd.filtered_modis_hotspots_2007() INHERITS(rdaprd.filtered_modis_hotspots);
ALTER TABLE rdaprd.filtered_modis_hotspots_2007 ADD CHECK(hs_date >= '2007-01-01' AND hs_date <= '2007-12-31');

CREATE TABLE rdaprd.filtered_modis_hotspots_2006() INHERITS(rdaprd.filtered_modis_hotspots);
ALTER TABLE rdaprd.filtered_modis_hotspots_2006 ADD CHECK(hs_date >= '2006-01-01' AND hs_date <= '2006-12-31');

--ORACLE NON FUNZIONA CAMBIAMO METODO
INSERT INTO rdaprd.filtered_modis_hotspots(objectid,lea_longit, lea_latitu,fp_confide, fp_t21, fp_t31,fp_power,
					   file_name, hs_date, hs_time, t_a, code_00, nucncd, corinweb, 
		                           geom) 
		                           SELECT 
		                           objectid, lea_longit,lea_latitu, fp_confide, fp_t21, fp_t31, fp_power, file_name, hs_date::date,
					   hs_time, t_a, code_00, nucncd, corinweb, shape 
					   FROM rdaprd.rob_modis_hotspots_since2006;

--2006/2007
ALTER TABLE temp.hs2006
    ALTER COLUMN geom TYPE geometry(MultiPoint,4326) USING ST_Multi(geom);

ALTER TABLE temp.hs2007
    ALTER COLUMN geom TYPE geometry(MultiPoint,4326) USING ST_Multi(geom);


INSERT INTO rdaprd.filtered_modis_hotspots(gid,objectid, lea_longitude, lea_latitude, fp_confidence, fp_t21 , fp_t31, 
                                           fp_power , file_name , hs_date , hs_time ,t_a , code_00 , nucncd , geom) 
		                           SELECT 
		                           gid, objectid, lea_longit, lea_latitu, fp_confide, fp_t21, fp_t31, fp_power, file_name, hs_date::date,
					   hs_time, t_a, code_00, nucncd, geom FROM temp.hs2006;

INSERT INTO rdaprd.filtered_modis_hotspots(gid,objectid, lea_longitude, lea_latitude, fp_confidence, fp_t21 , fp_t31, 
                                           fp_power , file_name , hs_date , hs_time ,t_a , code_00 , nucncd , geom) 
		                           SELECT 
		                           gid, objectid, lea_longit, lea_latitu, fp_confide, fp_t21, fp_t31, fp_power, file_name, hs_date::date,
					   hs_time, t_a, code_00, nucncd, geom FROM temp.hs2007;


--2008/2017
INSERT INTO rdaprd.filtered_modis_hotspots(gid,objectid, lea_longitude, lea_latitude, fp_confidence, fp_t21 , fp_t31, 
                                           fp_power , file_name , hs_date , hs_time ,t_a , code_00 , nucncd , geom) 
		                           SELECT 
		                           id, objectid, lea_longit, lea_latitu, fp_confide, fp_t21, fp_t31, fp_power, file_name, hs_date::date,
					   hs_time, t_a, code_00, nucncd, geom FROM temp.hs2008_2017;

ALTER TABLE rdaprd.filtered_modis_hotspots RENAME COLUMN nucncd TO iso2;

SELECT iso2, EXTRACT(YEAR FROM hs_date) AS year, COUNT(id) FROM rdaprd.filtered_modis_hotspots WHERE iso2 = 'IT' GROUP BY (iso2,year) ORDER BY(year);

SELECT iso2, EXTRACT(YEAR FROM hs_date) AS year, COUNT(id) FROM rdaprd.filtered_modis_hotspots WHERE iso2 = 'IT' GROUP BY ROLLUP(iso2,year) ORDER BY(year);

SELECT iso2, EXTRACT(YEAR FROM hs_date) AS year, COUNT(id) FROM rdaprd.filtered_modis_hotspots WHERE iso2 IN ('IT','PT') GROUP BY ROLLUP(iso2,year) ORDER BY(iso2);

--SELECT iso2,
--       EXTRACT(YEAR FROM hs_date) AS year,
--       COUNT(id) as all,
--       COUNT(id) as FILTER(WHERE year < 2008) AS old,
--       COUNT(id) as FILTER(WHERE year >=2008) AS recent
--FROM rdaprd.filtered_modis_hotspots
--GROUP BY ROLLUP(iso2,year);

SELECT iso2,
       EXTRACT(YEAR FROM hs_date) AS year,       
       COUNT(id) OVER () --(PARTITION BY iso2)
FROM rdaprd.filtered_modis_hotspots;

--TOTALE PER ANNO PER PAESE E TOTALE NEL PAESE NEGLI ANNI
CREATE MATERIALIZED VIEW rdaprd.hotspot_by_country_year AS 
	SELECT iso2, EXTRACT(YEAR FROM hs_date) AS year, COUNT(id) 
	FROM rdaprd.filtered_modis_hotspots 
	GROUP BY ROLLUP(iso2,year) ORDER BY(iso2);

SELECT iso2, EXTRACT(YEAR FROM hs_date) AS year, COUNT(id) FROM rdaprd.filtered_modis_hotspots WHERE iso2 = 'IT' GROUP BY CUBE(iso2,year) ORDER BY(iso2);
