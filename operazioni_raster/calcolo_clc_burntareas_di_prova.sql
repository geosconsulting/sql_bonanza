-- Function: effis.burntarea_fireid_clc(integer)

DROP FUNCTION effis.burntarea_fireid_clc(integer);

CREATE OR REPLACE FUNCTION effis.burntarea_fireid_clc(IN fire_id integer)
  RETURNS TABLE(landcover_code double precision, landcover_description character varying, 
                landcover_pixel bigint, landcover_percentage double precision) AS
$BODY$
DECLARE
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- feature of interest
     burnt_area AS(SELECT id As area_id, 
		          ST_Transform(shape,3035) as geom_proj
	           FROM effis.current_burntareaspoly as b
	           WHERE b.id = fire_id),
     -- clip all bands to boundaries then get stats for these clipped regions
     values_area AS(SELECT (stats).*,rastpixwidth,rastpixheight
			 FROM (SELECT ST_ValueCount(ST_Clip(rast, geom_proj)) AS stats,
				      ST_ScaleX(rast) As rastpixwidth, 
		                      ST_ScaleY(rast) As rastpixheight
		               FROM rst.clc_1x1k
				  INNER JOIN burnt_area ON ST_Intersects(burnt_area.geom_proj, rast)) AS foo)
     -- finally summarize stats
     SELECT values_area.value,	 
	       clc_legend.label_specific,
	       SUM(count) as num_pixels,
	       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
	       FROM values_area
		  INNER JOIN rst.clc_legend ON clc_legend.grid_code = values_area.value 
     WHERE count > 0
	   GROUP BY values_area.value, rastpixwidth, rastpixheight, clc_legend.label_specific
	   ORDER BY values_area.value;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.burntarea_fireid_clc(integer)
  OWNER TO postgres;


-- Function: effis.fires_by_adm3(integer)

DROP FUNCTION effis.fires_by_adm3(integer);

CREATE OR REPLACE FUNCTION effis.fires_by_adm3(IN code integer)
  RETURNS TABLE(name_adm3 character varying, f_id integer, firedate character varying, update character varying, area_ha integer) AS
$BODY$
BEGIN
   RETURN QUERY
      SELECT c.name_en,a.fire_id,b.firedate,b.lastupdate,b.area_ha
      FROM mm.ca_adm3 a
         LEFT JOIN effis.current_burntareaspoly b ON(a.fire_id = b.id)
         LEFT JOIN effis.adm3 c ON(a.adm3_id = c.id)
       WHERE a.adm3_id= code;
     
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.fires_by_adm3(integer)
  OWNER TO postgres;

