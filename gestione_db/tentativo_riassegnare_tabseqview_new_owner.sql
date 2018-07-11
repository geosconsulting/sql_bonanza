SELECT 'ALTER TABLE '|| schemaname || '.' || tablename ||' OWNER TO postgres;'
FROM pg_tables WHERE NOT schemaname IN ('pg_catalog', 'information_schema')
ORDER BY schemaname, tablename;

SELECT 'ALTER SEQUENCE '|| sequence_schema || '.' || sequence_name ||' OWNER TO postgres;'
FROM information_schema.sequences WHERE NOT sequence_schema IN ('pg_catalog', 'information_schema')
ORDER BY sequence_schema, sequence_name;

SELECT 'ALTER VIEW '|| table_schema || '.' || table_name ||' OWNER TO postgres;'
FROM information_schema.views WHERE NOT table_schema IN ('pg_catalog', 'information_schema')
ORDER BY table_schema, table_name;

SELECT 'ALTER TABLE '|| oid::regclass::text ||' OWNER TO postgres;'
FROM pg_class WHERE relkind = 'm'
ORDER BY oid;

create view my_tables as 
select table_catalog, table_schema, table_name, table_type 
from information_schema.tables 
where table_schema not in ('pg_catalog', 'information_schema');

select nsp.nspname as object_schema,
       cls.relname as object_name, 
       rol.rolname as owner, 
       case cls.relkind
         when 'r' then 'TABLE'
         when 'i' then 'INDEX'
         when 'S' then 'SEQUENCE'
         when 'v' then 'VIEW'
         when 'c' then 'TYPE'
         else cls.relkind::text
       end as object_type
from pg_class cls
  join pg_roles rol on rol.oid = cls.relowner
  join pg_namespace nsp on nsp.oid = cls.relnamespace
where nsp.nspname not in ('information_schema', 'pg_catalog')
  --and nsp.nspname not like 'pg_toast%'
  and rol.rolname = current_user  --- remove this if you want to see all objects
order by nsp.nspname, cls.relname;