SELECT c.id,c.commune,c.broadlea,e.broadleavedforest,c.firedate,e.id,e.firedate, c.area_ha,e.area_ha
       --,ST_Area(c.shape),ST_Area(e.shape)
FROM rdaprd.current_burntareaspoly c, rdaprd.current_firesevolution e 
WHERE c.id = e.id 
ORDER BY c.commune, e.area_ha;