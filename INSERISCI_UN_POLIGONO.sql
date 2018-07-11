CREATE TABLE public.poly_aoi
(
  id serial NOT NULL primary key,
  datedeb date,
  datefin date,
  relfile varchar,
  ldufile varchar,
  ldudesc varchar,  
  geom geometry(Polygon,4326)
)

insert into poly_aoi(datedeb,datefin,proj,relfile,ldufile,ldudesc,geom) values('2017-09-12','2017-09-13',
                          'tilef1.tif','CLC2006_13_250m2.tif','CLC06_R11_GEO_IdF.classif',
                          ST_Transform(ST_SetSRID(ST_MakePolygon(ST_GeometryFromText('LINESTRING(5258935.72044 1645452.9233,
                                                                                                 5258935.72044 1787452.9233, 
                                                                                                 5417935.72044 1787452.9233,
                                                                                                 5417935.72044 1645452.9233,
                                                                                                 5258935.72044 1645452.9233)')),3035),4326));

drop function __generate_aoi_dispersion(date,date,varchar,varchar,varchar,double precision,double precision,double precision,double precision);

create function __generate_aoi_dispersion(date_deb date,date_fin date,rel_file varchar,ldu_file varchar,ldu_desc varchar,
                                          low_x double precision,low_y double precision,high_x double precision,high_y double precision) 
returns void as $$
declare
     qry varchar := 'insert into poly_aoi(datedeb,datefin,relfile,ldufile,ldudesc,geom) values(''' || date_deb || ''',''' || date_fin || ''',
                          ''' || rel_file || ''',''' || ldu_file || ''',''' || ldu_desc || ''',
                          ST_Transform(ST_SetSRID(ST_MakePolygon(ST_GeometryFromText(''LINESTRING(' || low_x  || ' ' || low_y  ||','
                                                                                                    || high_x || ' ' || low_y  ||','
                                                                                                    || high_x || ' ' || high_y ||','
                                                                                                    || high_x || ' ' || low_y  ||','
                                                                                                    || low_x  || ' ' || low_y  ||')'')),3035),4326));';
begin
  --raise notice '%', qry;
  EXECUTE qry;
end;
$$ LANGUAGE plpgsql; 

select * from __generate_aoi_dispersion('2017-09-12','2017-09-13','F1D20170912','tilef1.tif','CLC2006_13_250m2.tif','CLC06_R11_GEO_IdF.classif',5258935.72044,1645452.9233,5417935.72044,1787452.9233);

select * from __generate_aoi_dispersion('2017-06-18','2017-06-23','PEDROGAODEBUG','tilef1.tif','g250_clc12_V18_5.tif','g250_clc12_V18_5.classif',2708435.76119,1992887.23992,2850435.76119,2113887.23992);

select * from emission_dispersion.generate_aoi_dispersion_modelling('2017-09-12',
                                                                    '2017-09-13',
                                                                    'F1D20170912',
                                                                    'tilef1.tif',
                                                                    'CLC2006_13_250m2.tif',
                                                                    'CLC06_R11_GEO_IdF.classif',
                                                                    5258935.72044,
                                                                    1645452.9233,
                                                                    5417935.72044,
                                                                    1787452.9233);

select * from emission_dispersion.generate_aoi_dispersion_modelling('2017-06-18',
                                                                    '2017-06-23',
                                                                    'PEDROGAODEBUG',
                                                                    'tilef1.tif',
                                                                    'g250_clc12_V18_5.tif',
                                                                    'g250_clc12_V18_5.classif',
                                                                    2708435.76119,
                                                                    1992887.23992,
                                                                    2850435.76119,
                                                                    2113887.23992);
																	
select * from emission_dispersion.generate_aoi_dispersion_modelling('2017-09-12',
                                                                    '2017-09-13',
                                                                    'F1D20170912',                                                                    
                                                                    5258935.72044,
                                                                    1645452.9233,
                                                                    5417935.72044,
                                                                    1787452.9233);
