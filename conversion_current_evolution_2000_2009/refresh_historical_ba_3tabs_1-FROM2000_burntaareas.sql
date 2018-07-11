DROP TABLE IF EXISTS effis.archived_burnt_area_spatial CASCADE;

CREATE TABLE IF NOT EXISTS effis.archived_burnt_area_spatial AS 
 SELECT id_source,
    yearid as year_id,
    id AS ba_id,
    area_ha,
    firedate,
    lastupdate,
    shape AS geom
FROM rdaprd.from2000_burntareas;

ALTER TABLE effis.archived_burnt_area_spatial OWNER TO postgres;
GRANT ALL ON TABLE effis.archived_burnt_area_spatial TO postgres;

ALTER TABLE effis.archived_burnt_area_spatial ADD COLUMN id serial;

ALTER TABLE effis.archived_burnt_area_spatial 
ADD CONSTRAINT archived_burnt_area_spatial_pk  
PRIMARY KEY (id); 

DROP TABLE IF EXISTS effis.archived_burnt_area_location CASCADE;

CREATE TABLE effis.archived_burnt_area_location AS 
 SELECT id AS ba_id, 
    country AS iso2,
    countryfullname As country,
    province,
    place_name AS commune    
FROM rdaprd.from2000_burntareas;
   
ALTER TABLE effis.archived_burnt_area_location OWNER TO postgres;
GRANT ALL ON TABLE effis.archived_burnt_area_location TO postgres;

ALTER TABLE effis.archived_burnt_area_location ADD COLUMN id serial;

ALTER TABLE effis.archived_burnt_area_location 
ADD CONSTRAINT archived_burnt_area_location_pk 
PRIMARY KEY (id); 

-- I CAMPI LANDCOVER NON SONO CALCOLATI NELLA TABELLA FROM2000_BURNTAREAS
-- DROP TABLE IF EXISTS effis.archived_burnt_area_landcover CASCADE;

--CREATE TABLE IF NOT EXISTS effis.archived_burnt_area_landcover AS 
-- SELECT id AS ba_id,
--    area_ha,
--    broadleavedforest,
--    coniferous,
--    mixed,
--    sclerophyllous,
--    transitional,
--    othernatland,
--    agriareas,
--    artsurf,
--    otherlandcover,
--    percnat2k
-- FROM rdaprd.archived_burnt_area_landcover;

--ALTER TABLE effis.archived_burnt_area_landcover OWNER TO postgres;
--GRANT ALL ON TABLE effis.archived_burnt_area_landcover TO postgres;

--ALTER TABLE effis.archived_burnt_area_landcover ADD COLUMN id serial;

--ALTER TABLE effis.archived_burnt_area_landcover 
--ADD CONSTRAINT archived_burnt_area_landcover_pk 
--PRIMARY KEY (id); 
