select count(ba.id) 
from nasa_modis_ba.final_ba as ba
join public.admin_level_0 as adm on st_contains(adm.geom,ba.geom)
where initialdate between '2015-06-15'::date and '2017-07-15'::date
and adm.name_en in(select country_name from region_aggregate('Southern Europe');
