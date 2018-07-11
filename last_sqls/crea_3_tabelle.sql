-- DROP TABLE public.burnt_area_landcover;

CREATE TABLE IF NOT EXISTS public.burnt_area_landcover AS 
 SELECT current_burntareaspoly.id,
    current_burntareaspoly.broadlea,
    current_burntareaspoly.conifer,
    current_burntareaspoly.mixed,
    current_burntareaspoly.scleroph,
    current_burntareaspoly.transit,
    current_burntareaspoly.othernatlc,
    current_burntareaspoly.agriareas,
    current_burntareaspoly.artifsurf,
    current_burntareaspoly.otherlc,
    current_burntareaspoly.percna2k,
    current_burntareaspoly.mic,
    current_burntareaspoly.critech
   FROM rdaprd.current_burntareaspoly;

ALTER TABLE public.burnt_area_landcover OWNER TO postgres;
GRANT ALL ON TABLE public.burnt_area_landcover TO postgres;

-- DROP TABLE public.burnt_area_location;

CREATE TABLE public.burnt_area_location AS 
 SELECT current_burntareaspoly.id,
    current_burntareaspoly.country,
    current_burntareaspoly.countryful,
    current_burntareaspoly.province,
    current_burntareaspoly.commune
   FROM rdaprd.current_burntareaspoly;

ALTER TABLE public.burnt_area_location OWNER TO postgres;
GRANT ALL ON TABLE public.burnt_area_location TO postgres;

-- DROP TABLE public.burnt_area_spatial;

CREATE TABLE public.burnt_area_spatial AS 
 SELECT current_burntareaspoly.id,
    current_burntareaspoly.area_ha,
    current_burntareaspoly.firedate,
    current_burntareaspoly.lastupdate,
    current_burntareaspoly.class,
    current_burntareaspoly.shape AS geom
   FROM rdaprd.current_burntareaspoly;
   
ALTER TABLE public.burnt_area_spatial
  OWNER TO postgres;
GRANT ALL ON TABLE public.burnt_area_spatial TO postgres;


