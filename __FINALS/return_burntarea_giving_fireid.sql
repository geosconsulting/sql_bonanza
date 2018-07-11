-- Function: fire_admin_link.adm2_by_fireid(integer)

-- DROP FUNCTION fire_admin_link.adm2_by_fireid(integer);

CREATE OR REPLACE FUNCTION fire_admin_link.adm2_by_fireid(IN code integer)
  RETURNS TABLE(f_id integer, adm3_code integer, firedate character varying, update character varying, name_adm2 character varying) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT a.fire_id,a.adm2_id,b.firedate,b.lastupdate,c.name_en
	FROM fire_admin_link.ba_adm2 a
	   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
	   LEFT JOIN public.countries_adminsublevel2 c ON(a.adm2_id = c.id)
	WHERE a.fire_id = code;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION fire_admin_link.adm2_by_fireid(integer)
  OWNER TO postgres;


-- DROP FUNCTION fire_admin_link.adm3_by_fireid(integer);

CREATE OR REPLACE FUNCTION fire_admin_link.adm3_by_fireid(IN code integer)
  RETURNS TABLE(f_id integer, adm3_code integer, firedate character varying, update character varying, name_adm3 character varying) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT a.fire_id,a.adm3_id,b.firedate,b.lastupdate,c.name_en
	FROM fire_admin_link.ba_adm3 a
	   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
	   LEFT JOIN public.countries_adminsublevel3 c ON(a.adm3_id = c.id)
	WHERE a.fire_id = code;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION fire_admin_link.adm3_by_fireid(integer)
  OWNER TO postgres;

 
-- DROP FUNCTION fire_admin_link.adm1_by_fireid(integer);

CREATE OR REPLACE FUNCTION fire_admin_link.adm1_by_fireid(IN code integer)
  RETURNS TABLE(f_id integer, adm1_code integer, firedate character varying, update character varying, name_adm1 character varying) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT a.fire_id,a.adm1_id,b.firedate,b.lastupdate,c.name_en
	FROM fire_admin_link.ba_adm1 a
	   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
	   LEFT JOIN public.countries_adminsublevel1 c ON(a.adm1_id = c.id)
	WHERE a.fire_id = code;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION fire_admin_link.adm1_by_fireid(integer)
  OWNER TO postgres;


SELECT b.geom As bgeom, p.geom As pgeom, 
       ST_Intersection(b.geom, p.geom) As intersect_bp
FROM effis.burnt_area_spatial b 
      INNER JOIN public.countries_adminsublevel3 p ON ST_Intersects(b.geom,p.geom)
WHERE ST_Overlaps(b.geom, p.geom)
AND b.id = 6097
LIMIT 1;

SELECT b.geom As bgeom, p.geom As pgeom, p.id,b.id,
       ST_Intersection(b.geom, p.geom) As intersect_bp
FROM effis.burnt_area_spatial b       
     INNER JOIN public.countries_adminsublevel3 p ON ST_Intersects(b.geom,p.geom)
WHERE ST_Overlaps(b.geom, p.geom)
AND b.id = 6097
LIMIT 1;

SELECT p.id,b.id,p.name_local,ST_Area(ST_Intersection(b.geom, p.geom)) As area_intersection
FROM effis.burnt_area_spatial b       
     INNER JOIN public.countries_adminsublevel3 p ON ST_Intersects(b.geom,p.geom)
WHERE ST_Overlaps(b.geom, p.geom)
AND b.id = 6097;
--LIMIT 1;

SELECT p.id,b.id,p.name_local,ST_Area(ST_Intersection(b.geom, p.geom)) As area_intersection
FROM effis.burnt_area_spatial b       
     INNER JOIN public.countries_adminsublevel3 p ON ST_Intersects(b.geom,p.geom)
WHERE b.id = 6097;

SELECT p.id,b.id,p.name_local,ST_Area(ST_Intersection(b.geom, p.geom)) As area_intersection
FROM effis.burnt_area_spatial b       
     INNER JOIN public.countries_adminsublevel3 p ON ST_Intersects(b.geom,p.geom)
WHERE b.id = 5348
ORDER BY area_intersection;

SELECT p.id,b.id,b.firedate,b.lastupdate,p.name_local,ST_Area(ST_Intersection(b.geom, p.geom)) As area_intersection
FROM effis.burnt_area_spatial b       
     INNER JOIN public.countries_adminsublevel2 p ON ST_Intersects(b.geom,p.geom)
WHERE b.id = 3993
ORDER BY area_intersection DESC;

-- DROP FUNCTION fire_admin_link.adm2_by_fireid_with_areas(integer);

CREATE OR REPLACE FUNCTION fire_admin_link.adm2_by_fireid_with_areas(IN code integer)
  RETURNS TABLE(f_id integer, adm2_code integer, firedate character varying, update character varying, name_adm2 character varying,area float8) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT p.id,b.id,b.firedate,b.lastupdate,p.name_local,ST_Area(ST_Intersection(b.geom, p.geom)) As area_intersection
     FROM effis.burnt_area_spatial b       
	INNER JOIN public.countries_adminsublevel2 p ON ST_Intersects(b.geom,p.geom)
     WHERE b.id = code
     ORDER BY area_intersection DESC;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION fire_admin_link.adm2_by_fireid_with_areas(integer)
  OWNER TO postgres;

-- DROP FUNCTION fire_admin_link.adm1_by_fireid_with_areas(integer);

CREATE OR REPLACE FUNCTION fire_admin_link.adm1_by_fireid_with_areas(IN code integer)
  RETURNS TABLE(f_id integer, adm1_code integer, firedate character varying, update character varying, name_adm1 character varying,area float8) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT p.id,b.id,b.firedate,b.lastupdate,p.name_local,ST_Area(ST_Intersection(b.geom, p.geom)) As area_intersection
     FROM effis.burnt_area_spatial b       
	INNER JOIN public.countries_adminsublevel1 p ON ST_Intersects(b.geom,p.geom)
     WHERE b.id = code
     ORDER BY area_intersection DESC;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION fire_admin_link.adm1_by_fireid_with_areas(integer)
  OWNER TO postgres;

-- DROP FUNCTION fire_admin_link.adm3_by_fireid_with_areas(integer);

CREATE OR REPLACE FUNCTION fire_admin_link.adm3_by_fireid_with_areas(IN code integer)
  RETURNS TABLE(f_id integer, adm3_code integer, firedate character varying, update character varying, name_adm3 character varying,area float8) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT p.id,b.id,b.firedate,b.lastupdate,p.name_local,ST_Area(ST_Intersection(b.geom, p.geom)) As area_intersection
     FROM effis.burnt_area_spatial b       
	INNER JOIN public.countries_adminsublevel3 p ON ST_Intersects(b.geom,p.geom)
     WHERE b.id = code
     ORDER BY area_intersection DESC;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION fire_admin_link.adm3_by_fireid_with_areas(integer)
  OWNER TO postgres;

SELECT ST_AsText(ST_Intersection('POINT(0 0)'::geometry, 'LINESTRING ( 2 0, 0 2 )'::geometry));
SELECT ST_AsText(ST_Intersection('POINT(0 0)'::geometry, 'LINESTRING ( 0 0, 0 2 )'::geometry));

SEELCT ST_AsText(ST_Intersection(linestring, polygon)) As wkt
FROM  ST_GeomFromText('LINESTRING Z (2 2 6,1.5 1.5 7,1 1 8,0.5 0.5 8,0 0 10)') AS linestring
CROSS JOIN ST_GeomFromText('POLYGON((0 0 8, 0 1 8, 1 1 8, 1 0 8, 0 0 8))') AS polygon;