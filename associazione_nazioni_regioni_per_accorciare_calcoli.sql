drop function macroarea_aggregate(text);

create function macroarea_aggregate (in organization text) 
returns table ( country_id integer,
                country_name varchar,
                macroarea_name varchar)
As $$
BEGIN
 return QUERY
     select a.id,a.name_en,c.name
     from public.admin_level_0 a
	join public.admin_level_0_macroareas b on a.id=b.country_id
	join public.macroareas  c on b.macroarea_id= c.id
     where c.name = organization;
end; $$
language 'plpgsql';

SELECT * from macroarea_aggregate('EU');

drop function if exists region_aggregate(text);

create function region_aggregate (in regione text) 
returns table ( country_id integer,
                country_name varchar,
                region_name varchar)
As $$
BEGIN
 return QUERY
     select a.id,a.name_en,c.region
     from public.admin_level_0 a
	join public.admin_level_0_regions b on a.id=b.country_id
	join public.region  c on b.region_id= c.id
     where c.region = regione;
end; $$
language 'plpgsql';

SELECT * from region_aggregate('Northern Europe');
SELECT country_name from region_aggregate('Northern Europe');

drop materialized view public.adm0_cntrd;

create materialized view public.adm0_cntrd as 
Select id,iso2,ST_Centroid(geom) as geom
from public.admin_level_0;

drop materialized view public.adm3_cntrd;

create materialized view public.adm3_cntrd as 
Select id,ST_Centroid(geom) as geom
from public.admin_level_3;

drop materialized view public.adm0_divided_by_region;

drop materialized view public.adm0_grouped_by_region;

create materialized view public.adm0_grouped_by_region as 
select row_number() over (order by p1.id),
 p1.id as country_id,
 p2.id as region_id 
from adm0_cntrd p1, region p2 
where st_within (p1.geom, p2.geom);

create table admin_level_0_regions as 
select * from adm0_grouped_by_region;

select datname,usename,query from pg_stat_activity where wait_event is not null;

select distinct(adm.name_en),
       extract(year from initialdate) as anno, 
       extract(month from initialdate) as mese,
       count(ba.id),
       sum(ST_Area(ba.geom)) 
from nasa_modis_ba.final_ba as ba
     join public.admin_level_0 as adm on st_contains(adm.geom,ba.geom)
where ba.initialdate between '2017-01-01'::date and '2017-12-31'::date
and adm.name_en in (select country_name from region_aggregate('Southern Europe'))
group by (adm.name_en,anno,mese)
order by adm.name_en,mese;
