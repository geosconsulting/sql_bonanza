-- Database diff generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.0-beta2
-- PostgreSQL version: 9.6

-- [ Diff summary ]
-- Dropped objects: 0
-- Created objects: 3
-- Changed objects: 0
-- Truncated tables: 0

SET search_path=public,pg_catalog;
-- ddl-end --


-- [ Created objects ] --
-- object: altra_fk | type: COLUMN --
-- ALTER TABLE public.test_table DROP COLUMN IF EXISTS altra_fk CASCADE;
ALTER TABLE public.test_table ADD COLUMN altra_fk integer;
-- ddl-end --


-- object: public.table_altra_ext | type: TABLE --
-- DROP TABLE IF EXISTS public.table_altra_ext CASCADE;
CREATE TABLE public.table_altra_ext(
	id serial NOT NULL,
	chiave_esterna integer NOT NULL,
	CONSTRAINT table_altra_ext_pk PRIMARY KEY (id),
	CONSTRAINT unique_ext UNIQUE (chiave_esterna)

);
-- ddl-end --
ALTER TABLE public.table_altra_ext OWNER TO postgres;
-- ddl-end --

INSERT INTO public.table_altra_ext (id, chiave_esterna) VALUES (DEFAULT, E'100');
-- ddl-end --
INSERT INTO public.table_altra_ext (id, chiave_esterna) VALUES (DEFAULT, E'200');
-- ddl-end --
INSERT INTO public.table_altra_ext (id, chiave_esterna) VALUES (DEFAULT, E'300');
-- ddl-end --



-- [ Created foreign keys ] --
-- object: altra_fk_unique | type: CONSTRAINT --
-- ALTER TABLE public.test_table DROP CONSTRAINT IF EXISTS altra_fk_unique CASCADE;
ALTER TABLE public.test_table ADD CONSTRAINT altra_fk_unique FOREIGN KEY (altra_fk)
REFERENCES public.table_altra_ext (chiave_esterna) MATCH FULL
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --

