SELECT distinct(yearseason), 
       count(id) over w,
	   sum(area_ha) over w 
FROM rdaprd.rob_burntareas_history 
WHERE country = 'CY' 
WINDOW w as (PARTITION BY yearseason);

SELECT DISTINCT(yearseason), 
               country,
			   count(id) over w, 
			   sum(area_ha) over w 
FROM rdaprd.rob_burntareas_history 
WINDOW w as (PARTITION BY yearseason,country);

CREATE MATERIALIZED VIEW effis.num_fires_area_by_country_yearseason AS 
     SELECT DISTINCT(yearseason), 
	                 country, 
					 COUNT(id) OVER w AS "Numer of Fires", 
	                 SUM(area_ha) OVER w AS "Summed Hectares" 
	FROM rdaprd.rob_burntareas_history 
	WINDOW w AS (PARTITION BY yearseason,country);

SELECT * FROM effis.num_fires_area_by_country_yearseason WHERE country = 'IT';

SELECT DISTINCT(extract(year FROM hs_date)) AS anno, 
                iso2,
				count(id) OVER w AS "Nunmber of Hotspots" 
FROM effis.hotspots WINDOW w AS (PARTITION BY iso2);