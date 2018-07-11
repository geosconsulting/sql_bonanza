INSERT INTO public.fire(detected,updated) SELECT f.fire_id, b.id, b.firedate, b.lastupdate FROM public.burnt_area_spatial b LEFT JOIN public.fire f ON b.id = f.fire_id;
UPDATE fire SET detected = b.firedate::date, updated = b.lastupdate::date FROM public.burnt_area_spatial b , public.fire f WHERE b.id = f.fire_id;
UPDATE fire SET area = b.area_ha FROM public.burnt_area_spatial b , public.fire f WHERE b.id = f.fire_id;
SELECT f.fire_id,c.name_en FROM public.fire f, public.countries_adminsublevel2 c WHERE ST_Intersects(f.geom,c.geom);
SELECT f.fire_id,c.name_en FROM public.fire f, public.countries_adminsublevel2 c WHERE ST_Intersects(f.geom,c.geom);
UPDATE fire SET country = (SELECT DISTINCT c.name_en FROM public.fire f, public.countries_country c WHERE ST_Intersects(f.geom,c.geom));
SELECT DISTINCT ON(f.fire_id) f.fire_id, c.name_local FROM public.fire f, public.countries_adminsublevel2 c WHERE ST_Intersects(f.geom,c.geom);
UPDATE fire SET country = (SELECT DISTINCT ON(f.fire_id) c.name_local FROM public.fire f, public.countries_adminsublevel2 c WHERE ST_Intersects(f.geom,c.geom));

---ESEMPIO
---ESEMPIO
---ESEMPIO
UPDATE point_table AS A
SET tile = B.tile_name
FROM (
  SELECT DISTINCT ON (p.id)
    p.id, g.tile_name
  FROM point_table p
  JOIN "5km_grid_polygons" g ON ST_Intersects(p.geom, g.geom)
  ORDER BY p.id, ST_XMin(g.geom) DESC, ST_YMin(g.geom) DESC
) B
WHERE B.id=A.id;
---ESEMPIO
---ESEMPIO
---ESEMPIO

UPDATE fire AS f
SET country = p.id
FROM (
  SELECT DISTINCT ON (f_interno.fire_id)
    f_interno.fire_id, 
    p_interno.id
  FROM fire f_interno
  	JOIN public.countries_country p_interno ON ST_Intersects(f_interno.geom, p_interno.geom)
) p
WHERE p.id=f.fire_id;

ALTER TABLE public.fire ALTER COLUMN country TYPE character varying(255);

effis=# UPDATE fire AS f
SET region = p.name_en
FROM (
  SELECT DISTINCT ON (f_interno.fire_id)
    f_interno.fire_id, 
    p_interno.name_en
  FROM fire f_interno
   JOIN public.countries_adminsublevel1 p_interno ON ST_Intersects(f_interno.geom, p_interno.geom)
) p
WHERE p.id=f.fire_id;


effis=# UPDATE fire AS f
SET province = p.name_en
FROM (
  SELECT DISTINCT ON (f_interno.fire_id)
    f_interno.fire_id, 
    p_interno.name_en
  FROM fire f_interno
   JOIN public.countries_adminsublevel2 p_interno ON ST_Intersects(f_interno.geom, p_interno.geom)
) p
WHERE p.id=f.fire_id;

effis=# UPDATE fire AS f
SET commune = p.name_en
FROM (
  SELECT DISTINCT ON (f_interno.fire_id)
    f_interno.fire_id, 
    p_interno.name_en
  FROM fire f_interno
   JOIN public.countries_adminsublevel3 p_interno ON ST_Intersects(f_interno.geom, p_interno.geom)
) p
WHERE p.id=f.fire_id;