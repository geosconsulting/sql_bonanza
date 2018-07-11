ALTER TABLE effis.burnt_area_spatial ADD PRIMARY KEY(id);

CREATE TABLE effis.adm3 AS 
   SELECT * FROM effis_ext_public.countries_adminsublevel3;
ALTER TABLE effis.adm3 ADD PRIMARY KEY(id);

CREATE TABLE mm.fire_adm3 (
   id serial PRIMARY KEY NOT NULL,
   fire_id int REFERENCES effis.burnt_area_spatial,
   adm3_id int REFERENCES effis.adm3);--,
   --PRIMARY KEY (fire_id, adm3_id));

-- NECESSARIA PERCHE ADM3 NON IN TUTTI I PAESI QUINDI 
-- ADM2 PRIMO LIVELLO con id ADMIN sempre disponibile
CREATE TABLE mm.fire_adm2 (
   id serial PRIMARY KEY NOT NULL,
   fire_id int REFERENCES effis.burnt_area_spatial,
   adm2_id int REFERENCES effis.adm2);--,
   --PRIMARY KEY (fire_id, adm3_id));

-- CORRELAZIONE FIRES ADM3 TUTTE
ROLLBACK;

BEGIN;
INSERT INTO mm.fire_adm3(fire_id,adm3_id)
    SELECT ba.id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN effis_ext_public.countries_adminsublevel3 ad ON ST_Intersects(ba.geom,ad.geom);    
COMMIT;


-- CORRELAZIONE FIRES ADM2 TUTTE
ROLLBACK;

BEGIN;
INSERT INTO mm.fire_adm2(fire_id,adm2_id)
    SELECT ba.id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN effis_ext_public.countries_adminsublevel2 ad ON ST_Intersects(ba.geom,ad.geom);    
COMMIT;

BEGIN;
INSERT INTO mm.fire_adm3(fire_id,adm3_id)
    SELECT ba.id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN effis_ext_public.countries_adminsublevel3 ad ON ST_Intersects(ba.geom,ad.geom)
    WHERE  ba.fire IN (201824, 168869,168870,182937,159573);
COMMIT;

SELECT * FROM effis.burnt_area_spatial WHERE id = 2667;

SELECT fire_id,adm3_id,b.firedate,b.lastupdate,c.country_id,c.admin1_id,c.admin2_id
FROM mm.fire_adm3 a
   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
   LEFT JOIN effis.adm3 c ON(a.adm3_id = c.id)
WHERE a.fire_id = 2667;

SELECT c.*
FROM effis.adm3 c 
WHERE c.name_en in ('Pratola Peligna','Salle');

SELECT * FROM effis.burnt_area_spatial WHERE id = 289;

SELECT fire_id,adm2_id,b.firedate,b.lastupdate,c.*
FROM mm.fire_adm2 a
   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
   LEFT JOIN effis.adm2 c ON(a.adm2_id = c.id)
WHERE a.fire_id = 2667;

-- SELECT a.fire_id, a.adm2_id --,b.adm3_id,c.firedate,c.lastupdate,d.*
-- FROM mm.fire_adm2 a, mm.fire_adm3 b
--   LEFT JOIN effis.burnt_area_spatial c ON(a.fire_id = c.id)
--   --LEFT JOIN effis.adm2 d ON(a.adm2_id = d.id)
--   --LEFT JOIN effis.adm3 e ON(b.adm3_id = e.id)
-- WHERE a.fire_id = 2667;

DROP FUNCTION effis.adm3_by_fireid(integer);

CREATE OR REPLACE FUNCTION effis.adm3_by_fireid(IN code integer)
  RETURNS TABLE(f_id integer,adm3_code integer, firedate character varying(10),update character varying(10), name_adm3 character varying) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT a.fire_id,a.adm3_id,b.firedate,b.lastupdate,c.name_en
	FROM mm.fire_adm3 a
	   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
	   LEFT JOIN effis.adm3 c ON(a.adm3_id = c.id)
	WHERE a.fire_id = code;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.adm3_by_fireid(integer)
  OWNER TO postgres;

DROP FUNCTION effis.adm2_by_fireid(integer);

CREATE OR REPLACE FUNCTION effis.adm2_by_fireid(IN code integer)
  RETURNS TABLE(f_id integer,adm3_code integer, firedate character varying(10),
                update character varying(10), name_adm2 character varying) AS
$BODY$
BEGIN
   RETURN QUERY
     SELECT a.fire_id,a.adm2_id,b.firedate,b.lastupdate,c.name_en
	FROM mm.fire_adm2 a
	   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
	   LEFT JOIN effis.adm2 c ON(a.adm2_id = c.id)
	WHERE a.fire_id = code;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.adm2_by_fireid(integer)
  OWNER TO postgres;

