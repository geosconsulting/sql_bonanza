SELECT a.name_en,COUNT(f.id) as num_fires
FROM nasa_modis_ba.final_ba f, public.admin_level_1 a
where f.initialdate between '2003-01-01'::date and '2003-12-31'::date
AND a.name_local='Sicilia' 
AND ST_Relate(f.geom,a.geom)
group by a.name_en;

SELECT a.name_en,COUNT(f.id) as num_fires
FROM nasa_modis_ba.final_ba f, public.admin_level_2 a
where f.initialdate between '2003-01-01'::date and '2003-12-31'::date
AND a.name_local='Palermo' 
AND ST_Intersects(f.geom,a.geom)
group by a.name_en;
