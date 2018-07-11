--SELECT VIIRS AROUND A CITY
SELECT c.name, v.acq_date, v.acq_time,
       st_distance(v.geom::geography,c.geom::geography)/1000 distkm_viirs
FROM "public"."populated_places" c, "public"."VNP14IMGTDL_NRT_Global_7d" v
WHERE c.name = 'Crotone'
AND st_dwithin(v.geom,c.geom, 0.15);

--SELECT MODIS AROUND A CITY
SELECT c.name, m.acq_date, m.acq_time,
       st_distance(m.geom::geography,c.geom::geography)/1000 distkm_modis
FROM "public"."populated_places" c, public."MODIS_C6_Global_7d" m
WHERE c.name = 'Crotone'
AND st_dwithin(m.geom,c.geom, 0.5);