- Materialized View: effis.archived_burnt_areas_detailed

-- DROP MATERIALIZED VIEW effis.archived_burnt_areas_detailed;

CREATE MATERIALIZED VIEW effis.archived_burnt_areas_detailed AS 
 SELECT hba.id_source AS id_left,
    hba.year_id AS year_id_left,
    hba.ba_id AS ba_id_left,
    hba.firedate AS firedate_left,
    hba.lastupdate AS lastupdate_left,
    hbae.objectid,
    hbae.firedate,
    hbae.country,
    hbae.area_ha,
    hbae.place_name,
    hbae.province,
    hbae.lastupdate,
    hbae.yearid,
    hbae.id_source,
    hbae.yearseason,
    hbae.id,
    hbae.mese,
    hbae.lon,
    hbae.lat,
    hbae.se_anno_cad_data,
    hbae.countryfullname,
    hbae.lastfiredate,
    hbae.lastfiretime,
    hbae.shape,
    hbae.flag
   FROM effis.archived_burnt_area hba
     LEFT JOIN rdaprd.from2000_burntareas hbae ON hbae.yearid::text = hba.year_id::text
WITH DATA;

ALTER TABLE effis.archived_burnt_areas_detailed
  OWNER TO e1gwis;
  
  -- Materialized View: effis.ba_by_country_year

-- DROP MATERIALIZED VIEW effis.ba_by_country_year;

CREATE MATERIALIZED VIEW effis.ba_by_country_year AS 
 SELECT archived_burnt_areas_detailed.countryfullname AS "Country",
    date_part('year'::text, archived_burnt_areas_detailed.firedate::date) AS "Year",
    count(archived_burnt_areas_detailed.yearid) AS "Number of Fires",
    sum(archived_burnt_areas_detailed.area_ha) AS "Sum Ha Burnt Area"
   FROM effis.archived_burnt_areas_detailed
  GROUP BY GROUPING SETS ((archived_burnt_areas_detailed.countryfullname, (date_part('year'::text, archived_burnt_areas_detailed.firedate::date))), (archived_burnt_areas_detailed.countryfullname))
WITH DATA;

ALTER TABLE effis.ba_by_country_year
  OWNER TO e1gwis;
  
  -- Materialized View: effis.ba_by_country_year_month

-- DROP MATERIALIZED VIEW effis.ba_by_country_year_month;

CREATE MATERIALIZED VIEW effis.ba_by_country_year_month AS 
 SELECT archived_burnt_areas_detailed.countryfullname AS "Country",
    date_part('year'::text, archived_burnt_areas_detailed.firedate::date) AS "Year",
    date_part('month'::text, archived_burnt_areas_detailed.firedate::date) AS "Month",
    count(archived_burnt_areas_detailed.yearid) AS "Number of Fires",
    sum(archived_burnt_areas_detailed.area_ha) AS "Sum Ha Burnt Area"
   FROM effis.archived_burnt_areas_detailed
  GROUP BY GROUPING SETS ((archived_burnt_areas_detailed.countryfullname, (date_part('year'::text, archived_burnt_areas_detailed.firedate::date)), (date_part('month'::text, archived_burnt_areas_detailed.firedate::date))), (archived_burnt_areas_detailed.countryfullname))
WITH DATA;

ALTER TABLE effis.ba_by_country_year_month
  OWNER TO e1gwis;


-- Materialized View: effis.ba_by_country_year_month_total

-- DROP MATERIALIZED VIEW effis.ba_by_country_year_month_total;

CREATE MATERIALIZED VIEW effis.ba_by_country_year_month_total AS 
 SELECT archived_burnt_areas_detailed.countryfullname AS "Country",
    date_part('year'::text, archived_burnt_areas_detailed.firedate::date) AS "Year",
    date_part('month'::text, archived_burnt_areas_detailed.firedate::date) AS "Month",
    sum(archived_burnt_areas_detailed.area_ha) AS area_ettari
   FROM effis.archived_burnt_areas_detailed
  GROUP BY CUBE(((date_part('year'::text, archived_burnt_areas_detailed.firedate::date)), (date_part('month'::text, archived_burnt_areas_detailed.firedate::date))), archived_burnt_areas_detailed.countryfullname)
