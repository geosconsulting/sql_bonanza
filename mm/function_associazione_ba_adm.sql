-- DROP FUNCTION ba_adm.associate_ba_adm(integer);

--CREATE OR REPLACE FUNCTION ba_adm.associate_ba_adm(IN admin_level integer)
--  RETURNS void AS $BODY$
--DECLARE
--    admin_level_table varchar := 'public.admin_level_' || admin_level;    
--    adm_mm varchar := 'ba_adm.ba_adm' || admin_level;
--    fld_ba text := 'fire_id';
--    fld_adm text := 'adm' || admin_level || '_id';
--    query varchar :=  'INSERT INTO ' || adm_mm || '(' || fld_ba || ',' || fld_adm || ')' ||
--                      ' SELECT ba.ba_id, ad.id FROM effis.current_burnt_area ba' || 
--                      ' LEFT JOIN public.admin_level_' || admin_level || ' ad ON ST_Intersects(ba.geom,ad.geom);'; 
--BEGIN   
--   RAISE NOTICE 'query %', query;
--   --EXECUTE query;              
--END; 
--$BODY$
--  LANGUAGE plpgsql VOLATILE
--  COST 100;


ALTER SEQUENCE ba_adm.ba_adm0_seq RESTART WITH 1;
ALTER SEQUENCE ba_adm.ba_adm1_seq RESTART WITH 1;
ALTER SEQUENCE ba_adm.ba_adm2_seq RESTART WITH 1;
ALTER SEQUENCE ba_adm.ba_adm3_seq RESTART WITH 1;

--INSERT INTO ba_adm.ba_adm2(fire_id,adm2_id)
  --SELECT ba.ba_id,ad.id
  --FROM effis.burnt_area_spatial ba
    --LEFT JOIN public.admin_level_2 ad ON ST_Intersects(ba.geom,ad.geom);

DROP FUNCTION ba_adm.associate_ba_adm(integer);

CREATE OR REPLACE FUNCTION ba_adm.associate_ba_adm(IN admin_level integer)
  RETURNS void AS $BODY$
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

ALTER FUNCTION ba_adm.associate_ba_adm(character varying)
  OWNER TO postgres;