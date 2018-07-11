--Che fa postgres
SELECT datname FROM pg_stat_activity WHERE usename = 'postgres';

--Chi e connesso
SELECT datname, usename, client_addr, client_port,
       application_name FROM pg_stat_activity;

SELECT count(*) FROM pg_stat_activity; 

--Che query girano
SET track_activities = on

SELECT datname, usename, state, query FROM pg_stat_activity;

SELECT datname
, usename
, wait_event_type
, wait_event
, query
FROM pg_stat_activity
WHERE wait_event IS NOT NULL;


CREATE TEMPORARY TABLE tmp_stat_user_tables AS
       SELECT * FROM pg_stat_user_tables;
SELECT * FROM pg_stat_user_tables n
  JOIN tmp_stat_user_tables t
    ON n.relid=t.relid
   AND (n.seq_scan,n.idx_scan,n.n_tup_ins,n.n_tup_upd,n.n_tup_del)
    <> (t.seq_scan,t.idx_scan,t.n_tup_ins,t.n_tup_upd,t.n_tup_del);

SELECT current_setting('temp_tablespaces');

ANALYZE;
