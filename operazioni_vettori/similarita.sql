SELECT DISTINCT ON(g1.id) g1.id, g2.id,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom)
--ST_MaxDistance(g1.geom, g2.geom)
FROM tmp.area_1 g1, tmp.area_2 As g2   
WHERE ST_Intersects(g1.geom, g2.geom);

SELECT DISTINCT ON(g1.id) g1.id, g2.id,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom)
--ST_MaxDistance(g1.geom, g2.geom)
FROM tmp.area_1 g1, tmp.area_3 As g2   
WHERE ST_Intersects(g1.geom, g2.geom);

SELECT DISTINCT ON(g1.id) g1.id, g2.id,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom)
--ST_MaxDistance(g1.geom, g2.geom)
FROM tmp.area_1 g1, tmp.area_4 As g2   
WHERE ST_Intersects(g1.geom, g2.geom);

SELECT DISTINCT ON(g1.id) g1.id, g2.id,
ST_Distance(g1.geom,g2.geom) as distance,
ST_HausdorffDistance(g1.geom, g2.geom)
--ST_MaxDistance(g1.geom, g2.geom)
FROM tmp.area_1 g1, tmp.area_5 As g2   
WHERE ST_Intersects(g1.geom, g2.geom);



