ALTER TABLE cross_effis_nasamodis.ba_modis_2017
  ADD CONSTRAINT ba_modis_2017_pk PRIMARY KEY(id);

ALTER TABLE cross_effis_nasamodis.ba_modis_2017
  ADD CONSTRAINT ba_final_ba_fk FOREIGN KEY (id)
      REFERENCES effis.archived_burnt_area (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

CREATE INDEX ba_modis_2013_geom_sidx
  ON cross_effis_nasamodis.ba_modis_2017
  USING gist
  (geom);

CREATE INDEX final_ba_effis_2006_geom_sidx
  ON cross_effis_nasamodis.final_ba_effis_2006
  USING gist
  (geom);







