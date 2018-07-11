create table admin_level_4 (like original_mit_admin.admin_level_4_hres);

insert into admin_level_4 (
  id, 
  name_en,
  name_iso,
  name_local,
  name_alt,
  valid_to,
  valid_since,
  area,
  geom,
  created_at,
  updated_at,
  country_id,
  entity_type_id,
  admin1_id,
  admin2_id,
  admin3_id,
  hasc,
  cca,
  ccn)
select 
  id, 
  name_en,
  name_iso,
  name_local,
  name_alt,
  valid_to,
  valid_since,
  area,
  ST_Simplify(shape,0.001),
  created_at,
  updated_at,
  country_id,
  entity_type_id,
  admin1_id,
  admin2_id,
  admin3_id,
  hasc,
  cca,
  ccn
FROM original_mit_admin.admin_level_4_hres;

alter table public.admin_level_4 ADD CONSTRAINT countries_adminsublevel4_simple_pkey PRIMARY KEY (id);
alter table public.admin_level_4 add CONSTRAINT countries_adminsublevel4_simple_adminsublevel4_entitytypeid_fk FOREIGN KEY (entity_type_id)
      REFERENCES public.admin_definitions (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE public.admin_level_4
  OWNER TO postgres;
GRANT ALL ON TABLE public.admin_level_4 TO postgres;
COMMENT ON TABLE public.admin_level_4
  IS 'Administrative polygons from MIT - 0.005 with ST_SimplifyPreserveTopology';


CREATE INDEX countries_adminsublevel4_simple_id
  ON public.admin_level_4
  USING btree
  (id);

CREATE INDEX sidx_countries_adminsublevel4_simple_geom
  ON public.admin_level_4
  USING gist
  (geom);


