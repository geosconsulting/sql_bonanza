SELECT foo."Nome Villaggio", (foo.geomval).val AS height
FROM (
   SELECT
	ST_Intersection(A.rast,g.geom) As geomval, g.name AS "Nome Villaggio"
   FROM raster_ops.clip AS A
	CROSS JOIN(
		SELECT geom, name FROM raster_ops.places WHERE type = 'village'
		) As g(geom,name)
	WHERE A.rid = 4) As foo;

SELECT * FROM raster_ops.clip WHERE rid = 4;

SELECT rid, (foo.md).*
 FROM (SELECT rid, ST_MetaData(rast) As md
FROM raster_ops.clip
WHERE rid=4) As foo;

SELECT
	ST_Intersection(A.rast,g.geom) As geomval, g.name AS "Nome Villaggio"
FROM raster_ops.clip AS A
	CROSS JOIN(
		SELECT geom, name FROM raster_ops.places WHERE type = 'village'
		) As g(geom,name)
	WHERE A.rid = 4;

SELECT ST_Clip(rast::raster, 1, (
	SELECT geometry FROM raster_ops.admin LIMIT 1),true) 
FROM raster_ops.dem d;

SELECT geometry FROM raster_ops.admin LIMIT 1;

SELECT ST_ScaleX(rast) FROM raster_ops.dem;
