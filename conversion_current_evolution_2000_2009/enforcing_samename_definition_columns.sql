﻿-- Enforcing the same name and definition for columns

SELECT 
  table_schema
  ,table_name
  ,column_name
  ,data_type
     || coalesce(' ' || text(character_maximum_length),'')
     || coalesce(' ' || text(numeric_precision),'')
     || coalesce(' ' || text(numeric_scale),'')
     AS data_type
FROM information_schema.columns
WHERE column_name IN
    (SELECT column_name
    FROM (SELECT column_name
                ,data_type
                ,character_maximum_length
		,numeric_precision
		,numeric_scale
		FROM information_schema.columns
		WHERE table_schema NOT IN ('information_schema', 'pg_catalog')
		GROUP BY
		column_name
		,data_type
		,character_maximum_length
		,numeric_precision
		,numeric_scale
		) derived
		GROUP BY column_name
		HAVING count(*) > 1)
		AND table_schema NOT IN ('information_schema', 'pg_catalog')
		ORDER BY column_name;

SELECT table_schema
       ,table_name
       ,column_name
       ,data_type 
       ,character_maximum_length
       ,numeric_precision
       ,numeric_scale
FROM information_schema.columns 
WHERE table_schema IN('s1','s2');

SELECT 
  table_schema
  ,table_name
  ,column_name
  ,data_type
     || coalesce(' ' || text(character_maximum_length),'')
     || coalesce(' ' || text(numeric_precision),'')
     || coalesce(' ' || text(numeric_scale),'')
     AS data_type
FROM information_schema.columns
WHERE column_name IN
    (SELECT column_name
    FROM (SELECT column_name
                ,data_type
                ,character_maximum_length
		,numeric_precision
		,numeric_scale
		FROM information_schema.columns
		WHERE table_schema IN('s1','s2')
		GROUP BY
		column_name
		,data_type
		,character_maximum_length
		,numeric_precision
		,numeric_scale
		) derived
		GROUP BY column_name
		HAVING count(*) > 1)
		AND table_schema IN('s1','s2')
		ORDER BY column_name;
SELECT
      table_schema
      ,table_name
      ,column_name
      ,data_type
FROM information_schema.columns
WHERE table_name IN
       (SELECT table_name
       FROM
         (SELECT DISTINCT table_name
			 ,def
	  FROM
	     (SELECT table_schema
                    ,table_name
		    ,string_agg(column_name||' '||data_type, ',' ORDER BY column_name) AS def
              FROM information_schema.columns
              WHERE table_schema NOT IN ('information_schema','pg_catalog')
              GROUP BY table_schema,table_name) t ) def
	GROUP BY table_name
        HAVING count(*) > 1
)
ORDER BY table_name
        ,table_schema
        ,column_name;


CREATE OR REPLACE FUNCTION diff_table_definition
	(t1_schemaname text
	,t1_tablename text
	,t2_schemaname text
	,t2_tablename text)
RETURNS TABLE
	(t1_column_name text
	,t1_data_type text
	,t2_column_name text
	,t2_data_type text
	)
LANGUAGE SQL
as
$$
SELECT
    t1.column_name
   ,t1.data_type
   ,t2.column_name
   ,t2.data_type
FROM
  (SELECT column_name, data_type
   FROM information_schema.columns
   WHERE table_schema = $1
   AND table_name = $2
) t1
FULL OUTER JOIN
  (SELECT column_name, data_type
   FROM information_schema.columns
   WHERE table_schema = $3
   AND table_name = $4
) t2
ON t1.column_name = t2.column_name
AND t1.data_type = t2.data_type
WHERE t1.column_name IS NULL OR t2.column_name IS NULL;
$$;


SELECT * FROM diff_table_definition('rdaprd','current_burntareaspoly','rdaprd','current_firesevolution');
SELECT * FROM diff_table_definition('rdaprd','ba_current','rdaprd','ba_current_evolution');