DROP table tmp.ba_modis_2012_sicilia CASCADE;

create table tmp.ba_modis_2012_sicilia as 
SELECT ba.*
FROM public.admin_level_1 a, effis.archived_burnt_area ba
where a.name_local = 'Sicily' 
and ba.firedate::date between '2012-01-01'::date and '2012-12-31'::date
and ST_Within(ba.geom, a.geom);

create table tmp.ba_viirs_2012_sicilia as 
SELECT ba.*
FROM public.admin_level_1 a, nasa_modis_ba.final_ba ba
where a.name_local = 'Sicily' 
and ba.initialdate::date between '2012-01-01'::date and '2012-12-31'::date
and ST_Within(ba.geom, a.geom);

drop table tmp.ba_modis_2012_sicilia_centroid;

create table tmp.ba_modis_2012_sicilia_centroid as 
select *,st_centroid(geom) 
from tmp.ba_modis_2012_sicilia;

drop table tmp.ba_viirs_2012_sicilia_centroid;

create table tmp.ba_viirs_2012_sicilia_centroid as 
select *,st_centroid(geom) 
from tmp.ba_viirs_2012_sicilia;

select id,name_en,name_local,st_asGeoJSON(geom)
from public.admin_level_1 
where name_local = 'Sicily';

SELECT ba.ba_id, ba.geom 
FROM public.admin_level_0 a , effis.archived_burnt_area ba
where ba.firedate::date between '2012-01-01'::date and '2012-12-31'::date
AND a.iso = 'ITA'
AND ST_Intersects(a.geom,ba.geom);

select ba_id, geom
from effis.archived_burnt_area
    join public.
where firedate between '2012-01-01' and '2012-12-31';

create view effis.centr_2012 as 
select ba_id,st_centroid(geom) 
from effis.archived_burnt_area 
where firedate between '2012-01-01' and '2012-12-31';

-- query teoriche
SELECT g1.gid As gref_gid, g1.description As gref_description, g2.gid As gnn_gid, 
       g2.description As gnn_description  
FROM sometable As g1, sometable As g2   
WHERE g1.gid = 1 and g1.gid <> g2.gid AND ST_DWithin(g1.the_geom, g2.the_geom, 300)   
ORDER BY ST_Distance(g1.the_geom,g2.the_geom) 
LIMIT 5

SELECT DISTINCT ON(g1.gid)  g1.gid As gref_gid, g1.description As gref_description, g2.gid As gnn_gid, 
       g2.description As gnn_description  
FROM sometable As g1, sometable As g2   
WHERE g1.gid <> g2.gid AND ST_DWithin(g1.the_geom, g2.the_geom, 300)   
ORDER BY g1.gid, ST_Distance(g1.the_geom,g2.the_geom) 
--query teoriche

drop table tmp.tab_distances_from_modis_ba cascade;

create table tmp.tab_distances_from_modis_ba as 
SELECT distinct on(g1.ba_id) g1.ba_id, g2.id,ST_Distance(g1.geom,g2.geom) as distance
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2   
WHERE ST_DWithin(g1.geom, g2.geom, 10)   
ORDER BY g1.ba_id,distance;

drop table tmp.tab_distances_from_viirs_ba cascade;

create table tmp.tab_distances_from_viirs_ba as 
SELECT distinct on(g1.id) g1.id, g2.ba_id,ST_Distance(g1.geom,g2.geom) as distance
FROM  tmp.ba_viirs_2012_sicilia as g1, tmp.ba_modis_2012_sicilia As g2   
WHERE ST_DWithin(g1.geom, g2.geom, 50)   
ORDER BY g1.id,distance;

--rimuovendo distinct calcolo TUTTE le combinazioni di distanza
create table tmp.tab_distances_from_modis_ba_tutte_combinazioni as 
SELECT g1.ba_id, g2.id,ST_Distance(g1.geom,g2.geom) as distance
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2   
WHERE ST_DWithin(g1.geom, g2.geom, 10)   
ORDER BY g1.ba_id,distance;

select count(ba_id) from tmp.tab_distances_from_modis_ba_tutte_combinazioni where distance = 0;

--ST_MakeLine(g1.geom, g2.geom),

SELECT DISTINCT ON(g1.ba_id) g1.ba_id, g2.id,
g1.firedate as modis_init,
g1.lastupdate as modis_final,
g2.initialdate as viirs_init,
g2.finaldate as viirs_final,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom)
--ST_AsText(ST_ShortestLine(g1.geom, g2.geom)) As sline
--ST_MaxDistance(g1.geom, g2.geom)
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2   
WHERE ST_Intersects(g1.geom, g2.geom);

