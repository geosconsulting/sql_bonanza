alter table nasa_modis_ba.gwis_stats_ts add column data_ts date;
alter table nasa_modis_ba.gwis_stats_ts add column iso2 varchar;

select (year_stats || '-' || months_stats || '-15')::date from nasa_modis_ba.gwis_stats_ts;

select to_date(year_stats || '-' || months_stats || '-15','YYYY-MM-DD') as avg_date
from nasa_modis_ba.gwis_stats_ts;
--where avg_date between '2012-01-01' and '2012-06-30';

insert into nasa_modis_ba.gwis_stats_ts(data_ts)
select to_date(year_stats || '-' || months_stats || '-15','YYYY-MM-DD')
from nasa_modis_ba.gwis_stats_ts;

insert into nasa_modis_ba.gwis_stats_ts(iso2)
select ad.iso2--,st.country,ad.id,st.country_code 
from nasa_modis_ba.gwis_stats_ts st,public.admin_level_0 ad
where st.country_code=ad.id;
--LIMIT 10;

update nasa_modis_ba.gwis_stats_ts
set data_ts = to_date(year_stats || '-' || months_stats || '-15','YYYY-MM-DD');
--from nasa_modis_ba.gwis_stats_ts;

DELETE FROM nasa_modis_ba.gwis_stats_ts WHERE country IS NULL;

update nasa_modis_ba.gwis_stats_ts
set iso2 = ad.iso2
from nasa_modis_ba.gwis_stats_ts st, public.admin_level_0 ad
where st.country_code=ad.id;

update nasa_modis_ba.gwis_stats_ts
set iso2 = ad.iso2
from nasa_modis_ba.gwis_stats_ts st, public.admin_level_0 ad
where st.country_code=ad.id
and st.country_code=1;

select st.country,ad.iso2,st.country_code
from nasa_modis_ba.gwis_stats_ts st,public.admin_level_0 ad
where st.country_code=ad.id
order by st.country;

select * from nasa_modis_ba.gwis_stats_ts where country_code = 1;

alter table nasa_modis_ba.gwis_stats_ts add column data_ts date;
alter table nasa_modis_ba.gwis_stats_ts add column iso2 varchar;

select (year_stats || '-' || months_stats || '-15')::date from nasa_modis_ba.gwis_stats_ts;

select to_date(year_stats || '-' || months_stats || '-15','YYYY-MM-DD') as avg_date
from nasa_modis_ba.gwis_stats_ts;
--where avg_date between '2012-01-01' and '2012-06-30';

insert into nasa_modis_ba.gwis_stats_ts(data_ts)
select to_date(year_stats || '-' || months_stats || '-15','YYYY-MM-DD')
from nasa_modis_ba.gwis_stats_ts;

insert into nasa_modis_ba.gwis_stats_ts(iso2)
select ad.iso2--,st.country,ad.id,st.country_code 
from nasa_modis_ba.gwis_stats_ts st,public.admin_level_0 ad
where st.country_code=ad.id;
--LIMIT 10;

update nasa_modis_ba.gwis_stats_ts
set data_ts = to_date(year_stats || '-' || months_stats || '-15','YYYY-MM-DD');
--from nasa_modis_ba.gwis_stats_ts;

DELETE FROM nasa_modis_ba.gwis_stats_ts WHERE country IS NULL;

update nasa_modis_ba.gwis_stats_ts
set iso2 = ad.iso2
from nasa_modis_ba.gwis_stats_ts st, public.admin_level_0 ad
where st.country_code=ad.id;

update nasa_modis_ba.gwis_stats_ts st
set iso2 = ad.iso2
from public.admin_level_0 ad
where st.country_code=ad.id;

select st.country,ad.iso2,st.country_code
from nasa_modis_ba.gwis_stats_ts st,public.admin_level_0 ad
where st.country_code=ad.id
order by st.country;

select * from nasa_modis_ba.gwis_stats_ts where country_code = 1;


alter table nasa_modis_ba.gwis_stats_ts add column data_ts date;
alter table nasa_modis_ba.gwis_stats_ts add column iso2 varchar;

select (year_stats || '-' || months_stats || '-15')::date from nasa_modis_ba.gwis_stats_ts;

select to_date(year_stats || '-' || months_stats || '-15','YYYY-MM-DD') as avg_date
from nasa_modis_ba.gwis_stats_ts;
--where avg_date between '2012-01-01' and '2012-06-30';

insert into nasa_modis_ba.gwis_stats_ts(data_ts)
select to_date(year_stats || '-' || months_stats || '-15','YYYY-MM-DD')
from nasa_modis_ba.gwis_stats_ts;

insert into nasa_modis_ba.gwis_stats_ts(iso2)
select ad.iso2--,st.country,ad.id,st.country_code 
from nasa_modis_ba.gwis_stats_ts st,public.admin_level_0 ad
where st.country_code=ad.id;
--LIMIT 10;

