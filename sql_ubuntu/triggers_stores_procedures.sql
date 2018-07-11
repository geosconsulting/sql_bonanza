CREATE FUNCTION error_test1(int,int)
RETURNS int AS
$$
 BEGIN
    RAISE NOTICE 'debug message: % / %',$1,$2;
    BEGIN
	RETURN $1/$2;
    EXCEPTION
      WHEN division_by_zero THEN
        RAISE NOTICE 'division by zero detected: %', sqlerrm;
      WHEN others THEN
	RAISE NOTICE ' some othe error : %',sqlerrm;
      END;

      RAISE NOTICE 'all errors handled';
      RETURN 0;
   END;
$$ LANGUAGE 'plpgsql';

SELECT error_test1(9, 0); 

CREATE TYPE my_cool_type AS (s text, t text); 

CREATE FUNCTION f(my_cool_type)  
RETURNS my_cool_type AS 
$$ 
    DECLARE 
            v_row          my_cool_type; 
    BEGIN 
            RAISE NOTICE 'schema: (%) / table: (%)', $1.s, $1.t; 
            SELECT schemaname, tablename INTO v_row 
                   FROM   pg_tables  
                   WHERE  tablename = trim($1.t) 
                          AND schemaname = trim($1.s) 
                   LIMIT 1 ; 
            RETURN v_row;   
    END; 
$$ LANGUAGE 'plpgsql';

SELECT (f).s, (f).t  
            FROM   f ('("public", "t_test")'::my_cool_type);

CREATE TABLE t_sensor ( 
        id              serial, 
        ts              timestamp, 
        temperature     numeric 
);            

CREATE OR REPLACE FUNCTION trig_func()
RETURNS trigger AS
$$
  BEGIN
     IF NEW.temperature < -273
     THEN
       NEW.temperature := 0;
     END IF;

     RETURN NEW;
  END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER sensor_trig
  BEFORE INSERT ON t_sensor
  FOR EACH ROW
  EXECUTE PROCEDURE trig_func();

TRUNCATE t_sensor;

SELECT * FROM t_sensor;

INSERT INTO t_sensor (ts, temperature) 
            VALUES ('2017-05-04 14:43', -300)  
            RETURNING *; 

INSERT INTO t_sensor (ts, temperature) 
            VALUES ('2017-05-05 14:43', -150)  
            RETURNING *; 

CREATE FUNCTION add_numbers(rows_desired integer) 
        RETURNS integer AS 
$$ 
        mysum = 0 

        cursor = plpy.cursor("SELECT * FROM generate_series(1, %d) AS id" % (rows_desired)) 

        while True: 
                rows = cursor.fetch(rows_desired) 
                if not rows: 
                        break 
                for row in rows: 
                        mysum += row['id'] 
        return mysum 
$$ LANGUAGE 'plpythonu';

SELECT * FROM generate_series(12);

SELECT add_numbers(12); 
