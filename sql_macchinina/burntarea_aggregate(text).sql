-- Function: effis.burntarea_aggregate(text)

-- DROP FUNCTION effis.burntarea_aggregate(text);

CREATE OR REPLACE FUNCTION effis.burntarea_aggregate(IN country_txt text)
  RETURNS TABLE(num_ba bigint, summed_area double precision) AS
$BODY$
BEGIN
     RETURN QUERY
     SELECT COUNT(ba.geom), 
	SUM(ST_Area(ba.geom))
     FROM effis.current_burnt_area ba, public.admin_level_0 cnt
     WHERE cnt.name_en = country_txt 
     AND ST_Within(ba.geom, cnt.geom);  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.burntarea_aggregate(text)
  OWNER TO postgres;
