-- Function: egeos.update_ba()

DROP FUNCTION egeos.update_ba() CASCADE;

CREATE OR REPLACE FUNCTION egeos.update_ba()
  RETURNS trigger AS
$BODY$
DECLARE
  record_number int := 0;
  old_record record;
  oggetto_json jsonb;
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

      if old_record.firedate>NEW.firedate then
        RAISE NOTICE 'NEW RECORD % HAS AN INCOMPATIBLE DATE', NEW.id;
        --INSERT INTO egeos.ba_problems(ba_id, ba_problem) VALUES (NEW.id,'d');
        --oggetto_json := json_build_object('date_previous',old_record.firedate,'date_last',new.firedate);
        --RAISE NOTICE 'JSON costruito %',oggetto_json;
      ELSif old_record.area_ha>NEW.area_ha then
        RAISE NOTICE 'NEW RECORD % HAS A SMALLER AREA', NEW.id;
        --INSERT INTO egeos.ba_problems(ba_id, ba_problem) VALUES (NEW.id,'a');
        --oggetto_json := json_build_object('area_previous',old_record.area_ha,'area_last',new.area_ha);
        --RAISE NOTICE 'JSON costruito %',oggetto_json;
      end if;
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
