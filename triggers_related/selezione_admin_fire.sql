SELECT ad.id,ad.name_en
FROM effis.current_burntareaspoly ba
  LEFT JOIN effis_ext_public.countries_adminsublevel3 ad ON ST_Intersects(ba.shape,ad.geom)
WHERE  ba.objectid = 28;

SELECT ba.objectid,ba.fire,ad.id,ad.name_en
FROM effis.current_burntareaspoly ba, effis_ext_public.countries_adminsublevel3 ad 
WHERE  ba.objectid = 28
AND ST_Intersects(ba.shape,ad.geom);

SELECT ba.objectid,ba.fire,ad.id,ad.name_en
FROM effis.current_burntareaspoly ba
  LEFT JOIN effis_ext_public.countries_adminsublevel2 ad ON ST_Intersects(ba.shape,ad.geom)
WHERE ba.objectid = 28;

SELECT ba.objectid,ba.fire,ad.id,ad.name_en
FROM effis.current_burntareaspoly ba
  LEFT JOIN effis_ext_public.countries_adminsublevel1 ad ON ST_Intersects(ba.shape,ad.geom)
WHERE  ba.objectid = 28;

SELECT ba.objectid,ba.fire,ad.id,ad.name_en
FROM effis.current_burntareaspoly ba
  LEFT JOIN effis_ext_public.countries_country ad ON ST_Intersects(ba.shape,ad.geom)
WHERE  ba.objectid = 28;

SELECT ba.objectid,ba.fire,ad1.name_en,ad2.name_en,ad3.name_en
FROM effis.current_burntareaspoly ba
  LEFT JOIN public.countries_adminsublevel1 ad1 ON ST_Intersects(ba.shape,ad1.geom)
  LEFT JOIN public.countries_adminsublevel2 ad2 ON ST_Intersects(ba.shape,ad2.geom)
  LEFT JOIN public.countries_adminsublevel3 ad3 ON ST_Intersects(ba.shape,ad3.geom)
WHERE  ba.objectid = 100;

SELECT ba.id,ba.fire,ad.id,ad.name_en
FROM effis.burnt_area_spatial ba
  LEFT JOIN effis_ext_public.countries_adminsublevel3 ad ON ST_Intersects(ba.geom,ad.geom)
WHERE  ba.fire = 181976;

SELECT ba.id,ba.fire,ad.id,ad.name_en
FROM effis.burnt_area_spatial ba
  LEFT JOIN effis_ext_public.countries_adminsublevel2 ad ON ST_Intersects(ba.geom,ad.geom)
WHERE  ba.fire = 181976;

SELECT ba.id,ba.fire,ad.id,ad.name_en
FROM effis.burnt_area_spatial ba
  LEFT JOIN effis_ext_public.countries_adminsublevel1 ad ON ST_Intersects(ba.geom,ad.geom)
WHERE  ba.fire = 181976;

SELECT ba.id,ba.fire,ad.id,ad.name_en
FROM effis.burnt_area_spatial ba
  LEFT JOIN effis_ext_public.countries_adminsublevel2 ad ON ST_Intersects(ba.geom,ad.geom)
WHERE  ba.fire = 181976;
