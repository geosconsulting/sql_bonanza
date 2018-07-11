REVOKE ALL ON table1 FROM user2;
REVOKE role3 FROM user2;

GRANT SELECT ON table1 TO webreaders; 
GRANT SELECT, INSERT, UPDATE, DELETE ON table1 TO editors; 
GRANT ALL ON table1 TO admins;

GRANT USAGE ON someschema TO somerole; 
GRANT SELECT, INSERT, UPDATE, DELETE ON someschema.sometable TO somerole; 
GRANT somerole TO someuser, otheruser;

-------------------------------------------------------------------------------
CREATE GROUP webreaders; 
GRANT SELECT ON pages TO webreaders; 
GRANT INSERT ON viewlog TO webreaders; 
GRANT webreaders TO tim, bob;
GRANT INSERT, UPDATE, DELETE ON comments TO webreaders;
-------------------------------------------------------------------------------

--GRANT tutte le tabelle ma non ancora lo schema
GRANT SELECT ON ALL TABLES IN SCHEMA staging TO bob;

-- GRANT SU COLONNE di una tabella
CREATE TABLE someschema.sometable2(col1 int, col2 text);

- Inserire su tabella ma update solo su colonna
GRANT SELECT, INSERT ON someschema.sometable2 TO somerole; 
GRANT UPDATE (col2) ON someschema.sometable2 TO somerole;


--CREO RUOLI The CREATE USER and CREATE GROUP commands are actually variations of CREATE ROLE.
CREATE USER bob;
CREATE USER alice CREATEDB;

-- RIASSEGNO I DB DI bob Al SOTITUTITO DI bob
REASSIGN OWNED BY bob TO bobs_replacement;


GRANT effis_editor TO nome_utente;
REVOKE effis_editor FROM nome_utente;

SET ROLE nome_utente;

ALTER SCHEMA fabio RENAME TO ext_schema;
ALTER SCHEMA ext_schema OWNER TO postgres;
DROP USER fabio;

ALTER USER username WITH PASSWORD 'password';

GRANT ALL ON DATABASE effis TO fabio;


--ACCESS DB
REVOKE CONNECT ON DATABASE nova FROM PUBLIC;
GRANT  CONNECT ON DATABASE nova  TO user;

--ACCESS SCHEMA
REVOKE ALL     ON SCHEMA public FROM PUBLIC;
GRANT  USAGE   ON SCHEMA public  TO user;

--ACCESS TABLES
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC ;
GRANT SELECT                         ON ALL TABLES IN SCHEMA public TO read_only ;

-- TABLE
GRANT ALL                            ON ALL TABLES IN SCHEMA public TO admin ;


CREATE USER editor; --pwprompt;

-- POSSO CREARE SCHEMA COSI
GRANT CREATE ON DATABASE effis TO editor;


--TESTO della funzione
SELECT prosrc FROM pg_proc WHERE proname = 'effis_landcover_area';

-- FUNZIONE EDITABILE IN VIM
\ef effis_landcover_area

CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
CREATE EXTENSION plpythonu;

--Salvare in un file
SELECT effis_landcover_area('Lombardia') \g /home/jrc/lombardia.out;

--Ha dritti per la funzione??
SELECT has_function_privilege('editor','effis_sum_values(text,text,text)','execute');


-- Tutti i diritti di gestion della legenda solo select sul raster
GRANT SELECT, UPDATE,INSERT ON rst.glc_legend TO efist_editor;
GRANT SELECT ON rst.glc_1x1k TO effis_editor;

GRANT USAGE ON SCHEMA rst TO effis_editor;
-- GRANT SULLO SCHEMA NON GARANTISCE L USO delle tabelle contenute
GRANT USAGE ON SCHEMA public TO effis_editor;

GRANT SELECT ON ALL TABLES IN SCHEMA rst,public TO effis_editor;


