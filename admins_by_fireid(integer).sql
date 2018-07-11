-- Function: ba_adm.adm1_by_fireid(integer)

DROP FUNCTION ba_adm.admns_by_fireid(integer,integer);

CREATE OR REPLACE FUNCTION ba_adm.admns_by_fireid(IN fire_id integer,IN admin_level Integer)
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
  
ALTER FUNCTION ba_adm.admns_by_fireid(integer,integer)
  OWNER TO postgres;
