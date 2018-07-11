SELECT count(h.modis_id)
FROM modis_viirs.modis h, effis_ext_public.countries_adminsublevel1 a
WHERE h.acq_date >= '2010-01-01'::date 
AND h.acq_date <= '2017-12-01'::date 
AND a.name_local::text = 'Cataluña'::text 
AND st_intersects(a.geom, h.geom);

SELECT count(h.modis_id)
FROM modis_viirs.modis h, effis_ext_public.countries_adminsublevel2 a
WHERE h.acq_date >= '2012-01-01'::date 
AND h.acq_date <= '2012-12-01'::date 
AND a.name_local::text = 'Roma'::text 
AND st_intersects(a.geom, h.geom);

SELECT ba_id,firedate,area_ha,lastupdate
FROM effis.burnt_area_spatial
EXCEPT 
SELECT id,firedate,area_ha,lastupdate
FROM rdaprd.current_burntareaspoly
ORDER BY 2;
