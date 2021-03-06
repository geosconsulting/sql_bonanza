﻿-- Function: effis.fn_register_ba_change()

-- DROP FUNCTION effis.fn_register_ba_change();

CREATE OR REPLACE FUNCTION effis.fn_register_ba_change()
  RETURNS trigger AS
$BODY$
DECLARE
  old_row json := NULL;
  new_row json := NULL;
BEGIN
    IF TG_OP IN ('INSERT', ' UPDATE') THEN
	new_row = row_to_json(NEW); 

	    --INSERT INTO effis.burnt_area_registry(ba_id,activity,utente,time_activity,before_value,after_value) 
            --VALUES(NEW.objectid,TG_OP,session_user,current_timestamp,old_row,new_row);	  	
            INSERT INTO effis.burnt_area_registry(ba_id,activity,time_activity,before_value,after_value) 
            VALUES(NEW.objectid,TG_OP,current_timestamp,old_row,new_row);	  	

    ELSEIF TG_OP = 'UPDATE' THEN
	new_row = row_to_json(NEW); 
        old_row = row_to_json(OLD);	    	

            --INSERT INTO effis.burnt_area_registry(ba_id,activity,utente,time_activity,before_value,after_value) 
            --VALUES(NEW.objectid,TG_OP,session_user,current_timestamp,old_row,new_row);
            INSERT INTO effis.burnt_area_registry(ba_id,activity,time_activity,before_value,after_value) 
            VALUES(NEW.objectid,TG_OP,current_timestamp,old_row,new_row);

    ELSEIF TG_OP = 'DELETE' THEN
	old_row = row_to_json(OLD);

	    --INSERT INTO effis.burnt_area_registry(ba_id,activity,utente,time_activity,before_value,after_value) 
            --VALUES(OLD.objectid,TG_OP,session_user,current_timestamp,old_row,new_row);

	      INSERT INTO effis.burnt_area_registry(ba_id,activity,time_activity,before_value,after_value) 
              VALUES(OLD.objectid,TG_OP,current_timestamp,old_row,new_row);
    END IF;

    RAISE NOTICE 'Current activity % ', TG_OP;

    RETURN NEW;    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION effis.fn_register_ba_change()
  OWNER TO postgres;

DROP TRIGGER tg_ba_changes_registry ON effis.current_burntareaspoly;

CREATE TRIGGER tg_ba_changes_registry
AFTER INSERT OR UPDATE OR DELETE ON rdaprd.current_burntareaspoly
FOR EACH ROW
   EXECUTE PROCEDURE effis.fn_register_ba_change();
