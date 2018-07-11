

COMMENT ON TABLE public.countries_country_simple
  IS 'Administrative polygons from MIT - 0.005 with ST_SimplifyPreserveTopology';

COMMENT ON TABLE public.hotspot_cluster 
  IS 'Hotspots and Hotspots Clusters ARE not related';

COMMENT ON TABLE public.countries_adminsublevel1_simple 
  IS 'Administrative polygons from MIT - 0.005 with ST_SimplifyPreserveTopology';

COMMENT ON TABLE public.countries_adminsublevel2_simple 
  IS 'Administrative polygons from MIT - 0.005 with ST_SimplifyPreserveTopology';

COMMENT ON TABLE public.countries_adminsublevel3_simple 
  IS 'Administrative polygons from MIT - 0.005 with ST_SimplifyPreserveTopology';

COMMENT ON TABLE public.countries_adminsublevel4_simple 
  IS 'Administrative polygons from MIT - 0.005 with ST_SimplifyPreserveTopology';

GRANT ALL ON TABLE public.countries_country_simple TO fabio;
GRANT SELECT ON TABLE public.countries_country_simple TO effis_viewer;
GRANT SELECT ON TABLE public.countries_country_simple TO effis_editor;
GRANT SELECT, UPDATE, DELETE ON TABLE public.countries_country_simple TO "e1-usr";

--************* COUNTRY ************************
ALTER TABLE countries_country_simple ADD CONSTRAINT countries_country_simple_pkey PRIMARY KEY(id);

ALTER TABLE countries_country_simple
	ADD CONSTRAINT countries_country_simple_countries_entitytypeid_fk FOREIGN KEY (entity_type_id)
	REFERENCES public.countries_entitytype (id) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED,
	ADD CONSTRAINT "countries_country_simple_iso3_unq" UNIQUE (iso);

ALTER TABLE countries_country_simple ALTER COLUMN geom type geometry(MultiPolygon, 4326) USING ST_Multi(geom);

-- Index: public."countries_country_simple_id"
-- DROP INDEX public."countries_country_simple_id";
CREATE INDEX "countries_country_simple_id"
  ON public.countries_country
  USING btree (id);

-- Index: public.sidx_countries_country_geom
-- DROP INDEX public.sidx_countries_country_geom;
CREATE INDEX sidx_countries_country_simple_geom
  ON public.countries_country_simple
  USING gist(geom);

-- Index: public.countries_country_simple_iso
--DROP INDEX public.countries_country_simple_iso;
CREATE INDEX countries_country_simple_iso
  ON public.countries_country_simple
  USING btree
  (iso COLLATE pg_catalog."default");

-- Index: public."countries_country_simple_name_en_like"
-- DROP INDEX public."countries_country_simple_name_en_like";
CREATE INDEX "countries_country_simple_name_en_like"
  ON public.countries_country_simple
  USING btree
  (name_en COLLATE pg_catalog."default" varchar_pattern_ops);


--************* ADMIN LEVEL 1 ************************
ALTER TABLE countries_adminsublevel1_simple ADD CONSTRAINT countries_adminsublevel1_simple_pkey PRIMARY KEY(id);

ALTER TABLE countries_adminsublevel1_simple
	ADD CONSTRAINT countries_adminsublevel1_simple_countries_entitytypeid_fk FOREIGN KEY (entity_type_id)
	REFERENCES public.countries_entitytype (id) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE countries_adminsublevel1_simple ALTER COLUMN geom type geometry(MultiPolygon, 4326) USING ST_Multi(geom);

-- Index: public."countries_adminsublevel1_simple_id"
-- DROP INDEX public."countries_adminsublevel1_simple_id";
CREATE INDEX "countries_adminsublevel1_simple_id"
  ON public.countries_adminsublevel1_simple
  USING btree (id);

-- Index: public.sidx_countries_adminsublevel1_simple_geom
-- DROP INDEX public.sidx_countries_adminsublevel1_simple_geom;
CREATE INDEX sidx_countries_adminsublevel1_simple_geom
  ON public.countries_adminsublevel1_simple
  USING gist(geom);

-- Index: public."countries_adminisublevel1_name_en_like"
-- DROP INDEX public."countries_adminisublevel1_name_en_like";
CREATE INDEX "countries_adminisublevel1_name_en_like"
  ON public.countries_adminsublevel1
  USING btree
  (name_en COLLATE pg_catalog."default" varchar_pattern_ops);

