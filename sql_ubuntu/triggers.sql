-- Function: public.log_last_name_changes()

-- DROP FUNCTION public.log_last_name_changes();

CREATE OR REPLACE FUNCTION public.log_last_name_changes()
  RETURNS trigger AS
$BODY$
BEGIN
  IF NEW.last_name <> OLD.last_name THEN
  INSERT INTO employee_audits(employee_id,old_last_name,new_last_name,changed_on)
  VALUES(OLD.id,OLD.last_name,NEW.last_name,now());
  END IF;

  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.log_last_name_changes()
  OWNER TO postgres;


  -- Function: public.sample_label()

-- DROP FUNCTION public.sample_label();

CREATE OR REPLACE FUNCTION public.sample_label()
  RETURNS trigger AS
$BODY$
    BEGIN
    IF GeometryType(NEW.geom) = 'POINT' THEN
        EXECUTE 'SELECT label FROM burnt_area WHERE ST_Within($1, burnt_area.geom) LIMIT 1'
        USING NEW.geom 
        INTO NEW.label_sample;
        RETURN NEW;
    ELSEIF GeometryType(NEW.geom) = 'POLYGON' THEN
        EXECUTE 'UPDATE fire SET label_sample = NULL WHERE ST_Within(fire.geom, $1)'
        USING NEW.geom;
        RETURN NEW;
    END IF;
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.sample_label()
  OWNER TO postgres;
