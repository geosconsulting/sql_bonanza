DROP TABLE IF EXISTS effis.ba_archived CASCADE;

CREATE TABLE effis.ba_archived AS 
 SELECT id_source,
    yearid as year_id,
    id AS ba_id,
    country AS iso2,
    countryfullname As country,
    province,
    place_name as commune,
    firedate
FROM rdaprd.from2000_burntareas;
   
ALTER TABLE effis.ba_archived
  OWNER TO postgres;
GRANT ALL ON TABLE effis.ba_archived TO postgres;

ALTER TABLE effis.ba_archived ADD COLUMN id serial;

ALTER TABLE effis.ba_archived 
ADD CONSTRAINT ba_archived_pk PRIMARY KEY(id);

DROP TABLE IF EXISTS effis.ba_archived_evolution CASCADE;

CREATE TABLE IF NOT EXISTS effis.ba_archived_evolution AS 
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

ALTER TABLE effis.ba_archived_evolution OWNER TO postgres;
GRANT ALL ON TABLE effis.ba_archived_evolution TO postgres;

ALTER TABLE effis.ba_archived_evolution ADD COLUMN id serial;

ALTER TABLE effis.ba_archived_evolution 
ADD CONSTRAINT ba_archived_evolution_pk PRIMARY KEY(id);

SELECT c.ba_id, c.firedate, c.commune, c.province, c.country, e.ba_id, e.area_ha 
FROM effis.ba_archived c, effis.ba_archived_evolution e 
WHERE c.id_source = e.id_source;

-- CONTROLLO
SELECT c.ba_id, c.firedate, c.commune, c.province, c.country, e.ba_id, e.area_ha 
FROM effis.ba_archived c, effis.ba_archived_evolution e 
WHERE c.id_source = e.id_source
LIMIT 10;