CREATE OR REPLACE FUNCTION effis.fires_by_adm3(IN code integer)
  RETURNS TABLE(name_adm3 character varying,f_id integer,firedate character varying(10),update character varying(10),area_ha integer) AS
$BODY$
BEGIN
   RETURN QUERY
      SELECT c.name_en,a.fire_id,b.firedate,b.lastupdate,b.area_ha
      FROM mm.fire_adm3 a
         LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
         LEFT JOIN effis.adm3 c ON(a.adm3_id = c.id)
       WHERE a.adm3_id= code;
     END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.fires_by_adm3(integer)
  OWNER TO postgres;

DROP FUNCTION effis.fires_by_adm3_name(varchar);

CREATE OR REPLACE FUNCTION effis.fires_by_adm3_name(IN name_adm3 varchar)
  RETURNS TABLE(name_adm3_ret character varying,f_id integer,firedate date,update date,area_ha integer,days_fire integer) AS
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
ALTER FUNCTION effis.fires_by_adm3_name(varchar)
  OWNER TO postgres;


DROP FUNCTION effis.all_admin_areas_by_fire(integer);

CREATE OR REPLACE FUNCTION effis.all_admin_areas_by_fire(IN search_fire_id integer)
  RETURNS TABLE(fid integer,
                admin_id integer,
                fire_date date,
                fire_update date,
	        adm3_name varchar,
                adm2_name varchar,
                adm1_name varchar, 
	        country_name varchar) AS
$BODY$
BEGIN
   RETURN QUERY
	SELECT a.fire_id,a.adm3_id,
	       b.firedate::date,b.lastupdate::date,
	       c.name_en,d.name_en,e.name_local,f.name_en
	FROM mm.fire_adm3 a
	   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
	   LEFT JOIN effis.adm3 c ON(a.adm3_id = c.id)
	   LEFT JOIN effis.adm2 d ON(c.admin2_id = d.id)
	   LEFT JOIN effis_ext_public.countries_adminsublevel1 e ON(c.admin1_id = e.id)
	   LEFT JOIN effis_ext_public.countries_country f ON(c.country_id = f.id)
	WHERE a.fire_id = search_fire_id
	ORDER BY d.name_en;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.all_admin_areas_by_fire(integer)
  OWNER TO postgres;

SELECT ba.objectid,fi.fire_id,ST_Distance(ST_Centroid(ba.shape),fi.geom) AS distance
FROM effis.fire fi,effis.current_burntareaspoly ba
WHERE ba.objectid = 29
ORDER BY fi.geom <-> ba.shape
LIMIT 5;
        
--***************** TEST CURRENT BURNT AREA POLY DA IMPLEMENTARE SU BURNT AREAS *************************
CREATE TABLE mm.ca_adm3 (   
   fire_id int REFERENCES effis.current_burntareaspoly,
   adm3_id int REFERENCES effis.adm3,
   PRIMARY KEY (fire_id, adm3_id)
);

UPDATE effis.current_burntareaspoly SET id = objectid;

-- CORRELAZIONE FIRES ADM3 TUTTE
ROLLBACK;
BEGIN;
INSERT INTO mm.ca_adm3(fire_id,adm3_id)
    SELECT ca.id,ad.id
    FROM effis.current_burntareaspoly ca
       LEFT JOIN effis_ext_public.countries_adminsublevel3 ad ON ST_Intersects(ca.shape,ad.geom);
COMMIT;

-- CORRELAZIONE FIRES ADM2 TUTTE

CREATE TABLE mm.ca_adm2 (   
   fire_id int REFERENCES effis.current_burntareaspoly,
   adm2_id int REFERENCES effis.adm2,
   PRIMARY KEY (fire_id, adm2_id)
);

ROLLBACK;
BEGIN;
INSERT INTO mm.ca_adm2(fire_id,adm2_id)
    SELECT ca.id,ad.id
    FROM effis.current_burntareaspoly ca
       LEFT JOIN effis_ext_public.countries_adminsublevel2 ad ON ST_Intersects(ca.shape,ad.geom);
COMMIT;

-- ERRORE AREE ADM2 ERRORE ************************
CREATE TABLE mm.ca_adm (   
   fire_id int REFERENCES effis.current_burntareaspoly,
   -- adm1_id int REFERENCES effis_ext_public.countries_adminsublevel1,	   
   adm2_id int REFERENCES effis.adm2,
   adm3_id int REFERENCES effis.adm3,
   -- ctry_id INT REFERENCES effis_ext_public.countries_country,
   PRIMARY KEY (fire_id,adm2_id,adm3_id) -- adm1_id,ctry_id,
);

