truncate tmp.area_5 cascade;
   
INSERT INTO tmp.area_5 (geom) (
   SELECT ST_Buffer(ST_SetSRID(ST_MakePoint(13.13, 37.64),4326), 0.06, 'quad_segs=8'));
