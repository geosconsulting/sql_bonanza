-- COSI DEVE CALCOLARE LE DISTANZE DI TUTTE LE FEATURES E POI METTE IN ORDINE
SELECT ba.objectid,ba.id,fi.fire_id
FROM effis.current_burntareaspoly ba,
     effis.fire fi
WHERE ba.objectid = 450
ORDER BY ST_Distance(ba.shape,fi.geom) ASC
LIMIT 10;

--APPLICO UNA MASSIMA DISTANZA DI RICERCA
SELECT ba.objectid,ba.id,fi.fire_id
FROM effis.current_burntareaspoly ba,
     effis.fire fi
WHERE ba.objectid = 450
--ECCO IL CAMBIO
AND fi.geom && ST_Expand(ba.shape,0.01) -- 0.0 m
ORDER BY ST_Distance(ba.shape,fi.geom) ASC
LIMIT 10;

--APPLICO KNN <->
SELECT fire_id
FROM effis.fire fi
ORDER BY fi.geom <-> (SELECT ba.shape FROM effis.current_burntareaspoly ba WHERE ba.objectid = 450)
LIMIT 10;

--APPLICO KNN <-> e calcolo distanza
SELECT fire_id,
       ST_Distance(ST_Centroid(ba.shape),fi.geom) AS distance
FROM effis.fire fi,effis.current_burntareaspoly ba
WHERE ba.objectid = 450
ORDER BY fi.geom <-> ba.shape
OFFSET 1 
LIMIT 1;

--APPLICO KNN <#> e calcolo distanza dal bordo
SELECT fire_id, 
       ST_Distance(ST_Centroid(ba.shape),fi.geom) AS distance
FROM effis.fire fi,effis.current_burntareaspoly ba
WHERE ba.objectid = 450
ORDER BY fi.geom <#> ba.shape
LIMIT 5;

SELECT ST_AsGeoJSON(ST_Centroid(ba.shape)) FROM effis.current_burntareaspoly ba WHERE ba.objectid = 450;