GRANT USAGE ON SCHEMA public,rst,topology,modis_viirs TO "e1-usr";
GRANT SELECT,UPDATE,DELETE ON ALL TABLES IN SCHEMA public,rst,topology,modis_viirs TO "e1-usr";
GRANT USAGE, SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA public,rst,topology,modis_viirs TO "e1-usr";
GRANT USAGE,SELECT ON ALL SEQUENCES IN SCHEMA effis,public TO "viewer";

--BISOGNA SETTARE USAGE E GRANT SU TABELLE PER ACCEDERE ALLE FUNZIONI

-- SELECT
-- INSERT
-- UPDATE
-- DELETE
-- TRUNCATE
-- REFERENCES
-- TRIGGER
-- CREATE
-- CONNECT
-- TEMP
-- EXECUTE
-- USAGE

SELECT has_schema_privilege('effis_editor','rst','usage');

 SHOW hba_file;
 SHOW config_file;
 SHOW log_destination;
 SHOW log_directory;

--RESTART POSTGRESQL MACCHINA DB
/usr/pgsql-10/bin/pg_ctl start/stop/restart

--Write into directory where postgres user has write access. For instance /tmp.
pg_dump -h localhost mydb >/tmp/tempfile

--SETTARE il tempo IDLE senza fare niente
SET idle_in_transaction_session_timeout TO 2500; 

-- LOCK A TABLE AVOIDING TWO CONCURRENT UPDATES
BEGIN; 
LOCK TABLE product IN ACCESS EXCLUSIVE MODE; 
INSERT INTO product SELECT max(id) + 1, ... FROM product; 
COMMIT;

SET lock_timeout TO 5000;
SELECT FOR UPDATE SKIP LOCKED;

--PER NON BLOCCARE LA TABELLA MENTRE CREA INDICI
CREATE INDEX CONCURRENTLY;

--INDICIZZARE SOLO VALORI CHE SONO MOLTO SPARSI  
-- makes sense to exclude very frequent values that make up a large part of the table (at least 25% or so)
CREATE INDEX idx_name ON t_test (name) WHERE name NOT IN ('hans', 'paul'); 


--CARICO DENTRO PSQL DATA TRAMITE curl
COPY t_location FROM PROGRAM 'curl www.cybertec.at/secret/orte.txt';

--CON PROXY
COPY t_location FROM PROGRAM 'curl --proxy 10.168.209.72:8012 -L www.cybertec.at/secret/orte.txt';

--VICINANZA TRA STRINGHE
SELECT show_trgm('abcdef'); 
SELECT * FROM  t_location ORDER BY name <-> 'Kramertneusiedel' LIMIT 3;

CREATE INDEX idx_trgm ON t_location USING GiST(name GiST_trgm_ops);

--velocizzo ricerche testuali
SELECT * FROM t_location ORDER BY name <-> 'Kramertneusiedel' LIMIT 5;

--anche like
SELECT * FROM t_location WHERE name LIKE '%neusi%'; 

--ed espressioni regolari
SELECT * FROM t_location WHERE name ~ '[A-C].*neu.*';


 -- RAGGRUPPATI E TOTALI ROLLUP e CUBE
 SELECT region, avg(production) FROM t_oil GROUP BY ROLLUP (region);
 SELECT region, avg(production) FROM t_oil GROUP BY CUBE (region);

 SELECT   region, country, avg(production) 
 FROM   t_oil 
 WHERE   country IN ('USA', 'Canada', 'Iran', 'Oman')
 GROUP BY GROUPING SETS ( (), region, country); 

SELECT region,
 		avg(production) AS all, 
 		avg(production) FILTER (WHERE year < 1990) AS old, 
 		avg(production) FILTER (WHERE year >= 1990) AS new  
FROM t_oil   
GROUP BY ROLLUP(region);

--MOVING WINDOW
SELECT country, year, production,  
   min(production) OVER (PARTITION BY country  
                         ORDER BY year ROWS  
                         BETWEEN 1 PRECEDING 
                         AND 1 FOLLOWING)  
   FROM   t_oil  
   WHERE  year BETWEEN 1978 AND 1983  
          AND country IN ('Iran', 'Oman'); 
    
