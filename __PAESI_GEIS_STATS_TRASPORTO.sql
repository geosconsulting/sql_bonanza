select * from nasa_modis_ba.gwis_stats where country = 'Australia' order by year_stats,months_stats;

select * from nasa_modis_ba.gwis_stats where country = 'Australia' and year_stats = 2005 order by year_stats;

select * from nasa_modis_ba.gwis_stats where country = 'Australia' and year_stats = 2007 order by year_stats;

select * from nasa_modis_ba.gwis_stats where country = 'Australia' and year_stats = 2007 order by year_stats;

select * from nasa_modis_ba.gwis_stats where country = 'New Zealand' and year_stats = 2007 order by year_stats,months_stats;

select * from nasa_modis_ba.gwis_stats_lost where country = 'New Zealand' order by year_stats,months_stats;

CREATE MATERIALIZED VIEW nasa_modis_ba.australianewzealand_tmp as
select * from tmp.australianewzealand_20050101_20051231
union
select * from tmp.australianewzealand_20070101_20071231

create table nasa_modis_ba.gwis_stats_lost as
select * from nasa_modis_ba.australianewzealand_tmp

alter table nasa_modis_ba.gwis_stats_lost add column country_code integer;

select * from nasa_modis_ba.gwis_stats where country in ('Australia','New Zealand') order by year_stats;

update nasa_modis_ba.gwis_stats_lost set country_code = 15 where country = 'Australia';

update nasa_modis_ba.gwis_stats_lost set country_code = 160 where country = 'New Zealand';

--delete from nasa_modis_ba.gwis_stats_lost where year_stats = 2005 and country = 'Australia';
--delete from nasa_modis_ba.gwis_stats where year_stats = 2007 and country = 'New Zealand';

insert into nasa_modis_ba.gwis_stats(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
			      select country,year_stats,months_stats,number_of_fires,hectares_stats,country_code from nasa_modis_ba.gwis_stats_missing_years;
  
insert into nasa_modis_ba.gwis_stats(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) 
			      select country,year_stats,months_stats,number_of_fires,hectares_stats,country_code from nasa_modis_ba.gwis_stats_lost;

create table nasa_modis_ba.gwis_stats_trasporto as select * from nasa_modis_ba.gwis_stats;

select * from nasa_modis_ba.gwis_stats where year_stats = 2007;

select * from nasa_modis_ba.centralamerica where year_stats = 2007;

select * from nasa_modis_ba.gwis_stats where year_stats = 2007;