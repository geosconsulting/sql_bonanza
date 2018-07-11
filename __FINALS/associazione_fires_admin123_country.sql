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

ROLLBACK;

BEGIN;
INSERT INTO fire_admin_link.ba_cntry(fire_id,cntry_id)
    SELECT ba.id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN public.countries_country_simple ad ON ST_Intersects(ba.geom,ad.geom);
COMMIT;

BEGIN;
INSERT INTO fire_admin_link.ba_adm1(fire_id,adm1_id)
    SELECT ba.id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN public.countries_adminsublevel1 ad ON ST_Intersects(ba.geom,ad.geom);
COMMIT;

BEGIN;
INSERT INTO fire_admin_link.ba_adm2(fire_id,adm2_id)
    SELECT ba.id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN public.countries_adminsublevel2 ad ON ST_Intersects(ba.geom,ad.geom);
--ROLLBACK;
COMMIT;

BEGIN;
INSERT INTO fire_admin_link.ba_adm3(fire_id,adm3_id)
    SELECT ba.id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN public.countries_adminsublevel3 ad ON ST_Intersects(ba.geom,ad.geom);
--ROLLBACK;
COMMIT;


BEGIN;
INSERT INTO fire_admin_link.ba_adm3(fire_id,adm3_id)
    SELECT ba.id,ad.id
    FROM effis.burnt_area_spatial ba
       LEFT JOIN public.countries_adminsublevel3 ad ON ST_Intersects(ba.geom,ad.geom);
--ROLLBACK;
COMMIT;