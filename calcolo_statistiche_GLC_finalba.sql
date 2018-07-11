create materialized view final_ba_2001_clg as 
WITH
     -- feature of interest
     ba_area AS(SELECT ogc_fid As area_id, geom
	      FROM nasa_modis_ba.final_ba as b
	      WHERE b.initialdate between '2001-01-01' and '2001-12-31'),
     -- clip all bands to boundaries then get stats for these clipped regions
	  values_area AS(SELECT area_id, (stats).*,rastpixwidth,rastpixheight
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

