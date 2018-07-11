CREATE OR REPLACE VIEW effis.ba_stats_2018 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.current_burnt_area b,
    effis_countries a
  WHERE st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en);

CREATE MATERIALIZED VIEW effis.ba_stats_2017 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.archived_burnt_area b,
    effis_countries a
  WHERE b.firedate::date >= '2017-01-01'::date AND b.firedate::date <= '2017-12-31'::date AND st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en)
WITH DATA;

CREATE MATERIALIZED VIEW effis.ba_stats_2016 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.archived_burnt_area b,
    effis_countries a
  WHERE b.firedate::date >= '2016-01-01'::date AND b.firedate::date <= '2016-12-31'::date AND st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en)
WITH DATA;


CREATE MATERIALIZED VIEW effis.ba_stats_2015 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.archived_burnt_area b,
    effis_countries a
  WHERE b.firedate::date >= '2015-01-01'::date AND b.firedate::date <= '2015-12-31'::date AND st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en)
WITH DATA;


CREATE MATERIALIZED VIEW effis.ba_stats_2014 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.archived_burnt_area b,
    effis_countries a
  WHERE b.firedate::date >= '2014-01-01'::date AND b.firedate::date <= '2014-12-31'::date AND st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en)
WITH DATA;

CREATE MATERIALIZED VIEW effis.ba_stats_2013 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.archived_burnt_area b,
    effis_countries a
  WHERE b.firedate::date >= '2013-01-01'::date AND b.firedate::date <= '2013-12-31'::date AND st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en)
WITH DATA;

CREATE MATERIALIZED VIEW effis.ba_stats_2012 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.archived_burnt_area b,
    effis_countries a
  WHERE b.firedate::date >= '2012-01-01'::date AND b.firedate::date <= '2012-12-31'::date AND st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en)
WITH DATA;

CREATE MATERIALIZED VIEW effis.ba_stats_2011 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.archived_burnt_area b,
    effis_countries a
  WHERE b.firedate::date >= '2011-01-01'::date AND b.firedate::date <= '2011-12-31'::date AND st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en)
WITH DATA;

CREATE MATERIALIZED VIEW effis.ba_stats_2010 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.archived_burnt_area b,
    effis_countries a
  WHERE b.firedate::date >= '2010-01-01'::date AND b.firedate::date <= '2010-12-31'::date AND st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en)
WITH DATA;

CREATE MATERIALIZED VIEW effis.ba_stats_2009 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.archived_burnt_area b,
    effis_countries a
  WHERE b.firedate::date >= '2009-01-01'::date AND b.firedate::date <= '2009-12-31'::date AND st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en)
WITH DATA;

CREATE MATERIALIZED VIEW effis.ba_stats_2008 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.archived_burnt_area b,
    effis_countries a
  WHERE b.firedate::date >= '2008-01-01'::date AND b.firedate::date <= '2008-12-31'::date AND st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en)
WITH DATA;

CREATE MATERIALIZED VIEW effis.ba_stats_2007 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.archived_burnt_area b,
    effis_countries a
  WHERE b.firedate::date >= '2007-01-01'::date AND b.firedate::date <= '2007-12-31'::date AND st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en)
WITH DATA;

CREATE MATERIALIZED VIEW effis.ba_stats_2006 AS 
 SELECT a.name_en,
    date_part('year'::text, b.firedate::date) AS year_date,
    date_part('month'::text, b.firedate::date) AS month_date,
    sum(st_area(b.geom::geography) * 0.0001::double precision) AS sum,
    count(b.ba_id) AS count
   FROM effis.archived_burnt_area b,
    effis_countries a
  WHERE b.firedate::date >= '2006-01-01'::date AND b.firedate::date <= '2006-12-31'::date AND st_intersects(b.geom, a.geom)
  GROUP BY CUBE(((date_part('year'::text, b.firedate::date)), (date_part('month'::text, b.firedate::date))), a.name_en)
WITH DATA;

CREATE MATERIALIZED VIEW effis.ba_stats_2000_2017 AS 
 SELECT DISTINCT rob_burntareas_history.yearseason,
    rob_burntareas_history.country,
    count(rob_burntareas_history.id) OVER w AS "Number of Fires",
    sum(rob_burntareas_history.area_ha) OVER w AS "Summed Hectares"
   FROM rdaprd.rob_burntareas_history
  WINDOW w AS (PARTITION BY rob_burntareas_history.yearseason, rob_burntareas_history.country)
WITH DATA;

CREATE MATERIALIZED VIEW effis.ba_stats_206_comparison AS 
select name_en,sum,count from effis.ba_stats_2016 where year_date is null and month_date is null;

