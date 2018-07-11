-- Function: effis.stats_poly_on_raster_effis_gwis(integer, text, text)

-- DROP FUNCTION effis.stats_poly_on_raster_effis_gwis(integer, text, text);

CREATE OR REPLACE FUNCTION effis.stats_poly_on_raster_effis_gwis(
    IN fireid integer,
    IN aoi text,
    IN landcover text)
  RETURNS TABLE(landcover_code double precision, landcover_description character varying, landcover_pixel bigint, landcover_percentage double precision) AS
$BODY$
DECLARE
    var_r record;
    proj integer;
    legend text;
    id_field text := 'ba_id';
    vect_schema_table text := 'effis.current_burnt_area';
    land_cover_table text :=landCover || '_1x1k';
    land_cover_legend text :=landCover || '_legend';
    legend_link_postfix text := 'value';
    legend_group text := 'GROUP BY values_area.value, rastpixwidth, rastpixheight, glc_legend.value, glc_legend.label';
    values_area_str text := 'values_area AS(SELECT (stats).*,rastpixwidth,rastpixheight';
    geom_field text := 'geom';
    query varchar; 
begin
   if aoi = 'gwis' then
       id_field := 'id';  
       vect_schema_table := 'nasa_modis_ba.final_ba';     
   end if;  
   if landCover = 'clc' then
        geom_field := 'ST_Transform(geom,3035) as geom';   
        legend_link_postfix := 'id';      
        legend_group := 'GROUP BY values_area.value, rastpixwidth, rastpixheight, clc_legend.label';  
    end if;  
    query :='with
             burnt_area AS(SELECT ' || id_field || ' AS area_id,' || geom_field ||
   	               ' FROM ' || vect_schema_table || ' as b 
   	               WHERE b.' ||id_field ||'=' ||  fireId || '), ' ||    
                       values_area_str ||
   			        ' FROM (SELECT ST_ValueCount(ST_Clip(rast,geom)) AS stats,
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
   --raise notice '%',query; 
   RETURN QUERY
     execute query;     
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.stats_poly_on_raster_effis_gwis(integer, text, text)
  OWNER TO e1gwis;
