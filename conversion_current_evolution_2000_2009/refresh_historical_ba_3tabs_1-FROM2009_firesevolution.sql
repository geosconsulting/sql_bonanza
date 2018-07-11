DROP TABLE IF EXISTS effis.archived_burnt_area_evolution_spatial CASCADE;

CREATE TABLE IF NOT EXISTS effis.archived_burnt_area_evolution_spatial AS 
 SELECT id_source,
    yearid as year_id,
    id AS ba_id,
    area_ha,
    firedate,
    lastupdate,
    shape AS geom
FROM rdaprd.from2009_firesevolution;

ALTER TABLE effis.archived_burnt_area_evolution_spatial OWNER TO postgres;
GRANT ALL ON TABLE effis.archived_burnt_area_evolution_spatial TO postgres;

ALTER TABLE effis.archived_burnt_area_evolution_spatial ADD COLUMN id serial;

ALTER TABLE effis.archived_burnt_area_evolution_spatial 
ADD CONSTRAINT archived_burnt_area_evolution_spatial_pk  
PRIMARY KEY(id); 

DROP TABLE IF EXISTS effis.archived_burnt_area_evolution_location CASCADE;

CREATE TABLE effis.archived_burnt_area_evolution_location AS 
 SELECT id AS ba_id,     
    countryfullname As country,
    province,
    place_name AS commune    
FROM rdaprd.from2009_firesevolution;
   
ALTER TABLE effis.archived_burnt_area_evolution_location OWNER TO postgres;
GRANT ALL ON TABLE effis.archived_burnt_area_evolution_location TO postgres;

ALTER TABLE effis.archived_burnt_area_evolution_location ADD COLUMN id serial;

ALTER TABLE effis.archived_burnt_area_evolution_location 
ADD CONSTRAINT archived_burnt_area_evolution_location_pk 
PRIMARY KEY(id);

DROP TABLE IF EXISTS effis.archived_burnt_area_evolution_landcover CASCADE;

CREATE TABLE IF NOT EXISTS effis.archived_burnt_area_evolution_landcover AS 
 SELECT id AS ba_id,
    area_ha,
    broadleavedforest,
    coniferous,
    mixed,
    sclerophyllous,
    transitional,
    othernatland,
    agriareas,
    artsurf,
    otherlandcover,
    percnat2k
 FROM rdaprd.from2009_firesevolution;

ALTER TABLE effis.archived_burnt_area_evolution_landcover OWNER TO postgres;
GRANT ALL ON TABLE effis.archived_burnt_area_evolution_landcover TO postgres;

ALTER TABLE effis.archived_burnt_area_evolution_landcover ADD COLUMN id serial;

ALTER TABLE effis.archived_burnt_area_evolution_landcover 
ADD CONSTRAINT archived_burnt_area_evolution_landcover_pk 
PRIMARY KEY (id); 
