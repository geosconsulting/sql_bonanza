SELECT --ST_AsText(ba.geom), 
       ba.id as "Fire ID", 
       firedate as "Fire Date", 
       lc.conifer as "Conifer", 
       lc.broadlea as "Broad Leaf", 
       lc.mixed as "Mixed"
FROM public.burnt_area_spatial ba, public.burnt_area_landcover lc, public.countries_adminsublevel3 cnt
WHERE cnt.name_en='Veroli'
AND ba.id = lc.id
AND ST_Within(ba.geom, cnt.geom);

WITH
-- feature of interest
   regione AS(SELECT ba.id,cnt.geom
	      FROM public.burnt_area_spatial ba, public.countries_adminsublevel3 cnt
	      WHERE cnt.name_en='Veroli'
	      AND ST_Within(ba.geom, cnt.geom)),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT (stats).*,rastpixwidth,rastpixheight
		 FROM (SELECT ST_ValueCount(ST_Clip(rast, geom)) AS stats,
			      rid, 
		              ST_ScaleX(rast) As rastpixwidth, 
		              ST_ScaleY(rast) As rastpixheight
		       FROM rst.glc_1x1k 
		          INNER JOIN regione ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT values_area.value as landcover,        
       glc_legend.label,
       SUM(count) as num_pixels, 
       rastpixwidth,
       rastpixheight,      
       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
       FROM values_area
       INNER JOIN rst.glc_legend ON rst.glc_legend.value = values_area.value
WHERE count > 0
   GROUP BY values_area.value, rastpixwidth, rastpixheight, glc_legend.value, glc_legend.label
   ORDER BY num_pixels;

WITH
-- feature of interest
   regione AS(SELECT ba.id,
	      ST_Transform(cnt.geom,3035) as geom
	      FROM public.burnt_area_spatial ba, public.countries_adminsublevel3 cnt
	      WHERE cnt.name_en='Veroli'
	      AND ST_Within(ba.geom, cnt.geom)),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT (stats).*, rastpixwidth, rastpixheight
		 FROM (SELECT ST_ValueCount(ST_Clip(rast, geom)) AS stats,
			      rid, 
		              ST_ScaleX(rast) As rastpixwidth, 
		              ST_ScaleY(rast) As rastpixheight
		       FROM rst.clc_1x1k 
		          INNER JOIN regione ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT values_area.value as landcover,        
       clc_legend.label_specific,       
       SUM(count) as num_pixels, 
       rastpixwidth,
       rastpixheight,      
       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
       FROM values_area
       INNER JOIN rst.clc_legend ON rst.clc_legend.grid_code = values_area.value
WHERE count > 0
   GROUP BY values_area.value, rastpixwidth, rastpixheight, clc_legend.grid_code, clc_legend.label_specific
   ORDER BY num_pixels;