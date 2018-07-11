UPDATE fire AS f
SET country = p.id
FROM (
  SELECT DISTINCT ON (f_interno.fire_id)
    f_interno.fire_id, 
    p_interno.id
  FROM fire f_interno
   JOIN public.countries_adminsublevel1 p_interno ON ST_Intersects(f_interno.geom, p_interno.geom)
) p
WHERE p.id=f.fire_id;

SELECT DISTINCT ON (fire_inside.fire_id)
    fire_inside.fire_id, 
    poly_inside.id,
    poly_inside.name_local
FROM fire fire_inside
   JOIN public.countries_adminsublevel1 poly_inside ON ST_Intersects(fire_inside.geom, poly_inside.geom);
--WHERE poly_inside.name_local= 'Lazio';

SELECT DISTINCT ON (poly_inside.id)
    poly_inside.name_local,
    fire_inside.fire_id, 
    poly_inside.id    
FROM fire fire_inside
   JOIN public.countries_adminsublevel1 poly_inside ON ST_Intersects(fire_inside.geom, poly_inside.geom)
ORDER BY poly_inside.id;

SELECT DISTINCT ON (fire_inside.fire_id)
    poly_inside.name_local,
    fire_inside.fire_id, 
    poly_inside.id    
FROM fire fire_inside
   JOIN public.countries_adminsublevel1 poly_inside ON ST_Intersects(fire_inside.geom, poly_inside.geom)
ORDER BY fire_inside.fire_id,poly_inside.name_local;

SELECT DISTINCT ON (fire_inside.fire_id)
    poly_inside.name_local,
    fire_inside.fire_id, 
    poly_inside.id    
FROM fire fire_inside
   JOIN public.countries_adminsublevel1 poly_inside ON ST_Intersects(fire_inside.geom, poly_inside.geom)
ORDER BY fire_inside.fire_id,poly_inside.name_local;

SELECT poly.name_local, fire.fire_id, poly.id 
FROM public.countries_adminsublevel1 poly, public.fire fire 
WHERE ST_Within(fire.geom, poly.geom)
AND poly.name_local= 'Lazio';

SELECT poly_esterno.id,poly_esterno.name_local
FROM (
  SELECT DISTINCT ON (fire_interno.fire_id)
    fire_interno.fire_id, 
    poly_interno.name_local,
    poly_interno.id
  FROM fire fire_interno
   JOIN public.countries_adminsublevel1 poly_interno ON ST_Intersects(fire_interno.geom, poly_interno.geom);   
) poly_esterno
WHERE poly_esterno.name_local = 'Lazio';

UPDATE public.fire AS f
SET country =  (
  SELECT id
  FROM public.countries_country p
  WHERE ST_Intersects(f.geom, p.geom)
  ORDER BY ST_XMin(p.geom), ST_YMin(p.geom)
  LIMIT 1);

UPDATE public.fire AS f
SET region =  (
  SELECT id
  FROM public.countries_adminsublevel1 p
  WHERE ST_Intersects(f.geom, p.geom)
  ORDER BY ST_XMin(p.geom), ST_YMin(p.geom)
  LIMIT 1);

UPDATE public.fire AS f
SET province =  (
  SELECT id
  FROM public.countries_adminsublevel2 p
  WHERE ST_Intersects(f.geom, p.geom)
  ORDER BY ST_XMin(p.geom), ST_YMin(p.geom)
  LIMIT 1);

UPDATE public.fire AS f
SET commune =  (
  SELECT id
  FROM public.countries_adminsublevel3 p
  WHERE ST_Intersects(f.geom, p.geom)
  ORDER BY ST_XMin(p.geom), ST_YMin(p.geom)
  LIMIT 1);



