SELECT DISTINCT(countryful),
       ROUND(AVG(broadlea) OVER(PARTITION BY countryful),2) AS "Broadleaf",
       ROUND(AVG(conifer) OVER(PARTITION BY countryful),2) AS "Conifer",
       ROUND(AVG(mixed) OVER(PARTITION BY countryful),2) AS "Mixed"
FROM burnt_area_spatial s,burnt_area_location l, burnt_area_landcover c
WHERE s.id = l.id
AND s.id = c.id
ORDER BY countryful;

SELECT DISTINCT(countryful),
       AVG(broadlea),
       AVG(conifer),
       AVG(mixed) 
FROM burnt_area_spatial s,burnt_area_location l, burnt_area_landcover c
WHERE s.id = l.id
AND s.id = c.id
GROUP BY countryful