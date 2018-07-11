select ef.id_source,ef.firedate,ef.lastupdate
from cross_effis_nasamodis.ba_modis_2008 as ef
 order by
  ef.geom <-> (select geom from cross_effis_nasamodis.final_ba_effis_2008 where ogc_fid = 572389)
limit 3;

select ef.id_source,
       ef.firedate,
       ef.lastupdate,
       ST_Distance(
       ef.geom::geography,(select ST_Centroid(geom) from cross_effis_nasamodis.final_ba_effis_2006 where ogc_fid = 572389)::geography
    ) AS distance
from cross_effis_nasamodis.ba_modis_2006 as ef
 order by
  ef.geom <#> (select geom from cross_effis_nasamodis.final_ba_effis_2006 where ogc_fid = 572389)
limit 3;