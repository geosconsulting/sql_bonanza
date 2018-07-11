--SELECT THE NEAREST FIRE TO THIS BURNT AREA
SELECT f.fire_id, f.updated, st_distance(f.geom::geography,b.geom::geography) AS nearest_fire_metres
FROM public.fire f, public.burnt_area b
WHERE b.id = 168213
AND st_dwithin(b.geom,f.geom, 0.01);

SELECT b.area_ha, b.broadlea, b.conifer FROM burnt_area b WHERE b.id = 168213;

SELECT f.fire_id, f.updated FROM fire f;