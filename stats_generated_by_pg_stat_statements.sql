SELECT rolname,
       calls,
       total_time,
       mean_time,
       max_time,
       stddev_time,
       rows,
       regexp_replace(query, '[ \t\n]+', ' ', 'g') AS query_text
FROM pg_stat_statements
JOIN pg_roles r ON r.oid = userid
WHERE calls > 100
AND rolname NOT LIKE '%backup'
ORDER BY mean_time DESC
LIMIT 15;