DROP TABLE IF EXISTS effis.burnt_area_spatial CASCADE;

CREATE TABLE IF NOT EXISTS effis.burnt_area_spatial AS 
 SELECT id AS ba_id,
    area_ha,
    firedate,
    lastupdate,
    shape AS geom
FROM rdaprd.from2000_burntareas;

ALTER TABLE effis.burnt_area_spatial OWNER TO postgres;
GRANT ALL ON TABLE effis.burnt_area_spatial TO postgres;

ALTER TABLE effis.burnt_area_spatial 
ADD CONSTRAINT burnt_area_spatial_pk  PRIMARY KEY (ba_id); 

DROP TABLE IF EXISTS effis.burnt_area_location CASCADE;

CREATE TABLE effis.burnt_area_location AS 
 SELECT id AS ba_id,
    country AS iso2,
    countryful As country,
    province,
    commune    
FROM rdaprd.current_burntareaspoly;
   
ALTER TABLE effis.burnt_area_location OWNER TO postgres;
GRANT ALL ON TABLE effis.burnt_area_location TO postgres;
ALTER TABLE effis.burnt_area_location ADD CONSTRAINT burnt_area_location_pk PRIMARY KEY (ba_id); 

DROP TABLE IF EXISTS effis.burnt_area_landcover CASCADE;

CREATE TABLE IF NOT EXISTS effis.burnt_area_landcover AS 
 SELECT id AS ba_id,
    broadlea AS broadleavedforest,
    conifer AS coniferous,
    mixed,
    scleroph AS sclerophyllous,
    transit AS transitional,
    othernatlc AS othernatland,
    agriareas AS agriareas,
    artifsurf,
    otherlc As otherlandcover,
    percna2k
 FROM rdaprd.current_burntareaspoly;

ALTER TABLE effis.burnt_area_landcover OWNER TO postgres;
GRANT ALL ON TABLE effis.burnt_area_landcover TO postgres;
ALTER TABLE effis.burnt_area_landcover ADD CONSTRAINT burnt_area_landcover_pk PRIMARY KEY (ba_id); 
