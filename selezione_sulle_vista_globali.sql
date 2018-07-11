select * from nasa_modis_ba.centralamerica where year_stats = 2001 and country = 'Belize';

select * from nasa_modis_ba.centralamerica where year_stats between 2001 and 2014 and country = 'Belize' order by year_stats;

select * from nasa_modis_ba.centralamerica where year_stats = 2012 and country in ('Belize','Honduras','El Salvador') order by year_stats;

select * from nasa_modis_ba.centralamerica where year_stats between 2001 and 2014 and country in ('Honduras','Belize') order by year_stats,country;

select * from nasa_modis_ba.centralamerica where year_stats = 2001 and months_stats=3;

select * from nasa_modis_ba.gwis_stats g
     left join public.admin_level_0 a on g.country_code = a.id
where year_stats = 2001 
and months_stats=3;
