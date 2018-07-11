-- Function: effis.fn_search_fire()
-- DROP FUNCTION effis.fn_register_ba_change();

CREATE OR REPLACE FUNCTION effis.fn_register_ba_change()
  RETURNS trigger AS
$BODY$
DECLARE
  old_row json := NULL;
  new_row json := NULL;
BEGIN
    IF TG_OP = 'INSERT' THEN
	new_row = row_to_json(NEW); 	  	
    ELSEIF TG_OP IN ('UPDATE','DELETE') THEN
	new_row = row_to_json(NEW); 
        old_row = row_to_json(OLD);	    	
    END IF;

    RAISE NOTICE 'Current activity % ', TG_OP;
    
    INSERT INTO effis.burnt_area_registry(ba_id,activity,utente,time_activity,before_value,after_value) 
    VALUES(NEW.objectid,TG_OP,session_user,current_timestamp,old_row,new_row);

    RETURN NEW;    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

ALTER FUNCTION effis.fn_register_ba_change()
  OWNER TO postgres;


CREATE TRIGGER tg_ba_changes_registry
  AFTER INSERT OR UPDATE OR DELETE
  ON effis.current_burntareaspoly
  FOR EACH ROW
  EXECUTE PROCEDURE effis.fn_register_ba_change();

-- Trigger: tg_sample_label on effis.current_burntareaspoly
-- DROP TRIGGER tg_ba_changes_registry ON effis.current_burntareaspoly;

-- DROP FUNCTION effis.fn_register_ba_change();

