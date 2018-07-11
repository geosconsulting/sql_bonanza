select id,ST_AsGeoJSON(shape,2) from rdaprd.current_burntareaspoly order by id LIMIT 10;

select ba_id,ST_AsGeoJSON(geom,2) from effis.current_burnt_area order by ba_id LIMIT 10;

select * from effis.glc_by_ba_id(3123);

select * from effis.clc_by_ba_id(3123);

select * from effis.glc_by_ba_id(5763);

select * from effis.clc_by_ba_id(5763);
