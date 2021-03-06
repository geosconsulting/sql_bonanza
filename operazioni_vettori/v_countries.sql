﻿-- View: geo.countries

-- DROP VIEW geo.countries;

CREATE OR REPLACE VIEW geo.countries AS 
 SELECT nuts.gid,
    nuts.nuts_id,
    nuts.stat_levl_,
    nuts.shape_area,
    nuts.shape_len,
    nuts.geom
   FROM geo.nuts
  WHERE length(nuts.nuts_id::text) = 2;

ALTER TABLE geo.countries
  OWNER TO postgres;