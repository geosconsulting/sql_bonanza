DROP MATERIALIZED VIEW raster_ops.places_4258;
CREATE MATERIALIZED VIEW raster_ops.places_4258 AS 
 SELECT place, ST_Transform(geom, 4258) AS geom
   FROM raster_ops.places;

--select UpdateGeometrySRID('Schema Name', 'mytable', 'the_geom', newSRID) ;
SELECT UpdateGeometrySRID('raster_ops','places','geom',4326);
SELECT UpdateGeometrySRID('raster_ops','denver_poly_tbl','geom',4326);
SELECT UpdateRasterSRID('raster_ops','dem_denver','rast',4326);

SELECT rid, (foo.md).*
 FROM (SELECT rid, ST_MetaData(rast) As md
FROM raster_ops.dem_denver
WHERE rid=4) As foo;
