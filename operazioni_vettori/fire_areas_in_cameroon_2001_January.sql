SELECT a.iso, a.name_en, f.idate,f.type,f.id,f.fdate
FROM public.countries_country a, modis_viirs."Fires_Europe_1_1_2001" f
WHERE a.iso='CMR'
AND f.type = 'FinalArea'
AND st_intersects(a.geom, f.geom);

SELECT DISTINCT name_en FROM public.countries_country ORDER BY name_en;

SELECT * FROM public.countries_country ORDER BY name_en;