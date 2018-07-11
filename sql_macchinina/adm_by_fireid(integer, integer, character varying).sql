-- Function: effis.adm_by_fireid(integer, integer, character varying)

-- DROP FUNCTION effis.adm_by_fireid(integer, integer, character varying);

CREATE OR REPLACE FUNCTION effis.adm_by_fireid(
    IN code integer,
    IN admin_level integer,
    IN ba_status character varying)
  RETURNS TABLE(f_id integer, adm3_code integer, firedate character varying, update character varying, name_adm3 character varying) AS
$BODY$
DECLARE
    admin_level_table varchar := 'public.admin_level_' || admin_level;
    adm_id varchar := 'adm' || admin_level ||'_id';
    adm_mm varchar := 'fire_admin_link.ba_adm' || admin_level;
    query varchar :=  'SELECT a.fire_id,a.' || adm_id ||',b.firedate,b.lastupdate,c.name_en FROM ' || adm_mm || 
                      ' a LEFT JOIN effis.current_burnt_area b ON(a.fire_id = b.ba_id) LEFT JOIN ' || admin_level_table || 
                      ' c ON(a.' || adm_id || '= c.id) WHERE a.fire_id = ' || code || ';';
BEGIN
   RETURN QUERY
      EXECUTE query;
END; 
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.adm_by_fireid(integer, integer, character varying)
  OWNER TO postgres;
