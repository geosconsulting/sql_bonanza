--composizione multipoint da single 
SELECT ST_Collect(ST_MakePoint(20,50),ST_MakePoint(19.95,49.98));

-- piu di due
SELECT
ST_Collect(ARRAY[ST_MakePoint(20,50),ST_MakePoint(19.95,49.98),
ST_MakePoint(19.90,49.96)]);

--DECOMPOSIZIONE Prendo il secondo punto indicato alla fine
SELECT
ST_AsText(ST_GeometryN(ST_Collect(ARRAY[ST_MakePoint(20,50),
ST_MakePoint(19.95,49.98), ST_MakePoint(19.90,49.96)]),2));

--Dump esplode multishape in singole righe
SELECT
ST_Dump(ST_Collect(ARRAY[ST_MakePoint(20,50),
ST_MakePoint(19.95,49.98), ST_MakePoint(19.90,49.96)]));

SELECT
(ST_Dump(ST_Collect(ARRAY[ST_MakePoint(20,50),
ST_MakePoint(19.95,49.98), ST_MakePoint(19.90,49.96)]))).geom;

--Linee
SELECT ST_MakeLine(ST_MakePoint(20,50),ST_MakePoint(19.95,49.98));

SELECT ST_SetSRID(ST_MakeLine(ST_MAkePoint(20,50), ST_MakePoint(19.95,49.98)),4326);

--For three or more points and raw coordinates, the ARRAY argument can be used:
SELECT ST_MakeLine(ARRAY[ST_MakePoint(20,50),ST_MakePoint(19.95,49.98),
ST_MakePoint(19.90,49.96)]);

--especially useful when dealing with a series of points from GPS tracking devices:
--SELECT ST_MakeLine(gpx.geom ORDER BY time) AS geom FROM gpx GROUP BY 1;

SELECT
ST_MakePolygon(ST_MakeLine(ARRAY[ST_MakePoint(20,50),
ST_MakePoint(19.95,49.98),
ST_MakePoint(19.90,49.90),ST_MakePoint(20,50)]));

SELECT
ST_IsClosed(ST_MakeLine(ARRAY[ST_MakePoint(20,50),ST_MakePoint(19.95,49.98),
ST_MakePoint(19.90,49.96),ST_MakePoint(20,50),ST_MakePoint(20.01,50.01)]));

SELECT
ST_IsClosed(ST_MakeLine(ARRAY[ST_MakePoint(20,50), ST_MakePoint(19.95,49.98),
ST_MakePoint(19.90,49.96),ST_MakePoint(20,50), ST_MakePoint(20,50)]));