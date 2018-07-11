-- Function: ba_adm.adm1_by_fireid(integer)

-- DROP FUNCTION ba_adm.adm1_by_fireid(integer);

CREATE OR REPLACE FUNCTION ba_adm.adm1_by_fireid(IN code integer)
  RETURNS TABLE(f_id integer, adm1_code integer, firedate character varying, update character varying, name_adm1 character varying) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT a.fire_id,a.adm1_id,b.firedate,b.lastupdate,c.name_en
	FROM ba_adm.ba_adm1 a
	   LEFT JOIN rdaprd.current_burntareaspoly b ON(a.fire_id = b.id)
	   LEFT JOIN public.admin_level_1 c ON(a.adm1_id = c.id)
	WHERE a.fire_id = code;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION ba_adm.adm1_by_fireid(integer)
  OWNER TO postgres;