-- Index: public."countries_adminisublevel1_local_name_like"
-- DROP INDEX public."countries_adminisublevel1_local_name_like";
CREATE INDEX "countries_adminisublevel1_local_name_like"
  ON public.countries_adminsublevel1
  USING btree
  (name_local COLLATE pg_catalog."default" varchar_pattern_ops);

-- Index: public.countries_adminisublevel1_countryid
-- DROP INDEX public.countries_adminisublevel1_countryid;
CREATE INDEX countries_adminisublevel1_countryid
  ON public.countries_adminsublevel1
  USING btree
  (country_id);

--************* ADMIN LEVEL 2 ************************
ALTER TABLE countries_adminsublevel2_simple ADD CONSTRAINT countries_adminsublevel2_simple_pkey PRIMARY KEY(id);

ALTER TABLE countries_adminsublevel2_simple
	ADD CONSTRAINT countries_adminsublevel2_simple_adminsublevel2_entitytypeid_fk FOREIGN KEY (entity_type_id)
	REFERENCES public.countries_entitytype(id) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE countries_adminsublevel2_simple ALTER COLUMN geom type geometry(MultiPolygon, 4326) USING ST_Multi(geom);

-- Index: public.countries_adminsublevel2_simple_id
-- DROP INDEX public.countries_adminsublevel2_simple_id;
CREATE INDEX countries_adminsublevel2_simple_id
  ON public.countries_adminsublevel2_simple
  USING btree (id);

-- Index: public.sidx_countries_adminsublevel2_simple_geom
-- DROP INDEX public.sidx_countries_adminsublevel2_simple_geom;
CREATE INDEX sidx_countries_adminsublevel2_simple_geom
  ON public.countries_adminsublevel2_simple
  USING gist(geom);

-- Index: public."countries_adminsublevel2_name_en_like"
-- DROP INDEX public."countries_adminsublevel2_name_en_like";
CREATE INDEX countries_adminsublevel2_name_en_like
  ON public.countries_adminsublevel2
  USING btree
  (name_en COLLATE pg_catalog."default" varchar_pattern_ops);

-- Index: public."countries_adminsublevel2_local_name_like"
-- DROP INDEX public."countries_adminsublevel2_local_name_like";
CREATE INDEX countries_adminsublevel2_local_name_like
  ON public.countries_adminsublevel2
  USING btree
  (name_local COLLATE pg_catalog."default" varchar_pattern_ops);

-- Index: public.countries_adminsublevel2_countryid
-- DROP INDEX public.countries_adminsublevel2_countryid;
CREATE INDEX countries_adminsublevel2_countryid
  ON public.countries_adminsublevel2
  USING btree(country_id);

-- Index: public.countries_adminsublevel2_admin1id
-- DROP INDEX public.countries_adminsublevel2_admin1id;
CREATE INDEX countries_adminsublevel2_admin1id
  ON public.countries_adminsublevel2
  USING btree(admin1_id); 

--************* ADMIN LEVEL 3 ************************
ALTER TABLE countries_adminsublevel3_simple ADD CONSTRAINT countries_adminsublevel3_simple_pkey PRIMARY KEY(id);

ALTER TABLE countries_adminsublevel3_simple
  ADD CONSTRAINT countries_adminsublevel3_simple_adminsublevel3_entitytypeid_fk FOREIGN KEY (entity_type_id)
  REFERENCES public.countries_entitytype(id) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE countries_adminsublevel3_simple ALTER COLUMN geom type geometry(MultiPolygon, 4326) USING ST_Multi(geom);

-- Index: public.countries_adminsublevel3_simple_id
-- DROP INDEX public.countries_adminsublevel3_simple_id;
CREATE INDEX countries_adminsublevel3_simple_id
  ON public.countries_adminsublevel3_simple
  USING btree (id);

-- Index: public.sidx_countries_adminsublevel3_simple_geom
-- DROP INDEX public.sidx_countries_adminsublevel3_simple_geom;
CREATE INDEX sidx_countries_adminsublevel3_simple_geom
  ON public.countries_adminsublevel3_simple
  USING gist(geom);

