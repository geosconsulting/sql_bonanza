CREATE or replace VIEW effis.current_ba_detailed as 
select pba.ba_id, pba.area_ha,pba.firedate,pba.lastupdate,pba.geom,
       oba.id,oba.country,oba.countryful,oba.province, oba.commune,
       oba.broadlea, oba.conifer, oba.mixed, oba.scleroph, oba.transit, 
       oba.othernatlc,oba.agriareas,oba.artifsurf, oba.otherlc, oba.percna2k,
       oba.class,oba.mic,oba.se_anno_cad_data, oba.critech 
from effis.current_burnt_area pba
    left join rdaprd.current_burntareaspoly oba on oba.id = pba.ba_id;


-- Materialized View: effis.ba_by_country_total_by_month

-- DROP MATERIALIZED VIEW effis.ba_by_country_total_by_month;

CREATE or replace VIEW effis.current_ba_country_total_by_month AS 
 SELECT current_ba_detailed.countryful AS "Country",
    to_char(to_timestamp(date_part('month'::text, current_ba_detailed.firedate::date)::text, 'MM'::text),     'Month'::text) AS "Month",
    sum(current_ba_detailed.area_ha) AS area_ettari
   FROM effis.current_ba_detailed
  GROUP BY ROLLUP((to_char(to_timestamp(date_part('month'::text, current_ba_detailed.firedate::date)::text, 'MM'::text), 'Month'::text)), current_ba_detailed.countryful);

ALTER TABLE effis.current_ba_country_total_by_month
  OWNER TO e1gwis;



CREATE or replace VIEW effis.current_ba_country_year_month_week_total AS 
 SELECT current_ba_detailed.countryful AS "Country",
    date_part('year'::text, current_ba_detailed.firedate::date) AS "Year",
    date_part('month'::text, current_ba_detailed.firedate::date) AS "Month",
    date_part('week'::text, current_ba_detailed.firedate::date) AS "Week",
    sum(current_ba_detailed.area_ha) AS area_hectares
   FROM effis.current_ba_detailed
  GROUP BY CUBE(((date_part('year'::text, current_ba_detailed.firedate::date)), (date_part('month'::text, current_ba_detailed.firedate::date)),(date_part('week'::text, current_ba_detailed.firedate::date))), current_ba_detailed.countryful);

ALTER MATERIALized VIEW effis.ba_country_year RENAME TO archived_ba_country_year;