select distinct(adm.name_en),
       extract(year from initialdate) as anno, 
       extract(month from initialdate) as mese,
       count(ba.id),
       round(sum(ST_Area(ba.geom::geography)*0.0001)::numeric,2) as area_ha
from nasa_modis_ba.final_ba as ba
     join public.admin_level_0 as adm on st_contains(adm.geom,ba.geom)
where ba.initialdate between '2015-01-01'::date and '2017-12-31'::date
and adm.name_en in (select country_name from region_aggregate('Northern Europe'))
group by (adm.name_en,anno,mese)
order by adm.name_en,mese;


\copy modis_viirs.viirs(latitude ,longitude , bright_ti4, scan, track , 
	                    acq_date,acq_time,satellite,instrument,confidence,version_tf,bright_ti5,frp) 
FROM '/media/sf_Downloads/__effis/data/modis_viirs/DL_FIRE_V1_4965/fire_archive_V1_4965.csv'