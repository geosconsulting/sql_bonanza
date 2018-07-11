CREATE TABLE country_stable AS
SELECT nuts_attr.gid,
    nuts_attr.nuts_id,
    nuts_attr.stat_levl_,
    nuts_attr.geom,
    nuts_attr.name_latin,
    nuts_attr.name_ascii
   FROM nuts_attr
  WHERE (nuts_attr.stat_levl_ = 0);