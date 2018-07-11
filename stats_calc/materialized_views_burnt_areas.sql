-- Table: public.burnt_area_only

-- DROP TABLE public.burnt_area_spatial;

CREATE MATERIALIZED VIEW public.burnt_area_spatial AS
SELECT 
  id,
  area_ha,
  firedate,
  lastupdate,
  class,
  shape as geom
FROM rdaprd.current_burntareaspoly;

ALTER TABLE public.burnt_area_spatial OWNER TO postgres;

CREATE MATERIALIZED VIEW public.burnt_area_landcover AS
SELECT 
  id,
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
  
ALTER TABLE public.burnt_area_landcover
  OWNER TO postgres;

CREATE MATERIALIZED VIEW public.burnt_area_landcover AS
SELECT 
  id,
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
  
ALTER TABLE public.burnt_area_landcover
  OWNER TO postgres;


CREATE MATERIALIZED VIEW public.burnt_area_location AS
SELECT 
    id,
    country,
    countryful,
    province,
    commune
FROM rdaprd.current_burntareaspoly; 

ALTER TABLE public.burnt_area_location
  OWNER TO postgres; 

SELECT s.id,s.firedate,s.lastupdate, c.*, l.* 
FROM burnt_area_spatial s 
	INNER JOIN burnt_area_landcover c ON s.id = c.id 
	INNER JOIN burnt_area_location l ON s.id = l.id 
WHERE s.id = 179788;

SELECT s.id,s.firedate,s.lastupdate, c.*, l.* 
FROM burnt_area_spatial s 
	INNER JOIN burnt_area_landcover c ON s.id = c.id 
	INNER JOIN burnt_area_location l ON s.id = l.id 
WHERE l.country = 'AL';

-- LINK FIRE_ID BURNT_AREAS
DROP TABLE IF EXISTS public.fire_temp;
CREATE TABLE public.fire_temp AS
SELECT id, 
ST_Centroid(geom) AS geom
FROM burnt_area_spatial;

ALTER TABLE public.fire_temp ADD CONSTRAINT fire_temp_pk PRIMARY KEY (id);
ALTER TABLE public.fire_temp ADD CONSTRAINT fire_temp_unq UNIQUE (id);
CREATE INDEX fire_temp_gix ON public.fire_temp USING GIST (geom);

-- Table: public.fire
-- DROP TABLE public.fire;

CREATE TABLE public.fire
(
  fire_id integer NOT NULL DEFAULT nextval('fire_fire_id_seq'::regclass),
  updated date,
  area double precision,
  country character varying(14),
  detected date,
  meta integer,
  geom geometry(Point,4326),
  macro_region character varying(14),
  region character varying(14),
  province character varying(14),
  CONSTRAINT fire_pk PRIMARY KEY (fire_id),
  CONSTRAINT fire_metadata_fk FOREIGN KEY (meta)
      REFERENCES public.metadata (metadata_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT unique_fire UNIQUE (fire_id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.fire
  OWNER TO fabio;
GRANT ALL ON TABLE public.fire TO fabio;
GRANT SELECT ON TABLE public.fire TO effis_viewer;
GRANT SELECT ON TABLE public.fire TO effis_editor;
GRANT SELECT, UPDATE, DELETE ON TABLE public.fire TO "e1-usr";

-- Index: public.sidx_fire_geom

-- DROP INDEX public.sidx_fire_geom;

CREATE INDEX sidx_fire_geom
  ON public.fire
  USING gist
  (geom);

-- Table: public.burnt_area
-- DROP TABLE public.burnt_area;
CREATE TABLE public.burnt_area
(
  gid integer NOT NULL,
  objectid numeric(10,0),
  id integer,
  country character varying(2),
  countryful character varying(100),
  province character varying(60),
  commune character varying(50),
  firedate date,
  area_ha integer,
  broadlea numeric,
  conifer numeric,
  mixed numeric,
  scleroph numeric,
  transit numeric,
  othernatlc numeric,
  agriareas numeric,
  artifsurf numeric,
  otherlc numeric,
  percna2k numeric,
  lastupdate character varying(10),
  class character varying(6),
  mic character varying(5),
  critech character varying(3),
  shape_area numeric,
  shape_len numeric,
  geom geometry(MultiPolygon,4326),
  fire integer,
  CONSTRAINT burnt_area_pk PRIMARY KEY (gid),
  CONSTRAINT burnt_area_fk FOREIGN KEY (fire)
      REFERENCES public.fire (fire_id) MATCH FULL
      ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT "id_UQ" UNIQUE (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.burnt_area
  OWNER TO fabio;
GRANT ALL ON TABLE public.burnt_area TO fabio;
GRANT SELECT ON TABLE public.burnt_area TO effis_viewer;
GRANT SELECT ON TABLE public.burnt_area TO effis_editor;
GRANT SELECT, UPDATE, DELETE ON TABLE public.burnt_area TO "e1-usr";
COMMENT ON TABLE public.burnt_area
  IS 'Real Data From Roberto';

-- Index: public.sidx_burnt_area_geom

-- DROP INDEX public.sidx_burnt_area_geom;

CREATE INDEX sidx_burnt_area_geom
  ON public.burnt_area
  USING gist
  (geom);