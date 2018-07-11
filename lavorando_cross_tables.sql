create table cross_effis_nasamodis.cross_intersect (like cross_effis_nasamodis.cross_intersects_2006);


insert into cross_effis_nasamodis.cross_distance(effis_index,ba_id,effis_id,effis_start_date,effis_last_date,
                                                 gwis_index,gwis_id,gwis_start_date,gwis_last_date,initial_days_diff,
                                                 final_days_diff,distance,similarity) 
                                                 select effis_index,ba_id,effis_id,effis_start_date::date,effis_last_date::date,
                                                        gwis_index,gwis_id,gwis_start_date,gwis_last_date,
                                                        initial_days_diff,final_days_diff,distance,similarity 
                                                 from cross_effis_nasamodis.cross_distance_2018;


ALTER TABLE cross_effis_nasamodis.cross_distance ALTER COLUMN effis_start_date TYPE DATE using to_date(effis_start_date, 'YYYY-MM-DD');
ALTER TABLE cross_effis_nasamodis.cross_distance ALTER COLUMN effis_last_date TYPE DATE using to_date(effis_last_date, 'YYYY-MM-DD');

create table cross_effis_nasamodis.ba_final_ba as
select c.effis_index,c.gwis_index, 
       ea.geom as ba_geom, 
       gw.geom as fba_geom
from cross_effis_nasamodis.cross_distance c, 
     effis.archived_burnt_area ea, 
     nasa_modis_ba.final_ba gw
WHERE c.effis_index = ea.year_id
or c.gwis_index = gw.ogc_fid;

select cr.*,bm.geom,bh.geom as geom1 
from cross_effis_nasamodis.cross_distance_2009 cr, 
     cross_effis_nasamodis.ba_modis_2009 bm,
     cross_effis_nasamodis.final_ba_effis_2009 bh
where distance < 2000 
and bm.year_id = cr.effis_index
and bh.ogc_fid = cr.gwis_index
order by id,distance;

drop table cross_effis_nasamodis.cross_distance_final_merge_2006;

create table cross_effis_nasamodis.cross_distance_final_merge_2006 as 
select distinct(cr.effis_index),
       st_union(bh.geom)
from cross_effis_nasamodis.cross_distance_2006 cr,      
     cross_effis_nasamodis.final_ba_effis_2006 bh
where distance < 1 
and bh.ogc_fid = cr.gwis_index
group by cr.effis_index;

CREATE SEQUENCE cross_effis_nasamodis.cross_intersect_seq;
ALTER TABLE cross_effis_nasamodis.cross_intersect ALTER COLUMN id SET NOT NULL;
ALTER TABLE cross_effis_nasamodis.cross_intersect ALTER COLUMN id SET DEFAULT nextval('cross_effis_nasamodis.cross_intersect_seq');
ALTER SEQUENCE cross_effis_nasamodis.cross_intersect_seq OWNED BY postgres;

insert into cross_effis_nasamodis.cross_intersect(
  effis_index, ba_id, effis_id,effis_start_date,
  effis_last_date, gwis_index, gwis_id, gwis_start_date,
  gwis_last_date, initial_days_diff, final_days_diff,similarity
)
select effis_index,ba_id,effis_id,effis_start_date::date,effis_last_date::date,
                                                        gwis_index,gwis_id,gwis_start_date,gwis_last_date,
                                                        initial_days_diff,final_days_diff,similarity 
                                                 from cross_effis_nasamodis.cross_intersects_2018;

create table cross_effis_nasamodis.ba_modis_2018 (like cross_effis_nasamodis.ba_modis_2006);

insert into cross_effis_nasamodis.ba_modis_2018(id_source,year_id,ba_id,area_ha,firedate,lastupdate,geom,id)
select ba_id as id_source,extract(year from firedate::date) || '_' || ba_id as year_id,
       ba_id,area_ha,firedate,lastupdate,ST_SetSRID(ST_AsText(ST_Multi(geom)),4326) as geom, row_number() over (order by firedate)
from effis.current_burnt_area;

select min(initialdate),max(initialdate),
       min(finaldate),max(finaldate) 
from nasa_modis_ba_dev10.final_burnt_areas_2018;

create table cross_effis_nasamodis.final_ba_effis_2018 as 
select ogc_fid,id,initialdate,finaldate,wkb_geometry as geom
from nasa_modis_ba_dev10.final_burnt_areas_2018;