create table tmp.closest_points as
SELECT DISTINCT ON(g1.ba_id) g1.ba_id, g2.id,
ST_X(ST_ClosestPoint(g1.geom,g2.geom)),
ST_Y(ST_ClosestPoint(g1.geom,g2.geom)),
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom),
--ST_AsText(ST_ShortestLine(g1.geom, g2.geom)) As sline
--ST_MaxDistance(g1.geom, g2.geom)
ST_MakePoint(ST_X(ST_ClosestPoint(g1.geom,g2.geom)),ST_Y(ST_ClosestPoint(g1.geom,g2.geom))) as geom 
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2   
WHERE ST_Intersects(g1.geom, g2.geom);

create table tmp.linee as 
SELECT DISTINCT ON(g1.ba_id) g1.ba_id, g2.id,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom),
--ST_MakeLine(g1.geom, g2.geom),
ST_ShortestLine(g1.geom, g2.geom) As geom
--ST_MaxDistance(g1.geom, g2.geom)
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2   
WHERE ST_Intersects(g1.geom, g2.geom);

create table tmp.linee_centroids as 
SELECT DISTINCT ON(g1.ba_id) g1.ba_id, g2.id,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom),
ST_MakeLine(st_centroid(g1.geom), st_centroid(g2.geom))
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2   
WHERE ST_Intersects(g1.geom, g2.geom);

drop table tmp.linee_centroids_within;

create table tmp.linee_centroids_within as 
SELECT DISTINCT ON(g1.ba_id) g1.ba_id, g2.id,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom),
--ST_ShortestLine(g1.geom, g2.geom) as linea_corta,
--ST_MakeLine(st_centroid(g1.geom), st_centroid(g2.geom))
ST_MakeLine(ST_StartPoint(ST_ShortestLine(g1.geom, g2.geom)),ST_EndPoint(ST_ShortestLine(g1.geom, g2.geom))) as geom
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2   
WHERE ST_DWithin(g1.geom, g2.geom, 0.1);

create table tmp.linee_centroids_within_ampio_raggio as 
SELECT DISTINCT ON(g1.ba_id) g1.ba_id, g2.id,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom),
--ST_ShortestLine(g1.geom, g2.geom) as linea_corta,
--ST_MakeLine(st_centroid(g1.geom), st_centroid(g2.geom))
ST_MakeLine(ST_StartPoint(ST_ShortestLine(g1.geom, g2.geom)),ST_EndPoint(ST_ShortestLine(g1.geom, g2.geom))) as geom
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2   
WHERE ST_DWithin(g1.geom, g2.geom, 1);

--create table tmp.linee_nearest as 
SELECT DISTINCT ON(g1.ba_id) g1.ba_id, g2.id,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom)
--ST_MakeLine(ST_StartPoint(ST_Distance(g1.geom, g2.geom)),ST_EndPoint(ST_Distance(g1.geom, g2.geom)))
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2   
WHERE ST_Intersects(g1.geom, g2.geom)
OR ST_DWithin(g1.geom, g2.geom, 0.1);

--****************************************************************************************
-- MOTHER OF ALL SPATIAL QUERY
--****************************************************************************************
create table cross_effis_nasamodis.modis_ba_distances_from_viirs_ba as 
SELECT distinct on(g1.global_id) g1.global_id, g2.id,ST_Distance(g1.geom,g2.geom) as distance
FROM  effis.burnt_areas as g1, nasa_modis_ba.final_ba As g2   
WHERE ST_DWithin(g1.geom, g2.geom, 50)   
ORDER BY g1.global_id,distance;
--****************************************************************************************
-- MOTHER OF ALL SPATIAL QUERY
--****************************************************************************************

select find_srid('tmp','closest_points','geom');
select UpdateGeometrySRID('tmp','closest_points','geom', 4326);

--*********************************************************
--       FILTERING OF CENTROIDS OF VIIRS POLYGONS
--*********************************************************
with lc as(
SELECT ba_id,
       ST_Value(r.rast, p.geom) as valore
FROM rst.glc_1x1k r, tmp.closest_points p
where ST_Intersects(r.rast,p.geom)
)
select 
    lc.ba_id,
    lc.valore,
    rl.label
from rst.glc_legend rl ,lc
where rl.value = lc.valore;

