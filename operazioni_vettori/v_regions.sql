-- View: geo.regions

-- DROP VIEW geo.regions;

CREATE OR REPLACE VIEW geo.regions AS 
 SELECT nuts.gid,
    nuts.nuts_id,
    nuts.stat_levl_,
    nuts.shape_area,
    nuts.shape_len,
    nuts.geom
   FROM geo.nuts
  WHERE length(nuts.nuts_id::text) = 4;

ALTER TABLE geo.regions
  OWNER TO postgres;