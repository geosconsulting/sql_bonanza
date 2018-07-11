TRUNCATE effis.burnt_area;

INSERT INTO effis.burnt_area 
 SELECT id,
    area_ha,    
    firedate,    
    lastupdate,
    shape
FROM rdaprd.current_burntareaspoly;

TRUNCATE effis.burnt_area_evolution;

INSERT INTO effis.burnt_area_evolution
 SELECT id,
    area_ha,    
    firedate,    
    lastupdate,
    shape
FROM rdaprd.current_firesevolution;