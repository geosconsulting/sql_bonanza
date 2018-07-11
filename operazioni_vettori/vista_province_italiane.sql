CREATE or REPLACE VIEW geo.province_italiane AS
SELECT provinces.gid,provinces.nuts_id,provinces.geom
FROM geo.provinces, geo.countries
WHERE ST_Intersects(provinces.geom, countries.geom)
AND countries.nuts_id = 'IT';