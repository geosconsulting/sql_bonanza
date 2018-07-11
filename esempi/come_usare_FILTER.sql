SELECT commune as "Commune Name",
       avg(broadlea) 
       FILTER (WHERE firedate BETWEEN '01-05-2017' AND '01-08-2017') as "Average Broadleaf"
FROM public.burnt_area
GROUP BY (commune)
ORDER BY(commune);

SELECT lower(province),
       percentile_disc(0.5) WITHIN GROUP (ORDER BY broadlea DESC NULLS LAST)
FROM public.burnt_area
GROUP BY(province)
ORDER BY(province);

SELECT lower(province),
       rank(10) WITHIN GROUP (ORDER BY broadlea)
FROM public.burnt_area
GROUP BY ROLLUP(1);

SELECT commune as "Commune Name",
       rank() OVER (ORDER BY avg(broadlea))
FROM public.burnt_area
GROUP BY commune;

SELECT commune as "Commune Name",
       dense_rank() OVER (ORDER BY avg(broadlea))
FROM public.burnt_area
GROUP BY commune;

-- NUOVE QUERIES

SELECT l.commune as "Commune Name",
       avg(c.broadlea) 
       FILTER (WHERE firedate BETWEEN '01-05-2017' AND '01-08-2017') as "Average Broadleaf"
FROM burnt_area_spatial s,burnt_area_location l, burnt_area_landcover c
GROUP BY (l.commune)
ORDER BY(l.commune);

SELECT lower(l.province),
       percentile_disc(0.5) WITHIN GROUP (ORDER BY broadlea DESC NULLS LAST)
FROM burnt_area_spatial s,burnt_area_location l, burnt_area_landcover c
GROUP BY(l.province)
ORDER BY(l.province);

SELECT lower(l.province),
       rank(10) WITHIN GROUP (ORDER BY c.broadlea)
FROM burnt_area_spatial s,burnt_area_location l, burnt_area_landcover c
GROUP BY ROLLUP(1);

SELECT commune as "Commune Name",
       rank() OVER (ORDER BY avg(broadlea))
FROM burnt_area_spatial s,burnt_area_location l, burnt_area_landcover c
GROUP BY commune;

SELECT l.commune as "Commune Name",
       dense_rank() OVER (ORDER BY avg(c.broadlea))
FROM burnt_area_spatial s,burnt_area_location l, burnt_area_landcover c
GROUP BY l.commune;