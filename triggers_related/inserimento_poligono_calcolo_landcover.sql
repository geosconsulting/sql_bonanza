CREATE OR REPLACE FUNCTION effis_calc_area()
RETURNS trigger AS
$BODY$
BEGIN
NEW.area_ha := ROUND((st_area(NEW.geom::geography)/10000)::numeric,2);
RETURN NEW;
END;
$BODY$
LANGUAGE plpgsql;

DROP TRIGGER effis_trgr_calc_area ON public.test_polys;

CREATE TRIGGER effis_trgr_calc_area BEFORE INSERT OR UPDATE ON public.test_polys
    FOR EACH ROW EXECUTE PROCEDURE effis_calc_area();

TRUNCATE public.test_polys;

--CALCOLO CON INDICE CLASSE LANDCOVER
WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom 
	      FROM public.burnt_area as b 
	      WHERE b.objectid= 366688),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT area_id, (stats).*,rastpixwidth,rastpixheight
		 FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS stats,
		       rid, ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		       FROM rst.glc_1x1k 
		       INNER JOIN regione ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT values_area.value as landcover_id,               
       SUM(count) as num_pixels,       
       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels    
       FROM values_area   
WHERE count > 0
   GROUP BY area_id, values_area.value, rastpixwidth, rastpixheight
   ORDER BY values_area.value;

--CALCOLO CON NOME CLASSE LANDCOVER
WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom 
	      FROM public.burnt_area as b 
	      WHERE b.objectid= 366673),
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

CREATE OR REPLACE FUNCTION effis_calculate_burnt_landcover()
RETURNS trigger AS $body$
    BEGIN
    IF GeometryType(NEW.geom) = 'POLYGON' THEN
        EXECUTE 'SELECT label FROM burnt_area WHERE ST_Within($1, burnt_area.geom) LIMIT 1'
        USING NEW.geom 
        INTO NEW.label_sample;
        RETURN NEW;    
    END IF;
    END;
$body$ LANGUAGE plpgsql;

CREATE TRIGGER tg_sample_label BEFORE INSERT OR UPDATE
ON fire FOR EACH ROW
EXECUTE PROCEDURE sample_label();