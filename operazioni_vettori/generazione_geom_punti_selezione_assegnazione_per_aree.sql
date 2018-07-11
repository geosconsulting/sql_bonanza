EXPLAIN SELECT * FROM modis_viirs.modis WHERE acq_date BETWEEN '2008-01-01' AND '2008-01-12';

SELECT count(*) FROM modis_viirs.modis WHERE acq_date BETWEEN '2008-01-01' AND '2008-01-12';

SELECT count(*) FROM modis_viirs.modis WHERE acq_date BETWEEN '2000-11-11' AND '2000-12-31';

SELECT count(*) FROM modis_viirs.modis WHERE acq_date BETWEEN '2000-11-01' AND '2000-12-31';

SELECT modis_id,latitude,longitude,ST_X(geom),ST_Y(geom)
FROM modis_viirs.modis 
WHERE acq_date <@ daterange('[2000-11-01,2000-12-31]')
LIMIT 25;

SELECT * FROM modis_viirs.modis WHERE acq_date BETWEEN '2000-11-01' AND '2000-12-31';

explain SELECT * FROM modis_viirs.modis WHERE acq_date BETWEEN '2001-01-01'::date AND '2001-12-31'::date;

SELECT count(modis_id) FROM modis_viirs.modis WHERE acq_date BETWEEN '2001-01-01'::date AND '2001-12-31'::date;

UPDATE modis_viirs.modis SET geom = ST_SetSrid(ST_MakePoint(longitude, latitude), 4326) 
WHERE acq_date BETWEEN '2009-01-01' AND '2009-12-31';

SELECT * FROM modis_viirs.modis WHERE acq_date BETWEEN '2010-11-01' AND '2010-12-31';


--********** INEFFICENTE LAVORA SU TUTTI I RECORDS ****************--
--SELECT mod.* FROM public.effis_countries adm, modis_viirs.modis mod 
--WHERE mod.acq_date BETWEEN '2000-11-01' AND '2000-12-31'
--AND ST_Within(mod.geom,adm.geom);

--********** NON FUNZIONA ****************--
WITH modis_annual As (SELECT count(mod.*)
		      FROM public.effis_countries adm, modis_viirs.modis mod 
                      WHERE mod.acq_date BETWEEN '2000-11-01'::date AND '2000-12-31'::date)
SELECT count(modis_annual.*)
FROM public.effis_countries adm
WHERE ST_Within(modis_annual.geom,adm.geom);

DROP VIEW modis_viirs.hs_2000_effis_area;

CREATE VIEW modis_viirs.hs_2000_effis_area AS 
	SELECT year_hs.*
	FROM (SELECT * FROM modis_viirs.modis mod WHERE mod.acq_date BETWEEN '2000-11-01'::date AND '2000-12-31'::date) AS year_hs 
	     ,public.effis_countries adm
	WHERE ST_Within(year_hs.geom,adm.geom);

CREATE MATERIALIZED VIEW modis_viirs.hs_2001_effis_area AS 
	SELECT year_hs.*
	FROM (SELECT * FROM modis_viirs.modis mod WHERE mod.acq_date BETWEEN '2001-01-01'::date AND '2001-12-31'::date) AS year_hs 
	     ,public.effis_countries adm
	WHERE ST_Within(year_hs.geom,adm.geom);

show work_mem;
show maintenance_work_mem;
show effective_cache_size;
SHOW shared_buffers;

SET LOCAL work_mem = '500MB';

SET work_mem = '500MB';

RESET work_mem;
     
--SELECT mod.* 
--FROM modis_viirs.modis AS mod , public.effis_countries adm 
--WHERE ST_Within((SELECT modint.geom 
--                 FROM modis_viirs.modis modint
--                 WHERE modint.acq_date 
--                 BETWEEN '2000-11-01' AND '2000-12-31')
--               ,adm.geom);



--SELECT a.iso, a.name_iso, a.name_local, f.idate, f.type, f.fdate
--FROM public.countries_country a , modis_viirs.fires_1_1_2001 f
--WHERE a.iso = 'CMR'
--AND f.type = 'FinalArea'
--AND ST_Intersects(a.geom,f.geom);