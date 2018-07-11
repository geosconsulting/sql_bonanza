-- Trigger: new_ca_inserted_calculate_adm2 on effis.current_burntareaspoly_internal
-- DROP TRIGGER new_ca_inserted_calculate_adm2 ON effis.current_burntareaspoly_internal;

CREATE TRIGGER new_ca_inserted_calculate_adm2
  AFTER INSERT
  ON effis.current_burntareaspoly_internal
  FOR EACH ROW
  EXECUTE PROCEDURE mm.log_admin2_intersect();

-- Function: mm.log_admin2_intersect()
-- DROP FUNCTION mm.log_admin2_intersect();

CREATE OR REPLACE FUNCTION mm.log_admin2_intersect()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO mm.ca_adm2(fire_id,adm2_id)
	  SELECT ca.id,ad.id
	  FROM effis.current_burntareaspoly ca
	  LEFT JOIN effis_ext_public.countries_adminsublevel2 ad 
	       ON ST_Intersects(ca.shape,ad.geom)
	  WHERE ca.id = NEW.id;
	  RAISE NOTICE 'new id %',NEW.id;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION mm.log_admin2_intersect()
  OWNER TO postgres;

-- Trigger: new_ca_inserted_calculate_adm3 on effis.current_burntareaspoly_internal
-- DROP TRIGGER new_ca_inserted_calculate_adm3 ON effis.current_burntareaspoly_internal;

CREATE TRIGGER new_ca_inserted_calculate_adm3
  AFTER INSERT
  ON effis.current_burntareaspoly_internal
  FOR EACH ROW
  EXECUTE PROCEDURE mm.log_admin3_intersect();
  
-- Function: mm.log_admin3_intersect()
-- DROP FUNCTION mm.log_admin3_intersect();

CREATE OR REPLACE FUNCTION mm.log_admin3_intersect()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO mm.ca_adm3(fire_id,adm3_id)
	SELECT ca.id,ad.id
	FROM effis.current_burntareaspoly ca
	LEFT JOIN effis_ext_public.countries_adminsublevel3 ad
	       ON ST_Intersects(ca.shape,ad.geom)
	WHERE ca.id = NEW.id;
     RAISE NOTICE 'new id %',NEW.id;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION mm.log_admin3_intersect()
  OWNER TO postgres;
  
-- Function: effis.fn_register_ba_change()
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

-- Trigger: new_ca_inserted_calculate_adm2 on effis.current_burntareaspoly_internal
-- DROP TRIGGER new_ca_inserted_calculate_adm2 ON effis.current_burntareaspoly_internal;

CREATE TRIGGER new_ca_inserted_calculate_adm2
  AFTER INSERT
  ON effis.current_burntareaspoly_internal
  FOR EACH ROW
  EXECUTE PROCEDURE mm.log_admin2_intersect();

-- Trigger: new_ca_inserted_calculate_adm3 on effis.current_burntareaspoly_internal
-- DROP TRIGGER new_ca_inserted_calculate_adm3 ON effis.current_burntareaspoly_internal;

CREATE TRIGGER new_ca_inserted_calculate_adm3
  AFTER INSERT
  ON effis.current_burntareaspoly_internal
  FOR EACH ROW
  EXECUTE PROCEDURE mm.log_admin3_intersect();
  
-- Function: ba_adm.log_admin3_intersect()
-- DROP FUNCTION ba_adm.log_admin3_intersect();

CREATE OR REPLACE FUNCTION ba_adm.log_admin3_intersect()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO fire_admin_link.ba_adm3(fire_id,adm3_id)
	SELECT ca.ba_id,ad.id
	FROM effis.current_burnt_areas ca
	LEFT JOIN effis_ext_public.admin_level_3 ad
	       ON ST_Intersects(ca.geom,ad.geom)
	WHERE ca.id = NEW.id;
     RAISE NOTICE 'new id %',NEW.id;
  RETURN NEW;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION ba_adm.log_admin3_intersect()
  OWNER TO postgres;
  
-- Function: ba_adm.adm1_by_fireid_with_areas(integer)
-- DROP FUNCTION ba_adm.adm1_by_fireid_with_areas(integer);

CREATE OR REPLACE FUNCTION ba_adm.adm1_by_fireid_with_areas(IN code integer)
  RETURNS TABLE(f_id integer, adm1_code integer, firedate character varying, update character varying, name_adm1 character varying, area double precision) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT p.id,b.id,b.firedate,b.lastupdate,p.name_local,ST_Area(ST_Intersection(b.geom, p.geom)) As area_intersection
     FROM effis.burnt_area_spatial b       
     INNER JOIN public.countries_adminsublevel1 p ON ST_Intersects(b.geom,p.geom)
     WHERE b.id = code
     ORDER BY area_intersection DESC;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION ba_adm.adm1_by_fireid_with_areas(integer)
  OWNER TO postgres;
  
