SELECT id,idate,fdate 
FROM public.fires_2001_centre_3 
WHERE id = 293890;

SELECT id,idate,fdate,type 
FROM modis_viirs.fires_1_1_2001 
WHERE id = 293890 
ORDER BY fdate;

SELECT * 
FROM modis_viirs.fires_1_1_2001 
WHERE id = 293890 
ORDER BY idate,fdate;

SELECT count(id)
FROM modis_viirs.fires_1_1_2001 
WHERE id = 293890;

CREATE TABLE merged AS
SELECT ST_Union(ST_SnapToGrid(geom,0.0001)) 
FROM modis_viirs.fires_1_1_2001
WHERE id = 293890 
GROUP BY id;