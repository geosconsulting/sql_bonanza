SELECT * FROM nasa_modis_ba.gwis_stats 
EXCEPT
SELECT * FROM nasa_modis_ba.gwis_stats_last 

SELECT * FROM nasa_modis_ba.gwis_stats where year_stats=2007 and number_of_fires=0 and hectares_stats=0;

SELECT * FROM nasa_modis_ba.gwis_stats where year_stats=2007 and country='Afghanistan';

alter table nasa_modis_ba.gwis_stats_2007 ADD COLUMN country_code integer;

SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Afghanistan';
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Afghanistan';
select * from nasa_modis_ba.gwis_stats where year_stats=2007 and country='Afghanistan'; 

select country,country_code from nasa_modis_ba.gwis_stats_last
except
select country,country_code from nasa_modis_ba.gwis_stats
--UPDATE b
--SET column1 = a.column1,
--  column2 = a.column2,
--  column3 = a.column3
--FROM a
--WHERE a.id = b.id
--AND b.id = 1

update nasa_modis_ba.gwis_stats_2007 gs7
set country_code= gs.country_code
from nasa_modis_ba.gwis_stats gs
where gs7.country=gs.country;

select id from public.admin_level_0 where name_en = 'Armenia';
select id from public.admin_level_0 where name_en = 'Angola';
select id from public.admin_level_0 where name_en = 'Cuba';
select id from public.admin_level_0 where name_en = 'Albania';

--blocco comandi
--Afghanistan
delete from nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Afghanistan';
insert into nasa_modis_ba.gwis_stats_last(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code)
SELECT country,year_stats,months_stats,number_of_fires,hectares_stats,country_code FROM nasa_modis_ba.gwis_stats_2007 WHERE country = 'Afghanistan';
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Afghanistan'; 

--Albania
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Albania'; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Albania';
delete from nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Albania';
insert into nasa_modis_ba.gwis_stats_last(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code)
SELECT country,year_stats,months_stats,number_of_fires,hectares_stats,country_code FROM nasa_modis_ba.gwis_stats_2007 WHERE country = 'Albania';
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Albania'; 

create or replace function nasa_modis_ba.aggiungi_2007(paese varchar)
returns void as $$
declare 
 qry_del varchar := 'delete from nasa_modis_ba.gwis_stats_last where year_stats=2007 and country=''' || paese || ''';';
 qry_ins varchar := 'insert into nasa_modis_ba.gwis_stats_last(country,year_stats,months_stats,number_of_fires,hectares_stats,country_code)
              SELECT country,year_stats,months_stats,number_of_fires,hectares_stats,country_code FROM nasa_modis_ba.gwis_stats_2007 
			  WHERE country = ''' || paese || ''';';
begin
  raise notice '%',qry_del;
  raise notice '%',qry_ins;
  BEGIN
        execute qry_del;
		execute qry_ins;
  END;  
end;
$$ language 'plpgsql';

--Algeria
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Algeria'; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Algeria';
select * from nasa_modis_ba.aggiungi_2007('Algeria');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Algeria'; 

--Angola
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Angola' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Angola' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Angola');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Angola' order by months_stats; 

--Argentina
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Argentina' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Argentina' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Argentina');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Argentina' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2008 and country='Argentina' order by months_stats; 

--Armenia
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Armenia' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Armenia' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Armenia');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Armenia' order by months_stats; 

--Austria
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Austria' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Austria' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Austria');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Austria' order by months_stats; 

--Azerbaijan
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Azerbaijan' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Azerbaijan' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Azerbaijan');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Azerbaijan' order by months_stats; 

--Bangladesh
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Bangladesh' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Bangladesh' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Bangladesh');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Bangladesh' order by months_stats; 

--Belarus
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Belarus' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Belarus' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Belarus');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Belarus' order by months_stats; 

--Belgium
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Belgium' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Belgium' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Belgium');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Belgium' order by months_stats; 

--Belize
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Belize' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Belize' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Belize');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Belize' order by months_stats; 

--Benin
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Benin' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Benin' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Benin');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Benin' order by months_stats; 

--Bhutan
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Bhutan' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Bhutan' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Bhutan');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Bhutan' order by months_stats; 

--Bolivia
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Bolivia' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Bolivia' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Bolivia');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Bolivia' order by months_stats; 

--Bosnia and Herzegovina
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Bosnia and Herzegovina' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Bosnia and Herzegovina' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Bosnia and Herzegovina');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Bosnia and Herzegovina' order by months_stats; 

--Botswana
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Botswana' order by months_stats; 
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Botswana' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Botswana');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Botswana' order by months_stats; 

--Brazil
SELECT * FROM nasa_modis_ba.gwis_stats_2007 where country='Brazil' order by months_stats;
select * from nasa_modis_ba.aggiungi_2007('Brazil');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Brazil' order by months_stats; 

--Brunei
select * from nasa_modis_ba.aggiungi_2007('Brunei');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Brunei' order by months_stats; 

--Bulgaria
select * from nasa_modis_ba.aggiungi_2007('Bulgaria');
SELECT * FROM nasa_modis_ba.gwis_stats_last where year_stats=2007 and country='Bulgaria' order by months_stats; 