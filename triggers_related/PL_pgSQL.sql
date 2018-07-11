DO $$
<<aumenta_uno>>
DECLARE
  counter integer := 0;
BEGIN
  counter := counter + 1;
  RAISE NOTICE 'Current Value is %', counter;
END aumenta_uno $$;

DO $$
<<somma>>
DECLARE	
  somma_calc integer;
  primo_num integer := 8;
  secondo_num integer := 5;
BEGIN
  somma_calc := primo_num + secondo_num;
  RAISE NOTICE 'La Somma is %', somma_calc;
END somma $$;

DO $$ 
DECLARE
   counter integer := 1;
   first_name varchar(50) := 'John';
   last_name varchar(50) := 'Doe';
   payment numeric(11,2) := 20.5;
BEGIN 
   RAISE NOTICE '% % % has been paid % USD', counter, first_name, last_name, payment;
END $$;

DO $$ 
DECLARE
   created_at time := now();
BEGIN 
   RAISE NOTICE '%', created_at;
END $$;

DO $$ 
BEGIN 
  RAISE INFO 'information message %', now() ;
  RAISE LOG 'log message %', now();
  RAISE DEBUG 'debug message %', now();
  RAISE WARNING 'warning message %', now();
  RAISE NOTICE 'notice message %', now();
END $$;

CREATE FUNCTION inc(val integer) RETURNS integer AS $$
BEGIN
RETURN val + 1;
END; $$
LANGUAGE PLPGSQL;

SELECT inc(20);
SELECT inc(inc(20));

SELECT inc(60);
SELECT inc(60,12);


CREATE OR REPLACE FUNCTION public.sommolo(
    val1 integer DEFAULT 1,
    val2 integer DEFAULT 1)
  RETURNS integer AS
$BODY$BEGIN
	RETURN val1 + val2;
END;$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION public.sommolo(integer, integer)
  OWNER TO postgres;
COMMENT ON FUNCTION public.sommolo(integer, integer) IS 'Somma due numeri';

SELECT sommolo(160,212);

-- VARIABILI DIVISE TRA IN (SENZA VALORE) e OUT
CREATE OR REPLACE FUNCTION hi_lo(
 a NUMERIC, 
 b NUMERIC,
 c NUMERIC, 
 OUT hi NUMERIC,
 OUT lo NUMERIC)
AS $$
BEGIN
 hi := GREATEST(a,b,c);
 lo := LEAST(a,b,c);
END; $$
LANGUAGE plpgsql;

SELECT hi_lo(10,20,30);
SELECT * FROM hi_lo(10,20,30);
SELECT hi FROM hi_lo(10,20,30);

CREATE OR REPLACE FUNCTION square(
 INOUT a NUMERIC)
AS $$
BEGIN
 a := a * a;
END; $$
LANGUAGE plpgsql;

SELECT square(4);

CREATE OR REPLACE FUNCTION sum_avg(
 VARIADIC list NUMERIC[],
 OUT total NUMERIC, 
        OUT average NUMERIC)
AS $$
BEGIN
   SELECT INTO total SUM(list[i])
   FROM generate_subscripts(list, 1) g(i);
 
   SELECT INTO average AVG(list[i])
   FROM generate_subscripts(list, 1) g(i);
 
END; $$
LANGUAGE plpgsql;

SELECT * FROM sum_avg(10,20,30);
SELECT * FROM sum_avg(10,20,30,76,12,1,56);