update nasa_modis_ba.gwis_stats_ts
set data_ts = to_date(year_stats || '-' || months_stats || '-15','YYYY-MM-DD');
--from nasa_modis_ba.gwis_stats_ts;

DELETE FROM nasa_modis_ba.gwis_stats_ts WHERE country IS NULL;

update nasa_modis_ba.gwis_stats_ts
set iso2 = ad.iso2
from nasa_modis_ba.gwis_stats_ts st, public.admin_level_0 ad
where st.country_code=ad.id;

update nasa_modis_ba.gwis_stats_ts st
set iso2 = ad.iso2
from public.admin_level_0 ad
where st.country_code=ad.id;

select st.country,ad.iso2,st.country_code
from nasa_modis_ba.gwis_stats_ts st,public.admin_level_0 ad
where st.country_code=ad.id
order by st.country;

select * from nasa_modis_ba.gwis_stats_ts where country_code = 1;

--quali anni ci sono
select country,year_stats
from nasa_modis_ba.gwis_stats 
where year_stats between 2001 and 2017
and country = 'Switzerland'
group by country,year_stats;
					
--quali anni NON ci sono
SELECT s.i as missing_year
from generate_series(2001,2017) s(i)
WHERE NOT EXISTS (select 1 from nasa_modis_ba.gwis_stats where year_stats = s.i 
				  and country = 'Switzerland');

select * from generate_series(2001,2017);
select * from array(generate_series(2001,2017));										 
										
select country,year_stats,sum(hectares_stats) 
from nasa_modis_ba.gwis_stats 
where country = 'Norway' 
group by country,year_stats
order by year_stats;				   

alter table nasa_modis_ba.gwis_stats_ts add column data_ts date;
alter table nasa_modis_ba.gwis_stats_ts add column iso2 varchar;

select (year_stats || '-' || months_stats || '-15')::date from nasa_modis_ba.gwis_stats_ts;

select to_date(year_stats || '-' || months_stats || '-15','YYYY-MM-DD') as avg_date
from nasa_modis_ba.gwis_stats_ts;
--where avg_date between '2012-01-01' and '2012-06-30';

insert into nasa_modis_ba.gwis_stats_ts(data_ts)
select to_date(year_stats || '-' || months_stats || '-15','YYYY-MM-DD')
from nasa_modis_ba.gwis_stats_ts;

insert into nasa_modis_ba.gwis_stats_ts(iso2)
select ad.iso2--,st.country,ad.id,st.country_code 
from nasa_modis_ba.gwis_stats_ts st,public.admin_level_0 ad
where st.country_code=ad.id;
--LIMIT 10;

update nasa_modis_ba.gwis_stats_ts
set data_ts = to_date(year_stats || '-' || months_stats || '-15','YYYY-MM-DD');
--from nasa_modis_ba.gwis_stats_ts;

DELETE FROM nasa_modis_ba.gwis_stats_ts WHERE country IS NULL;

update nasa_modis_ba.gwis_stats_ts
set iso2 = ad.iso2
from nasa_modis_ba.gwis_stats_ts st, public.admin_level_0 ad
where st.country_code=ad.id;

update nasa_modis_ba.gwis_stats_ts st
set iso2 = ad.iso2
from public.admin_level_0 ad
where st.country_code=ad.id;

select st.country,ad.iso2,st.country_code
from nasa_modis_ba.gwis_stats_ts st,public.admin_level_0 ad
where st.country_code=ad.id
order by st.country;

select * from nasa_modis_ba.gwis_stats_ts where country_code = 1;

--quali anni ci sono
select country,year_stats
from nasa_modis_ba.gwis_stats 
where year_stats between 2001 and 2017
and country = 'Switzerland'
group by country,year_stats;
					
--quali anni NON ci sono
SELECT s.i as missing_year
from generate_series(2001,2017) s(i)
WHERE NOT EXISTS (select 1 from nasa_modis_ba.gwis_stats where year_stats = s.i 
				  and country = 'Switzerland');

--quali anni NON ci sono con paese
with all_countries as (
	select distinct(country) as paese from nasa_modis_ba.gwis_stats)
SELECT paese,
       s.i as missing_year
from generate_series(2001,2017) s(i),all_countries
WHERE NOT EXISTS (select 1 from nasa_modis_ba.gwis_stats 
				  where year_stats = s.i
				  and country = paese)
				  order by paese, s;

select * from generate_series(2001,2017);
select * from array(generate_series(2001,2017));										 
										
select country,year_stats,sum(hectares_stats) 
from nasa_modis_ba.gwis_stats 
where country = 'Norway' 
group by country,year_stats
order by year_stats;