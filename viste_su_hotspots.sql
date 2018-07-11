SELECT a0.id,a0.name_en,a1.id,a1.country_id,a1.name_en
FROM public.admin_level_0 a0, public.admin_level_1 a1
WHERE a1.country_id = a0.id
ORDER BY a0.name_en;

--Select points.*, polygons.* from points 
--inner join polygons on
--st_intersects(points.geom,polygons.geom);

DROP VIEW hs_province_albania;

CREATE VIEW rdaprd.hs_province_albania AS 
	SELECT hs.id AS hs_id, hs.hs_date, a0.name_en AS country_name, a0.iso, a1.name_en AS province_name,a1.name_local, a1.id AS a1_id,hs.geom
	FROM rdaprd.filtered_modis_hotspots hs
	   INNER JOIN public.admin_level_1 a1 ON ST_Intersects(hs.geom,a1.geom)
	   INNER JOIN public.admin_level_0 a0 ON (a1.country_id = a0.id)
	WHERE a1.country_id = 5;

