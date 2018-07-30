select * from nasa_modis_ba.missing_years ou
where (select count(*) from nasa_modis_ba.missing_years inr
where inr.country = ou.country
and inr.year_stats = ou.year_stats
and inr.months_stats = ou.months_stats) > 1;

select * from nasa_modis_ba.missing_years 
where country = 'Costa Rica'
and year_stats = 2007
and months_stats = 12;

delete from nasa_modis_ba.missing_years 
where country = 'Costa Rica'
and year_stats = 2007
and months_stats = 12;

insert into nasa_modis_ba.missing_years(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code) values('Costa Rica',2007,12,0,0,56);