-- Function: ba_adm.adm1_by_fireid(integer)

DROP FUNCTION ba_adm.admns_by_fireid(integer,integer);

CREATE OR REPLACE FUNCTION ba_adm.admns_by_fireid(IN fire_id integer,IN admin_level Integer)
  RETURNS TABLE(f_id integer, adm1_code integer, firedate character varying, update character varying, name_adm1 character varying) AS
$BODY$
DECLARE
    admin_level_table varchar := 'public.admin_level_' || admin_level;    
    adm_mm varchar := 'ba_adm.ba_adm' || admin_level;
    fld_ba text := 'fire_id';
    fld_adm text := 'adm' || admin_level || '_id';
    query varchar :=  'SELECT a.fire_id, a.adm_id,b.firedate,b.lastupdate,c.name_en ' ||
		      'FROM ' || adm_mm || ' a ' ||
			'LEFT JOIN rdaprd.current_burntareaspoly b ON(a.fire_id = b.id) ' ||
			'LEFT JOIN ' || admin_level_table || ' c ON(a.adm_id = c.id) ' ||
		      'WHERE a.fire_id = ' || fire_id || ';';
BEGIN
   RETURN QUERY     
     EXECUTE query; 
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
  
ALTER FUNCTION ba_adm.admns_by_fireid(integer,integer)
  OWNER TO postgres;

  
-- Function: effis.stats_poly_on_raster(integer, text, text)

-- DROP FUNCTION effis.stats_poly_on_raster(integer, text, text);

CREATE OR REPLACE FUNCTION effis.stats_poly_on_raster(
    IN fireid integer,
    IN datalevel text,
    IN landcover text)
  RETURNS TABLE(landcover_code double precision, landcover_description character varying, landcover_pixel bigint, landcover_percentage double precision) AS
$BODY$
DECLARE
    var_r record;
    proj integer;
    legend text;
    id_field text;
    land_cover_table text :=landCover || '_1x1k';
    land_cover_legend text :=landCover || '_legend';
    geom_field text := 'geom';
    query varchar; 
