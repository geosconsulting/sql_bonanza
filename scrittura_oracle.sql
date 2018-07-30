CREATE SERVER dea_orcl_scrittura
   FOREIGN DATA WRAPPER oracle_fdw
  OPTIONS (dbserver 'dea.ies.jrc.it:1521/LANALFA_TABLES ');
ALTER SERVER dea_orcl_scrittura
  OWNER TO postgres;
GRANT USAGE ON FOREIGN SERVER dea_orcl_scrittura TO postgres;


CREATE USER MAPPING FOR postgres
SERVER dea_orcl_scrittura
OPTIONS (user 'LANALFA', password 'only4fab10');


CREATE FOREIGN TABLE emp 
  (empno    integer   OPTIONS (key 'true') NOT NULL,
   ename    varchar(10),
   hiredate date,
   sal      numeric(7,2))
  SERVER dea_orcl_scrittura OPTIONS (table 'SAMPLE_EMP');
