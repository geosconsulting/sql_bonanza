DROP TABLE effis.current_ba_emission;

CREATE TABLE effis.current_burnt_area_emission AS 
SELECT * FROM rdaprd.emissions_fires;

ALTER TABLE effis.current_burnt_area_emission ADD COLUMN em_id SERIAL NOT NULL;

ALTER TABLE effis.current_burnt_area_emission 
ADD CONSTRAINT current_burnt_area_emission_pk PRIMARY KEY(em_id);

ALTER TABLE effis.current_burnt_area_emission 
ADD CONSTRAINT current_burnt_area_fk FOREIGN KEY (id) 
    REFERENCES effis.current_burnt_area (ba_id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE effis.current_burnt_area_emission 
DROP CONSTRAINT current_burnt_area_fk;
