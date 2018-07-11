SELECT ST_Area(CAST(the_geom AS geography)) as "Area sqm", ST_Area(the_geom) 
FROM (SELECT ST_GeomFromText('POLYGON((12 42, 12 42.1, 12.1 42.1, 12.1 42,12 42))',4326)) AS foo(the_geom);


SELECT ba_id,area_ha,(ST_Area(geom::geography)*0.0001)::integer FROM effis.burnt_area_spatial;

3176253.09478923

135622043255520.0