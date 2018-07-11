-- Function: effis.burntarea_aggregate_rec(text, date, date)

-- DROP FUNCTION effis.burntarea_aggregate_rec(text, date, date);

CREATE OR REPLACE FUNCTION effis.burntarea_aggregate_rec(
    IN country_txt text,
    IN from_date date,
    IN to_date date,
    OUT num_ba bigint,
    OUT sum_area_ba double precision)
  RETURNS record AS
$BODY$
BEGIN 
     SELECT COUNT(ba.geom), SUM(ST_Area(ba.geom))
     INTO num_ba, sum_area_ba
     FROM public.current_burnt_area ba, effis.admin_level_0 cnt
     WHERE cnt.name_en = country_txt  
     AND firedate BETWEEN(from_date) AND (to_date)
     AND ST_Within(ba.geom, cnt.geom);  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION effis.burntarea_aggregate_rec(text, date, date)
  OWNER TO postgres;
