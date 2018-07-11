CREATE VIEW nuts_attr AS
SELECT a.gid,a.nuts_id,a.stat_levl_,a.geom,b.name_latin,b.name_ascii
   FROM nuts a,attributes b
   WHERE a.nuts_id = b.nuts_id;