SELECT a.iso, a.name_iso, a.name_local, f.idate, f.type, f.fdate
FROM public.countries_country a , modis_viirs.fires_1_1_2001 f
WHERE a.iso = 'CMR'
AND f.type = 'FinalArea'
AND ST_Intersects(a.geom,f.geom);

SELECT COUNT(f.geom) as "Number of Fires", SUM(ST_Area(f.geom)) as "Summed Area Fires for Cameroon"
FROM modis_viirs.fires_1_1_2001 f, public.countries_country a
WHERE a.iso='CMR' 
AND ST_Within(f.geom,a.geom) 
GROUP BY f.type;

SELECT *
FROM public.glc_1x1k 
LIMIT 50;

SELECT (md).*, (bmd).* 
FROM (SELECT ST_Metadata(rast) AS md, 
             ST_BandMetadata(rast) AS bmd 
      FROM rst.glc_1x1k LIMIT 1
      ) foo;

SELECT COUNT(ba.geom) as "Number of Burnt Areas", SUM(ST_Area(ba.geom)) as "Summed Burnt Areas"
FROM public.burnt_area ba, public.countries_country cnt
WHERE cnt.name_en='Greece' 
AND ST_Within(ba.geom, cnt.geom);

SELECT SUM(ST_Area(ba.geom)) as "Summed Burnt Areas"
FROM public.burnt_area ba, public.countries_country cnt
WHERE cnt.name_en='Portugal' 
AND firedate BETWEEN('01-01-2017') AND ('01-04-2017')
AND ST_Within(ba.geom, cnt.geom);

SELECT SUM(ba.conifer) as "Conifer", SUM(ba.broadlea) as "Broad Leaf", SUM(ba.mixed) as "Mixed"
FROM public.burnt_area ba, public.countries_country cnt
WHERE cnt.name_en='Portugal' 
AND firedate BETWEEN('01-01-2017') AND ('01-04-2017')
AND ST_Within(ba.geom, cnt.geom);

SELECT COUNT(ba.geom) as "Number of  Burnt Areas ", SUM(ST_Area(ba.geom))*100000 as "Summed Burnt Areas", SUM(ba.conifer) as "Conifer", SUM(ba.broadlea) as "Broad Leaf", SUM(ba.mixed) as "Mixed"
FROM public.burnt_area ba, public.countries_country cnt
WHERE cnt.name_en='Italy' 
AND firedate BETWEEN('01-01-2017') AND ('01-04-2017')
AND ST_Within(ba.geom, cnt.geom);

SELECT ba.id as "Fire ID", firedate as "Fire Date", ba.conifer as "Conifer", ba.broadlea as "Broad Leaf", ba.mixed as "Mixed"
FROM public.burnt_area ba, public.countries_country cnt
WHERE cnt.name_en='Italy' 
AND firedate BETWEEN('01-01-2017') AND ('01-04-2017')
AND ST_Within(ba.geom, cnt.geom);

DROP VIEW vista_italia;
CREATE OR REPLACE VIEW vista_italia AS
	SELECT ba.geom, ba.id as "Fire ID", firedate as "Fire Date", ba.conifer as "Conifer", ba.broadlea as "Broad Leaf", ba.mixed as "Mixed"
	FROM public.burnt_area ba, public.countries_country cnt
	WHERE cnt.name_en='Italy' 
	AND firedate BETWEEN('01-01-2017') AND ('01-04-2017')
	AND ST_Within(ba.geom, cnt.geom);