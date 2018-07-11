WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom 
	      FROM public.countries_adminsublevel1  as b 
	      WHERE b.name_local= 'Kogi'),
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
       INNER JOIN glc_legend ON glc_legend.value = values_area.value
WHERE count > 0
   GROUP BY area_id, values_area.value, rastpixwidth, rastpixheight, glc_legend.value, glc_legend.label
   ORDER BY values_area.value;


-- FUNZIONE MOLTO COMPLESSA PER CALCOLO LANDCOVER IN AREA INCENDIATA
DROP FUNCTION landcover_adm3(VARCHAR);

CREATE OR REPLACE FUNCTION landcover_adm3(adm_name VARCHAR) 
 RETURNS TABLE (
	 landcover_code FLOAT,
	 landcover_description VARCHAR,
	 landcover_pixel BIGINT,
	 landcover_percentage FLOAT 
) 
AS $$
DECLARE 
    var_r record;
BEGIN
   RETURN QUERY 
     WITH
     -- feature of interest
     regione AS(SELECT id As area_id, geom 
	      FROM public.countries_adminsublevel1  as b 
	      WHERE b.name_local= adm_name),
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
	       INNER JOIN glc_legend ON glc_legend.value = values_area.value
	WHERE count > 0
	   GROUP BY area_id, values_area.value, rastpixwidth, rastpixheight, glc_legend.value, glc_legend.label
	   ORDER BY values_area.value;
END; $$  
LANGUAGE 'plpgsql';

SELECT * FROM landcover_adm3('Sicily');

-- QUESTA FUNZIONA SOPRA MOLTO COMPLESSA LA QUERY SPATIAL
CREATE OR REPLACE FUNCTION names_amd3(adm_name VARCHAR) 
 RETURNS TABLE (
	name_iso VARCHAR,
	name_local VARCHAR	 
) 
AS $$
BEGIN
 RETURN QUERY SELECT
	cnt.name_iso, adm1.name_local 
	FROM countries_adminsublevel1 adm1 
	RIGHT JOIN countries_country cnt ON adm1.country_id = cnt.id 
	WHERE adm1.name_local LIKE adm_name;
END; $$  
LANGUAGE 'plpgsql';
SELECT * FROM names_amd3('Lazio');