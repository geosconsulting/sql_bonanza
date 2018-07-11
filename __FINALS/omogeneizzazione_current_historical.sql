DROP TABLE IF EXISTS rdaprd.ba_current;

CREATE TABLE rdaprd.ba_current AS 
 SELECT id AS ba_id,
    country AS iso2,
    countryful As country,
    province,
    commune,
    firedate
FROM rdaprd.current_burntareaspoly;
   
ALTER TABLE rdaprd.ba_current
  OWNER TO postgres;
GRANT ALL ON TABLE rdaprd.ba_current TO postgres;

-- ALTER TABLE rdaprd.ba_current ADD COLUMN event integer;

ALTER TABLE rdaprd.ba_current 
ADD CONSTRAINT ba_current_pk  PRIMARY KEY (ba_id); --,
-- ADD CONSTRAINT burnt_area_spatial_event_fk FOREIGN KEY (event)
--       REFERENCES effis.event (event_id) MATCH FULL
--       ON UPDATE SET NULL 
--       ON DELETE SET NULL;

DROP TABLE IF EXISTS rdaprd.ba_current_evolution;

CREATE TABLE IF NOT EXISTS rdaprd.ba_current_evolution AS 
 SELECT id AS ba_id,
    area_ha,
    broadlea AS broadleavedforest,
    conifer AS coniferous,
    mixed,
    scleroph AS sclerophyllous,
    transit AS transitional,
    othernatlc AS othernatland,
    agriareas,
    artifsurf,
    otherlc AS otherlandcover,
    percna2k AS percnat2k,
    shape as geom
   FROM rdaprd.current_burntareaspoly;

ALTER TABLE rdaprd.ba_current_evolution OWNER TO postgres;
GRANT ALL ON TABLE rdaprd.ba_current_evolution TO postgres;

ALTER TABLE rdaprd.ba_current_evolution 
ADD CONSTRAINT ba_current_evolution_pk PRIMARY KEY (ba_id);


-- ###################----------------------------#############################
DROP TABLE IF EXISTS rdaprd.ba_archived;

CREATE TABLE rdaprd.ba_archived AS 
 SELECT id_source,
    yearid as year_id,
    id AS ba_id,
    country AS iso2,
    countryfullname As country,
    province,
    place_name as commune,
    firedate
FROM rdaprd.from2000_burntareas;
   
ALTER TABLE rdaprd.ba_archived
  OWNER TO postgres;
GRANT ALL ON TABLE rdaprd.ba_archived TO postgres;

ALTER TABLE rdaprd.ba_archived 
ADD CONSTRAINT ba_archived_pk  PRIMARY KEY (id_source);

DROP TABLE IF EXISTS rdaprd.ba_archived_evolution;

CREATE TABLE IF NOT EXISTS rdaprd.ba_archived_evolution AS 
 SELECT id_source,
    yearid as year_id,
    id AS ba_id,
    area_ha,
    broadleavedforest,
    coniferous,
    mixed,
    sclerophyllous,
    transitional,
    othernatland,
    agriareas,
    artsurf AS artifsurf,
    otherlandcover,
    percnat2k,
    lastfiredate,
    lastfiretime,
    shape as geom
   FROM rdaprd.from2009_firesevolution;

ALTER TABLE rdaprd.ba_archived_evolution OWNER TO postgres;
GRANT ALL ON TABLE rdaprd.ba_archived_evolution TO postgres;

--ALTER TABLE rdaprd.ba_archived_evolution 
--ADD CONSTRAINT ba_archived_evolution_pk PRIMARY KEY (id_source);

--SELECT * 
--FROM (SELECT ba_id,
--      ROW_NUMBER() OVER(PARTITION BY ba_id ORDER BY ba_id ASC) AS Row 
--      FROM rdaprd.ba_archived_evolution) dups 
--      WHERE dups.Row > 1;

