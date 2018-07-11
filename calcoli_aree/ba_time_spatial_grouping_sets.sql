select adm.name_en,count(ba.id),sum(ST_Area(ba.geom)),extract(month from initialdate)
from nasa_modis_ba.final_ba as ba
join public.admin_level_0 as adm on st_contains(adm.geom,ba.geom)
where initialdate between '2017-01-01'::date and '2017-12-31'::date
and adm.name_en in (select country_name from region_aggregate('Southern Europe'))
group by grouping sets ((adm.name_en,extract(year from initialdate),adm.name_en);
