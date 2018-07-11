-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.0-beta2
-- PostgreSQL version: 9.6
-- Project Site: pgmodeler.com.br
-- Model Author: ---


-- Database creation must be done outside an multicommand file.
-- These commands were put in this file only for convenience.
-- -- object: effis | type: DATABASE --
-- -- DROP DATABASE IF EXISTS effis;
-- CREATE DATABASE effis
-- ;
-- -- ddl-end --
-- 

-- object: public."BurntAreaForecast" | type: TABLE --
-- DROP TABLE IF EXISTS public."BurntAreaForecast" CASCADE;
CREATE TABLE public."BurntAreaForecast"(
	id serial,
	date smallint,
	fire smallint,
	metadata smallint,
	shape geometry(POLYGON),
	time_horizon smallint
);
-- ddl-end --
ALTER TABLE public."BurntAreaForecast" OWNER TO postgres;
-- ddl-end --

-- object: public."Choices" | type: TABLE --
-- DROP TABLE IF EXISTS public."Choices" CASCADE;
CREATE TABLE public."Choices"(
	id serial NOT NULL,
	type varchar(40),
	CONSTRAINT "Choices_pk" PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public."Choices" OWNER TO postgres;
-- ddl-end --

INSERT INTO public."Choices" (id, type) VALUES (DEFAULT, E'Modis');
-- ddl-end --
INSERT INTO public."Choices" (id, type) VALUES (DEFAULT, E'Viirs');
-- ddl-end --

-- object: public."Intensity" | type: TABLE --
-- DROP TABLE IF EXISTS public."Intensity" CASCADE;
CREATE TABLE public."Intensity"(
	"Intensity_id" integer,
	evo_id smallint,
	date date,
	map smallint,
	total float,
	average float,
	peak float,
	meta smallint
);
-- ddl-end --
ALTER TABLE public."Intensity" OWNER TO postgres;
-- ddl-end --

-- object: public."BurntArea" | type: TABLE --
-- DROP TABLE IF EXISTS public."BurntArea" CASCADE;
CREATE TABLE public."BurntArea"(
	id serial,
	area float,
	date smallint,
	fire smallint,
	metadata smallint,
	shape geometry(POLYGON, 4326)
);
-- ddl-end --
ALTER TABLE public."BurntArea" OWNER TO postgres;
-- ddl-end --

-- object: public."GhostHotSpot" | type: TABLE --
-- DROP TABLE IF EXISTS public."GhostHotSpot" CASCADE;
CREATE TABLE public."GhostHotSpot"(
	hot_spot_id integer,
	country smallint,
	province smallint,
	commune smallint,
	date date,
	satellite smallint,
	shape smallint,
	meta smallint
);
-- ddl-end --
ALTER TABLE public."GhostHotSpot" OWNER TO postgres;
-- ddl-end --

-- object: public."MacroArea" | type: TABLE --
-- DROP TABLE IF EXISTS public."MacroArea" CASCADE;
CREATE TABLE public."MacroArea"(
	id serial NOT NULL,
	name varchar(50),
	organization integer,
	CONSTRAINT "MacroArea_pk" PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public."MacroArea" OWNER TO postgres;
-- ddl-end --

INSERT INTO public."MacroArea" (id, name) VALUES (DEFAULT, E'Africa');
-- ddl-end --
INSERT INTO public."MacroArea" (id, name) VALUES (DEFAULT, E'Asia');
-- ddl-end --
INSERT INTO public."MacroArea" (id, name) VALUES (DEFAULT, E'Europe');
-- ddl-end --
INSERT INTO public."MacroArea" (id, name) VALUES (DEFAULT, E'North America');
-- ddl-end --
INSERT INTO public."MacroArea" (id, name) VALUES (DEFAULT, E'Oceania');
-- ddl-end --
INSERT INTO public."MacroArea" (id, name) VALUES (DEFAULT, E'South America');
-- ddl-end --

-- object: public."HotSpot" | type: TABLE --
-- DROP TABLE IF EXISTS public."HotSpot" CASCADE;
CREATE TABLE public."HotSpot"(
	hot_spot_id integer,
	country smallint,
	province smallint,
	commune smallint,
	date date,
	satellite smallint,
	ghost bool,
	shape smallint,
	meta smallint,
	ghost_spot_id smallint
);
-- ddl-end --
ALTER TABLE public."HotSpot" OWNER TO postgres;
-- ddl-end --

-- object: public."HotSpotCluster" | type: TABLE --
-- DROP TABLE IF EXISTS public."HotSpotCluster" CASCADE;
CREATE TABLE public."HotSpotCluster"(
	hot_spot_cluster_id integer,
	country smallint,
	province smallint,
	commune smallint,
	date date,
	area float,
	shape smallint,
	meta smallint,
	fire_id smallint
);
-- ddl-end --
ALTER TABLE public."HotSpotCluster" OWNER TO postgres;
-- ddl-end --

-- object: public."FirePopulationDamageStatistic" | type: TABLE --
-- DROP TABLE IF EXISTS public."FirePopulationDamageStatistic" CASCADE;
CREATE TABLE public."FirePopulationDamageStatistic"(
	id serial,
	burnt_area smallint,
	buffer_size integer,
	fire_builtup_area integer,
	fire_forecast smallint,
	fire_pop_avg integer,
	fire_pop_peak integer,
	fire_pop_total integer,
	on_forecast bool,
	potential_builtup_area integer,
	potential_pop_avg integer,
	potential_pop_peak integer,
	potential_pop_total integer
);
-- ddl-end --
ALTER TABLE public."FirePopulationDamageStatistic" OWNER TO postgres;
-- ddl-end --

-- object: public."FireEnvironmentalDamageStatistic" | type: TABLE --
-- DROP TABLE IF EXISTS public."FireEnvironmentalDamageStatistic" CASCADE;
CREATE TABLE public."FireEnvironmentalDamageStatistic"(
	id serial,
	burnt_area smallint,
	agricultural_area float,
	artificial_surface float,
	broad_leaved_forest float,
	coniferous float,
	mixed float,
	other_land_cover float,
	other_natural_landcover float,
	percentage_natura2k float,
	sclerophyllous float,
	transitional float
);
-- ddl-end --
ALTER TABLE public."FireEnvironmentalDamageStatistic" OWNER TO postgres;
-- ddl-end --

-- object: public."Emission" | type: TABLE --
-- DROP TABLE IF EXISTS public."Emission" CASCADE;
CREATE TABLE public."Emission"(
	emission_id integer NOT NULL,
	fire_id smallint,
	date date,
	chemical smallint,
	total float,
	average float,
	peak float,
	meta smallint,
	CONSTRAINT "Emission_pk" PRIMARY KEY (emission_id)

);
-- ddl-end --
ALTER TABLE public."Emission" OWNER TO postgres;
-- ddl-end --

-- object: public."Organization" | type: TABLE --
-- DROP TABLE IF EXISTS public."Organization" CASCADE;
CREATE TABLE public."Organization"(
	id serial,
	name varchar(25)
);
-- ddl-end --
ALTER TABLE public."Organization" OWNER TO postgres;
-- ddl-end --

INSERT INTO public."Organization" (id, name) VALUES (DEFAULT, E'ONU');
-- ddl-end --
INSERT INTO public."Organization" (id, name) VALUES (DEFAULT, E'EMEA');
-- ddl-end --
INSERT INTO public."Organization" (id, name) VALUES (DEFAULT, E'EU');
-- ddl-end --

-- object: public."EmissionShapes" | type: TABLE --
-- DROP TABLE IF EXISTS public."EmissionShapes" CASCADE;
CREATE TABLE public."EmissionShapes"(
	emission_shape_id integer,
	emission_id smallint,
	date date,
	shape geometry(MULTIPOLYGON),
	altitude float,
	meta smallint
);
-- ddl-end --
ALTER TABLE public."EmissionShapes" OWNER TO postgres;
-- ddl-end --

-- object: public."FireEmissionStatistic" | type: TABLE --
-- DROP TABLE IF EXISTS public."FireEmissionStatistic" CASCADE;
CREATE TABLE public."FireEmissionStatistic"(
	id serial,
	fire smallint,
	biomass float,
	ch4 float,
	co float,
	co2 float,
	ec float,
	nmhc float,
	nox float,
	oc float,
	pm float,
	pm10 float,
	pm2_5 float,
	voc float
);
-- ddl-end --
ALTER TABLE public."FireEmissionStatistic" OWNER TO postgres;
-- ddl-end --

-- object: public."Chemicals" | type: TABLE --
-- DROP TABLE IF EXISTS public."Chemicals" CASCADE;
CREATE TABLE public."Chemicals"(
	id serial NOT NULL,
	name char(80),
	CONSTRAINT chemical_pk PRIMARY KEY (id)

);
-- ddl-end --
ALTER TABLE public."Chemicals" OWNER TO postgres;
-- ddl-end --

INSERT INTO public."Chemicals" (id) VALUES (DEFAULT);
-- ddl-end --
INSERT INTO public."Chemicals" (id) VALUES (DEFAULT);
-- ddl-end --

-- object: public.new_table | type: TABLE --
-- DROP TABLE IF EXISTS public.new_table CASCADE;
CREATE TABLE public.new_table(

);
-- ddl-end --
ALTER TABLE public.new_table OWNER TO postgres;
-- ddl-end --

-- object: organization_id | type: CONSTRAINT --
-- ALTER TABLE public."MacroArea" DROP CONSTRAINT IF EXISTS organization_id CASCADE;
ALTER TABLE public."MacroArea" ADD CONSTRAINT organization_id FOREIGN KEY (organization)
REFERENCES public."Organization" (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: chemical_fk | type: CONSTRAINT --
-- ALTER TABLE public."Emission" DROP CONSTRAINT IF EXISTS chemical_fk CASCADE;
ALTER TABLE public."Emission" ADD CONSTRAINT chemical_fk FOREIGN KEY (chemical)
REFERENCES public."Chemicals" (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


