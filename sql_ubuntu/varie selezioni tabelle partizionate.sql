EXPLAIN SELECT * FROM modis_viirs.modis WHERE acq_date = '2012-01-01';

SELECT * FROM modis_viirs.modis WHERE acq_date = '2012-01-01';

SELECT * FROM modis_viirs.modis WHERE acq_date = '2015-01-01';

SELECT * FROM modis_viirs.modis WHERE acq_date = '2017-01-08';

SELECT count(modis_id) 
FROM modis_viirs.modis h, effis_ext_public.countries_adminsublevel1 a
WHERE h.acq_date = '2012-08-01' 
AND a.name_local = 'Lazio'
AND st_intersects(a.geom, h.geom);

SELECT count(modis_id) 
FROM modis_viirs.modis h, effis_ext_public.countries_adminsublevel1 a
WHERE h.acq_date BETWEEN '2012-01-01' AND '2012-12-01'
AND a.name_local = 'Lazio'
AND st_intersects(a.geom, h.geom);

SELECT count(modis_id) 
FROM modis_viirs.modis h, effis_ext_public.countries_country a
WHERE h.acq_date = '2012-08-01' 
AND a.name_local = 'Italia'
AND st_intersects(a.geom, h.geom);

SELECT name_en,name_local,ST_AsGeoJSON(geom)
FROM effis_ext_public.countries_adminsublevel1 a
WHERE a.name_local = 'Lazio';