-- Table: effis.event

DROP TABLE effis.event;

CREATE TABLE effis.event
(
  event_id integer PRIMARY KEY,
  event_description varchar,
  geom geometry(Point,4326)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE effis.event
  OWNER TO postgres;

DROP TABLE effis.burnt_area_spatial;

CREATE TABLE effis.burnt_area_spatial AS 
 SELECT id AS ba_id,
    area_ha,
    firedate,
    lastupdate,
    class,
    shape AS geom
FROM rdaprd.current_burntareaspoly;
   
ALTER TABLE effis.burnt_area_spatial
  OWNER TO postgres;
GRANT ALL ON TABLE effis.burnt_area_spatial TO postgres;

ALTER TABLE effis.burnt_area_spatial ADD COLUMN event integer;

ALTER TABLE effis.burnt_area_spatial 
ADD CONSTRAINT burnt_area_spatial_pk  PRIMARY KEY (ba_id),
ADD CONSTRAINT burnt_area_spatial_event_fk FOREIGN KEY (event)
      REFERENCES effis.event (event_id) MATCH FULL
      ON UPDATE SET NULL 
      ON DELETE SET NULL;

DROP TABLE effis.burnt_area_landcover;

CREATE TABLE IF NOT EXISTS effis.burnt_area_landcover AS 
 SELECT id AS ba_id,
    broadlea,
    conifer,
    mixed,
    scleroph,
    transit,
    othernatlc,
    agriareas,
    artifsurf,
    otherlc,
    percna2k,
    mic,
    critech
   FROM rdaprd.current_burntareaspoly;

ALTER TABLE effis.burnt_area_landcover OWNER TO postgres;
GRANT ALL ON TABLE effis.burnt_area_landcover TO postgres;

ALTER TABLE effis.burnt_area_landcover 
ADD CONSTRAINT burnt_area_landcover_pk PRIMARY KEY (ba_id);

DROP TABLE public.burnt_area_location;

CREATE TABLE effis.burnt_area_location AS 
  SELECT id AS ba_id,
    country,
    countryful,
    province,
    commune
  FROM rdaprd.current_burntareaspoly;

ALTER TABLE effis.burnt_area_location OWNER TO postgres;
GRANT ALL ON TABLE effis.burnt_area_location TO postgres;

ALTER TABLE effis.burnt_area_location 
ADD CONSTRAINT burnt_area_location_pk PRIMARY KEY (ba_id);