-- GENERA UN ARRAY array_agg dei valori tra uno prima e uno dopo
SELECT *, array_agg(id) OVER (ORDER BY id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) FROM generate_series(1,5) AS id;


--BLOCCATO IN AVANTI LIBERO INDIETRO
SELECT *,  
          array_agg(id) OVER  
                 (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING  
                  AND 0 FOLLOWING)  
   FROM   generate_series(1, 5) AS id; 


SELECT country, year, production, min(production) OVER (w), max(production) OVER (w) 
FROM      t_oil 
WHERE     country = 'Canada'  
AND year BETWEEN 1980 AND 1985 
WINDOW w AS (ORDER BY year); 


--CALCOLA IL RANK DEI RECORDS ovver il primo il secondo etc...
SELECT year,production,rank() OVER (ORDER BY production) FROM t_oil WHERE country = 'Other Middle East' ORDER BY rank LIMIT 7;


--QUI SIAMO NELL'INCREDIBILE lag() AND lead()

SELECT year, production,  
          production - lag(production, 1) OVER (ORDER BY year)  
FROM      t_oil  
WHERE     country = 'Mexico'  
LIMIT 3; 


SELECT year, production,  
          production - lead(production, 1) OVER (ORDER BY year)  
FROM      t_oil  
WHERE     country = 'Mexico'  
LIMIT 3; 


---first_value(), nth_value(), and last_value() functions

--CREATE AGGREGATE CUSTOM

CREATE TABLE t_taxi (trip_id int, km numeric);

INSERT INTO t_taxi VALUES  
   (1, 4.0), (1, 3.2), (1, 4.5), 
   (2, 1.9), (2, 4.5);

CREATE FUNCTION taxi_per_line (numeric, numeric)

CREATE AGGREGATE taxi_price (numeric)  
( 
          INITCOND = 2.5,  
          SFUNC = taxi_per_line,  
          STYPE = numeric 
);

SELECT trip_id, taxi_price(km)  
          FROM   t_taxi  
          GROUP BY 1; 


CREATE FUNCTION taxi_per_line (numeric, numeric)  
RETURNS numeric AS  $$ 
BEGIN
RAISE NOTICE 'intermediate: %, per row: %', $1, $2;                                                                                                                                                                          RETURN $1 + $2*2.2;                                                                                                                                                                                           END;                                                                                                                                                                                                       $$ LANGUAGE 'plpgsql'; 


GRANT USAGE ON SCHEMA ostm TO effis_editors;
GRANT SELECT,UPDATE,DELETE ON ALL TABLES IN SCHEMA ostm TO effis_editors;
GRANT USAGE, SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA ostm TO effis_editors;

GRANT CONNECT ON DATABASE effis TO effis_editors;


\d pg_stat_activity
SELECT usename,client_addr,state,query FROM pg_stat_activity;

 \d pg_stat_database
 numbackends that shows the number of database connections that are currently open


 \d pg_stat_user_tables
SELECT schemaname, relname,  
       seq_scan,  
       seq_tup_read,  
       seq_tup_read / seq_scan AS avg,  
       idx_scan  
FROM     pg_stat_user_tables  
WHERE    seq_scan > 0  
ORDER BY seq_tup_read  
DESC LIMIT 25;

\d pg_statio_user_tables

\d pg_stat_user_indexes
The view tells us, for every index on every table in every schema, how often it has been used (idx_scan)

SELECT  schemaname, 
        relname, 
        indexrelname, 
        idx_scan, 
        pg_size_pretty(pg_relation_size(indexrelid)), 
        pg_size_pretty(sum(pg_relation_size(indexrelid))  
                       OVER (ORDER BY idx_scan, indexrelid)) AS total 
FROM    pg_stat_user_indexes 
ORDER BY 6 ;

pg_stat_bgwriter

\d pg_stat_xact_user_tables
Inspecting transactions in real time


\d pg_stat_progress_vacuum

--INDICI NORMALE E SPATIAL
CREATE INDEX idx_serial ON test_polys(id);
CREATE INDEX gix_polys ON test_polys USING GIST(geom);


