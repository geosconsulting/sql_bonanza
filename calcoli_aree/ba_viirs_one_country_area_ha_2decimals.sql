select distinct(adm.name_en),
       extract(year from initialdate) as anno, 
       extract(month from initialdate) as mese,
       count(ba.id),
       round(sum((ST_Area(ba.geom::geography))*0.0001)::numeric,2) 
from nasa_modis_ba.final_ba as ba
     join public.admin_level_0 as adm on st_contains(adm.geom,ba.geom)
where ba.initialdate between '2012-01-01'::date and '2017-12-31'::date
and adm.name_en in ('Spain')
group by (adm.name_en,anno,mese)
order by anno,mese;
