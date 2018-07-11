SELECT ba_id,firedate,area_ha,lastupdate
FROM effis.current_burnt_area
EXCEPT 
SELECT id,firedate,area_ha,lastupdate
FROM rdaprd.current_burntareaspoly
ORDER BY 2;