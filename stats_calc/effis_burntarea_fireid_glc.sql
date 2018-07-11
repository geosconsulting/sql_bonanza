-- Function: public.effis_burntarea_fireid_glc(integer)

DROP FUNCTION public.effis_burntarea_fireid_glc(integer);

CREATE OR REPLACE FUNCTION public.effis_burntarea_fireid_glc(IN fire_id integer)
  RETURNS TABLE(landcover_code double precision, landcover_description character varying, landcover_pixel bigint, landcover_percentage double precision) AS
$BODY$
DECLARE
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- feature of interest
     regione AS(SELECT id As area_id, geom
	      FROM public.burnt_area_only as b
	      WHERE b.id= fire_id),
     -- clip all bands to boundaries then get stats for these clipped regions
	  values_area AS(SELECT area_id, (stats).*,rastpixwidth,rastpixheight
	 	 FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS stats,
		       rid, ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		       FROM rst.glc_1x1k
		       INNER JOIN regione ON ST_Intersects(regione.geom, rast)) AS foo)
     -- finally summarize stats
	SELECT values_area.value as landcover,
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
ALTER FUNCTION public.effis_burntarea_fireid_glc(integer)
  OWNER TO postgres;
