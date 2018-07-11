DROP TABLE IF EXISTS effis.archived_burnt_area CASCADE;

CREATE TABLE IF NOT EXISTS effis.archived_burnt_area AS 
 SELECT id_source,
    yearid as year_id,
    id AS ba_id,
    area_ha,
    firedate,
    lastupdate,
    shape AS geom
FROM rdaprd.from2000_burntareas;

ALTER TABLE effis.archived_burnt_area OWNER TO postgres;
GRANT ALL ON TABLE effis.archived_burnt_area TO postgres;

ALTER TABLE effis.archived_burnt_area ADD COLUMN id serial;

ALTER TABLE effis.archived_burnt_area 
ADD CONSTRAINT archived_burnt_area_pk  
PRIMARY KEY (id); 

DROP TABLE IF EXISTS effis.archived_burnt_area_evolution CASCADE;

CREATE TABLE IF NOT EXISTS effis.archived_burnt_area_evolution AS 
 SELECT id_source,
    yearid as year_id,
    id AS ba_id,
    area_ha,
    firedate,
    lastupdate,
    shape AS geom
FROM rdaprd.from2009_firesevolution;

ALTER TABLE effis.archived_burnt_area_evolution OWNER TO postgres;
GRANT ALL ON TABLE effis.archived_burnt_area_evolution TO postgres;

ALTER TABLE effis.archived_burnt_area_evolution ADD COLUMN id serial;

ALTER TABLE effis.archived_burnt_area_evolution 
ADD CONSTRAINT archived_burnt_area_evolution_pk  
PRIMARY KEY(id); 
