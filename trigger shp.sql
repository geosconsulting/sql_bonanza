CREATE TABLE temp_ba AS SELECT * FROM current_ba WHERE 1=2;
CREATE TABLE current_ba AS SELECT * FROM temp_ba WHERE 1=2;
CREATE TABLE evolution_ba AS SELECT * FROM temp_ba WHERE 1=2;
CREATE TABLE ba_problems(id serial,ba_id integer,ba_problem char);

DROP FUNCTION update_ba() CASCADE;

CREATE OR REPLACE FUNCTION update_ba()
  RETURNS trigger AS $BODY$
DECLARE
  record_number int := 0;
  old_record_row record;
BEGIN
  IF TG_OP IN ('INSERT') THEN
    --RAISE NOTICE 'Geometry % ', ST_AsGeoJSON(NEW.geom,2); 
    record_number := (SELECT count(id) FROM current_ba WHERE id = NEW.id);
    if (record_number > 0) THEN
      SELECT INTO old_record_row 
              * FROM current_ba WHERE id = NEW.id;
      --RAISE 'Duplicate user ID: %', NEW.id USING ERRCODE = 'unique_violation';
      RAISE NOTICE 'Duplicate FIRE-ID: %', NEW.id;
      RAISE NOTICE 'Old Record % ', old_record_row;
      RAISE NOTICE 'nuovo record % ' , NEW;
      RETURN old_record_row;
    ELSE
      RAISE NOTICE 'ID % not in the current burnt areas' , NEW.id;
      RAISE NOTICE 'nuovo record % ' , NEW;
      RETURN NEW;
    END IF; 
  END IF; 
END;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

ALTER TABLE current_ba ADD CONSTRAINT current_ba_pk PRIMARY KEY
  
ALTER FUNCTION update_ba()
  OWNER TO postgres;

CREATE TRIGGER new_ba_inserted
  AFTER INSERT ON temp_ba
  FOR EACH ROW
  EXECUTE PROCEDURE update_ba();