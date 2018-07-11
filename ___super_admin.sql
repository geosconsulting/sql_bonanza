select pid,query_start,state_change,state,query,client_addr from pg_stat_activity;

select schemaname,relname,seq_scan,seq_tup_read,seq_tup_read/seq_scan as avg, idx_scan from pg_stat_user_tables where seq_scan > 0 order by seq_tup_read DESC limit 25;
