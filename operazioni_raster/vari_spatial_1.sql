SELECT * FROM geometry_columns;

SELECT UpdateGeometrySRID('modis_cameroon_buffers','geom',4326)

SELECT ST_GeometryType(geom),ST_NDims(geom),ST_SRID(geom) FROM modis_cameroon;

SELECT id_1 as area_id,ST_Area(geom) 
FROM public.gadm28_adm1 as a
WHERE a.iso='ITA'
AND a.name_1 = 'Lazio';

SELECT ST_AsGeoJSON(geom)
FROM public.gadm28_adm1 as a
WHERE a.iso='ITA'
AND a.name_1 = 'Lazio';

SELECT ST_NumGeometries(geom)
FROM public.gadm28_adm1 as a
WHERE a.iso='ITA'
AND a.name_1 = 'Lazio';

SELECT ST_AsText(geom)
FROM public.gadm28_adm1 as a
WHERE a.iso='ITA'
AND a.name_1 = 'Lazio';

SELECT viirs.id, viirs.acq_date
FROM public."VNP14IMGTDL_NRT_Global_7d" as viirs
JOIN  public.gadm28_adm1 as admin
ON ST_Contains(admin.geom, viirs.geom)
WHERE admin.iso = 'COD';

SELECT COUNT(viirs.id)
FROM public."VNP14IMGTDL_NRT_Global_7d" as viirs
JOIN  public.gadm28_adm1 as admin
ON ST_Contains(admin.geom, viirs.geom)
WHERE admin.iso = 'SOM';

SELECT SUM(bright_ti5)/COUNT(viirs.id),SUM(frp)
FROM public."VNP14IMGTDL_NRT_Global_7d" as viirs
JOIN  public.gadm28_adm1 as admin
ON ST_Contains(admin.geom, viirs.geom)
WHERE admin.iso = 'KEN';
--GROUP BY viirs.bright_ti5;

SELECT ST_AsGeoJSON(ST_SimplifyPreserveTopology(geom,.01)) AS geom
FROM public.gadm28_adm1 as a
WHERE a.iso='ITA'
AND a.name_1 = 'Lazio';

