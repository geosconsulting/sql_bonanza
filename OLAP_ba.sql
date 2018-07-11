CREATE extension tablefunc;

select * from effis.burnt_area;

select ba_id,sum(area_ha) from effis.burnt_area GROUP By ba_id;

select * from effis.burnt_area 
     natural join effis.burnt_area_location
     natural join effis.burnt_area_landcover;

select * from effis.burnt_area 
     natural join effis.burnt_area_location;

select country,sum(area_ha) from effis.burnt_area 
     natural join effis.burnt_area_location 
     group by country;

select lo.country,extract(year from s.firedate::date) as "Anno",extract(Month from s.firedate::date) as "Mese",sum(area_ha) 
from effis.burnt_area s
     natural join effis.burnt_area_location lo
     natural join effis.burnt_area_landcover la
group by grouping sets ((lo.country,extract(year from s.firedate::date),extract(month from s.firedate::date)),lo.country);

select lo.country as paese,       
       extract(year from s.firedate::date) as "Anno",
       extract(Month from s.firedate::date) as "Mese",
       sum(area_ha) as area_ettari
from effis.burnt_area s
     natural join effis.burnt_area_location lo
     natural join effis.burnt_area_landcover la
group by grouping sets ((paese,"Anno","Mese"),paese);

select lo.country as paese,       
       extract(year from s.firedate::date) as "Anno",
       extract(Month from s.firedate::date) as "Mese",
       sum(area_ha) as area_ettari
from effis.burnt_area s
     natural join effis.burnt_area_location lo
     natural join effis.burnt_area_landcover la
group by cube(("Anno","Mese"),paese);

select lo.country as paese,       
       extract(year from s.firedate::date) as "Anno",
       extract(Month from s.firedate::date) as "Mese",
       sum(area_ha) as area_ettari
from effis.burnt_area s
     natural join effis.burnt_area_location lo
     natural join effis.burnt_area_landcover la
group by rollup(("Anno","Mese"),paese);

select lo.country as paese,       
       --extract(year from s.firedate::date) as "Anno",
       extract(Month from s.firedate::date) as "Mese",
       sum(area_ha) as area_ettari
from effis.burnt_area s
     natural join effis.burnt_area_location lo
     natural join effis.burnt_area_landcover la
group by rollup("Mese",paese); --"Anno",
