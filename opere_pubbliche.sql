select * from effis_stats.effis_stats_country_current('Albania');

select * from effis_stats.create_view_effis_stats_country_current('Albania');
select * from effis_stats.create_view_effis_stats_country_archived('Albania');

select * from effis_stats.effis_stats_country_archived('Albania');

select * from effis_stats.effis_stats_country_current('Italy');

select * from effis_stats.effis_stats_country_current('Macedonia');

select * from effis_stats.effis_stats_country_archived('Italy');

select distinct(adm.name_en) country,
       extract(year from firedate::date)::INTEGER as year_stats,			   
       extract(month from firedate::date)::INTEGER as months_stats,
       count(ba.ba_id) number_of_fires,		       
	   round(sum(public.ST_Area(ba.geom::public.geography)*0.0001)::numeric,2) hectares_stats
from effis.current_burnt_area as ba
     join public.admin_level_0 as adm on public.ST_Contains(adm.geom,ba.geom)
where ba.firedate between '2000-01-01' and '2050-12-31' 
and adm.name_en = 'Albania'
group by (country,year_stats,months_stats)
order by country,year_stats,months_stats;

select distinct(adm.name_en) country,
       firedate,     
       ba.ba_id,		       
	   public.ST_Area(ba.geom::public.geography)*0.0001 hectares_stats
from effis.current_burnt_area as ba
     join public.admin_level_0 as adm on public.ST_Contains(adm.geom,ba.geom)
where ba.firedate between '2000-01-01' and '2050-12-31' 
and adm.name_en = 'Macedonia'
group by (country,ba_id,firedate)
order by country;

select distinct(adm.name_en) country,
       extract(year from firedate::date)::INTEGER as year_stats,			   
       extract(month from firedate::date)::INTEGER as months_stats,
       count(ba.ba_id) number_of_fires,		       
	   round(sum(public.ST_Area(ba.geom::public.geography)*0.0001)::numeric,2) hectares_stats
from effis.archived_burnt_area as ba
     join public.admin_level_0 as adm on public.ST_Contains(adm.geom,ba.geom)
where ba.firedate between '2000-01-01' and '2050-12-31' 
and adm.name_en = 'Italy'
group by (country,year_stats,months_stats)
order by country,year_stats,months_stats;

with paese_effis as 
 ( select name_en from public.admin_level_0 where name_en LIKE 'H%')
select * from paese_effis;

--seleziono paesi che iniziano con H maiuscola
with paesi_effis_iniziano_con_H as 
 ( select name_en from public.admin_level_0 where name_en LIKE 'H%' ),
--seleziono paesi che iniziano con s minuscola
paesi_effis_finiscono_con_s as 
 (select name_en from public.admin_level_0 where name_en LIKE '%s' ),
paesi_che_iniziano_con_H_e_finiscono_con_s as (
  select h.name_en 
  from paesi_effis_iniziano_con_H h, paesi_effis_finiscono_con_s s
  where h.name_en = s.name_en)
select * from paesi_che_iniziano_con_H_e_finiscono_con_s;
