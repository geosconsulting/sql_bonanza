CREATE OR REPLACE FUNCTION effis.adm_by_fireid(IN code integer,IN admin_level integer,IN ba_status varchar)
  RETURNS TABLE(f_id integer, adm3_code integer, firedate character varying, update character varying, name_adm3 character varying) AS
$BODY$
DECLARE
    admin_level varchar := 'public.admin_level_' || admin_level;
    adm_id varchar := 'adm' || admin_level ||'_id';
    adm_mm varchar := 'admin_link.ba_adm' || admin_level;
BEGIN
   RAISE NOTICE 'Nome tabella %' , admin_level;
   RETURN QUERY
     EXECUTE '
     SELECT a.fire_id,a.'|| adm_id ||',b.firedate,b.lastupdate,c.name_en
	FROM ' || adm_mm ||' a
	   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.ba_id)
	   LEFT JOIN ' || admin_level || ' c ON(a.' || adm_id || '= c.id)
	WHERE a.fire_id = ' || code;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.adm3_by_fireid(integer)
  OWNER TO postgres;
  
SELECT a.fire_id,a.3,b.firedate,b.lastupdate,c.name_en 
FROM admin_link.ba_adm3 a 
	 LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.ba_id) 
	 LEFT JOIN public.admin_level_3 c ON(a.adm3_id= c.id) 
WHERE a.fire_id = 3129;


ALTER TABLE effis.current_burnt_area ALTER COLUMN geom type geometry(Polygon, 4326);
ALTER TABLE effis.current_burnt_area_evolution ALTER COLUMN geom type geometry(Polygon, 4326);

ALTER TABLE effis.archived_burnt_area ALTER COLUMN geom type geometry(MultiPolygon, 4326) USING ST_Multi(geom);
ALTER TABLE effis.archived_burnt_area_evolution ALTER COLUMN geom type geometry(MultiPolygon, 4326) USING ST_Multi(geom);

SELECT ba_id AS "ID", (ROUND(ST_Area(geom::geography)*0.0001)) AS "Area HA" 
FROM effis.current_burnt_area;

--AREE UGUALI
SELECT a.ba_id,b.id 
FROM effis.current_burnt_area a,rdaprd.current_burntareaspoly b
WHERE ST_Equals(a.geom, b.shape);

SELECT a.id,b.id 
FROM effis.current_burntareaspoly a,rdaprd.current_burntareaspoly b
WHERE ST_Equals(a.shape, b.shape);


SELECT a.ba_id,b.id 
FROM effis.current_burnt_area a,rdaprd.current_burntareaspoly b
WHERE ST_Equals(a.geom, b.shape);

SELECT a.id,b.id 
FROM effis.current_burntareaspoly a,rdaprd.current_burntareaspoly b
WHERE ST_Equals(a.shape, b.shape);

SELECT a.ba_id,b.id 
FROM effis.current_burnt_area a, rdaprd.current_burntareaspoly b
WHERE ST_Overlaps(a.geom, b.shape);

SELECT a.id,b.id 
FROM effis.current_burntareaspoly a,rdaprd.current_burntareaspoly b
WHERE ST_Disjoint(a.shape, b.shape);

SELECT a.id,b.id, ST_DIstance(a.shape, b.shape)
FROM effis.current_burntareaspoly a,rdaprd.current_burntareaspoly b;

SELECT a.id,b.id, ST_Distance(a.shape, b.shape),ST_Distance(a.shape::geography, b.shape::geography)*0.001
FROM effis.current_burntareaspoly a,rdaprd.current_burntareaspoly b;

SELECT a.id,b.id, ST_DIstance(a.shape::geography, b.shape::geography)
FROM effis.current_burntareaspoly a,rdaprd.current_burntareaspoly b;
