SELECT UpdateGeometrySRID(vct.poly_stats,'geom',4258);
--COME 
ALTER TABLE vct.poly_stats
  ALTER COLUMN geom TYPE geometry(Polygon, 4258)
    USING ST_SetSRID(geom,4258);

ALTER TABLE vct.poly_stats ALTER COLUMN geom type geometry(Polygon, 4258);

SELECT ST_Intersects(clipper.geom, raster.rast)
FROM (SELECT *
      FROM vct.poly_stats as p
      WHERE p.name = 'test1') as clipper,
raster_ops.clip as raster;

-- METADATA OF RASTER FILE
SELECT (md).*, (bmd).* 
FROM (SELECT ST_Metadata(rast) AS md, 
             ST_BandMetadata(rast) AS bmd 
      FROM raster_ops.clip  LIMIT 1
     ) foo;

SELECT rid, ST_AsText(rast::geometry) FROM raster_ops.clip;
SELECT ST_AsText(ST_Buffer(ST_Union(rast::geometry), 0.000001)) FROM raster_ops.clip;

--SET postgis.enable_outdb_rasters TO True;
--SET postgis.enable_outdb_rasters = default;
--SET postgis.enable_outdb_rasters = True;
--SET postgis.enable_outdb_rasters = False;

SHOW data_directory;
SHOW all;

-- FUNZIONA
SELECT ST_AsBinary((ST_DumpAsPolygons(rast)).geom), 
      (ST_DumpAsPolygons(rast)).val
FROM raster_ops.clip
WHERE rid=1;

WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom FROM vct.poly_stats  as b WHERE b.name= 'test1'),
-- clip all bands to boundaries
-- then get stats for these clipped regions
   b_stats AS(SELECT area_id, (stats).*
	      FROM (SELECT area_id, ST_SummaryStats(ST_Clip(rast, geom)) AS stats
		    FROM raster_ops.clip 
		    INNER JOIN regione
		    ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT area_id,
	SUM(count) as num_pixels,
	MIN(min) as min_pval,
	MAX(max) as max_pval,	
	SUM(mean*count)/SUM(count) AS avg_pval
	FROM b_stats
WHERE count > 0
	GROUP BY area_id
	ORDER BY area_id;

SELECT rid, (stats).*
FROM (SELECT rid, ST_SummaryStats(rast) As stats
      FROM raster_ops.clip  --CROSS JOIN generate_series(1,3) As band
      WHERE rid=2) As foo;

/* MOLTO IMPORTANTE */
WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom 
	      FROM vct.poly_stats  as b 
	      WHERE b.name = 'test2'),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT area_id, (values).*
		 FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS values
		       FROM raster_ops.clip 
		       INNER JOIN regione
		       ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT value as landcover,
       SUM(count) as num_pixels	 
       FROM values_area
WHERE count > 0
   GROUP BY value
   ORDER BY value;

SELECT (dem).value, SUM((dem).count) AS total
FROM (SELECT ST_ValueCount(rast, 1) as dem
      FROM raster_ops.clip 
      WHERE ST_Intersects(rast, ST_GeomFromText('POLYGON((18.8468223121908 49.6000598290598,18.8871596941071 49.6003243364822,18.9117588843905 49.5958277103014,
	 18.9084525416105 49.5853796671165,18.8984012595592 49.5701704903284,18.8821340530814 49.5647480881691,
	 18.8526414754836 49.5696414754836,18.8412676563203 49.5804862798021,18.8412676563203 49.590934322987,
	 18.8468223121908 49.6000598290598))',4258)
             ) 
        ) As foo
GROUP BY (dem).value
HAVING SUM((dem).count) > 0
ORDER BY (dem).value;

SELECT 
    id,
    name,
    Min((gv).val) As MinELEV,
    Max((gv).val) As MaxELEV
FROM (
    SELECT 
        id,
        name,
        ST_DumpAsPolygons(ST_Clip(rast, 1, geom, true)) AS gv
    FROM vct.poly_stats,raster_ops.clip 
        WHERE ST_Intersects(rast, geom)) AS foo 
            GROUP BY id,name
            ORDER BY id;

WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom 
	      FROM vct.poly_stats  as b 
	      WHERE b.name= 'test1'),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT area_id, (values).*
		 FROM (SELECT area_id, ST_SummaryStats(rast) AS values
		       FROM raster_ops.clip 
		       INNER JOIN regione
		       ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT * FROM values_area;

/* WORKS!!!!!! raster FILE managed internally  */
WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom FROM vct.poly_stats as b WHERE b.id= '1'),
-- clip all bands to boundaries
-- then get stats for these clipped regions
   b_stats AS(SELECT area_id, (stats).*
	      FROM (SELECT area_id, ST_SummaryStats(ST_Clip(rast, geom)) AS stats
		    FROM raster_ops.clip
		    INNER JOIN regione
		    ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT area_id,
	SUM(count) as num_pixels,
	MIN(min) as min_pval,
	MAX(max) as max_pval,	
	SUM(mean*count)/SUM(count) AS avg_pval
	FROM b_stats
WHERE count > 0
	GROUP BY area_id
	ORDER BY area_id;

--COME SOPRA MA CON CALCOLO PARALLELO
SET max_parallel_workers_per_gather = 8;

WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom FROM vct.poly_stats as b WHERE b.id= '1'),
-- clip all bands to boundaries
-- then get stats for these clipped regions
   b_stats AS(SELECT area_id, (stats).*
	      FROM (SELECT area_id, ST_SummaryStats(ST_Clip(rast, geom)) AS stats
		    FROM raster_ops.clip
		    INNER JOIN regione
		    ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT area_id,
	SUM(count) as num_pixels,
	MIN(min) as min_pval,
	MAX(max) as max_pval,	
	SUM(mean*count)/SUM(count) AS avg_pval
	FROM b_stats
WHERE count > 0
	GROUP BY area_id
	ORDER BY area_id;
	
WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom 
	      FROM vct.poly_stats as b 
	      WHERE b.id= '2'),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT area_id, (values).*
		 FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS values
		       FROM raster_ops.clip 
		       INNER JOIN regione
		       ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT value as height,
       SUM(count) as num_pixels	        
       FROM values_area
WHERE count > 0
   GROUP BY value
   ORDER BY value;

SELECT ST_Width(rast) As rastwidth, ST_PixelWidth(rast) As pixwidth,
	ST_ScaleX(rast) As scalex, 
	ST_ScaleY(rast) As scaley, 
	ST_SkewX(rast) As skewx,
	ST_SkewY(rast) As skewy
	FROM raster_ops.dem;

-- CALCOLO AREA
SELECT rid, 
       ST_ScaleX(rast) As rastpixwidth, 
       ST_ScaleY(rast) As rastpixheight
FROM raster_ops.dem
WHERE rid = 1;

WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom 
	      FROM vct.poly_stats  as b 
	      WHERE b.name= 'test2'),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT area_id, (stats).*,rastpixwidth,rastpixheight
		 FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS stats,
		       rid, ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		       FROM raster_ops.dem 
		       INNER JOIN regione
		       ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT value as height,       
       SUM(count) as num_pixels,
       --rastpixwidth,
       --rastpixheight,
       SUM(count) * rastpixwidth * rastpixheight as area_pixels
       FROM values_area
WHERE count > 0
   GROUP BY area_id,value,rastpixwidth,rastpixheight
   ORDER BY value;

WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom 
	      FROM vct.poly_stats as b 
	      WHERE b.name = 'test1'),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT area_id, (stats).*,rastpixwidth,rastpixheight
		 FROM (SELECT area_id, 
                              ST_ValueCount(ST_Clip(rast, geom)) AS stats,
		              rid, 
		              ST_ScaleX(rast) As rastpixwidth, 
		              ST_ScaleY(rast) As rastpixheight
		       FROM raster_ops.dem 
		               INNER JOIN regione ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT value as height, 
       SUM(count) as num_pixels       
       FROM values_area
WHERE count > 0
   GROUP BY area_id,value
   ORDER BY value;

WITH
-- feature of interest
   regioni AS(SELECT * FROM vct.poly_stats as b WHERE b.name LIKE 't%'),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT id, (count_stats).* --,(pvc).*
		  FROM (SELECT id, 
			       ST_ValueCount(ST_Clip(rast, geom)) AS count_stats,			       
		               rid --		              		              
		       FROM raster_ops.dem 
		           INNER JOIN regioni ON ST_Intersects(regioni.geom, rast)) AS foo)
-- finally summarize stats
SELECT regioni.id,
       regioni.name,     
       SUM(count) as num_pixels                
       FROM values_area, regioni
WHERE count > 0
   GROUP BY regioni.id,regioni.name --,values_area
   ORDER BY regioni.id;

SELECT rid, (ST_Quantile(rast,1)).* As pvc
    FROM raster_ops.clip 
        WHERE ST_Intersects(rast, 
                            ST_GeomFromText('POLYGON((18.8468223121908 49.6000598290598,18.8871596941071 49.6003243364822,18.9117588843905 49.5958277103014,
			              18.9084525416105 49.5853796671165,18.8984012595592 49.5701704903284,18.8821340530814 49.5647480881691,
	                              18.8526414754836 49.5696414754836,18.8412676563203 49.5804862798021,18.8412676563203 49.590934322987,
	                              18.8468223121908 49.6000598290598))',4258)
            )
ORDER BY value, quantile,rid;

WITH
-- feature of interest
   regione AS(SELECT id As area_id,name As area_name, geom 
	      FROM vct.poly_stats as b 
	      WHERE b.name = 'test2'),
   quantiles_area AS (SELECT (pvc).*
		      FROM (SELECT ST_Quantile(rast,1,ARRAY[0,0.25,0.33,0.5,0.66,0.75]) AS pvc	
		            FROM raster_ops.clip 
				INNER JOIN regione ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT 
       area_name,
       quantiles_area.quantile,
       quantiles_area.value                     
       FROM quantiles_area, regione
--WHERE count > 0
GROUP BY area_name,quantiles_area.quantile,quantiles_area.value
ORDER BY area_name,quantiles_area.quantile;