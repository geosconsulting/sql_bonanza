SELECT 
PSUI.indexrelid::regclass AS IndexName 
,PSUI.relid::regclass AS TableName 
FROM pg_stat_user_indexes AS PSUI 
JOIN pg_index AS PI 
ON PSUI.IndexRelid = PI.IndexRelid 
WHERE PSUI.idx_scan = 0 
AND PI.indisunique IS FALSE;