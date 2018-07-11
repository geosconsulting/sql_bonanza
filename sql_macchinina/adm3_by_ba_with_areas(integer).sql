-- Function: effis.adm3_by_ba_with_areas(integer)

-- DROP FUNCTION effis.adm3_by_ba_with_areas(integer);

CREATE OR REPLACE FUNCTION effis.adm3_by_ba_with_areas(IN code integer)
  RETURNS TABLE(admin_id integer, name_adm3 character varying, area_ha double precision) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT p.id, p.name_local, ST_Area(ST_Intersection(p.geom,b.geom)::geography)*0.0001 As area_intersection
     FROM effis.current_burnt_area b       
	INNER JOIN public.admin_level_3 p ON ST_Intersects(p.geom,b.geom)
     WHERE b.ba_id = code
     ORDER BY area_intersection DESC;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.adm3_by_ba_with_areas(integer)
  OWNER TO postgres;
