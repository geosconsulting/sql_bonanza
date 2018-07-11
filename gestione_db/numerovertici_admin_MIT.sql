SELECT ST_Npoints(geom) As np_before, 
ST_NPoints(ST_Simplify(geom,0.0005)) As np00005,
ST_NPoints(ST_Simplify(geom,0.001)) As np0001, 
ST_NPoints(ST_Simplify(geom,0.01)) As np001, 
ST_NPoints(ST_Simplify(geom,0.1)) As np01, 
ST_NPoints(ST_Simplify(geom,0.5)) As np05,
ST_NPoints(ST_Simplify(geom,1)) As np1
FROM countries_country WHERE name_iso = 'NIGERIA';

SELECT name_en,name_iso FROM countries_country WHERE name_en LIKE 'Nig%';

SELECT shape FROM countries_country WHERE name_iso = 'Nigeria';

ALTER TABLE countries_country RENAME COLUMN shape TO geom;

CREATE TABLE countries_country_simple AS 
SELECT id,name_en,name_iso,name_local,area,created_at,updated_at,iso,iso2,entity_type_id,ST_SimplifyPreserveTopology(geom,0.0005)  AS geom
FROM countries_country;

CREATE TABLE countries_adminsublevel1_simple AS 
SELECT 	id,
	name_en,
	name_local,
	area,
	created_at,
	updated_at,
	country_id,	
	entity_type_id,
	hasc,
	cca,
	ccn,
	ST_SimplifyPreserveTopology(geom,0.0005) AS geom
FROM countries_adminsublevel1;

CREATE TABLE countries_adminsublevel2_simple AS 
SELECT 	id,
	name_en,
	name_local,
	area,
	created_at,
	updated_at,
	country_id,	
	entity_type_id,
	admin1_id,
	hasc,
	cca,
	ccn,
	ST_SimplifyPreserveTopology(geom,0.0005) AS geom
FROM countries_adminsublevel2;

CREATE TABLE countries_adminsublevel3_simple AS 
SELECT 	id,
	name_en,
	name_local,
	area,
	created_at,
	updated_at,
	country_id,	
	entity_type_id,
	admin1_id,
	admin2_id,	
	cca,
	ccn,
	ST_SimplifyPreserveTopology(geom,0.0005) AS geom
FROM countries_adminsublevel3;

CREATE TABLE countries_adminsublevel4_simple AS 
SELECT 	id,
	name_en,
	name_local,
	area,
	created_at,
	updated_at,
	country_id,	
	entity_type_id,
	admin1_id,
	admin2_id,
	admin3_id,	
	cca,
	ccn,
	ST_SimplifyPreserveTopology(geom,0.0005) AS geom
FROM countries_adminsublevel4;
