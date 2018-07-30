create table nasa_modis_ba.jiup as 
select * from nasa_modis_ba.indonesia
union
select * from nasa_modis_ba.japan
union
select * from nasa_modis_ba.philippines
union
select * from nasa_modis_ba.unitedkingdom;

select * from nasa_modis_ba.generate_stats_all_years('Malta');
select nasa_modis_ba.move_table_to_another_schema('malta','tmp');

select * from nasa_modis_ba.generate_stats_all_years('Gambia');
select nasa_modis_ba.move_table_to_another_schema('gambia','tmp');

select * from nasa_modis_ba.generate_stats_all_years('Malaysia');
select nasa_modis_ba.move_table_to_another_schema('malaysia','tmp');

select * from nasa_modis_ba.generate_stats_all_years('Western Sahara');
select nasa_modis_ba.move_table_to_another_schema('westernsahara','tmp');