-- CORRELAZIONE FIRES ADM TUTTE
-- ERRORE AREE ADM2 ERRORE ************************
ROLLBACK;
BEGIN;
INSERT INTO mm.ca_adm(fire_id,adm2_id,adm3_id)
    SELECT ca.id,a2.id,a3.id
    FROM effis.current_burntareaspoly ca
       LEFT JOIN effis.adm2 AS a2 ON ST_Intersects(ca.shape,a2.geom)
       LEFT JOIN effis.adm3 AS a3 ON ST_Intersects(ca.shape,a3.geom);
COMMIT;

-- ERRORE AREE ADM2 ERRORE ************************
SELECT a.fire_id,a.adm3_id,a.adm2_id,
       b.firedate::date,b.lastupdate::date,       
       c.name_en AS "ADM3",       
       d.name_en AS "ADM2",
       e.name_en AS "ADM1",
       f.name_en AS "CNTRY"
FROM mm.ca_adm a
   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
   LEFT JOIN effis.adm3 c ON(a.adm3_id = c.id)
   LEFT JOIN effis.adm2 d ON(a.adm2_id = d.id)
   LEFT JOIN effis_ext_public.countries_adminsublevel1 e ON(c.admin1_id = e.id)
   LEFT JOIN effis_ext_public.countries_country f ON(c.country_id = f.id)
WHERE a.fire_id = 100;

SELECT * FROM effis.adm2 WHERE id = 33768;

SELECT * FROM effis.adm3 WHERE id = 76114;

-- ############# SCRIPT FINALI PER EFFIS ###############
-- ############# SCRIPT FINALI PER EFFIS ###############
-- ############# SCRIPT FINALI PER EFFIS ###############

-- TABELLE MULTI-MULTI

CREATE TABLE fire_admin_link.ba_cntry ( 
   id_cntry_fire SERIAL UNIQUE NOT NULL PRIMARY KEY,  
   fire_id int REFERENCES effis.burnt_area_spatial,
   cntry_id int REFERENCES public.countries_country
);

CREATE TABLE fire_admin_link.ba_adm1 ( 
   id_amd1_fire SERIAL UNIQUE NOT NULL PRIMARY KEY,  
   fire_id int REFERENCES effis.burnt_area_spatial,
   adm1_id int REFERENCES public.countries_adminsublevel1
);

CREATE TABLE fire_admin_link.ba_adm2 ( 
   id_amd2_fire SERIAL UNIQUE NOT NULL PRIMARY KEY,  
   fire_id int REFERENCES effis.burnt_area_spatial,
   adm2_id int REFERENCES public.countries_adminsublevel2
);

CREATE TABLE fire_admin_link.ba_adm3 ( 
   id_amd3_fire SERIAL UNIQUE NOT NULL PRIMARY KEY,  
   fire_id int REFERENCES effis.burnt_area_spatial,
   adm3_id int REFERENCES public.countries_adminsublevel3
);

-- CORRELAZIONE FIRES ADM1 TUTTE
ROLLBACK;
BEGIN;
INSERT INTO fire_admin_link.ba_cntry(fire_id,cntry_id)
    SELECT ba.ba_id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN public.countries_country ad ON ST_Intersects(ba.geom,ad.geom);
COMMIT;

-- CORRELAZIONE FIRES ADM1 TUTTE
ROLLBACK;
BEGIN;
INSERT INTO fire_admin_link.ba_adm1(fire_id,adm1_id)
    SELECT ba.ba_id,ad.id
    FROM effis.current_burnt_area ba
       LEFT JOIN public.admin_level_1 ad ON ST_Intersects(ba.geom,ad.geom);
COMMIT;

-- CORRELAZIONE FIRES ADM2 TUTTE
ROLLBACK;
BEGIN;
INSERT INTO fire_admin_link.ba_adm2(fire_id,adm2_id)
    SELECT ba.ba_id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN public.countries_adminsublevel2 ad ON ST_Intersects(ba.geom,ad.geom);
COMMIT;

-- CORRELAZIONE FIRES ADM3 TUTTE
ROLLBACK;
BEGIN;
INSERT INTO fire_admin_link.ba_adm3(fire_id,adm3_id)
    SELECT ba.ba_id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN public.countries_adminsublevel3 ad ON ST_Intersects(ba.geom,ad.geom);
COMMIT;