--*********************************************************
--   FINALE CON DIFFERENZE DATA,DISTANZA E SIMILARITA'
--*********************************************************
create table cross_effis_nasamodis.cross_sicily as
SELECT DISTINCT ON(g1.ba_id) g1.ba_id, 
g2.id,
g1.firedate::date as modis_init,
g1.lastupdate::date as modis_final,
g2.initialdate as viirs_init,
g2.finaldate as viirs_final,
g1.firedate::date - g2.initialdate as init_lag_days,
g1.lastupdate::date - g2.finaldate as finale_lag_days,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom)
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2   
WHERE ST_Intersects(g1.geom, g2.geom)
order by g1.ba_id,init_lag_days;

SELECT DISTINCT ON(g1.ba_id) g1.ba_id,  
ST_ClusterDBSCAN(st_centroid(g1.geom), eps := 50, minpoints := 2) over () AS cid
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2  
WHERE ST_DWithin(g1.geom, g2.geom, 0.1);

--5 sono i cluster che voglio intorno al centroide del poligono modis
drop table tmp.clusterkmeans_sicily;

create table tmp.clusterkmeans_sicily as 
SELECT DISTINCT ON(g1.ba_id) g1.ba_id,  
ST_ClusterKMeans(st_centroid(g1.geom), 5) over () AS cid,
g2.geom
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2  
WHERE ST_Intersects(g1.geom, g2.geom);

create table tmp.clusterkmeans_sicily_nogeom as 
SELECT DISTINCT ON(g1.ba_id) g1.ba_id,  
ST_ClusterKMeans(st_centroid(g1.geom), 5) over () AS cid,
g2.id
FROM tmp.ba_modis_2012_sicilia g1, tmp.ba_viirs_2012_sicilia As g2  
WHERE ST_Intersects(g1.geom, g2.geom);

--*********************************************************
--       GNENTE DA FA NUN RIESCE LA CONVERSIONE
--*********************************************************
CREATE TABLE tmp.viirs_rast AS 
SELECT ST_Union(ST_AsRaster(geometry, rast, '32BF', geom, -9999)) rast 
FROM rst.glc_1x1k, (SELECT rast FROM tmp.ba_viirs_2012_sicilia LIMIT 1) rast;

--*********************************************************
--   FINALE CON DIFFERENZE DATA,DISTANZA E SIMILARITA' 2017
--*********************************************************
drop materialized view effis.ba_modis_2017;

drop table cross_effis_nasamodis.cross_complete_2017;

create materialized view effis.ba_modis_2017 as
select * from effis.archived_burnt_area 
where firedate::date between '2017-01-01'::Date and '2017-12-31'::Date;

create table cross_effis_nasamodis.cross_complete_2017 as
SELECT DISTINCT ON(g1.ba_id) g1.ba_id, 
g2.id,
g1.firedate::date as modis_init,
g1.lastupdate::date as modis_final,
g2.initialdate as viirs_init,
g2.finaldate as viirs_final,
g1.firedate::date - g2.initialdate as init_lag_days,
g1.lastupdate::date - g2.finaldate as finale_lag_days,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom)
FROM effis.ba_modis_2017 g1, nasa_modis_ba.final_ba_2017 As g2   
WHERE ST_Intersects(g1.geom, g2.geom)
order by g1.ba_id,init_lag_days;

create materialized view effis.ba_modis_2016 as
select * from effis.archived_burnt_area 
where firedate::date between '2016-01-01'::Date and '2016-12-31'::Date;

create table cross_effis_nasamodis.cross_complete_2016 as
SELECT DISTINCT ON(g1.ba_id) g1.ba_id, 
g2.id,
g1.firedate::date as modis_init,
g1.lastupdate::date as modis_final,
g2.initialdate as viirs_init,
g2.finaldate as viirs_final,
g1.firedate::date - g2.initialdate as init_lag_days,
g1.lastupdate::date - g2.finaldate as finale_lag_days,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom)
FROM effis.ba_modis_2016 g1, nasa_modis_ba.final_ba_2016 As g2   
WHERE ST_DWithin(g1.geom, g2.geom, 50) 
order by g1.ba_id,init_lag_days;


create table cross_effis_nasamodis.cross_complete_2015 as
SELECT DISTINCT ON(g1.ba_id) g1.ba_id, 
g2.id,
g1.firedate::date as modis_init,
g1.lastupdate::date as modis_final,
g2.initialdate as viirs_init,
g2.finaldate as viirs_final,
g1.firedate::date - g2.initialdate as init_lag_days,
g1.lastupdate::date - g2.finaldate as finale_lag_days,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom)
FROM effis.ba_modis_2015 g1, nasa_modis_ba.final_ba_2015 As g2   
WHERE ST_Intersects(g1.geom, g2.geom)
order by g1.ba_id,init_lag_days;