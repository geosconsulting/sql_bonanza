SELECT * FROM modis_viirs.modis LIMIT 10;

SELECT * FROM modis_viirs.modis WHERE acq_date = '2017-01-01';

SELECT date_trunc('month',acq_date) FROM modis_viirs.modis WHERE acq_date = '2016-01-01';

EXPLAIN SELECT * FROM modis_viirs.modis WHERE acq_date = '2017-01-01';

EXPLAIN SELECT * FROM modis_viirs.modis WHERE acq_date = '2016-01-01';

EXPLAIN SELECT * FROM modis_viirs.modis WHERE acq_date = '2015-01-01';

EXPLAIN SELECT * FROM modis_viirs.modis WHERE acq_date = '2014-06-01';


EXPLAIN SELECT * FROM modis_viirs.modis WHERE acq_date BETWEEN '2017-06-01' AND '2017-06-12';
EXPLAIN SELECT * FROM modis_viirs.modis WHERE acq_date BETWEEN '2016-06-01' AND '2016-06-12';
EXPLAIN SELECT * FROM modis_viirs.modis WHERE acq_date BETWEEN '2015-06-01' AND '2016-06-12';
EXPLAIN SELECT * FROM modis_viirs.modis WHERE acq_date BETWEEN '2016-02-01' AND '2016-03-02';
EXPLAIN SELECT * FROM modis_viirs.modis WHERE acq_date BETWEEN '2012-02-01' AND '2016-03-02';


--CREATE OR REPLACE VIEW public.lazio_2012 AS 
 SELECT h.modis_id,
    h.geom
   FROM modis_viirs.modis h,
    effis_ext_public.countries_adminsublevel1 a
  WHERE h.acq_date >= '2012-01-01'::date 
  AND h.acq_date <= '2012-12-01'::date 
  AND a.name_local::text = 'Lazio'::text 
  AND st_intersects(a.geom, h.geom);

SELECT count(h.modis_id)
FROM modis_viirs.modis h,  effis_ext_public.countries_adminsublevel1 a
WHERE h.acq_date >= '2012-01-01'::date 
AND h.acq_date <= '2012-12-01'::date 
AND a.name_local::text = 'Lazio'::text 
AND st_intersects(a.geom, h.geom);

SELECT count(h.modis_id)
FROM modis_viirs.modis h,
    effis_ext_public.countries_country a
WHERE h.acq_date >= '2012-01-01'::date 
AND h.acq_date <= '2012-12-01'::date 
AND a.name_en::text = 'Italy'::text 
AND st_intersects(a.geom, h.geom);


SELECT id,name_en,name_local,similarity(name_en, 'cataluna') AS sml
FROM effis_ext_public.countries_adminsublevel1
WHERE name_local % 'cataluna'
ORDER BY sml DESC, name_en
LIMIT 10;

--UPDATE modis_viirs.modis
--SET geom = ST_GeomFromText('POINT(' || longitude || ' ' || latitude || ')',4326);

SELECT count(h.modis_id)
FROM modis_viirs.modis h, effis_ext_public.countries_adminsublevel2 a
WHERE h.acq_date >= '2012-01-01'::date 
AND h.acq_date <= '2012-12-01'::date 
AND a.name_local::text = 'Roma'::text 
AND st_intersects(a.geom, h.geom);


SELECT count(h.modis_id)
FROM modis_viirs.modis h, effis_ext_public.countries_adminsublevel1 a
WHERE h.acq_date >= '2010-01-01'::date 
AND h.acq_date <= '2017-12-01'::date 
AND a.name_local::text = 'Cataluña'::text 
AND st_intersects(a.geom, h.geom);

SELECT count(h.modis_id) AS conteggio,to_char(to_timestamp(date_part('month',h.acq_date::timestamp)::text,'MM'),'Month') AS mese
FROM modis_viirs.modis h, effis_ext_public.countries_adminsublevel1 a
WHERE acq_date BETWEEN '2012-08-28' AND '2014-09-3'
AND a.name_local::text = 'Cataluña'::text 
AND st_intersects(a.geom, h.geom)
GROUP BY mese
ORDER BY conteggio;
