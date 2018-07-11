SELECT pg_size_pretty(pg_database_size('gwis')); 

SELECT schema_name, 
       pg_size_pretty(sum(table_size)),
       (sum(table_size) / database_size) * 100
FROM (
  SELECT pg_catalog.pg_namespace.nspname as schema_name,
         pg_relation_size(pg_catalog.pg_class.oid) as table_size,
         sum(pg_relation_size(pg_catalog.pg_class.oid)) over () as database_size
  FROM   pg_catalog.pg_class
     JOIN pg_catalog.pg_namespace ON relnamespace = pg_catalog.pg_namespace.oid
) t
GROUP BY schema_name, database_size;