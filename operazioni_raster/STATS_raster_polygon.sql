SELECT id AS area_id, ST_AsText(geom)
FROM public.countries_adminsublevel1
WHERE name_local = 'Lazio';

SELECT ST_Band(rast,1) FROM rst.glc_1x1k WHERE rid IN (10,25,60);

SELECT PostGIS_Full_Version();

SELECT b.id,(ST_SummaryStats(a.rast, 1, true)).count
FROM rst.glc_1x1k AS a, public.countries_adminsublevel1 as b
WHERE ST_Intersects(b.geom,a.rast)
AND b.name_local = 'Lazio'
GROUP BY a.rid,b.id;


SELECT COUNT(f1.geom) as "Fires 2001" --, COUNT(f2.geom) as "Fires 2002"
FROM public.countries_country  a, modis_viirs.fires_1_1_2001 f1 --, public."Fires_Europe_1_1_2002" f2
WHERE a.iso='CMR'
AND ST_Within(f1.geom,a.geom);
--OR ST_Within(f2.geom,a.geom);
--GROUP BY f1.idate,f2.idate;

SELECT f2.gid,f2.idate,f2.fdate,f2.type as "Fires 2002"
FROM public.countries_country a, modis_viirs.fires_1_1_2002 f2
WHERE a.iso='CMR'
AND ST_Within(f2.geom,a.geom);

SELECT cnt.name_iso, adm1.name_local 
FROM countries_adminsublevel1 adm1 
RIGHT JOIN countries_country cnt ON adm1.country_id = cnt.id 
WHERE adm1.name_local LIKE 'Centre';

SELECT cnt.name_iso, adm1.name_local 
FROM countries_adminsublevel1 adm1 
RIGHT JOIN countries_country cnt 
ON adm1.country_id = cnt.id 
WHERE adm1.name_local LIKE 'Centre' 
AND cnt.iso = 'CMR';

SELECT COUNT(f.geom) as "Fires 2001"
FROM public.countries_country a, countries_adminsublevel1 b, modis_viirs.fires_1_1_2001 f 
WHERE a.iso= 'CMR'
AND b.name_local = 'Centre'
AND ST_Within(f.geom,b.geom);


SELECT SUM(ST_Area(f.geom))*1000 as "Area of Fires in 2001 in Cameroon Centre"
FROM public.countries_country a, countries_adminsublevel1 b, modis_viirs.fires_1_1_2001 f 
WHERE a.iso= 'CMR'
AND b.name_local = 'Centre'
AND ST_Contains(b.geom,f.geom);


SELECT f.gid,f.idate,f.fdate,f."type"
FROM public.countries_country a, countries_adminsublevel1 b, modis_viirs.fires_1_1_2001 f 
WHERE a.iso= 'CMR'
AND b.name_local = 'Centre'
AND ST_Intersects(b.geom,f.geom);

SELECT f.id, f.idate, f.fdate, a.name_en as name_0, b.name_en as name_1
FROM public.countries_country a, countries_adminsublevel1 b, modis_viirs.fires_1_1_2001 f 
WHERE a.iso= 'CMR'
AND b.name_local = 'Centre'
AND ST_Within(f.geom,b.geom);

SELECT f.id, f.idate, f.fdate, a.name_en as name_0, b.name_en as name_1, ST_AsKML(f.geom)
FROM public.countries_country a, countries_adminsublevel1 b, modis_viirs.fires_1_1_2001 f 
WHERE a.iso= 'CMR'
AND b.name_local = 'Centre'
AND ST_Within(f.geom,b.geom);

--MOLTO LUNGA EVITARE QUERY SPATIAL DOPPIE
SELECT COUNT(f1.geom) as "Fires 2001", COUNT(f1.geom) as "Fires 2002"
FROM public.countries_adminsublevel1 a, modis_viirs.fires_1_1_2001 f1 , modis_viirs.fires_1_1_2002 f2
WHERE a.name_en = 'Centre'
AND ST_Within(f1.geom,a.geom)
OR ST_Within(f2.geom,a.geom);
--MOLTO LUNGA EVITARE QUERY SPATIAL DOPPIE

