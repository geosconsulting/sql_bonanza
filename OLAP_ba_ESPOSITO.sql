drop materialized view effis.archived_burnt_areas_detailed;

create materialized view effis.archived_burnt_areas_detailed as
select hba.id_source id_left,
       hba.year_id year_id_left,
       hba.ba_id ba_id_left,
       hba.firedate firedate_left,
       hba.lastupdate lastupdate_left,
       hbae.* 
from effis.archived_burnt_area hba
left join rdaprd.from2000_burntareas hbae on (hbae.yearid = hba.year_id);

drop materialized view effis.ba_bt_country_year;

create materialized view effis.ba_by_country_year as 
select countryfullname as "Country",
       extract(year from firedate::date) as "Year",       
       COUNT(yearid) as "Number of Fires",
       SUM(area_ha) as "Sum Ha Burnt Area"
from effis.archived_burnt_areas_detailed          
group by grouping sets (("Country", "Year"), "Country");

drop materialized view effis.ba_by_country_year_month;

create materialized view effis.ba_by_country_year_month as 
select countryfullname as "Country",
       extract(year from firedate::date) as "Year",
       extract(Month from firedate::date) as "Month",
       COUNT(yearid) as "Number of Fires",
       SUM(area_ha) as "Sum Ha Burnt Area"
from effis.archived_burnt_areas_detailed          
group by grouping sets (("Country", "Year","Month"), "Country");

drop materialized view effis.ba_bt_country_year_month_total;

create materialized view effis.ba_by_country_year_month_total as 
select countryfullname as "Country",       
       extract(year from firedate::date) as "Year",
       extract(Month from firedate::date) as "Month",
       SUM(area_ha) as area_ettari
from effis.archived_burnt_areas_detailed
group by cube(("Year","Month"),"Country");

create materialized view effis.ba_by_country_year_month_total as 
select countryfullname as "Country",       
       extract(year from firedate::date) as "Year",
       extract(Month from firedate::date) as "Month",
       SUM(area_ha) as area_ettari
from effis.archived_burnt_areas_detailed
group by rollup(("Year","Month"),"Country");
	
create materialized view effis.ba_by_country_year_month_total_by_month as 
select countryfullname as "Country",       
       --extract(year from firedate::date) as "Year",
       to_char(to_timestamp(extract(Month from firedate::date)::text,'MM'),'Month') AS "Month",
       SUM(area_ha) as area_ettari
from effis.archived_burnt_areas_detailed
group by rollup(("Month"),"Country");

create materialized view effis.ba_by_month_country as 
select countryfullname as "Country",       
       --extract(year from firedate::date) as "Year",
       to_char(to_timestamp(extract(Month from firedate::date)::text,'MM'),'Month') AS "Month",
       SUM(area_ha) as area_hectares
from effis.archived_burnt_areas_detailed
group by ("Month","Country")
ORDER BY "Month";

create materialized view effis.ba_by_monthNumeric_country as 
select countryfullname as "Country",       
       --extract(year from firedate::date) as "Year",
       extract(Month from firedate::date) AS "Month",
       SUM(area_ha) as area_hectares
from effis.archived_burnt_areas_detailed
group by ("Month","Country")
ORDER BY "Month";

SELECT * FROM effis.ba_by_monthNumeric_country WHERE "Country" = 'Spain';

SELECT * FROM effis.ba_by_monthNumeric_country WHERE "Country" in ('Italy','Spain','Portugal','Greece');

SELECT "Country","Month", sum(area_hectares) over (partition by "Country") 
FROM effis.ba_by_monthNumeric_country WHERE "Country" in ('Italy','Spain','Portugal','Greece');

SELECT "Month", area_hectares, row_number () over (partition by area_hectares order by "Month") 
FROM effis.ba_by_monthNumeric_country WHERE "Country" = 'Italy';

SELECT "Month", area_hectares, rank () over (partition by area_hectares) 
FROM effis.ba_by_monthNumeric_country WHERE "Country" = 'Italy';

SELECT "Month", area_hectares, dense_rank () over (partition by area_hectares) 
FROM effis.ba_by_monthNumeric_country WHERE "Country" = 'Italy';

SELECT "Month", area_hectares, percent_rank () over (partition by area_hectares) 
FROM effis.ba_by_monthNumeric_country WHERE "Country" = 'Italy';

SELECT "Month", area_hectares, ntile(5) over (partition by area_hectares) 
FROM effis.ba_by_monthNumeric_country WHERE "Country" = 'Italy';

select countryfullname as "Country",       
       extract(year from firedate::date) as "Year",
       extract(Month from firedate::date) AS "Month",
       --sum(area_ha) as somma_area,
       rank() over (partition by area_ha)
from effis.archived_burnt_areas_detailed;
--group by ("Month","Country")
--ORDER BY "Month";

select countryfullname as "Country",       
       --extract(year from firedate::date) as "Year",
       extract(Month from firedate::date) AS "Month",
       SUM(area_ha) as area_hectares
from effis.archived_burnt_areas_detailed
group by ("Month","Country")
ORDER BY "Month";

create materialized view effis.ba_country_totals as 
SELECT "Country","Number of Fires","Sum Ha Burnt Area" 
from effis.ba_by_country_year 
where "Year" is null;