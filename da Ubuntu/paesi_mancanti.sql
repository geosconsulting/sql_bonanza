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


SELECT s.i as missing_year
from generate_series(2001,2017) s(i)
WHERE NOT EXISTS (select 1 from nasa_modis_ba.gwis_stats where year_stats = s.i 
				  and country = 'Côte d''Ivoire');

SELECT s.i as missing_year
from generate_series(2001,2017) s(i)
WHERE NOT EXISTS (select 1 from nasa_modis_ba.gwis_stats where year_stats = s.i 
				  and country = 'Norway');

--quali anni NON ci sono con paese
with all_countries as (
	select 
	distinct(country) as paese,
	country_code
	from nasa_modis_ba.gwis_stats)
SELECT paese,
       country_code,
	   s.i as missing_year
from generate_series(2001,2017) s(i),all_countries
WHERE NOT EXISTS (select 1 from nasa_modis_ba.gwis_stats 
				  where year_stats = s.i
				  and country = paese)
				  order by paese, s;
				  
with all_countries as (
	select 
	distinct(country) as paese,
	country_code
	from nasa_modis_ba.gwis_stats)
SELECT paese,
       country_code,
	   s.i as missing_year
from generate_series(2000,2000) s(i),all_countries
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
									
create table nasa_modis_ba.missing_years as select * from nasa_modis_ba.gwis_stats where 1 = 2;
									
SELECT s.i as missing_year
from generate_series(2001,2017) s(i)
WHERE NOT EXISTS (select 1 from nasa_modis_ba.gwis_stats where year_stats = s.i 
				  and country = 'Côte d''Ivoire');
									
select * from nasa_modis_ba.gwis_stats where country = 'Côte d''Ivoire' order by year_stats;

select * from nasa_modis_ba.genera_un_anno_vuoto(2000,'Côte d''Ivoire',57);	
									
insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2000,1,0,0,57)									
								
insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2000,2,0,0,57)
									
insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2000,3,0,0,57)

--******************************************************************************************************************************									
insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2007,1,0,0,57);									
								
insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2007,2,0,0,57);
									
insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2007,3,0,0,57);									

insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2007,4,0,0,57);

insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2007,5,0,0,57);

insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2007,6,0,0,57);	

insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2007,7,0,0,57);								

insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2007,8,0,0,57);

insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2007,9,0,0,57);

insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2007,10,0,0,57);	

insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2007,11,0,0,57);

insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									values('Côte d''Ivoire',2007,12,0,0,57);								

select * from nasa_modis_ba.missing_years where country = 'Côte d''Ivoire'; 
select * from nasa_modis_ba.missing_years where country = 'Albania';
select * from nasa_modis_ba.missing_years where country = 'Belarus'; 	

select * from nasa_modis_ba.gwis_stats where year_stats = 2007;		
select * from nasa_modis_ba.gwis_stats where year_stats is null;		

create table nasa_modis_ba.gwis_stats_missing_years as
select * from nasa_modis_ba.gwis_stats;

insert into nasa_modis_ba.gwis_stats_missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									select country,year_stats,months_stats,number_of_fires,hectares_stats,country_code from nasa_modis_ba.gwis_stats;									
									
insert into nasa_modis_ba.gwis_stats_missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									select country,year_stats,months_stats,number_of_fires,hectares_stats,country_code from nasa_modis_ba.missing_years;
									
-- delete from nasa_modis_ba.missing_years where country = 'Côte d''Ivoire'; 								

truncate nasa_modis_ba.gwis_stats_missing_years cascade;
									
select count(*) from nasa_modis_ba.gwis_stats_missing_years;
									
select count(*) from nasa_modis_ba.gwis_stats;
select count(*) from nasa_modis_ba.missing_years;	

insert into nasa_modis_ba.gwis_stats_missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									select country,year_stats,months_stats,number_of_fires,hectares_stats,country_code from nasa_modis_ba.gwis_stats;									
									
insert into nasa_modis_ba.gwis_stats_missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									select country,year_stats,months_stats,number_of_fires,hectares_stats,country_code from nasa_modis_ba.missing_years;
									
select * from nasa_modis_ba.gwis_stats_missing_years where year_stats is null;	

select country,count(distinct(year_stats))
from nasa_modis_ba.gwis_stats_missing_years 
where year_stats between 2001 and 2017
group by (country)
order by country;

select country,count(distinct(year_stats)) as num_anni
from nasa_modis_ba.gwis_stats 
where year_stats between 2001 and 2017
group by (country)
having count(distinct(year_stats)) = 17
order by country;

insert into nasa_modis_ba.gwis_stats_test(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
									select country,year_stats,months_stats,number_of_fires,hectares_stats,country_code from nasa_modis_ba.gwis_stats_missing_years;					  
									