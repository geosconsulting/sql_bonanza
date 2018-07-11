ALTER TABLE public.burnt_area_spatial ADD COLUMN fire integer;

GRANT ALL ON TABLE public.burnt_area_spatial TO postgres;
GRANT SELECT ON TABLE public.burnt_area_spatial TO effis_viewer;
GRANT SELECT ON TABLE public.burnt_area_spatial TO effis_editor;
COMMENT ON TABLE public.burnt_area_spatial
  IS 'Real Data From Roberto divided in spatial e non spatial data';

-- DROP INDEX public.sidx_burnt_area_spatial_geom;
CREATE INDEX sidx_burnt_area_spatial_geom
  ON public.burnt_area_spatial
  USING gist
  (geom);

ALTER TABLE public.burnt_area_spatial 
ADD CONSTRAINT burnt_area_spatial_pk PRIMARY KEY (id),
ADD CONSTRAINT burnt_area_spatial_fk FOREIGN KEY (fire)
      REFERENCES public.fire (fire_id) MATCH FULL
      ON UPDATE CASCADE 
      ON DELETE CASCADE,
ADD CONSTRAINT id_uq UNIQUE (id);

ALTER TABLE public.burnt_area_spatial ADD CONSTRAINT id_uq UNIQUE (id);

ALTER TABLE public.fire_environmental_damage_statistic -- rename constraint
   --DROP CONSTRAINT feds_burntarea_fk,
    ADD  CONSTRAINT feds_burntarea_fk FOREIGN KEY (feds_id)
      REFERENCES public.burnt_area_spatial(id) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE public.fire_population_damage_statistic -- rename constraint
   --DROP CONSTRAINT fpds_burntarea_fk,
   ADD  CONSTRAINT fpds_burntarea_fk FOREIGN KEY (fpds_id)
      REFERENCES public.burnt_area_spatial(id) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE public.burnt_area_landcover
ADD CONSTRAINT burnt_area_landcover_fk FOREIGN KEY (id)
      REFERENCES public.burnt_area_spatial (id) MATCH FULL
      ON UPDATE CASCADE 
      ON DELETE CASCADE,
ADD CONSTRAINT id_landcover_uq UNIQUE (id);

GRANT ALL ON TABLE public.burnt_area_landcover TO postgres;
GRANT SELECT ON TABLE public.burnt_area_landcover TO effis_viewer;
GRANT SELECT ON TABLE public.burnt_area_landcover TO effis_editor;
COMMENT ON TABLE public.burnt_area_landcover
  IS 'Real Data From Roberto divided in spatial e non spatial data';

ALTER TABLE public.burnt_area_location
ADD CONSTRAINT burnt_area_location_fk FOREIGN KEY (id)
      REFERENCES public.burnt_area_spatial (id) MATCH FULL
      ON UPDATE CASCADE 
      ON DELETE CASCADE,
ADD CONSTRAINT id_location_uq UNIQUE (id);

GRANT ALL ON TABLE public.burnt_area_location TO postgres;
GRANT SELECT ON TABLE public.burnt_area_location TO effis_viewer;
GRANT SELECT ON TABLE public.burnt_area_location TO effis_editor;
COMMENT ON TABLE public.burnt_area_location
  IS 'Real Data From Roberto divided in spatial e non spatial data';

ALTER TABLE public.intensity -- rename constraint
   DROP CONSTRAINT intensity_burntarea_fk
 , ADD  CONSTRAINT intensity_burntarea_fk FOREIGN KEY (evo_id)
      REFERENCES public.burnt_area_spatial(id) DEFERRABLE INITIALLY DEFERRED;

--RIMUOVO I CONSTRAINTS  burnt area Referenced by
ALTER TABLE public.fire_environmental_damage_statistic DROP CONSTRAINT feds_burntarea_fk CASCADE;
ALTER TABLE public.fire_population_damage_statistic DROP CONSTRAINT fpds_burntarea_fk CASCADE;
ALTER TABLE public.intensity DROP CONSTRAINT intensity_burntarea_fk CASCADE;

--RIMUOVO I CONSTRAINTS burnt area Foreign-key constraints
ALTER TABLE public.burnt_area DROP CONSTRAINT burnt_area_fk;

-- CONVERTO I CENTROIDI DELLE AREE IN FIRE_ID
INSERT INTO fire(fire_id, geom)
SELECT id, geom
FROM fire_temp;
--WHERE col_a = 'something';