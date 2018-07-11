CREATE MATERIALIZED VIEW nuts_attr AS
   SELECT a.gid,a.nuts_id,a.stat_levl_,a.geom,b.name_latin,b.name_ascii
   FROM nuts a, attributenuts b
   WHERE a.nuts_id = b.nut_id;