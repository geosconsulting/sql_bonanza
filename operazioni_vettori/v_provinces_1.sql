-- View: geo.regions

-- DROP VIEW geo.regions;

CREATE OR REPLACE VIEW geo.provinces AS 
SELECT nuts_attr.gid,
    nuts_attr.nuts_id,
    nuts_attr.stat_levl_,
    nuts_attr.name_ascii,    
    nuts_attr.geom
   FROM geo.nuts_attr
  WHERE stat_levl_ = 3;

ALTER TABLE geo.provinces
  OWNER TO postgres;