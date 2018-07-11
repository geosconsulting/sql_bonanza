create table tmp.area_test(id serial,geom geometry(MultiPolygon,4326));

ALTER TABLE tmp.area_test add primary key(id);

--INSERT INTO tmp.area_test(geom) VALUES (ST_GeometryFromText('POLYGON((0 3162.277660, 3162.277660 0, 3162.277660 3162.277660,0 3162.277660))'));

SELECT id,(ST_Area(geom::geography)*0.0001)::integer 
FROM tmp."04042018-42tsn2r6";

SELECT id,ST_Perimeter(geom)
FROM tmp."04042018-42tsn2r6";