WITH DATA;

ALTER TABLE effis.ba_by_country_year_month_total
  OWNER TO e1gwis;
  
  
  -- Materialized View: effis.ba_by_country_year_month_total_by_month

-- DROP MATERIALIZED VIEW effis.ba_by_country_year_month_total_by_month;

CREATE MATERIALIZED VIEW effis.ba_by_country_year_month_total_by_month AS 
 SELECT archived_burnt_areas_detailed.countryfullname AS "Country",
    to_char(to_timestamp(date_part('month'::text, archived_burnt_areas_detailed.firedate::date)::text, 'MM'::text), 'Month'::text) AS "Month",
    sum(archived_burnt_areas_detailed.area_ha) AS area_ettari
   FROM effis.archived_burnt_areas_detailed
  GROUP BY ROLLUP((to_char(to_timestamp(date_part('month'::text, archived_burnt_areas_detailed.firedate::date)::text, 'MM'::text), 'Month'::text)), archived_burnt_areas_detailed.countryfullname)
WITH DATA;

ALTER TABLE effis.ba_by_country_year_month_total_by_month
  OWNER TO e1gwis;
  
  -- Materialized View: effis.ba_by_month_country

-- DROP MATERIALIZED VIEW effis.ba_by_month_country;

CREATE MATERIALIZED VIEW effis.ba_by_month_country AS 
 SELECT archived_burnt_areas_detailed.countryfullname AS "Country",
    to_char(to_timestamp(date_part('month'::text, archived_burnt_areas_detailed.firedate::date)::text, 'MM'::text), 'Month'::text) AS "Month",
    sum(archived_burnt_areas_detailed.area_ha) AS area_hectares
   FROM effis.archived_burnt_areas_detailed
  GROUP BY (to_char(to_timestamp(date_part('month'::text, archived_burnt_areas_detailed.firedate::date)::text, 'MM'::text), 'Month'::text)), archived_burnt_areas_detailed.countryfullname
  ORDER BY (to_char(to_timestamp(date_part('month'::text, archived_burnt_areas_detailed.firedate::date)::text, 'MM'::text), 'Month'::text))
WITH DATA;

ALTER TABLE effis.ba_by_month_country
  OWNER TO e1gwis;


-- Materialized View: effis.ba_by_monthnumeric_country

-- DROP MATERIALIZED VIEW effis.ba_by_monthnumeric_country;

CREATE MATERIALIZED VIEW effis.ba_by_monthnumeric_country AS 
 SELECT archived_burnt_areas_detailed.countryfullname AS "Country",
    date_part('month'::text, archived_burnt_areas_detailed.firedate::date) AS "Month",
    sum(archived_burnt_areas_detailed.area_ha) AS area_hectares
   FROM effis.archived_burnt_areas_detailed
  GROUP BY (date_part('month'::text, archived_burnt_areas_detailed.firedate::date)), archived_burnt_areas_detailed.countryfullname
  ORDER BY (date_part('month'::text, archived_burnt_areas_detailed.firedate::date))
WITH DATA;

ALTER TABLE effis.ba_by_monthnumeric_country
  OWNER TO e1gwis;

-- Materialized View: effis.ba_by_country_total_by_month

-- DROP MATERIALIZED VIEW effis.ba_by_country_total_by_month;

CREATE MATERIALIZED VIEW effis.ba_by_country_total_by_month AS 
 SELECT archived_burnt_areas_detailed.countryfullname AS "Country",
    to_char(to_timestamp(date_part('month'::text, archived_burnt_areas_detailed.firedate::date)::text, 'MM'::text), 'Month'::text) AS "Month",
    sum(archived_burnt_areas_detailed.area_ha) AS area_ettari
   FROM effis.archived_burnt_areas_detailed
  GROUP BY ROLLUP((to_char(to_timestamp(date_part('month'::text, archived_burnt_areas_detailed.firedate::date)::text, 'MM'::text), 'Month'::text)), archived_burnt_areas_detailed.countryfullname)
WITH DATA;

ALTER TABLE effis.ba_by_country_total_by_month
  OWNER TO e1gwis;