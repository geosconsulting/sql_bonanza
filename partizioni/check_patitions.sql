SELECT
    nmsp_parent.nspname AS parent_schema,
    parent.relname      AS parent,
    nmsp_child.nspname  AS child_schema,
    child.relname       AS child_table
FROM pg_inherits
    JOIN pg_class parent        ON pg_inherits.inhparent = parent.oid
    JOIN pg_class child         ON pg_inherits.inhrelid   = child.oid
    JOIN pg_namespace nmsp_parent   ON nmsp_parent.oid  = parent.relnamespace
    JOIN pg_namespace nmsp_child    ON nmsp_child.oid   = child.relnamespace;



SELECT
    nmsp_parent.nspname     AS parent_schema,
    parent.relname          AS parent,
    COUNT(*)
FROM pg_inherits
    JOIN pg_class parent        ON pg_inherits.inhparent = parent.oid
    JOIN pg_class child     ON pg_inherits.inhrelid   = child.oid
    JOIN pg_namespace nmsp_parent   ON nmsp_parent.oid  = parent.relnamespace
    JOIN pg_namespace nmsp_child    ON nmsp_child.oid   = child.relnamespace
GROUP BY
    parent_schema,
    parent;