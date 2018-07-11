CREATE TABLE cross_effis_nasamodis.ba_modis_2017 AS 
 SELECT archived_burnt_area.id_source,
    archived_burnt_area.year_id,
    archived_burnt_area.ba_id,
    archived_burnt_area.area_ha,
    archived_burnt_area.firedate,
    archived_burnt_area.lastupdate,
    archived_burnt_area.geom,
    archived_burnt_area.id
   FROM effis.archived_burnt_area
  WHERE archived_burnt_area.firedate::date >= '2017-01-01'::date AND archived_burnt_area.firedate::date <= '2017-12-31'::date
WITH DATA;

ALTER TABLE cross_effis_nasamodis.ba_modis_2017
  OWNER TO postgres;

create table cross_effis_nasamodis.cross_complete_2017 as
SELECT DISTINCT ON(g1.ba_id) g1.ba_id, 
g2.id,
g1.firedate::date as modis_init,
g1.lastupdate::date as modis_final,
g2.initialdate as viirs_init,
g2.finaldate as viirs_final,
g1.firedate::date - g2.initialdate as init_lag_days,
g1.lastupdate::date - g2.finaldate as finale_lag_days,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom)
FROM cross_effis_nasamodis.ba_modis_2017 g1, nasa_modis_ba.final_ba_2017 As g2   
WHERE ST_DWithin(g1.geom, g2.geom, 50) 
order by g1.ba_id,init_lag_days;

ALTER TABLE cross_effis_nasamodis.cross_complete_2017 
ADD CONSTRAINT burnt_area_modis_2017_fk 
FOREIGN KEY(id_source) REFERENCES cross_effis_nasamodis.ba_modis_2017(id_source);