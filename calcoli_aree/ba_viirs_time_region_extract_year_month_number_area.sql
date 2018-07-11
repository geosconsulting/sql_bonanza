drop function nasa_modis_ba.stats_modis_ba_view(integer,integer,text);

create or replace function nasa_modis_ba.stats_modis_ba_view(in anno_start integer,in anno_end integer, in region text) 
RETURNS TABLE(country varchar, year_stat integer, month_stat integer, number_of_fires bigint,area_ha numeric)
as $$   
declare 
   start_date text := (anno_start::text || '-01-01');
   end_date text := (anno_end::text || '-12-31');
   query text := 'select distinct(adm.name_en) paese,
		       extract(year from initialdate)::INTEGER as anno, 
		       extract(month from initialdate)::INTEGER as mese,
		       count(ba.id) numero_incendi,
		       round(sum(ST_Area(ba.geom::geography)*0.0001)::numeric,2) ettari
		   from nasa_modis_ba.final_ba as ba
		     join public.admin_level_0 as adm on st_contains(adm.geom,ba.geom)
		   where ba.initialdate between ''' || start_date::date || ''' and ''' || end_date || '''
		   and adm.name_en in (select country_name from region_aggregate(''' || region || '''))
		   group by (adm.name_en,anno,mese)
		   order by adm.name_en,anno,mese;';
begin               
    --raise notice '%',query;                                       
    RETURN QUERY          
      execute query;
end
$$
language 'plpgsql';

create materialized view nasa_modis_ba.ee_2012_2017 as select * from nasa_modis_ba.stats_modis_ba_view(2012,2017,'Eastern Europe');

EXPLAIN select * from nasa_modis_ba.stats_modis_ba_view(2000,2017,'Northern Europe');

select * from nasa_modis_ba.stats_modis_ba_view(2010,2017,'Northern Europe');