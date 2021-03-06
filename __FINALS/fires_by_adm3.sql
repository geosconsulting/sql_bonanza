﻿-- Function: effis.fires_by_adm3(integer)

-- DROP FUNCTION effis.fires_by_adm3(integer);
CREATE OR REPLACE FUNCTION effis.fires_by_adm3(IN code integer)
  RETURNS TABLE(name_adm3 character varying, f_id integer, firedate character varying, update character varying, area_ha integer) AS
$BODY$
BEGIN
   RETURN QUERY
      SELECT c.name_en,a.fire_id,b.firedate,b.lastupdate,b.area_ha
      FROM mm.ca_adm3 a
         LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
         LEFT JOIN public.countries_adminsublevel3 c ON(a.adm3_id = c.id)
       WHERE a.id= code;
     
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.fires_by_adm3(integer)
  OWNER TO postgres;

-- Function: effis.fires_by_adm3_name(character varying)

-- DROP FUNCTION effis.fires_by_adm3_name(character varying);
CREATE OR REPLACE FUNCTION effis.fires_by_adm3_name(IN name_adm3 character varying)
  RETURNS TABLE(name_adm3_ret character varying, f_id integer, firedate date, update date, area_ha integer, days_fire integer) AS
$BODY$
BEGIN
   RETURN QUERY
      SELECT c.name_en,a.fire_id,b.firedate::date,b.lastupdate::date,b.area_ha,b.lastupdate::date - b.firedate::date
      FROM mm.fire_adm3 a
         LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
         LEFT JOIN effis.adm3 c ON(a.adm3_id = c.id)
       WHERE c.name_en = name_adm3;
     
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.fires_by_adm3_name(character varying)
  OWNER TO postgres;