-- Function: ba_adm.adm2_by_fireid_with_areas(integer)
-- DROP FUNCTION ba_adm.adm2_by_fireid_with_areas(integer);

CREATE OR REPLACE FUNCTION ba_adm.adm2_by_fireid_with_areas(IN code integer)
  RETURNS TABLE(f_id integer, adm2_code integer, firedate character varying, update character varying, name_adm2 character varying, area double precision) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT p.id,b.id,b.firedate,b.lastupdate,p.name_local,ST_Area(ST_Intersection(b.geom, p.geom)) As area_intersection
     FROM effis.burnt_area_spatial b       
     INNER JOIN public.countries_adminsublevel2 p ON ST_Intersects(b.geom,p.geom)
     WHERE b.id = code
     ORDER BY area_intersection DESC;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION ba_adm.adm2_by_fireid_with_areas(integer)
  OWNER TO postgres;

-- Function: ba_adm.adm3_by_fireid_with_areas(integer)
-- DROP FUNCTION ba_adm.adm3_by_fireid_with_areas(integer);

CREATE OR REPLACE FUNCTION ba_adm.adm3_by_fireid_with_areas(IN code integer)
  RETURNS TABLE(f_id integer, adm3_code integer, firedate character varying, update character varying, name_adm3 character varying, area double precision) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT p.id,b.id,b.firedate,b.lastupdate,p.name_local,ST_Area(ST_Intersection(b.geom, p.geom)) As area_intersection
     FROM effis.burnt_area_spatial b       
	INNER JOIN public.countries_adminsublevel3 p ON ST_Intersects(b.geom,p.geom)
     WHERE b.id = code
     ORDER BY area_intersection DESC;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION ba_adm.adm3_by_fireid_with_areas(integer)
  OWNER TO postgres;

-- Function: ba_adm.admns_by_fireid(integer, integer)
-- DROP FUNCTION ba_adm.admns_by_fireid(integer, integer);

CREATE OR REPLACE FUNCTION ba_adm.admns_by_fireid(
    IN fire_id integer,
    IN admin_level integer)
  RETURNS TABLE(f_id integer, adm1_code integer, firedate character varying, update character varying, name_adm1 character varying) AS
$BODY$
DECLARE
    admin_level_table varchar := 'public.admin_level_' || admin_level;    
    adm_mm varchar := 'ba_adm.ba_adm' || admin_level;
    fld_ba text := 'fire_id';
    fld_adm text := 'adm' || admin_level || '_id';
    query varchar :=  'SELECT a.fire_id, a.adm_id,b.firedate,b.lastupdate,c.name_en ' ||
		      'FROM ' || adm_mm || ' a ' ||
			'LEFT JOIN rdaprd.current_burntareaspoly b ON(a.fire_id = b.id) ' ||
			'LEFT JOIN ' || admin_level_table || ' c ON(a.adm_id = c.id) ' ||
		      'WHERE a.fire_id = ' || fire_id || ';';
BEGIN
   RETURN QUERY     
     EXECUTE query; 
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION ba_adm.admns_by_fireid(integer, integer)
  OWNER TO postgres;

-- Function: ba_adm.associate_ba_adm(integer)
-- DROP FUNCTION ba_adm.associate_ba_adm(integer);

CREATE OR REPLACE FUNCTION ba_adm.associate_ba_adm(admin_level integer)
  RETURNS void AS
$BODY$
DECLARE
    admin_level_table varchar := 'public.admin_level_' || admin_level;    
    adm_mm varchar := 'ba_adm.ba_adm' || admin_level;
    fld_ba text := 'fire_id';
    fld_adm text := 'adm' || admin_level || '_id';
    query varchar :=  'INSERT INTO ' || adm_mm || '(' || fld_ba || ',' || fld_adm || ')' ||
                      ' SELECT ba.id,ad.id FROM rdaprd.current_burntareaspoly ba' || 
                      ' LEFT JOIN public.admin_level_' || admin_level || ' ad ON ST_Intersects(ba.shape,ad.geom);'; 
BEGIN   
   RAISE NOTICE 'query %', query;
   EXECUTE query;              
END; 
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION ba_adm.associate_ba_adm(integer)
  OWNER TO postgres;

  