SELECT *
FROM public.countries_country c, public.countries_adminsublevel1 a1
WHERE a1.name_en = 'Centre'
--AND a1.country_id = c.id ;
AND c.name_en = 'Cameroon';

SELECT ST_Clip(rast,
	ST_Buffer(ST_Centroid(ST_Envelope(rast)), 20),
	false
	) 
FROM rst.glc_1x1k
WHERE rid = 4;

SELECT ST_Intersects(clipper.geom, raster.rast)
FROM (SELECT *
      FROM public.countries_country as c
      WHERE c.iso = 'CMR') as clipper,
      rst.glc_1x1k as raster;

SELECT id As area_id, geom FROM public.countries_adminsublevel1  as b WHERE b.name_en='Kogi';

-- METADATA OF RASTER FILE
SELECT (md).*, (bmd).* 
FROM (SELECT ST_Metadata(rast) AS md, 
             ST_BandMetadata(rast) AS bmd 
      FROM rst.glc_1x1k  LIMIT 1
     ) foo;

SELECT rid, ST_AsText(rast::geometry) FROM rst.glc_1x1k;
SELECT ST_AsText(ST_Buffer(ST_Union(rast::geometry), 0.000001)) FROM rst.glc_1x1k;

--SET postgis.enable_outdb_rasters TO True;
--SET postgis.enable_outdb_rasters = default;
--SET postgis.enable_outdb_rasters = True;
--SET postgis.enable_outdb_rasters = False;

SHOW data_directory;
SHOW all;

-- ERROR:  rt_band_load_offline_data: Cannot open offline raster: GLOBCOVER_L4_200901_200912_V2.3.tif
SELECT ST_AsBinary((ST_DumpAsPolygons(rast)).geom), 
      (ST_DumpAsPolygons(rast)).val
FROM rst.glc_1x1k
WHERE rid=3966;

/* WORKS!!!!!! raster FILE managed internally by postgis */
WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom FROM public.countries_adminsublevel1  as b WHERE b.name_local= 'Kogi'),
-- clip all bands to boundaries
-- then get stats for these clipped regions
   b_stats AS(SELECT area_id, (stats).*
	      FROM (SELECT area_id, ST_SummaryStats(ST_Clip(rast, geom)) AS stats
		    FROM rst.glc_1x1k 
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
      FROM rst.glc_1x1k  --CROSS JOIN generate_series(1,3) As band
      WHERE rid=2) As foo;

/* WORKS!!!!!! raster FILE managed internally by postgis */
/* MOLTO IMPORTANTE */
WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom 
	      FROM public.countries_adminsublevel1  as b 
	      WHERE b.name_local= 'Kogi'),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT area_id, (values).*
		 FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS values
		       FROM rst.glc_1x1k 
		       INNER JOIN regione
		       ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT value as landcover,
       SUM(count) as num_pixels	 
       FROM values_area
WHERE count > 0
   GROUP BY value
   ORDER BY value;

SELECT (lndcv).value, SUM((lndcv).count) AS total
FROM (SELECT ST_ValueCount(rast, 1) as lndcv
      FROM rst.glc_1x1k 
      WHERE ST_Intersects(rast, ST_GeomFromText('POLYGON((5.25 8.80,8.50 8.80,8.50 6.60,5.25 6.60,5.25 8.80))',4326)
             ) 
        ) As foo
GROUP BY (lndcv).value
HAVING SUM((lndcv).count) > 0
ORDER BY (lndcv).value;

WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom 
	      FROM public.countries_adminsublevel1  as b 
	      WHERE b.name_local= 'Kogi'),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT area_id, (values).*
		 FROM (SELECT area_id, ST_SummaryStats(rast) AS values
		       FROM rst.glc_1x1k 
		       INNER JOIN regione
		       ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT * FROM values_area;

/* WORKS!!!!!! raster FILE managed internally  */
WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom FROM modis_viirs.fires_1_1_2001 as b 
   WHERE b.id= '293890'),