export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export PG_DATA=/var/lib/postgresql/9.6/main


SET SESSION idle_in_transaction_session_timeout = '5min';

--install su pg96 con pgxn
sudo make PG_CONFIG=/usr/lib/postgresql/9.6/bin/pg_config install


/usr/lib/postgresql/9.6/bin/pg_ctl status -D /var/lib/postgresql/9.6/main/

alias pgi="sudo systemctl start postgresql.service"
alias pgt="sudo systemctl stop postgresql.service"
alias pgs="sudo systemctl status postgresql.service"
alias pgh="sudo vi /etc/postgresql/9.6/main/pg_hba.conf"
alias pgc="sudo vi /etc/postgresql/9.6/main/postgresql.conf"


--QUANTE QUERIES SUL SERVER
SELECT   datname,  
        count(*) AS open,  
        count(*) FILTER (WHERE state = 'active') AS active,  
        count(*) FILTER (WHERE state = 'idle') AS idle,  
        count(*) FILTER (WHERE state = 'idle in transaction') AS idle_in_trans  
FROM    pg_stat_activity  
GROUP BY ROLLUP(1); 

-- DA QUANTO SONO IN CORSO LE QUERY
SELECT pid, xact_start, now() - xact_start AS duration  
   FROM  pg_stat_activity  
   WHERE state LIKE '%transaction%'  
   ORDER BY 3 DESC;


 SELECT now() - query_start AS duration, datname, query  
   FROM  pg_stat_activity  
   WHERE       state = 'active' 
   ORDER BY 1 DESC;

-- CHECK momoria e disco
--blk_read_time and blk_write_time. It will tell you about the amount of time PostgreSQL has spent on waiting for the OS to respond.
\d pg_stat_database

UPDATE effis.fire f SET area = aree.area_ha FROM (SELECT id,area_ha 
	FROM rdaprd.current_burntareaspoly) AS aree 
WHERE f.fire_id = aree.id;

SELECT f.fire_id, f.area AS "Area Centroide" , ba.id , ba.area_ha AS "Area Polygono" 
FROM effis.fire f, rdaprd.current_burntareaspoly ba 
WHERE f.fire_id = ba.id LIMIT 10;

--TROVA NULLI IN UNA TABELLA IN RELAZIONE CON UN ALTRA
SELECT ba.id 
FROM effis.burnt_area_spatial ba LEFT JOIN effis.fire f ON ba.id = f.fire_id 
WHERE f.fire_id IS NULL;


-- UPDATE CENTROIDI
-- UPDATE CENTROIDI

INSERT INTO effis.fire(fire_id,detected,area,updated,geom) 
	(SELECT id,firedate::date,area_ha,lastupdate::date,ST_Centroid(shape) 
FROM rdaprd.current_burntareaspoly 
WHERE id IN(204060, 204061, 204369, 204370, 204371));

-- UPDATE CENTROIDI
-- UPDATE CENTROIDI

CREATE SEQUENCE burnt_area_spatial_seq;
SELECT generate_series(1,3116);


SELECT id,row_number() OVER (PARTITION BY fire ORDER BY id) as rn FROM effis.burnt_area_spatial;

update data 
   set ordering = t.rn
  from (select pk_column, 
               row_number() over (partition by clientid  order by pk_column) as rn
          from data
       ) t
where t.pk_column = data.pk_column;


-- COLLEGA sequence
ALTER TABLE effis.burnt_area_spatial ALTER COLUMN idx_temp SET DEFAULT nextval('effis.burnt_area_spatial_seq');

-- SCOLLEGA sequence
ALTER TABLE effis.burnt_area_spatial ALTER COLUMN idx_temp DROP DEFAULT;


SELECT f.fire_id, f.area, ba.id, ba.area_ha, ba.fire, lc.id, lc.broadlea, lc.conifer 
FROM effis.fire f, effis.burnt_area_spatial ba, effis.burnt_area_landcover lc 
WHERE f.fire_id = ba.fire 
AND f.fire_id = lc.id 
LIMIT 10;