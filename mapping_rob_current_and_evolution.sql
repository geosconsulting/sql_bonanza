--Mappa su DEA
TRUNCATE effis.current_burnt_area CASCADE;

create table effis.current_burnt_area_no_proj (like rdaprd.rob_burntareas);

INSERT INTO effis.current_burnt_area_no_proj 
SELECT *
FROM rdaprd.rob_burntareas;

UPDATE effis.current_burnt_area_no_proj SET shape = ST_SetSRID(shape, 3035);

--ALTER TABLE effis.current_burnt_area_no_proj ALTER COLUMN shape USING ST_SetSRID(shape,3035);
--TYPE Geometry(Polygon, 4326) 
--USING ST_Transform(geom, 0);

INSERT INTO effis.current_burnt_area 
SELECT id,
    area_ha,    
    firedate,    
    lastupdate,
    ST_Transform(shape,4326)
    --ST_SetSRID(shape,4326)
    --shape as geom
FROM effis.current_burnt_area_no_proj;

TRUNCATE effis.current_burnt_area_evolution CASCADE;

--SELECT setval('effis.current_burnt_area_evolution_id_seq', 1);

ALTER SEQUENCE effis.current_burnt_area_evolution_id_seq RESTART WITH 1;

INSERT INTO effis.current_burnt_area_evolution(ba_id,area_ha,firedate,lastupdate,geom)
SELECT id,
    area_ha,    
    firedate,    
    lastupdate,
    --ST_Transform(shape,4326)
    --ST_SetSRID(shape,4326)
    shape as geom
FROM rdaprd.rob_firesevolution;

--Mappa su ESPOSITO

TRUNCATE effis.current_burnt_area CASCADE;

INSERT INTO effis.current_burnt_area 
SELECT id,
    area_ha,    
    firedate,    
    lastupdate,
    shape as geom
FROM rdaprd.current_burntareaspoly;

TRUNCATE effis.current_burnt_area_evolution CASCADE;

--SELECT setval('effis.current_burnt_area_evolution_id_seq', 1);

ALTER SEQUENCE effis.current_burnt_area_evolution_id_seq RESTART WITH 1;

INSERT INTO effis.current_burnt_area_evolution(ba_id,area_ha,firedate,lastupdate,geom)
SELECT id,
    area_ha,    
    firedate,    
    lastupdate,
    shape as geom
FROM rdaprd.current_firesevolution;