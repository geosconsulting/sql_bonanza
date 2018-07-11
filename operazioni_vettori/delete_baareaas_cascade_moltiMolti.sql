ALTER TABLE mm.ca_adm3 DROP CONSTRAINT ca_adm3_fire_id_fkey;
ALTER TABLE mm.ca_adm3 DROP CONSTRAINT ca_adm3_adm3_id_fkey;

ALTER TABLE mm.ca_adm3 ADD CONSTRAINT ca_adm3_id_fkey 
FOREIGN KEY (adm3_id)
REFERENCES effis.adm3 (id) 
MATCH SIMPLE 
ON UPDATE NO ACTION 
ON DELETE CASCADE;

ALTER TABLE mm.ca_adm2 DROP CONSTRAINT ca_adm2_adm2_id_fkey;
ALTER TABLE mm.ca_adm2 DROP CONSTRAINT ca_adm2_fire_id_fkey;

ALTER TABLE mm.ca_adm 
DROP CONSTRAINT ca_adm_adm2_id_fkey;

ALTER TABLE mm.ca_adm 
DROP CONSTRAINT ca_adm_adm3_id_fkey;

ALTER TABLE mm.ca_adm 
DROP CONSTRAINT ca_adm_fire_id_fkey;

TRUNCATE TABLE mm.ca_adm3;
TRUNCATE TABLE mm.ca_adm2;
TRUNCATE TABLE mm.ca_adm;

TRUNCATE TABLE effis.current_burntareaspoly;

TRUNCATE TABLE effis.burnt_area_registry;

--*****************************************************************
DROP FUNCTION mm.log_admin3_intersect() CASCADE;

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
LANGUAGE 'plpgsql';

CREATE TRIGGER new_ca_inserted_calculate_adm3
  AFTER INSERT ON effis.current_burntareaspoly
  FOR EACH ROW
      EXECUTE PROCEDURE mm.log_admin3_intersect();

--TEST
SELECT a3.name_en, a3.name_local 
FROM effis_ext_public.countries_adminsublevel3 a3, mm.ca_adm3 fa3
WHERE fa3.adm3_id = a3.id;  

SELECT a3.name_local 
FROM effis_ext_public.countries_adminsublevel3 a3, mm.ca_adm3 fa3
WHERE fa3.adm3_id = a3.id
AND fa3.fire_id = 100; 

--*****************************************************************
DROP FUNCTION mm.log_admin2_intersect() CASCADE;

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
LANGUAGE 'plpgsql';

CREATE TRIGGER new_ca_inserted_calculate_adm2
  AFTER INSERT ON effis.current_burntareaspoly
  FOR EACH ROW
      EXECUTE PROCEDURE mm.log_admin2_intersect();    

--TEST
SELECT a2.name_en 
FROM effis_ext_public.countries_adminsublevel2 a2, mm.ca_adm2 fa2
WHERE fa2.adm2_id = a2.id;  

SELECT a2.name_local
FROM effis_ext_public.countries_adminsublevel2 a2, mm.ca_adm2 fa2
WHERE fa2.adm2_id = a2.id
AND fa2.fire_id = 100; 

--*****************************************************************
DROP FUNCTION mm.log_admin1_intersect() CASCADE;

CREATE OR REPLACE FUNCTION mm.log_admin1_intersect()
	RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO mm.ca_adm1(fire_id,adm1_id)
	  SELECT ca.id,ad.id
	  FROM effis.current_burntareaspoly ca
	       LEFT JOIN effis_ext_public.countries_adminsublevel1 ad ON ST_Intersects(ca.shape,ad.geom);
	  WHERE ca.id = NEW.id;
	  RAISE NOTICE 'new id %',NEW.id;
  RETURN NEW;
END;
$BODY$
LANGUAGE 'plpgsql';

CREATE TRIGGER new_ca_inserted_calculate_adm1
  AFTER INSERT ON effis.current_burntareaspoly
  FOR EACH ROW
      EXECUTE PROCEDURE mm.log_admin1_intersect();

--*****************************************************************
--*****************TEST TRIGGER WITH NEW OLD***********************
--*****************************************************************
DROP FUNCTION mm.log_admin_test_intersect() CASCADE;

CREATE OR REPLACE FUNCTION mm.log_admin_test_intersect() RETURNS trigger AS $BODY$
DECLARE 
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
LANGUAGE 'plpgsql';

DROP TRIGGER new_ca_inserted_calculate_test ON effis.current_burntareaspoly;

CREATE TRIGGER new_ca_inserted_calculate_test
  AFTER INSERT ON effis.current_burntareaspoly
  FOR EACH ROW
      EXECUTE PROCEDURE mm.log_admin_test_intersect();


-- Function: mm.adm3_by_fireid_with_areas(integer)

DROP FUNCTION mm.adm3_by_fireid_with_areas(integer);

CREATE OR REPLACE FUNCTION mm.adm3_by_fireid_with_areas(IN code integer)
  RETURNS TABLE(admin_id integer, name_adm3 character varying, area_ha double precision) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT p.id, p.name_local, ST_Area(ST_Intersection(p.geom,b.shape)::geography)*0.0001 As area_intersection
     FROM effis.current_burntareaspoly b       
	INNER JOIN effis_ext_public.countries_adminsublevel3 p ON ST_Intersects(p.geom,b.shape)
     WHERE b.id = code
     ORDER BY area_intersection DESC;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION mm.adm3_by_fireid_with_areas(integer)
  OWNER TO postgres;


-- Function: mm.adm3_by_fireid(integer)

DROP FUNCTION mm.adm3_by_fireid(integer);

CREATE OR REPLACE FUNCTION mm.adm3_by_fireid(IN code integer)
  RETURNS TABLE(admin_id integer, name_adm3 character varying) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT p.id, p.name_local 
     FROM effis.current_burntareaspoly b       
	INNER JOIN effis_ext_public.countries_adminsublevel3 p ON ST_Intersects(p.geom,b.shape)
     WHERE b.id = code;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION mm.adm3_by_fireid(integer)
  OWNER TO postgres;



