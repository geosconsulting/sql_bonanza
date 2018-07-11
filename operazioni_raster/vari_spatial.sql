WITH
-- feature of interest
    feat AS (SELECT id, geom 
		     FROM public.gadm28_adm2 as b
             WHERE b.iso='CMR'
			 AND b.name_1 = 'Centre'
			 AND b.objectid =  10910
             ),
--clip all bands to boundaries
-- then get stats for these clipped regions
     b_stats AS(SELECT id, (stats).*
				FROM (SELECT id, ST_SummaryStats(ST_Clip(rast,1,geom)) AS stats
				FROM public.globcov1000x1000
				INNER JOIN feat
				ON ST_Intersects(feat.geom,rast)) AS foo)
-- finally summarize stats
SELECT id,
       SUM(count) as num_pixels,
	   MIN(min) as min_pval,
	   MAX(max) as max_pval,
	   SUM(mean*count)/SUM(count) AS avg_pval
FROM b_stats
WHERE count>0
	GROUP BY id
	ORDER BY id;



--CREATE TABLE poly_stat AS 
SELECT * 
FROM public.gadm28_adm2 as b
WHERE b.iso='CMR'
AND b.name_1 = 'Centre'
AND b.objectid =  10910;

--globcov1000x1000 r
--poly_stat p

-- SOLO INTERSEZIONE RASTER POLIGONO
SELECT 
    r.rast 
FROM
    public.globcov1000x1000 as r, 
    public.poly_stat as p
WHERE
    ST_Intersects(r.rast, p.geom);	

SELECT ST_SummaryStats(rast) FROM public.globcov1000x1000;
	
SELECT ST_SummaryStats(r.rast) As result
FROM
	public.globcov1000x1000 as r, 
	public.poly_stat as p
WHERE ST_Intersects(r.rast, p.geom); 

-- INTERSEZIONE E SOMME TRA RASTER POLIGONO	
SELECT  
	(result).count,
    (result).sum    
FROM (  
    SELECT ST_SummaryStats(r.rast) As result
	FROM
		globcov1000x1000 as r, 
		poly_stat as p
	WHERE
            ST_Intersects(r.rast, p.geom)    
    ) As tmp;
	
SELECT
        (gv).geom,         
        (gv).val
 FROM 
 (
    SELECT 
        ST_Intersection(r.rast, p.geom) AS gv
    FROM 
        public.globcov1000x1000 as r, 
		poly_stat as p         
    WHERE 
        ST_Intersects(r.rast, p.geom)

      ) as foo;
	  

CREATE TABLE modis_cameroon AS 	  
SELECT        
       "gadm28_adm0"."iso",
       "gadm28_adm0"."name_engli",
       "MODIS_C6_Global_7d"."id",
       "MODIS_C6_Global_7d"."geom",
       "MODIS_C6_Global_7d"."acq_date",
       "MODIS_C6_Global_7d"."acq_time",
       "MODIS_C6_Global_7d"."satellite",
       "MODIS_C6_Global_7d"."version",
       "MODIS_C6_Global_7d"."bright_t31",
       "MODIS_C6_Global_7d"."frp",
       "MODIS_C6_Global_7d"."daynight",
       row_number() OVER () AS "ogc_fid"
FROM "public"."gadm28_adm0"
INNER JOIN "public"."MODIS_C6_Global_7d" ON ST_Contains("gadm28_adm0".geom,"MODIS_C6_Global_7d".geom)
WHERE "gadm28_adm0"."name_iso" = 'CAMEROON';

CREATE TABLE modis_cameroon_buffers AS 
SELECT id, ST_Buffer(geom,0.5) AS geom
FROM modis_cameroon;

CREATE TABLE modis_cameroon_buffers_stats AS
SELECT id, 
        (ST_Intersection(rast, geom)).geom AS the_geom, 
        (ST_Intersection(rast, geom)).val
FROM modis_cameroon_buffers, 
      globcov1000x1000
WHERE ST_Intersects(rast, geom);