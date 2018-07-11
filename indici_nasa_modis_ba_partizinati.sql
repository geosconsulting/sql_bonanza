create index if not exists finalba_2000_initialdate_idx on nasa_modis_ba.final_ba_2000(initialdate);
create index if not exists finalba_2001_initialdate_idx on nasa_modis_ba.final_ba_2001(initialdate);
create index if not exists finalba_2002_initialdate_idx on nasa_modis_ba.final_ba_2002(initialdate);
create index if not exists finalba_2003_initialdate_idx on nasa_modis_ba.final_ba_2003(initialdate);
create index if not exists finalba_2004_initialdate_idx on nasa_modis_ba.final_ba_2004(initialdate);
create index if not exists finalba_2005_initialdate_idx on nasa_modis_ba.final_ba_2050(initialdate);
create index if not exists finalba_2006_initialdate_idx on nasa_modis_ba.final_ba_2006(initialdate);
create index if not exists finalba_2007_initialdate_idx on nasa_modis_ba.final_ba_2007(initialdate);
create index if not exists finalba_2008_initialdate_idx on nasa_modis_ba.final_ba_2008(initialdate);
create index if not exists finalba_2009_initialdate_idx on nasa_modis_ba.final_ba_2009(initialdate);
create index if not exists finalba_2010_initialdate_idx on nasa_modis_ba.final_ba_2010(initialdate);
create index if not exists finalba_2011_initialdate_idx on nasa_modis_ba.final_ba_2011(initialdate);
create index if not exists finalba_2012_initialdate_idx on nasa_modis_ba.final_ba_2012(initialdate);
create index if not exists finalba_2013_initialdate_idx on nasa_modis_ba.final_ba_2013(initialdate);
create index if not exists finalba_2014_initialdate_idx on nasa_modis_ba.final_ba_2014(initialdate);
create index if not exists finalba_2015_initialdate_idx on nasa_modis_ba.final_ba_2015(initialdate);
create index if not exists finalba_2016_initialdate_idx on nasa_modis_ba.final_ba_2016(initialdate);
create index if not exists finalba_2017_initialdate_idx on nasa_modis_ba.final_ba_2017(initialdate);

create index if not exists finalba_2000_finaldate_idx on nasa_modis_ba.final_ba_2000(finaldate);
create index if not exists finalba_2001_finaldate_idx on nasa_modis_ba.final_ba_2001(finaldate);
create index if not exists finalba_2002_finaldate_idx on nasa_modis_ba.final_ba_2002(finaldate);
create index if not exists finalba_2003_finaldate_idx on nasa_modis_ba.final_ba_2003(finaldate);
create index if not exists finalba_2004_finaldate_idx on nasa_modis_ba.final_ba_2004(finaldate);
create index if not exists finalba_2005_finaldate_idx on nasa_modis_ba.final_ba_2005(finaldate);
create index if not exists finalba_2006_finaldate_idx on nasa_modis_ba.final_ba_2006(finaldate);
create index if not exists finalba_2007_finaldate_idx on nasa_modis_ba.final_ba_2007(finaldate);
create index if not exists finalba_2008_finaldate_idx on nasa_modis_ba.final_ba_2008(finaldate);
create index if not exists finalba_2009_finaldate_idx on nasa_modis_ba.final_ba_2009(finaldate);
create index if not exists finalba_2010_finaldate_idx on nasa_modis_ba.final_ba_2010(finaldate);
create index if not exists finalba_2011_finaldate_idx on nasa_modis_ba.final_ba_2011(finaldate);
create index if not exists finalba_2012_finaldate_idx on nasa_modis_ba.final_ba_2012(finaldate);
create index if not exists finalba_2013_finaldate_idx on nasa_modis_ba.final_ba_2013(finaldate);
create index if not exists finalba_2014_finaldate_idx on nasa_modis_ba.final_ba_2014(finaldate);
create index if not exists finalba_2015_finaldate_idx on nasa_modis_ba.final_ba_2015(finaldate);
create index if not exists finalba_2016_finaldate_idx on nasa_modis_ba.final_ba_2016(finaldate);
create index if not exists finalba_2017_finaldate_idx on nasa_modis_ba.final_ba_2017(finaldate);

