ALTER TABLE effis.burnt_area_spatial 
ALTER COLUMN geom type geometry(MultiPolygon, 4326)
USING ST_Multi(geom);