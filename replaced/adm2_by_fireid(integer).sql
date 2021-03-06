﻿-- Function: ba_adm.adm2_by_fireid(integer)

-- DROP FUNCTION ba_adm.adm2_by_fireid(integer);

CREATE OR REPLACE FUNCTION ba_adm.adm2_by_fireid(IN code integer)
  RETURNS TABLE(f_id integer, adm3_code integer, firedate character varying, update character varying, name_adm2 character varying) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT a.fire_id,a.adm2_id,b.firedate,b.lastupdate,c.name_en
	FROM fire_admin_link.ba_adm2 a
	   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
	   LEFT JOIN public.countries_adminsublevel2 c ON(a.adm2_id = c.id)
	WHERE a.fire_id = code;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION ba_adm.adm2_by_fireid(integer)
  OWNER TO postgres;
