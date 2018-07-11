-- View: geo.macro_regions

-- DROP VIEW geo.macro_regions;

CREATE OR REPLACE VIEW geo.macro_regions AS 
 SELECT nuts.gid,
    nuts.nuts_id,
    nuts.stat_levl_,
    nuts.shape_area,
    nuts.shape_len,
    nuts.geom
   FROM geo.nuts
  WHERE length(nuts.nuts_id::text) = 3;

ALTER TABLE geo.macro_regions
  OWNER TO postgres;