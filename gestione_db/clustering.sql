CREATE INDEX current_burntareaspoly_gix ON effis.current_burntareaspoly USING GIST (shape);

-- Cluster the blocks based on their spatial index
CLUSTER effis.current_burntareaspoly USING current_burntareaspoly_gix;

CREATE INDEX current_burntareaspoly_geohash ON effis.current_burntareaspoly (ST_GeoHash(ST_Transform(shape,4326)));

CLUSTER effis.current_burntareaspoly USING current_burntareaspoly_geohash;

SELECT ST_geoHash(shape) FROM effis.current_burntareaspoly;