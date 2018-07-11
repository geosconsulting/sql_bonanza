SELECT ST_IsSimple(ST_MakeLine(ST_MakePoint(20,50),ST_MakePoint(19.95,49.98)));

--repeated points
SELECT ST_IsSimple(ST_MakeLine(ARRAY[ST_MakePoint(20,50),ST_MakePoint(19.95,49.98)
,ST_MakePoint(19.90,49.90), ST_MakePoint(19.95,49.98)]));

-- E' valida??
SELECT * FROM data_import.ne_110m_land WHERE ST_IsValid(geom) = FALSE;

--Perche NON e' valida??
SELECT ST_IsValidReason(geom) FROM data_import.ne_110m_land WHERE
ST_IsValid(geom) = FALSE;

--Altra spiegazione perche non e' valida
SELECT ST_IsValidDetail(geom) FROM data_import.ne_110m_land WHERE
ST_IsValid(geom) = FALSE;

SELECT (ST_IsValidDetail(geom)).location, (ST_IsValidDetail(geom)).reason
FROM data_import.ne_110m_land WHERE ST_IsValid(geom) = FALSE;

-- RIPARIAMO la feature invalida
UPDATE data_import.ne_110m_land SET geom = ST_MakeValid(geom);
-- The ST_MakeValid will not touch geometries that are already valid, so an additional WHERE
-- clause is not needed.

SELECT * FROM data_import.ne_110m_land WHERE ST_IsValid(geom) = FALSE;

-- Buono aggiungere validity constraints all'inserimento di una feature\
--ALTER TABLE planet_osm_polygon ADD CONSTRAINT enforce_validity CHECK
--(ST_IsValid(way))

SELECT gid,ST_Intersection(geom,ST_SetSRID('POLYGON((-2 53, 2 53, 2 50, -2 50, -2 53))'::geometry,4326))
FROM data_import.ne_coastline WHERE gid = 73;

-- I ciqnue piu vicini NOTARE IL CAST del campo geo a geography
SELECT * FROM data_import.earthquakes_subset_with_geom
ORDER BY ST_Distance(geom::geography,
ST_SetSRID(ST_MakePoint(-66.11,18.46),4326)::geography)
LIMIT 5;