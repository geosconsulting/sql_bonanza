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