begin
   if landCover = 'clc' then
        geom_field := 'ST_Transform(geom,3035) as geom';   
    end if;  
    query :='with
             burnt_area AS(SELECT ba_id As area_id,' || geom_field ||
   	               ' FROM effis.current_burnt_area as b 
   	               WHERE b.ba_id=' ||  fireId || '),     
     values_area AS(SELECT (stats).*,rastpixwidth, rastpixheight
   			        FROM (SELECT ST_ValueCount(ST_Clip(rast,geom)) AS stats,
   				                 ST_ScaleX(rast) As rastpixwidth, 
   		                         ST_ScaleY(rast) As rastpixheight
   		                  FROM rst.' || land_cover_table || 
   				              ' INNER JOIN burnt_area ON ST_Intersects(burnt_area.geom, rast)) AS foo)     
     SELECT values_area.value,' || 	 
   	       land_cover_legend || '.label,
   	       SUM(count) as num_pixels,
   	       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
   	       FROM values_area
   		  INNER JOIN rst.' || land_cover_legend || ' ON ' || land_cover_legend || '.id = values_area.value 
     WHERE count > 0
   	   GROUP BY values_area.value, rastpixwidth, rastpixheight,' || land_cover_legend || '.label
   	   ORDER BY values_area.value;';     
   raise notice '%',query; 
   RETURN QUERY
     execute query;     
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.stats_poly_on_raster(integer, text, text)
  OWNER TO postgres;
 
****************************************************************************************************************************
CREATE OR REPLACE FUNCTION effis.clc_by_ba_id(IN fire_id integer)
  RETURNS TABLE(landcover_code double precision, landcover_description character varying, landcover_pixel bigint, landcover_percentage double precision) AS
$BODY$
DECLARE
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- feature of interest
     burnt_area AS(SELECT ba_id As area_id, 
		          ST_Transform(geom,3035) as geom_proj
	           FROM effis.current_burnt_area as b
	           WHERE b.ba_id= fire_id),
     -- clip all bands to boundaries then get stats for these clipped regions
     values_area AS(SELECT (stats).*,rastpixwidth,rastpixheight
			 FROM (SELECT ST_ValueCount(ST_Clip(rast, geom_proj)) AS stats,
				          ST_ScaleX(rast) As rastpixwidth, 
		                  ST_ScaleY(rast) As rastpixheight
		               FROM rst.clc_1x1k
				  INNER JOIN burnt_area ON ST_Intersects(burnt_area.geom_proj, rast)) AS foo)
     -- finally summarize stats
     SELECT values_area.value,	 
	       clc_legend.label,
	       SUM(count) as num_pixels,
	       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
	       FROM values_area
		  INNER JOIN rst.clc_legend ON clc_legend.id = values_area.value 
     WHERE count > 0
	   GROUP BY values_area.value, rastpixwidth, rastpixheight, clc_legend.label
	   ORDER BY values_area.value;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
****************************************************************************************************************************
CREATE OR REPLACE FUNCTION effis.glc_by_ba_id_1(IN fire_id integer)
  RETURNS TABLE(landcover_code double precision, landcover_description character varying, landcover_pixel bigint, landcover_percentage double precision) AS
$BODY$
DECLARE
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- feature of interest
     ba_area AS(SELECT ba_id As area_id, geom
	      FROM effis.current_burnt_area as b
	      WHERE b.ba_id=fire_id),
     -- clip all bands to boundaries then get stats for these clipped regions
	  values_area AS(SELECT area_id, 
	                       (stats).*,
						   rastpixwidth,
						   rastpixheight
	 	 FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS stats,
		       ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		       FROM rst.glc_1x1k
		          INNER JOIN ba_area ON ST_Intersects(ba_area.geom, rast)) AS foo)
     -- finally summarize stats
	SELECT values_area.value,
	       glc_legend.label,
	       SUM(count) as num_pixels,
	       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
	       FROM values_area
	       INNER JOIN rst.glc_legend ON glc_legend.value = values_area.value
	WHERE count > 0
	   GROUP BY area_id, values_area.value, rastpixwidth, rastpixheight, glc_legend.value, glc_legend.label
	   ORDER BY values_area.value;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;  
***************************************************************************************************************************
-- Function: effis.stats_poly_on_raster(integer, text, text)

-- DROP FUNCTION effis.stats_poly_on_raster(integer, text, text);

CREATE OR REPLACE FUNCTION effis.stats_poly_on_raster_1(
    IN fireid integer,
    IN datalevel text,
    IN landcover text)
  RETURNS TABLE(landcover_code double precision, landcover_description character varying, landcover_pixel bigint, landcover_percentage double precision) AS
$BODY$
DECLARE
    var_r record;
    proj integer;
    legend text;
    id_field text;
    land_cover_table text :=landCover || '_1x1k';
    land_cover_legend text :=landCover || '_legend';
    legend_link_postfix text := 'id';
    legend_group text := 'GROUP BY area_id, values_area.value, rastpixwidth, rastpixheight, glc_legend.value, glc_legend.label';
    values_area_str text := 'values_area AS(SELECT area_id, (stats).*,rastpixwidth,rastpixheight';
    geom_field text := 'geom';
    query varchar; 
begin
   if landCover = 'clc' then
        geom_field := 'ST_Transform(geom,3035) as geom';   
        legend_link_postfix := 'value';
        legend_group := 'GROUP BY values_area.value, rastpixwidth, rastpixheight, clc_legend.label';
        values_area_str := 'values_area AS(SELECT (stats).*,rastpixwidth,rastpixheight';
    end if;  
    query :='with
             burnt_area AS(SELECT ba_id As area_id,' || geom_field ||
   	               ' FROM effis.current_burnt_area as b 
   	               WHERE b.ba_id=' ||  fireId || '), ' ||    
                       values_area_str ||
   			        'FROM (SELECT ST_ValueCount(ST_Clip(rast,geom)) AS stats,
   				                 ST_ScaleX(rast) As rastpixwidth, 
   		                         ST_ScaleY(rast) As rastpixheight
   		                  FROM rst.' || land_cover_table || 
   				              ' INNER JOIN burnt_area ON ST_Intersects(burnt_area.geom, rast)) AS foo)     
     SELECT values_area.value,' || 	 
   	       land_cover_legend || '.label,
   	       SUM(count) as num_pixels,
   	       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
   	       FROM values_area
   		  INNER JOIN rst.' || land_cover_legend || ' ON ' || land_cover_legend || '.' || legend_link_postfix ||'= values_area.value 
     WHERE count > 0 ' || legend_group ||   	   
   	   ' ORDER BY values_area.value;';     
   raise notice '%',query; 
   RETURN QUERY
     execute query;     
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.stats_poly_on_raster(integer, text, text)
  OWNER TO postgres;
  
  
  
  with
burnt_area AS(SELECT ba_id As area_id, geom 
               FROM effis.current_burnt_area as b 
   	       WHERE b.ba_id=3123), 
values_area AS(SELECT (stats).*,
                      rastpixwidth,
                      rastpixheight 
               FROM (SELECT ST_ValueCount(ST_Clip(rast,geom)) AS stats,
                            ST_ScaleX(rast) As rastpixwidth, 
   		            ST_ScaleY(rast) As rastpixheight
   		     FROM rst.glc_1x1k 
   		          INNER JOIN burnt_area ON ST_Intersects(burnt_area.geom, rast)) AS foo)     
SELECT values_area.value,
        glc_legend.label,
        SUM(count) as num_pixels,
        SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
FROM values_area
     INNER JOIN rst.glc_legend ON glc_legend.value= values_area.value 
WHERE count > 0 
     GROUP BY values_area.value, rastpixwidth, rastpixheight, glc_legend.value, glc_legend.label 
     ORDER BY values_area.value;
  
  
 
