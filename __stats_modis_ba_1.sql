SELECT a.name_en,COUNT(f.id) as "Number of Fires" 
FROM nasa_modis_ba.final_ba f, public.admin_level_3 a
where f.initialdate between '2003-01-01'::date and '2003-12-31'::date
AND a.name_local='Roma' 
AND ST_Intersects(f.geom,a.geom)
group by a.name_en;
