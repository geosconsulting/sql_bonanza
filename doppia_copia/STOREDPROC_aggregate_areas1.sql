DROP FUNCTION effis_burntarea_aggregate(text);

CREATE OR REPLACE FUNCTION effis_burntarea_aggregate(IN country_txt text) 
RETURNS TABLE (
     num_ba  bigint
    ,summed_area double precision) AS $$
BEGIN
     RETURN QUERY
     SELECT COUNT(ba.geom), 
	SUM(ST_Area(ba.geom))
     FROM public.burnt_area ba, public.countries_country cnt
     WHERE cnt.name_en = country_txt 
     AND ST_Within(ba.geom, cnt.geom);  
END;
$$ LANGUAGE plpgsql;

SELECT effis_burntarea_aggregate('Greece');

DROP FUNCTION effis_burntarea_aggregate(text,date,date);

CREATE OR REPLACE FUNCTION effis_burntarea_aggregate(IN country_txt text, from_date DATE, to_date DATE) 
RETURNS TABLE (
     num_ba  bigint
    ,summed_area double precision) AS $$
BEGIN
     RETURN QUERY
     SELECT COUNT(ba.geom), 
	SUM(ST_Area(ba.geom))
     FROM public.burnt_area ba, public.countries_country cnt
     WHERE cnt.name_en = country_txt  
     AND firedate BETWEEN(from_date) AND (to_date)
     AND ST_Within(ba.geom, cnt.geom);  
END;
$$ LANGUAGE plpgsql;

SELECT effis_burntarea_aggregate('Portugal' ,'01-01-2017','01-04-2017');

DROP FUNCTION effis_burntarea_aggregate(text,date,date,varchar(1));

CREATE OR REPLACE FUNCTION effis_burntarea_aggregate(IN country_txt text, from_date DATE, to_date DATE, split varchar(1)) 
RETURNS TABLE (
     id  int
    ,fire_date date
    ,conifer numeric
    ,broadleaf numeric
    ,mixed numeric) AS $$
BEGIN
     RETURN QUERY
     SELECT ba.id, ba.firedate, ba.conifer, ba.broadlea , ba.mixed 
     FROM public.burnt_area ba, public.countries_country cnt
     WHERE cnt.name_en = country_txt  
     AND firedate BETWEEN(from_date) AND (to_date)
     AND ST_Within(ba.geom, cnt.geom);  
END;
$$ LANGUAGE plpgsql;

SELECT effis_burntarea_aggregate('Portugal' ,'01-01-2017','01-04-2017','s');


DROP FUNCTION effis_burntarea_aggregate_rec(text,date,date);

CREATE OR REPLACE FUNCTION effis_burntarea_aggregate_rec
			(IN country_txt text,IN from_date DATE,IN to_date DATE
			,OUT num_ba bigint,OUT sum_area_ba double precision) 
AS $$
BEGIN 
     SELECT COUNT(ba.geom), SUM(ST_Area(ba.geom))
     INTO num_ba, sum_area_ba
     FROM public.burnt_area ba, public.countries_country cnt
     WHERE cnt.name_en = country_txt  
     AND firedate BETWEEN(from_date) AND (to_date)
     AND ST_Within(ba.geom, cnt.geom);  
END;
$$ LANGUAGE plpgsql;

SELECT effis_burntarea_aggregate_rec('Portugal' ,'01-01-2017','01-04-2017');
