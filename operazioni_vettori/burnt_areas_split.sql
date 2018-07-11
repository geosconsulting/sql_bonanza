DROP TABLE IF EXISTS public.burnt_area_only CASCADE;

CREATE TABLE public.burnt_area_only AS 
SELECT 	id,
	area_ha,
	firedate,
	lastupdate,
	class,
	fire,
	geom
FROM burnt_area;

ALTER TABLE public.burnt_area_only ADD CONSTRAINT burnt_area_only_unq UNIQUE (id);
ALTER TABLE public.burnt_area_only ADD CONSTRAINT burnt_area_only_pk PRIMARY KEY (id);

--CREATE SEQUENCE burnt_area_id_seq;
ALTER TABLE public.burnt_area_only ALTER COLUMN id SET DEFAULT nextval('burnt_area_id_seq'::regclass);
ALTER TABLE public.burnt_area_only ALTER COLUMN id SET NOT NULL;
ALTER TABLE public.burnt_area_only OWNER TO fabio;
ALTER SEQUENCE burnt_area_gid_seq OWNED BY burnt_area_only.id;

DROP TABLE IF EXISTS public.burnt_area_clc CASCADE;

CREATE TABLE public.burnt_area_clc AS 
SELECT 	broadlea,
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
	critech,
	id
FROM burnt_area;

ALTER TABLE public.burnt_area_clc RENAME COLUMN id TO id_brntpoly;
ALTER TABLE public.burnt_area_clc ADD COLUMN id serial;
ALTER TABLE public.burnt_area_clc ADD CONSTRAINT burnt_area_clcl_pk PRIMARY KEY(id);

ALTER TABLE public.burnt_area_clc ADD CONSTRAINT brnt_poly_fk FOREIGN KEY (id_brntpoly) REFERENCES public.burnt_area_only(id);


