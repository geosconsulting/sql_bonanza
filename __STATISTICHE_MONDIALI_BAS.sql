select a.id, a.name_en, r.region 
from public.admin_level_0 a, public.region r
-- where r.region = 'Australia/New Zealand' 
-- where r.region = 'Polynesia' 
where r.region = 'Northern America' 
-- where r.region = 'Southern Europe' 
and ST_Intersects(a.geom,r.geom);
-- and ST_Crosses(a.geom,r.geom);
-- and ST_Touches(a.geom,r.geom);
-- and ST_Within(ST_Centroid(a.geom),r.geom);

select a.id, a.name_en, r.region 
from public.admin_level_0 a, public.region r
-- where r.region = 'Australia/New Zealand' 
-- where r.region = 'Polynesia' 
where r.region = 'Polynesia' 
and a.name_en not in ('United States','United States Minor Outlying Islands','Chile')
-- where r.region = 'Southern Europe' 
and ST_Intersects(a.geom,r.geom);
-- and ST_Crosses(a.geom,r.geom);
-- and ST_Touches(a.geom,r.geom);
-- and ST_Within(ST_Centroid(a.geom),r.geom);

ALTER TABLE admin_level_0_regions ALTER COLUMN id SET DEFAULT nextval('countries_regions_id_seq');

insert into public.admin_level_0_regions (country_id,region_id) 
select a.id, r.id 
from public.admin_level_0 a, public.region r
where r.region = 'Australia/New Zealand' 
and ST_Intersects(a.geom,r.geom);

insert into public.admin_level_0_regions (country_id,region_id) 
select a.id, r.id 
from public.admin_level_0 a, public.region r
where r.region = 'Polynesia' 
and a.name_en not in ('United States','United States Minor Outlying Islands','Chile')
and ST_Intersects(a.geom,r.geom);

select * from public.__effis_region_aggregate('Northern America');
select * from public.__effis_region_aggregate('Central America');
select * from public.__effis_region_aggregate('South America');

select * from public.__effis_region_aggregate('European Russia');

select a.id, a.name_en, r.region 
from public.admin_level_0 a, public.region r
where r.region = 'European Russia' 
-- and ST_Intersects(a.geom,r.geom);
-- and ST_Crosses(a.geom,r.geom);
and ST_Touches(a.geom,r.geom);
-- and ST_Within(ST_Centroid(a.geom),r.geom);

select * from public.__effis_region_aggregate('Eastern Europe');

select * from public.__effis_region_aggregate('Northern Africa');
select * from public.__effis_region_aggregate('Western Africa');
select * from public.__effis_region_aggregate('Middle Africa');
select * from public.__effis_region_aggregate('Eastern Africa');

select * from nasa_modis_ba.stats_modis_ba_view(2006,'Australia New Zealand');
select * from nasa_modis_ba.stats_modis_ba_view(2007,'Australia New Zealand');
select * from nasa_modis_ba.stats_modis_ba_view(2008,'Australia New Zealand');
select * from nasa_modis_ba.stats_modis_ba_view(2009,'Australia New Zealand');
select * from nasa_modis_ba.stats_modis_ba_view(2010,'Australia New Zealand');
select * from nasa_modis_ba.stats_modis_ba_view(2011,'Australia New Zealand');
select * from nasa_modis_ba.stats_modis_ba_view(2012,'Australia New Zealand');
select * from nasa_modis_ba.stats_modis_ba_view(2013,'Australia New Zealand');
select * from nasa_modis_ba.stats_modis_ba_view(2014,'Australia New Zealand');
select * from nasa_modis_ba.stats_modis_ba_view(2015,'Australia New Zealand');
select * from nasa_modis_ba.stats_modis_ba_view(2016,'Australia New Zealand');
select * from nasa_modis_ba.stats_modis_ba_view(2017,'Australia New Zealand');
select * from nasa_modis_ba.stats_modis_ba_view(2018,'Australia New Zealand');

select a.id, a.name_en, r.region 
from public.admin_level_0 a, public.region r
where r.region = 'Northern Africa' 
--and a.name_en not in ('United States','United States Minor Outlying Islands','Chile')
and ST_Intersects(a.geom,r.geom)
order by a.name_en;

select a.id, r.id 
from public.admin_level_0 a, public.region r
where r.region = 'Northern Africa' 
and ST_Intersects(a.geom,r.geom);

select * from nasa_modis_ba.stats_modis_ba_view(2000,'Northern Africa');
select * from nasa_modis_ba.stats_modis_ba_view(2001,'Northern Africa');