-- Index: public."countries_adminsublevel3_name_en_like"
-- DROP INDEX public."countries_adminsublevel3_name_en_like";
CREATE INDEX countries_adminsublevel3_name_en_like
  ON public.countries_adminsublevel3
  USING btree
  (name_en COLLATE pg_catalog."default" varchar_pattern_ops);

-- Index: public."countries_adminsublevel3_local_name_like"
-- DROP INDEX public."countries_adminsublevel3_local_name_like";
CREATE INDEX countries_adminsublevel3_local_name_like
  ON public.countries_adminsublevel3
  USING btree
  (name_local COLLATE pg_catalog."default" varchar_pattern_ops);

-- Index: public.countries_adminsublevel3_countryid
-- DROP INDEX public.countries_adminsublevel3_countryid;
CREATE INDEX countries_adminsublevel3_countryid
  ON public.countries_adminsublevel3
  USING btree(country_id);

-- Index: public.countries_adminsublevel3_admin1id
-- DROP INDEX public.countries_adminsublevel3_admin1id;
CREATE INDEX countries_adminsublevel3_admin1id
  ON public.countries_adminsublevel3
  USING btree(admin1_id); 

-- Index: public.countries_adminsublevel3_admin2id
-- DROP INDEX public.countries_adminsublevel3_admin2id;
CREATE INDEX countries_adminsublevel3_admin2id
  ON public.countries_adminsublevel3
  USING btree(admin2_id); 

--************* ADMIN LEVEL 4 ************************
ALTER TABLE countries_adminsublevel4_simple ADD CONSTRAINT countries_adminsublevel4_simple_pkey PRIMARY KEY(id);

ALTER TABLE countries_adminsublevel4_simple
  ADD CONSTRAINT countries_adminsublevel4_simple_adminsublevel4_entitytypeid_fk FOREIGN KEY (entity_type_id)
  REFERENCES public.countries_entitytype(id) MATCH SIMPLE
  ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE countries_adminsublevel4_simple ALTER COLUMN geom type geometry(MultiPolygon, 4326) USING ST_Multi(geom);

-- Index: public.countries_adminsublevel4_simple_id
-- DROP INDEX public.countries_adminsublevel4_simple_id;
CREATE INDEX countries_adminsublevel4_simple_id
  ON public.countries_adminsublevel4_simple
  USING btree (id);

-- Index: public.sidx_countries_adminsublevel4_simple_geom
-- DROP INDEX public.sidx_countries_adminsublevel4_simple_geom;
CREATE INDEX sidx_countries_adminsublevel4_simple_geom
  ON public.countries_adminsublevel4_simple
  USING gist(geom);

-- Index: public."countries_adminsublevel4_name_en_like"
-- DROP INDEX public."countries_adminsublevel4_name_en_like";
CREATE INDEX countries_adminsublevel4_name_en_like
  ON public.countries_adminsublevel4
  USING btree
  (name_en COLLATE pg_catalog."default" varchar_pattern_ops);

-- Index: public."countries_adminsublevel4_local_name_like"
-- DROP INDEX public."countries_adminsublevel4_local_name_like";
CREATE INDEX countries_adminsublevel4_local_name_like
  ON public.countries_adminsublevel4
  USING btree
  (name_local COLLATE pg_catalog."default" varchar_pattern_ops);

-- Index: public.countries_adminsublevel4_countryid
-- DROP INDEX public.countries_adminsublevel4_countryid;
CREATE INDEX countries_adminsublevel4_countryid
  ON public.countries_adminsublevel4
  USING btree(country_id);

-- Index: public.countries_adminsublevel4_admin1id
-- DROP INDEX public.countries_adminsublevel4_admin1id;
CREATE INDEX countries_adminsublevel4_admin1id
  ON public.countries_adminsublevel4
  USING btree(admin1_id); 

-- Index: public.countries_adminsublevel4_admin2id
-- DROP INDEX public.countries_adminsublevel4_admin2id;
CREATE INDEX countries_adminsublevel4_admin2id
  ON public.countries_adminsublevel4
  USING btree(admin2_id); 

-- Index: public.countries_adminsublevel4_admin3id
-- DROP INDEX public.countries_adminsublevel4_admin3id;
CREATE INDEX countries_adminsublevel4_admin3id
  ON public.countries_adminsublevel4
  USING btree(admin3_id); 



  