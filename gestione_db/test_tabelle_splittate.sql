SELECT s.ba_id,s.firedate,s.area_ha,
       l.broadleavedforest,l.coniferous,l.sclerophyllous
FROM effis.burnt_area_spatial s, effis.burnt_area_evolution_landcover l
WHERE s.ba_id = l.ba_id;

SELECT s.ba_id,s.firedate,s.area_ha,       
       a.country,a.province,a.commune
FROM effis.burnt_area_spatial s, effis.burnt_area_evolution_location a
WHERE s.ba_id = a.ba_id
AND s.ba_id = 3129;

SELECT s.ba_id,s.firedate,s.area_ha,       
       l.area_ha,l.broadleavedforest,l.coniferous,l.sclerophyllous
FROM effis.burnt_area_spatial s, effis.burnt_area_evolution_landcover l
WHERE s.ba_id = l.ba_id
AND s.ba_id = 3129
ORDER BY l.area_ha;

SELECT s.ba_id,s.firedate,s.area_ha,
       l.broadleavedforest,l.coniferous,l.sclerophyllous
FROM effis.burnt_area_spatial s, effis.burnt_area_landcover l
WHERE s.ba_id = l.ba_id;

SELECT s.ba_id,s.firedate,s.area_ha,       
       a.country,a.province,a.commune
FROM effis.burnt_area_spatial s, effis.burnt_area_location a
WHERE s.ba_id = a.ba_id;