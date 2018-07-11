-- Function: effis.ba_by_adm_name(integer, character varying)

-- DROP FUNCTION effis.ba_by_adm_name(integer, character varying);

CREATE OR REPLACE FUNCTION effis.ba_by_adm_name(
    IN admin_level integer,
    IN adm_name character varying)
  RETURNS TABLE(name_adm character varying, f_id integer, firedate date, update date, area_ha integer) AS
$BODY$
DECLARE
    admin_level_table varchar := 'public.admin_level_' || admin_level;
    adm_id varchar := 'adm' || admin_level ||'_id';
    adm_mm varchar := 'fire_admin_link.ba_adm' || admin_level;
    query varchar :=  'SELECT c.name_en, a.fire_id, b.firedate::date,b.lastupdate::date, b.area_ha FROM ' || adm_mm || 
                      ' a LEFT JOIN effis.current_burnt_area b ON(a.fire_id = b.ba_id) LEFT JOIN ' || admin_level_table || 
                      ' c ON(a.' || adm_id || '= c.id) WHERE c.name_en = ''' || adm_name || ''';';
BEGIN
   RETURN QUERY
   --RAISE NOTICE 'query %' , query;
   EXECUTE query;           
END; 
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.ba_by_adm_name(integer, character varying)
  OWNER TO postgres;
