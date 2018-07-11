DROP TABLE IF EXISTS effis.ba_current CASCADE;

CREATE TABLE effis.ba_current AS 
 SELECT id AS ba_id,
    country AS iso2,
    countryful As country,
    province,
    commune,
    firedate
FROM rdaprd.current_burntareaspoly;
   
ALTER TABLE effis.ba_current
  OWNER TO postgres;
GRANT ALL ON TABLE effis.ba_current TO postgres;

ALTER TABLE effis.ba_current 
ADD CONSTRAINT ba_current_pk  PRIMARY KEY (ba_id); 

DROP TABLE IF EXISTS effis.ba_current_evolution CASCADE;

CREATE TABLE IF NOT EXISTS effis.ba_current_evolution AS 
 SELECT id AS ba_id,
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
    shape as geom
   FROM rdaprd.current_firesevolution;

ALTER TABLE effis.ba_current_evolution ADD COLUMN id serial;

ALTER TABLE effis.ba_current_evolution OWNER TO postgres;
GRANT ALL ON TABLE effis.ba_current_evolution TO postgres;

ALTER TABLE effis.ba_current_evolution 
ADD CONSTRAINT ba_current_evolution_pk PRIMARY KEY (id);

SELECT c.ba_id, c.firedate, c.commune, c.province, c.country, e.ba_id, e.area_ha 
FROM effis.ba_current c, effis.ba_current_evolution e 
WHERE c.ba_id = e.ba_id
LIMIT 10;