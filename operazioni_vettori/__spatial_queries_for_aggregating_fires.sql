SELECT a.iso, a.name_iso, a.name_local, f.acq_date 
FROM public.admin_level_0 a , modis_viirs.modis f
where f.acq_date between '2001-01-01'::date and '2001-12-31'::date
AND a.iso = 'ITA'
AND ST_Intersects(a.geom,f.geom);

SELECT a.name_en,COUNT(f.modis_id) as "Number of Fires" 
FROM modis_viirs.modis f, public.admin_level_0 a
where f.acq_date between '2003-06-01'::date and '2003-06-30'::date
AND a.iso='ITA' 
AND ST_Intersects(f.geom,a.geom)
group by a.name_en;

drop materialized view modis_viirs.mv_modis_hotspots_italy;

set work_mem = '200MB';

create materialized view modis_viirs.mv_modis_hotspots_italy AS
SELECT a.iso, a.name_iso, a.name_local, f.acq_date 
FROM public.admin_level_0 a , modis_viirs.modis f
--where f.acq_date between '2001-01-01'::date and '2001-12-31'::date
WHERE a.iso = 'ITA'
AND ST_Intersects(a.geom,f.geom);

drop materialized view modis_viirs.mv_modis_hotspots_italy_provinces;

create materialized view modis_viirs.mv_modis_hotspots_italy AS
SELECT a.iso, a.name_iso, a.name_local, f.acq_date 
FROM public.admin_level_1 a , modis_viirs.modis f
--where f.acq_date between '2001-01-01'::date and '2001-12-31'::date
WHERE a.name_en = 'Lazio'
AND ST_Intersects(a.geom,f.geom);

drop view modis_viirs.v_modis_hotspots_italy;

create view modis_viirs.v_modis_hotspots_italy AS
SELECT a.iso, a.name_iso, a.name_local, f.acq_date ,f.geom
FROM public.admin_level_0 a , modis_viirs.modis f
--where f.acq_date between '2001-01-01'::date and '2001-12-31'::date
WHERE a.iso = 'ITA'
AND ST_Intersects(a.geom,f.geom);

SELECT COUNT(f.modis_id) over w as "Number of Fires" 
FROM modis_viirs.modis f, public.admin_level_0 a
where f.acq_date between '2001-03-01'::date and '2001-05-01'::date
and a.iso='ITA' 
AND ST_Within(f.geom,a.geom)
window w as (partition by extract(month from f.acq_date));

SELECT COUNT(ba.geom) as "Number of Burnt Areas", SUM(ST_Area(ba.geom)) as "Summed Burnt Areas"
FROM effis.burnt_area ba, public.countries_country cnt
WHERE cnt.name_en='Greece' 
AND ST_Within(ba.geom, cnt.geom);

SELECT SUM(ST_Area(ba.geom)) as "Summed Burnt Areas"
FROM public.current_burnt_area ba, public.countries_country cnt
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