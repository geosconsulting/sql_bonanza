select * from cross_effis_nasamodis.cross_bas(2016);

select ogc_fid,ST_IsValidReason(geom) from nasa_modis_ba.final_ba_2016 where ST_IsValid(geom)=FALSE;

SELECT ST_MakeValid(geom) from nasa_modis_ba.final_ba_2016;

update nasa_modis_ba.final_ba_2016 set geom = ST_MakeValid(geom) where ST_IsValid(geom)=FALSE;

select ogc_fid,ST_IsValidReason(geom) from nasa_modis_ba.final_ba_2016 where ST_IsValid(geom)=FALSE;

update nasa_modis_ba.final_ba_2014 set geom = ST_MakeValid(geom) where ST_IsValid(geom)=FALSE;

select * from cross_effis_nasamodis.cross_bas(2014);

