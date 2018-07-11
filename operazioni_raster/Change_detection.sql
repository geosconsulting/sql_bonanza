-- DROP TABLE december_b01_clipped;
CREATE TABLE december_b12_clipped AS 
SELECT * FROM december_b12 r WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 
									   709669.222 5590167.659, 646886.733 5590167.659,
										   674375.662 5631306.177))', 32631)); 

--DROP TABLE august_b01_clipped;
CREATE TABLE august_b01_clipped AS SELECT * FROM august_b01 r 
	WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 
			709669.222 5590167.659, 
			646886.733 5590167.659, 674375.662 5631306.177))', 32631)); 
--DROP TABLE august_b02_clipped;
CREATE TABLE august_b02_clipped AS SELECT * FROM august_b02 r WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 709669.222 5590167.659, 646886.733 5590167.659, 674375.662 5631306.177))', 32631)); 
--DROP TABLE august_b03_clipped;
CREATE TABLE august_b03_clipped AS SELECT * FROM august_b03 r WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 709669.222 5590167.659, 646886.733 5590167.659, 674375.662 5631306.177))', 32631)); 
--DROP TABLE august_b04_clipped;
CREATE TABLE august_b04_clipped AS SELECT * FROM august_b04 r WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 709669.222 5590167.659, 646886.733 5590167.659, 674375.662 5631306.177))', 32631)); 
CREATE TABLE august_b05_clipped AS SELECT * FROM august_b05 r WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 709669.222 5590167.659, 646886.733 5590167.659, 674375.662 5631306.177))', 32631)); 
CREATE TABLE august_b06_clipped AS SELECT * FROM august_b06 r WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 709669.222 5590167.659, 646886.733 5590167.659, 674375.662 5631306.177))', 32631)); 
CREATE TABLE august_b07_clipped AS SELECT * FROM august_b07 r WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 709669.222 5590167.659, 646886.733 5590167.659, 674375.662 5631306.177))', 32631)); 
CREATE TABLE august_b08_clipped AS SELECT * FROM august_b08 r WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 709669.222 5590167.659, 646886.733 5590167.659, 674375.662 5631306.177))', 32631)); 
CREATE TABLE august_b09_clipped AS SELECT * FROM august_b09 r WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 709669.222 5590167.659, 646886.733 5590167.659, 674375.662 5631306.177))', 32631)); 
CREATE TABLE august_b10_clipped AS SELECT * FROM august_b10 r WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 709669.222 5590167.659, 646886.733 5590167.659, 674375.662 5631306.177))', 32631)); 
CREATE TABLE august_b11_clipped AS SELECT * FROM august_b11 r WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 709669.222 5590167.659, 646886.733 5590167.659, 674375.662 5631306.177))', 32631)); 
CREATE TABLE august_b12_clipped AS SELECT * FROM august_b12 r WHERE ST_Intersects(r.rast, ST_GeomFromText('POLYGON((674375.662 5631306.177, 709669.222 5631306.177, 709669.222 5590167.659, 646886.733 5590167.659, 674375.662 5631306.177))', 32631)); 

DROP TABLE delta_aug_dec_b02;
CREATE TABLE delta_aug_dec_b02 AS
SELECT joined.rid, ST_MapAlgebra(arast, 1, brast, 1, 'ROUND([rast1] - [rast2])*([rast1] - [rast2])', '32BF') AS rast FROM 
			(SELECT a.rid, a.rast as arast, b.rast as brast FROM august_b02_clipped a INNER JOIN december_b02_clipped b ON a.rid = b.rid) AS joined; 
ALTER TABLE delta_aug_dec_b02 ADD CONSTRAINT delta_aug_dec_b02_pk PRIMARY KEY (rid);
SELECT AddRasterConstraints('delta_aug_dec_b02'::name, 'rast'::name);

DROP TABLE delta_aug_dec_b03;
CREATE TABLE delta_aug_dec_b03 AS
SELECT joined.rid, ST_MapAlgebra(arast, 1, brast, 1, 'ROUND([rast1] - [rast2])*([rast1] - [rast2])', '32BF') AS rast FROM 
				(SELECT a.rid, a.rast as arast, b.rast as brast FROM august_b03_clipped a INNER JOIN december_b03_clipped b ON a.rid = b.rid) AS joined; 
ALTER TABLE delta_aug_dec_b03 ADD CONSTRAINT delta_aug_dec_b03_pk PRIMARY KEY (rid);
SELECT AddRasterConstraints('delta_aug_dec_b03'::name, 'rast'::name);

DROP TABLE delta_aug_dec_b04;
CREATE TABLE delta_aug_dec_b04 AS
SELECT joined.rid, ST_MapAlgebra(arast, 1, brast, 1, 'ROUND([rast1] - [rast2])*([rast1] - [rast2])', '32BF') AS rast FROM 
			(SELECT a.rid, a.rast as arast, b.rast as brast FROM august_b04_clipped a INNER JOIN december_b04_clipped b ON a.rid = b.rid) AS joined; 
ALTER TABLE delta_aug_dec_b04 ADD CONSTRAINT delta_aug_dec_b04_pk PRIMARY KEY (rid);
SELECT AddRasterConstraints('delta_aug_dec_b04'::name, 'rast'::name);

-- Two-step formula as ST_MapAlgebra only takes two raster documents
DROP TABLE sum_delta_aug_dec_b02_b03;
CREATE TABLE sum_delta_aug_dec_b02_b03 AS
SELECT joined.rid, ST_MapAlgebra(arast, 1, brast, 1, 'ROUND([rast1] + [rast2])', '32BF') AS rast FROM 
			(SELECT a.rid, a.rast as arast, b.rast as brast FROM delta_aug_dec_b02 a 
			INNER JOIN delta_aug_dec_b03 b ON a.rid = b.rid) AS joined; 
ALTER TABLE sum_delta_aug_dec_b02_b03 ADD CONSTRAINT sum_delta_aug_dec_b02_b03_pk PRIMARY KEY (rid);

DROP TABLE sum_delta_aug_dec_b02_b03_b04;
CREATE TABLE sum_delta_aug_dec_b02_b03_b04 AS
SELECT joined.rid, ST_MapAlgebra(arast, 1, brast, 1, 'ROUND(SQRT([rast1] + [rast2]))', '32BF') AS rast FROM 
			(SELECT a.rid, a.rast as arast, b.rast as brast FROM sum_delta_aug_dec_b02_b03 a 
			INNER JOIN delta_aug_dec_b04 b ON a.rid = b.rid) AS joined; 
ALTER TABLE sum_delta_aug_dec_b02_b03_b04 ADD CONSTRAINT sum_delta_aug_dec_b02_b03_b04_pk PRIMARY KEY (rid);

-- Convert the raster document into a binary mask
UPDATE sum_delta_aug_dec_b02_b03_b04 SET rast = ST_Reclass(rast, '0-1500:0, 1500-55635:1', '2BUI');

-- NDVI august
DROP TABLE ndvi_aug;
CREATE TABLE ndvi_aug AS
SELECT joined.rid, ST_MapAlgebra(band8, 1, band4, 1, 'ROUND([rast1] - [rast2]) / ([rast1] + [rast2])', '32BF') AS rast FROM 
			(SELECT a.rid, a.rast as band8, b.rast as band4 FROM august_b08_clipped a 
			INNER JOIN august_b04_clipped b ON a.rid = b.rid) AS joined; 
ALTER TABLE ndvi_aug ADD CONSTRAINT ndvi_aug_pk PRIMARY KEY (rid);
SELECT AddRasterConstraints('ndvi_aug'::name, 'rast'::name);