DROP TABLE IF EXISTS effis.archived_burnt_area CASCADE;

CREATE TABLE IF NOT EXISTS effis.archived_burnt_area AS 
 SELECT id_source,
    yearid as year_id,
    id AS ba_id,
    area_ha,
    firedate,
    lastupdate,
    yearseason,
    shape AS geom
FROM rdaprd_esposito.from2000_burntareas;

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
    yearseason,
    shape AS geom
FROM rdaprd_esposito.from2009_firesevolution;

ALTER TABLE effis.archived_burnt_area_evolution OWNER TO postgres;
GRANT ALL ON TABLE effis.archived_burnt_area_evolution TO postgres;

ALTER TABLE effis.archived_burnt_area_evolution ADD COLUMN id serial;

ALTER TABLE effis.archived_burnt_area_evolution 
ADD CONSTRAINT archived_burnt_area_evolution_pk  
PRIMARY KEY(id); 

--*********************************************************
DROP TABLE IF EXISTS effis.archived_burnt_area CASCADE;

CREATE TABLE IF NOT EXISTS effis.archived_burnt_area AS 
 SELECT id_source,
    yearid as year_id,
    id AS ba_id,
    area_ha,
    firedate,
    lastupdate,
    yearseason,
    shape AS geom
FROM rdaprd.from2000_burntareas;

ALTER TABLE effis.archived_burnt_area OWNER TO e1gwis;
GRANT ALL ON TABLE effis.archived_burnt_area TO e1gwis;

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
    yearseason,
    shape AS geom
FROM rdaprd.from2009_firesevolution;

ALTER TABLE effis.archived_burnt_area_evolution OWNER TO e1gwis;
GRANT ALL ON TABLE effis.archived_burnt_area_evolution TO e1gwis;

ALTER TABLE effis.archived_burnt_area_evolution ADD COLUMN id serial;

ALTER TABLE effis.archived_burnt_area_evolution 
ADD CONSTRAINT archived_burnt_area_evolution_pk  
PRIMARY KEY(id); 

--*************************************************************
DELETE FROM effis.current_burnt_area
	WHERE ba_id = 2;
	
select * from effis.current_burnt_area where firedate is null;

select * from effis.burnt_areas where global_id between '2000_1' and '2006_1000';

--******************************************************************************

DROP TABLE IF EXISTS effis.archived_burnt_area CASCADE;

CREATE TABLE IF NOT EXISTS effis.archived_burnt_area AS 
 SELECT id_source,
    yearid as year_id,
    id AS ba_id,
    area_ha,
    firedate,
    lastupdate,
    yearseason,
    shape AS geom
FROM rdaprd.rob_burntareas_history;

ALTER TABLE effis.archived_burnt_area OWNER TO e1gwis;
GRANT ALL ON TABLE effis.archived_burnt_area TO e1gwis;

ALTER TABLE effis.archived_burnt_area ADD COLUMN id serial;

ALTER TABLE effis.archived_burnt_area 
ADD CONSTRAINT archived_burnt_area_pk  
PRIMARY KEY (id); 

DROP TABLE IF EXISTS effis.archived_burnt_area_evolution CASCADE;

CREATE TABLE IF NOT EXISTS effis.archived_burnt_area_evolution AS 
 SELECT id as id_source,
    extract(year from firedate::DATE)|| '_' || id as year_id,
    id AS ba_id,
    area_ha,
    firedate,
    lastupdate,
    extract(year from firedate::DATE) as yearseason,
    shape AS geom
FROM rdaprd.rob_firesevolution;

ALTER TABLE effis.archived_burnt_area_evolution OWNER TO e1gwis;
GRANT ALL ON TABLE effis.archived_burnt_area_evolution TO e1gwis;

ALTER TABLE effis.archived_burnt_area_evolution ADD COLUMN id serial;

ALTER TABLE effis.archived_burnt_area_evolution 
ADD CONSTRAINT archived_burnt_area_evolution_pk  
PRIMARY KEY(id); 