-- clip all bands to boundaries
-- then get stats for these clipped regions
   b_stats AS(SELECT area_id, (stats).*
	      FROM (SELECT area_id, ST_SummaryStats(ST_Clip(rast, geom)) AS stats
		    FROM rst.glc_1x1k 
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
   regione AS(SELECT id As area_id, geom FROM modis_viirs.fires_1_1_2001 as b 
   WHERE b.id= '293890'),
-- clip all bands to boundaries
-- then get stats for these clipped regions
   b_stats AS(SELECT area_id, (stats).*
	      FROM (SELECT area_id, ST_SummaryStats(ST_Clip(rast, geom)) AS stats
		    FROM rst.glc_1x1k 
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
	      FROM modis_viirs.fires_1_1_2001 as b 
	      WHERE b.id= '293890'),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT area_id, (values).*
		 FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS values
		       FROM rst.glc_1x1k 
		       INNER JOIN regione
		       ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT value as landcover,
       SUM(count) as num_pixels	        
       FROM values_area
WHERE count > 0
   GROUP BY value
   ORDER BY value;

SELECT ST_Width(rast) As rastwidth, ST_PixelWidth(rast) As pixwidth,
	ST_ScaleX(rast) As scalex, ST_ScaleY(rast) As scaley, ST_SkewX(rast) As skewx,
	ST_SkewY(rast) As skewy
	FROM rst.glc_1x1k ;

-- CALCOLO AREA
SELECT rid, ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
FROM rst.glc_1x1k
WHERE rid = 1;

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
		       INNER JOIN regione
		       ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT value as landcover,       
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
	      FROM public.countries_adminsublevel1  as b 
	      WHERE b.name_local= 'Kogi'),
-- clip all bands to boundaries then get stats for these clipped regions
   values_area AS(SELECT area_id, (stats).*,rastpixwidth,rastpixheight
		 FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS stats,
		       rid, ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		       FROM rst.glc_1x1k 
		       INNER JOIN regione
		       ON ST_Intersects(regione.geom, rast)) AS foo)
-- finally summarize stats
SELECT value as landcover,       
       SUM(count) as num_pixels,       
       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
       FROM values_area
WHERE count > 0
   GROUP BY area_id,value,rastpixwidth,rastpixheight
   ORDER BY value;

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
       glc_legend.value as check_legend,
       glc_legend.label,
       SUM(count) as num_pixels,       
       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
       FROM values_area
       INNER JOIN rst.glc_legend ON glc_legend.value = values_area.value
WHERE count > 0
   GROUP BY area_id, values_area.value, rastpixwidth, rastpixheight, glc_legend.value, glc_legend.label
   ORDER BY values_area.value;

SELECT id As area_id,name_en, name_local,country_id
FROM public.countries_adminsublevel1  as b 
WHERE b.name_local LIKE 'L%'
AND country_id = 'IT';

SELECT id As area_id,name_en, name_local
FROM public.countries_country  
WHERE name_en LIKE 'It%';

SELECT l0.id, l0.name_en, l0.name_local, l1.country_id,l1.name_local,l1.name_en
FROM countries_adminsublevel1 l1,countries_country l0
WHERE l0.id = l1.country_id
AND l0.name_en LIKE 'Fran%';

WITH
-- feature of interest
   regione AS(SELECT id As area_id, geom 
	      FROM public.countries_adminsublevel1  as b 
	      WHERE b.name_local= 'Comunidad de Madrid'),
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
       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
       FROM values_area
       INNER JOIN rst.glc_legend ON rst.glc_legend.value = values_area.value
WHERE count > 0
   GROUP BY values_area.value, rastpixwidth, rastpixheight, glc_legend.value, glc_legend.label
   ORDER BY num_pixels;