select (sum(ST_area(b.geom::geography))*0.0001)::integer
from nasa_modis_ba.final_ba b ,public.admin_level_1 a
where initialdate between '2012-01-01'::date and '2012-12-31'::date
and a.name_local='Sicily'
and ST_Intersects(b.geom,a.geom);

select (sum(ST_area(b.geom::geography))*0.0001)::integer
from effis.archived_burnt_area b ,public.admin_level_1 a
where firedate::date between '2012-01-01'::date and '2012-12-31'::date
and a.name_local='Sicily'
and ST_Intersects(b.geom,a.geom);

select sum(area_ha)
from effis.archived_burnt_area b ,public.admin_level_1 a
where firedate::date between '2012-01-01'::date and '2012-12-31'::date
and a.name_local='Sicily'
and ST_Intersects(b.geom,a.geom);

select count(b.id)
from nasa_modis_ba.final_ba b ,public.admin_level_1 a
where initialdate between '2012-01-01'::date and '2012-12-31'::date
and a.name_local='Sicily'
and ST_Intersects(b.geom,a.geom);

select count(b.ba_id)
from effis.archived_burnt_area b ,public.admin_level_1 a
where firedate::date between '2012-01-01'::date and '2012-12-31'::date
and a.name_local='Sicily'
and ST_Intersects(b.geom,a.geom);

select count(b.id),(sum(ST_area(b.geom::geography))*0.0001)::integer
from nasa_modis_ba.final_ba b ,public.admin_level_0 a
where initialdate between '2016-01-01'::date and '2016-12-31'::date
and a.name_local='Italia'
and ST_Intersects(b.geom,a.geom);

select count(b.ba_id),(sum(ST_area(b.geom::geography))*0.0001)::integer
from effis.archived_burnt_area b ,public.admin_level_0 a
where firedate::date between '2016-01-01'::date and '2016-12-31'::date
and a.name_en='Italy'
and ST_Intersects(b.geom,a.geom);

select count(b.ba_id),(sum(ST_area(b.geom::geography))*0.0001)::integer
from effis.archived_burnt_area b ,public.admin_level_0 a
where firedate::date between '2016-01-01'::date and '2016-12-31'::date
and a.name_en ='Portugal'
and ST_Intersects(b.geom,a.geom);

select count(b.ba_id),(sum(ST_area(b.geom::geography))*0.0001)::integer
from effis.archived_burnt_area b ,public.admin_level_0 a
where firedate::date between '2016-01-01'::date and '2016-12-31'::date
and a.name_en = 'Spain'
and ST_Intersects(b.geom,a.geom);

select count(b.ba_id),(sum(ST_area(b.geom::geography))*0.0001)::integer
from effis.archived_burnt_area b ,public.admin_level_0 a
where firedate::date between '2016-01-01'::date and '2016-12-31'::date
and a.name_en = 'Ireland'
and ST_Intersects(b.geom,a.geom);

select count(b.ba_id),(sum(ST_area(b.geom::geography))*0.0001)::integer
from effis.archived_burnt_area b ,public.admin_level_0 a
where firedate::date between '2016-01-01'::date and '2016-12-31'::date
and a.name_en = 'Greece'
and ST_Intersects(b.geom,a.geom);

select count(b.ba_id),(sum(ST_area(b.geom::geography))*0.0001)::integer
from effis.archived_burnt_area b ,public.admin_level_0 a
where firedate::date between '2016-01-01'::date and '2016-12-31'::date
and a.name_en = 'Croatia'
and ST_Intersects(b.geom,a.geom);

select count(b.ba_id),(sum(ST_area(b.geom::geography))*0.0001)::integer
from effis.archived_burnt_area b ,public.admin_level_0 a
where firedate::date between '2016-01-01'::date and '2016-12-31'::date
and a.name_en = 'Belgium'
and ST_Intersects(b.geom,a.geom);

select count(b.ba_id),(sum(ST_area(b.geom::geography))*0.0001)::integer
from effis.archived_burnt_area b ,public.admin_level_0 a
where firedate::date between '2016-01-01'::date and '2016-12-31'::date
and a.name_en = 'Algeria'
and ST_Intersects(b.geom,a.geom);

select count(b.ba_id),(sum(ST_area(b.geom::geography))*0.0001)::integer
from effis.archived_burnt_area b ,public.admin_level_0 a
where firedate::date between '2016-01-01'::date and '2016-12-31'::date
and a.name_en = 'Tunisia'
and ST_Intersects(b.geom,a.geom);
 
select a.name_en,
       firedate,
       count(b.ba_id) over w,
       --extract(year from firedate::date) as year_date,
       sum((ST_area(b.geom::geography))*0.0001) over w as "Hectares"
from effis.archived_burnt_area b ,public.effis_countries a
where firedate::date between '2016-01-01'::date and '2016-12-31'::date
--and a.name_en = 'Tunisia'
and ST_Intersects(b.geom,a.geom)
window w as(partition by a.name_en);

drop materialized view effis.ba_stats_2016;

select a.name_en, 
       extract(year from firedate::date) as year_date,
       extract(Month from firedate::date) as month_date,
       extract(week from firedate::date) as week_date,
       sum((ST_area(b.geom::geography))*0.0001),
       count(b.ba_id)
from effis.archived_burnt_area b ,public.effis_countries a
where firedate::date between '2016-01-01'::date and '2016-12-31'::date
and ST_Intersects(b.geom,a.geom)
group by rollup((year_date,month_date,week_date),a.name_en);
--group by rollup(year_date,a.name_en);

create materialized view effis.ba_stats_2016 as
select a.name_en, 
       extract(year from firedate::date) as year_date,
       extract(Month from firedate::date) as month_date,
       sum((ST_area(b.geom::geography))*0.0001),
       count(b.ba_id)
from effis.archived_burnt_area b ,public.effis_countries a
where firedate::date between '2016-01-01'::date and '2016-12-31'::date
and ST_Intersects(b.geom,a.geom)
group by cube((year_date,month_date),a.name_en);

drop materialized view effis.ba_stats_2017;

create materialized view effis.ba_stats_2017 as
select a.name_en, 
       extract(year from firedate::date) as year_date,
       extract(Month from firedate::date) as month_date,
       sum((ST_area(b.geom::geography))*0.0001),
       count(b.ba_id)
from effis.archived_burnt_area b ,public.effis_countries a
where firedate::date between '2017-01-01'::date and '2017-12-31'::date
and ST_Intersects(b.geom,a.geom)
group by cube((year_date,month_date),a.name_en);

create view effis.ba_stats_2018 as
select a.name_en, 
       extract(year from firedate::date) as year_date,
       extract(Month from firedate::date) as month_date,
       sum((ST_area(b.geom::geography))*0.0001),
       count(b.ba_id)
from effis.current_burnt_area b ,public.effis_countries a
--where firedate::date between '2017-01-01'::date and '2017-12-31'::date
where ST_Intersects(b.geom,a.geom)
group by cube((year_date,month_date),a.name_en);

