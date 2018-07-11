DROP TABLE IF EXISTS effis.current_burnt_area CASCADE;

CREATE TABLE IF NOT EXISTS effis.current_burnt_area AS 
 SELECT id AS ba_id,
    area_ha,
    firedate,
    lastupdate,
    shape AS geom
FROM rdaprd.current_burntareaspoly;

ALTER TABLE effis.current_burnt_area OWNER TO postgres;
GRANT ALL ON TABLE effis.current_burnt_area TO postgres;

ALTER TABLE effis.current_burnt_area 
ADD CONSTRAINT current_burnt_area_pk  PRIMARY KEY (ba_id); 

DROP TABLE IF EXISTS effis.current_burnt_area_evolution CASCADE;

CREATE TABLE IF NOT EXISTS effis.current_burnt_area_evolution AS 
 SELECT id AS ba_id,
    area_ha,
    firedate,
    lastupdate,
    shape AS geom
FROM rdaprd.current_firesevolution;

ALTER TABLE effis.current_burnt_area_evolution OWNER TO postgres;
GRANT ALL ON TABLE effis.current_burnt_area_evolution TO postgres;

ALTER TABLE effis.current_burnt_area_evolution ADD COLUMN id serial;

ALTER TABLE effis.current_burnt_area_evolution 
ADD CONSTRAINT current_burnt_area_evolution_pk  
PRIMARY KEY (id); 
