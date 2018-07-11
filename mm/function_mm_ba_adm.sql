--ROLLBACK;
--BEGIN;
--INSERT INTO fire_admin_link.ba_adm3(fire_id,adm3_id)
--    SELECT ba.ba_id,ad.id
--    FROM effis.burnt_area_spatial ba
--       LEFT JOIN public.admin_level_3 ad ON ST_Intersects(ba.geom,ad.geom);
--COMMIT;

ROLLBACK;
BEGIN;
INSERT INTO fire_admin_link.ba_adm2(fire_id,adm2_id)
    SELECT ba.ba_id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN public.admin_level_2 ad ON ST_Intersects(ba.geom,ad.geom);
COMMIT;

ROLLBACK;
BEGIN;
INSERT INTO fire_admin_link.ba_adm1(fire_id,adm1_id)
    SELECT ba.ba_id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN public.admin_level_1 ad ON ST_Intersects(ba.geom,ad.geom);
COMMIT;

ROLLBACK;
BEGIN;
INSERT INTO fire_admin_link.ba_adm0(fire_id,adm0_id)
    SELECT ba.ba_id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN public.admin_level_0 ad ON ST_Intersects(ba.geom,ad.geom);
COMMIT;

-- Function: effis.adm3_by_fireid(integer)

-- DROP FUNCTION effis.adm3_by_fireid(integer);

CREATE OR REPLACE FUNCTION effis.adm3_by_fireid(IN code integer)
  RETURNS TABLE(f_id integer, adm3_code integer, firedate character varying, update character varying, name_adm3 character varying) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT a.fire_id,a.adm3_id,b.firedate,b.lastupdate,c.name_en
	FROM fire_admin_link.ba_adm3 a
	   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.ba_id)
	   LEFT JOIN public.admin_level_3 c ON(a.adm3_id = c.id)
	WHERE a.fire_id = code;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.adm3_by_fireid(integer)
  OWNER TO postgres;


CREATE OR REPLACE FUNCTION effis.adm_by_fireid(IN code integer,IN admin_level integer,IN ba_status varchar)
  RETURNS TABLE(f_id integer, adm3_code integer, firedate character varying, update character varying, name_adm3 character varying) AS
$BODY$
DECLARE
    admin_level_table varchar := 'public.admin_level_' || admin_level;
    adm_id varchar := 'adm' || admin_level ||'_id';
    adm_mm varchar := 'fire_admin_link.ba_adm' || admin_level;
    query varchar :=  'SELECT a.fire_id,a.' || adm_id ||',b.firedate,b.lastupdate,c.name_en FROM ' || adm_mm || 
                      ' a LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.ba_id) LEFT JOIN ' || admin_level_table || 
                      ' c ON(a.' || adm_id || '= c.id) WHERE a.fire_id = ' || code || ';';
BEGIN
   RETURN QUERY
      EXECUTE query;
END; 
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.adm3_by_fireid(integer)
  OWNER TO postgres;


  -- Function: effis.fires_by_adm3_name(character varying)

-- DROP FUNCTION effis.fires_by_adm3_name(character varying);

CREATE OR REPLACE FUNCTION effis.fires_by_adm3_name(IN name_adm3 character varying)
  RETURNS TABLE(name_adm3_ret character varying, f_id integer, firedate date, update date, area_ha integer, days_fire integer) AS
$BODY$
BEGIN
   RETURN QUERY
      SELECT c.name_en,a.fire_id,b.firedate::date,b.lastupdate::date,b.area_ha,b.lastupdate::date - b.firedate::date
      FROM fire_admin_link.ba_adm3 a
         LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.ba_id)
         LEFT JOIN public.admin_level_3 c ON(a.adm3_id = c.id)
       WHERE c.name_en = name_adm3;
     
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.fires_by_adm3_name(character varying)
  OWNER TO postgres;


CREATE OR REPLACE FUNCTION effis.fires_by_adm3_name(IN name_adm3 character varying)
  RETURNS TABLE(name_adm3_ret character varying, f_id integer, firedate date, update date, area_ha integer, days_fire integer) AS
$BODY$
BEGIN
   RETURN QUERY
      SELECT c.name_en,a.fire_id,b.firedate::date,b.lastupdate::date,b.area_ha,b.lastupdate::date - b.firedate::date
      FROM fire_admin_link.ba_adm3 a
         LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.ba_id)
         LEFT JOIN public.admin_level_3 c ON(a.adm3_id = c.id)
       WHERE c.name_en = name_adm3;
     
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.fires_by_adm3_name(character varying)
  OWNER TO postgres;

DROP FUNCTION effis.ba_by_adm_name(integer,character varying);

CREATE OR REPLACE FUNCTION effis.ba_by_adm_name(IN admin_level integer,IN adm_name character varying)
  RETURNS TABLE(name_adm character varying, f_id integer, firedate date, update date, area_ha integer) AS
$BODY$
DECLARE
    admin_level_table varchar := 'public.admin_level_' || admin_level;
    adm_id varchar := 'adm' || admin_level ||'_id';
    adm_mm varchar := 'fire_admin_link.ba_adm' || admin_level;
    query varchar :=  'SELECT c.name_en, a.fire_id, b.firedate::date,b.lastupdate::date, b.area_ha FROM ' || adm_mm || 
                      ' a LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.ba_id) LEFT JOIN ' || admin_level_table || 
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
ALTER FUNCTION effis.fires_by_adm3_name(character varying)
  OWNER TO postgres;

DROP FUNCTION effis.ba_by_adm_code(integer,integer);

CREATE OR REPLACE FUNCTION effis.ba_by_adm_code(IN admin_level integer,IN adm_code integer)
  RETURNS TABLE(name_adm_ret character varying, f_id integer, firedate date, update date, area_ha integer) AS
$BODY$
DECLARE
    admin_level_table varchar := 'public.admin_level_' || admin_level;
    adm_id varchar := 'adm' || admin_level ||'_id';
    adm_mm varchar := 'fire_admin_link.ba_adm' || admin_level;
    query varchar :=  'SELECT c.name_en, a.fire_id, b.firedate::date,b.lastupdate::date, b.area_ha FROM ' || adm_mm || 
                      ' a LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.ba_id) LEFT JOIN ' || admin_level_table || 
                      ' c ON(a.' || adm_id || '= c.id) WHERE c.id = ''' || adm_code || ''';';
BEGIN
   RETURN QUERY
   --RAISE NOTICE 'query %' , query;
   EXECUTE query;           
END; 
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.fires_by_adm3_name(character varying)
  OWNER TO postgres;

