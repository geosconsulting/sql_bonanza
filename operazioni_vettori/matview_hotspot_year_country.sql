-- Materialized View: rdaprd.hotspot_by_country_year

DROP MATERIALIZED VIEW rdaprd.hotspot_by_country_year;

CREATE MATERIALIZED VIEW rdaprd.hotspot_by_country_year AS 
 SELECT ad.name_en,
    date_part('year'::text, hs.hs_date) AS year,
    count(hs.id) AS count    
  FROM rdaprd.filtered_modis_hotspots hs, public.admin_level_0 ad
  WHERE hs.iso2 = ad.iso2
  GROUP BY ROLLUP(ad.name_en,(date_part('year'::text, hs.hs_date)))
  ORDER BY ad.name_en
WITH DATA;

ALTER TABLE rdaprd.hotspot_by_country_year
  OWNER TO postgres;
