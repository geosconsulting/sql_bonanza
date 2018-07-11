-- View: geo.provinces

-- DROP VIEW geo.provinces;

CREATE OR REPLACE VIEW geo.provinces AS 
 SELECT nuts.gid,
    nuts.nuts_id,
    nuts.stat_levl_,
    nuts.shape_area,
    nuts.shape_len,
    nuts.geom
   FROM geo.nuts
  WHERE length(nuts.nuts_id::text) = 5;

ALTER TABLE geo.provinces
  OWNER TO postgres;