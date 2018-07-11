/*
-- trigger function
CREATE OR REPLACE FUNCTION fn_test_table_geo_update_event() RETURNS trigger AS $fn_test_table_geo_update_event$
  BEGIN  
	-- as this is an after trigger, NEW contains all the information we need even for INSERT
	UPDATE test_table SET 


	RAISE NOTICE 'UPDATING geo data for %, [%,%]' , NEW.id, NEW.latitude, NEW.longitude;	
    RETURN NULL; -- result is ignored since this is an AFTER trigger
  END;
$fn_test_table_geo_update_event$ LANGUAGE plpgsql;

-- triggers
-- INSERT trigger
DROP TRIGGER IF EXISTS tr_test_table_inserted ON test_table;
CREATE TRIGGER tr_test_table_inserted
  AFTER INSERT ON test_table
  FOR EACH ROW
EXECUTE PROCEDURE fn_test_table_geo_update_event();

--  UPDATE trigger
DROP TRIGGER IF EXISTS tr_test_table_geo_updated ON test_table;
CREATE TRIGGER tr_test_table_geo_updated
  AFTER UPDATE OF 
  latitude,
  longitude
  ON test_table
  FOR EACH ROW
  EXECUTE PROCEDURE fn_test_table_geo_update_event();
  
-- test queries
--INSERT INTO test_table (latitude, longitude) VALUES(43.653226, -79.3831843);
--UPDATE test_table SET latitude=39.653226 WHERE id=1;
--SELECT to_timestamp(updated_ts), * FROM test_table;
*/

CREATE OR REPLACE FUNCTION calc_area()
RETURNS trigger AS
$BODY$
BEGIN
NEW.area_ha := ROUND((st_area(NEW.geom::geography)/10000)::numeric,2);
RAISE NOTICE 'Area Polygon Inserted %' , NEW.area_ha;
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

CREATE TRIGGER area_calculate BEFORE INSERT OR UPDATE ON fabio.test_area
    FOR EACH ROW EXECUTE PROCEDURE calc_area();