create index if not exists finalba_2000_geom_sidx on nasa_modis_ba.final_ba_2000 using gist(geom);
create index if not exists finalba_2001_geom_sidx on nasa_modis_ba.final_ba_2001 using gist(geom);
create index if not exists finalba_2002_geom_sidx on nasa_modis_ba.final_ba_2002 using gist(geom);
create index if not exists finalba_2003_geom_sidx on nasa_modis_ba.final_ba_2003 using gist(geom);
create index if not exists finalba_2004_geom_sidx on nasa_modis_ba.final_ba_2004 using gist(geom);
create index if not exists finalba_2005_geom_sidx on nasa_modis_ba.final_ba_2050 using gist(geom);
create index if not exists finalba_2006_geom_sidx on nasa_modis_ba.final_ba_2006 using gist(geom);
create index if not exists finalba_2007_geom_sidx on nasa_modis_ba.final_ba_2007 using gist(geom);
create index if not exists finalba_2008_geom_sidx on nasa_modis_ba.final_ba_2008 using gist(geom);
create index if not exists finalba_2009_geom_sidx on nasa_modis_ba.final_ba_2009 using gist(geom);
create index if not exists finalba_2010_geom_sidx on nasa_modis_ba.final_ba_2010 using gist(geom);
create index if not exists finalba_2011_geom_sidx on nasa_modis_ba.final_ba_2011 using gist(geom);
create index if not exists finalba_2012_geom_sidx on nasa_modis_ba.final_ba_2012 using gist(geom);
create index if not exists finalba_2013_geom_sidx on nasa_modis_ba.final_ba_2013 using gist(geom);
create index if not exists finalba_2014_geom_sidx on nasa_modis_ba.final_ba_2014 using gist(geom);
create index if not exists finalba_2015_geom_sidx on nasa_modis_ba.final_ba_2015 using gist(geom);
create index if not exists finalba_2016_geom_sidx on nasa_modis_ba.final_ba_2016 using gist(geom);
create index if not exists finalba_2017_geom_sidx on nasa_modis_ba.final_ba_2017 using gist(geom);

select count(b.id) 
from nasa_modis_ba.final_ba b, public.admin_level_0 a 
where b.initialdate between '2011-12-15'::date and '2015-06-30'::date
AND a.name_local='Italia' 
AND ST_Intersects(a.geom,b.geom) 
group by a.name_en;

select name_local,name_en from public.admin_level_1 where name_local='Lazio';

select count(b.id) 
from nasa_modis_ba.final_ba b, public.admin_level_0 a 
where a.name_local='Italia' 
AND ST_Intersects(a.geom,b.geom) 
group by a.name_en;

select count(b.id) 
from nasa_modis_ba.final_ba b, public.admin_level_0 a 
where b.initialdate between '2001-01-01'::date and '2001-12-31'::date 
AND ST_Intersects(a.geom,b.geom) 
group by a.name_en;

drop materialized view nasa_modis_ba.stats_2001;

create materialized view nasa_modis_ba.stats_2001 AS 
select a.name_en,
       count(b.id),
       sum(st_area(b.geom))
from nasa_modis_ba.final_ba b, public.admin_level_0 a 
where b.initialdate between '2001-01-01'::date and '2001-12-31'::date 
AND a.name_local='Italia' 
AND ST_Within(b.geom,a.geom) 
group by a.name_en;

create view nasa_modis_ba.italia_stats_2001 AS 
select a.name_en,
       count(b.id),
       sum(st_area(b.geom::geography)*0.0001)
from nasa_modis_ba.final_ba b, public.admin_level_0 a 
where b.initialdate between '2001-01-01'::date and '2001-12-31'::date 
AND a.name_local='Italia' 
AND ST_Within(b.geom,a.geom) 
group by a.name_en;

create view nasa_modis_ba.europa_stats_2001 AS 
select a.name_en,
       count(b.id),
       sum(st_area(b.geom::geography)*0.0001)
from nasa_modis_ba.final_ba b, public.european_countries a 
where b.initialdate between '2001-01-01'::date and '2001-12-31'::date 
AND ST_Within(b.geom,a.geom) 
group by a.name_en;

create view nasa_modis_ba.effis_stats_2016 AS 
select a.name_en,
       count(b.id),
       sum(st_area(b.geom::geography)*0.0001)
from nasa_modis_ba.final_ba b, public.effis_countries a 
where b.initialdate between '2016-01-01'::date and '2016-12-31'::date 
AND ST_Within(b.geom,a.geom) 
group by a.name_en;

create view nasa_modis_ba.world_stats_2001_by_country AS 
select a.name_en,
       count(b.id),
       sum(st_area(b.geom::geography)*0.0001)
from nasa_modis_ba.final_ba b, public.admin_level_0 a 
where b.initialdate between '2001-01-01'::date and '2001-12-31'::date 
AND ST_Within(b.geom,a.geom) 
group by a.name_en
order by a.name_en;

create view nasa_modis_ba.world_stats_2001_by_country AS 
select a.name_en,
       count(b.id),
       sum(st_area(b.geom))
from nasa_modis_ba.final_ba b, public.admin_level_0 a 
where b.initialdate between '2001-01-01'::date and '2001-12-31'::date 
AND ST_Within(b.geom,a.geom) 
group by a.name_en;

create view nasa_modis_ba.italy_geom_2001 AS 
select b.id,b.geom
from nasa_modis_ba.final_ba b, public.admin_level_0 a 
where b.initialdate between '2001-01-01'::date and '2012-12-31'::date
AND a.name_local='Italia' 
AND ST_Intersects(a.geom,b.geom);

create view nasa_modis_ba.cameroon_geom_2001 AS 
select b.id,b.geom
from nasa_modis_ba.final_ba b, public.admin_level_0 a 
where b.initialdate between '2001-01-01'::date and '2012-12-31'::date
AND a.name_local='Cameroon' 
AND ST_Intersects(a.geom,b.geom);
