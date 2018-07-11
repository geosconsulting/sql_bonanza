-- Function: effis.burntarea_aggregate(text, date, date, character varying)

-- DROP FUNCTION effis.burntarea_aggregate(text, date, date, character varying);

CREATE OR REPLACE FUNCTION effis.burntarea_aggregate(
    IN country_txt text,
    IN from_date date,
    IN to_date date,
    IN split character varying)
  RETURNS TABLE(id integer, fire_date date, conifer numeric, broadleaf numeric, mixed numeric) AS
$BODY$
BEGIN
     RETURN QUERY
     SELECT ba.id, ba.firedate, ba.conifer, ba.broadlea , ba.mixed 
     FROM public.burnt_area ba, public.countries_country_simple cnt
     WHERE cnt.name_en = country_txt  
     AND firedate BETWEEN(from_date) AND (to_date)
     AND ST_Within(ba.geom, cnt.geom);  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.burntarea_aggregate(text, date, date, character varying)
  OWNER TO postgres;
