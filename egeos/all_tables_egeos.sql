CREATE TABLE egeos.ba_problems
(
  id serial primary key,
  ba_id integer,
  ba_problem character(1)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE egeos.ba_problems
  OWNER TO postgres;


CREATE TABLE egeos.current_ba
(
  gid integer,
  id bigint NOT NULL,
  firedate date,
  area_ha numeric,
  geom geometry(MultiPolygon,4326),
  CONSTRAINT current_ba_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE egeos.current_ba
  OWNER TO postgres;


CREATE TABLE egeos.evolution_ba
(
  gid integer,
  id bigint primary key,
  firedate date,
  area_ha numeric,
  geom geometry(MultiPolygon,4326)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE egeos.evolution_ba
  OWNER TO postgres;


CREATE TABLE egeos.processed_data
(
  shp_id integer primary key,
  filename character varying,
  data_date date,
  completed boolean,
  data_type character varying,
  sensor character varying(25)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE egeos.processed_data
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION egeos.update_ba()
  RETURNS trigger AS
$BODY$
DECLARE
  record_number int := 0;
  old_record record;
BEGIN
  IF TG_OP IN ('INSERT') THEN
    --RAISE NOTICE 'Geometry % ', ST_AsGeoJSON(NEW.geom,2); 
    --RAISE 'Duplicate user ID: %', NEW.id USING ERRCODE = 'unique_violation';      
    record_number := (SELECT count(id) FROM egeos.current_ba WHERE id = NEW.id);
    IF (record_number > 0) THEN
      RAISE NOTICE 'Duplicate FIRE-ID: %', NEW.id;
      SELECT INTO old_record * FROM egeos.current_ba WHERE id = NEW.id;
      
      DELETE FROM egeos.current_ba WHERE id = NEW.id;
      RAISE NOTICE 'Old Record % removed from CURRENT table', old_record.id;
            
      INSERT INTO egeos.evolution_ba(id,firedate,area_ha,geom) 
               VALUES (old_record.id,old_record.firedate,old_record.area_ha,old_record.geom);      
      RAISE NOTICE 'Old Record % MOVED into EVOLUTION table', NEW.id;
      
      INSERT INTO egeos.current_ba(id,firedate,area_ha,geom) VALUES (NEW.id,NEW.firedate,NEW.area_ha,NEW.geom);      
      RAISE NOTICE 'New record % REINSTATED into CURRENT table', NEW.id;
    ELSE
      RAISE NOTICE 'ID % not in the CURRENT burnt areas' , NEW.id;      
      INSERT INTO egeos.current_ba(id,firedate,area_ha,geom) VALUES (NEW.id,NEW.firedate,NEW.area_ha,NEW.geom);
      RAISE NOTICE 'Record % copied in CURRENT table ' , NEW.id;      
    END IF; 
    RETURN NEW;
  END IF; 
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION egeos.update_ba()
  OWNER TO postgres;


CREATE TABLE egeos.temp_ba
(
  gid integer primary key,
  id bigint NOT NULL,
  firedate date,
  area_ha numeric,
  geom geometry(MultiPolygon,4326)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE egeos.temp_ba
  OWNER TO postgres;

-- Trigger: new_ba_inserted on egeos.temp_ba

-- DROP TRIGGER new_ba_inserted ON egeos.temp_ba;

CREATE TRIGGER new_ba_inserted
  AFTER INSERT
  ON egeos.temp_ba
  FOR EACH ROW
  EXECUTE PROCEDURE egeos.update_ba();