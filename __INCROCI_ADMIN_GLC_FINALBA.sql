drop function nasa_modis_ba.admns_by_fireid_with_areas(integer, integer, integer);

CREATE OR REPLACE FUNCTION nasa_modis_ba.admns_by_fireid_with_areas(ba_code integer, livello integer,year_of_interest integer)
 RETURNS TABLE(ba_id integer, initialdate date, finaldate date, admin_code integer,name_adm character varying, area double precision)
 LANGUAGE plpgsql
AS $function$
DECLARE    
    query varchar :=  'SELECT b.ogc_fid, b.initialdate, b.finaldate, p.id, p.name_local, ST_Area(ST_Intersection(b.geom, p.geom)::geography)*0.0001 AS area_intersection ' ||
		              'FROM nasa_modis_ba.final_ba b ' ||
			             'INNER JOIN public.admin_level_' || livello || ' p ON ST_Intersects(b.geom,p.geom) ' ||			  
		              'WHERE b.ogc_fid = ' || ba_code  || ' AND extract(year from initialdate) = ' || year_of_interest || ' ORDER BY area_intersection DESC;';
BEGIN
   RETURN QUERY
     --raise notice '%',query;
     EXECUTE query;
END; $function$



CREATE OR REPLACE FUNCTION nasa_modis_ba.admns_by_fireid(ba_code integer, livello integer,year_of_interest integer)
 RETURNS TABLE(ba_id integer, initialdate date, finaldate date, admin_code integer,name_adm character varying)
 LANGUAGE plpgsql
AS $function$
DECLARE    
    query varchar :=  'SELECT b.ogc_fid, b.initialdate, b.finaldate, p.id, p.name_local ' ||
		              'FROM nasa_modis_ba.final_ba b ' ||
			             'INNER JOIN public.admin_level_' || livello || ' p ON ST_Intersects(b.geom,p.geom) ' ||			  
		              'WHERE b.ogc_fid = ' || ba_code  || ' AND extract(year from initialdate) = ' || year_of_interest || ';';
BEGIN
   RETURN QUERY
     --raise notice '%',query;
     EXECUTE query;
END; $function$


select * from nasa_modis_ba.admns_by_fireid_with_areas(69769, 3, 2000);

select * from nasa_modis_ba.admns_by_fireid_with_areas(28485, 3, 2000);

select * from nasa_modis_ba.admns_by_fireid(28485, 3, 2000);

select * from nasa_modis_ba.admns_by_fireid(58551, 3, 2000);

select * from nasa_modis_ba.admns_by_fireid_with_areas(58551, 3, 2000);

select * from nasa_modis_ba.admns_by_fireid_with_areas(2255, 3, 2005);

select * from nasa_modis_ba.glc_by_finalba_id(2255, 2005);

select * from nasa_modis_ba.glc_by_finalba_id(58551, 2005);

select * from nasa_modis_ba.admns_by_fireid_with_areas(69769, 4, 2000);