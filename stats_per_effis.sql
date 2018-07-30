SELECT DISTINCT yearseason,
                countryfullname,
				country,
				firedate,
				lastupdate,
				lastfiredate,
				mese,
                count(objectid) OVER w AS "Number of Fires",
                sum(area_ha) OVER w AS "Summed Hectares"				
FROM rdaprd_esposito.from2000_burntareas
WINDOW w AS (PARTITION BY yearseason, countryfullname)
order by yearseason;

SELECT DISTINCT yearseason,
                countryfullname,
				country,
				firedate,				
				mese,
                count(objectid) OVER w AS "Number of Fires",
                sum(area_ha) OVER w AS "Summed Hectares"				
FROM rdaprd_esposito.from2000_burntareas
where mese is not null
WINDOW w AS (PARTITION BY yearseason, countryfullname)
order by yearseason;

SELECT DISTINCT yearseason,
                countryfullname,
				firedate,
				--lastupdate,
				--lastfiredate,
                count(objectid) OVER w AS "Number of Fires",
                sum(area_ha) OVER w AS "Summed Hectares",
				sum(broadleavedforest) OVER w AS "Broadleaved Forest",
				sum(coniferous) OVER w AS "Coniferous",
				sum(mixed) OVER w AS "Mixed",
				sum(transitional) OVER w AS "Transitional",
				sum(othernatland) OVER w AS "Other Natural Landcover",
				sum(agriareas) OVER w AS "Agricultural Areas",
				sum(artsurf) OVER w AS "Artificial Surfaces",
				sum(otherlandcover) OVER w AS "Other Land Cover"				
FROM rdaprd_esposito.from2009_firesevolution
WINDOW w AS (PARTITION BY yearseason, countryfullname,broadleavedforest,coniferous,mixed,transitional,othernatland,agriareas,artsurf,otherlandcover)
order by yearseason;

select distinct(adm.name_en) country,
       extract(year from firedate::date)::INTEGER as year_stats,			   
       extract(month from firedate::date)::INTEGER as months_stats,
       count(ba.id) number_of_fires,		       
	   round(sum(public.ST_Area(ba.shape::public.geography)*0.0001)::numeric,2) hectares_stats
from rdaprd_esposito.from2009_firesevolution as ba
     join public.admin_level_0 as adm on public.ST_Contains(adm.geom,ba.shape)
where ba.firedate between '2000-01-01' and '2018-12-31' 
and adm.name_en='Italy'
group by (country,year_stats,months_stats)
order by country,year_stats,months_stats;

select distinct(adm.name_en) country,
       extract(year from firedate::date)::INTEGER as year_stats,			   
       extract(month from firedate::date)::INTEGER as months_stats,
       count(ba.global_id) number_of_fires,		       
	   round(sum(public.ST_Area(ba.geom::public.geography)*0.0001)::numeric,2) hectares_stats
from effis.burnt_areas as ba
     join public.admin_level_0 as adm on public.ST_Contains(adm.geom,ba.geom)
where ba.firedate between '2000-01-01' and '2018-12-31' 
and adm.name_en = 'Italy'
group by (country,year_stats,months_stats)
order by country,year_stats,months_stats;

select * from rdaprd_esposito.from2009_firesevolution OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;
select * from rdaprd_esposito.from2009_firesevolution FETCH first 5 ROWS ONLY;

select distinct(ST_SRID(shape)) from rdaprd_esposito.from2009_firesevolution;
select distinct(ST_SRID(shape)) from rdaprd.rob_burntareas;

create materialized view effis.portugal_stats as 
select distinct(adm.name_en) country,
       extract(year from firedate::date)::INTEGER as year_stats,			   
       extract(month from firedate::date)::INTEGER as months_stats,
       count(ba.global_id) number_of_fires,		       
	   round(sum(public.ST_Area(ba.geom::public.geography)*0.0001)::numeric,2) hectares_stats
from effis.burnt_areas as ba
     join public.admin_level_0 as adm on public.ST_Contains(adm.geom,ba.geom)
where ba.firedate between '2000-01-01' and '2018-12-31' 
and adm.name_en = 'Portugal'
group by (country,year_stats,months_stats)
order by country,year_stats,months_stats;
						
create materialized view effis.spain_stats as 
select distinct(adm.name_en) country,
       extract(year from firedate::date)::INTEGER as year_stats,			   
       extract(month from firedate::date)::INTEGER as months_stats,
       count(ba.global_id) number_of_fires,		       
	   round(sum(public.ST_Area(ba.geom::public.geography)*0.0001)::numeric,2) hectares_stats
from effis.burnt_areas as ba
     join public.admin_level_0 as adm on public.ST_Contains(adm.geom,ba.geom)
where ba.firedate between '2000-01-01' and '2018-12-31' 
and adm.name_en = 'Spain'
group by (country,year_stats,months_stats)
order by country,year_stats,months_stats;

drop function effis.__effis_stats_country(text);

create function effis.__effis_stats_country(paese text)
    RETURNS void    
AS $BODY$
DECLARE  
   qry varchar;
BEGIN 						
qry := 'create materialized view effis.' || lower(paese) || '_stats as 
             select distinct(adm.name_en) country,
             extract(year from firedate::date)::INTEGER as year_stats,			   
             extract(month from firedate::date)::INTEGER as months_stats,
             count(ba.global_id) number_of_fires,		       
	         round(sum(public.ST_Area(ba.geom::public.geography)*0.0001)::numeric,2) hectares_stats
      from effis.burnt_areas as ba
           join public.admin_level_0 as adm on public.ST_Contains(adm.geom,ba.geom)
      where ba.firedate between ''2000-01-01'' and ''2018-12-31'' 
      and adm.name_en = ''' || paese || '''
      group by (country,year_stats,months_stats)
      order by country,year_stats,months_stats;';
 raise notice '%',qry;
 execute qry;						
end;
$BODY$	
LANGUAGE 'plpgsql'	
COST 100
VOLATILE ;