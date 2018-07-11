DROP FUNCTION get_rental_duration(INTEGER);

CREATE OR REPLACE FUNCTION get_rental_duration(p_customer_id INTEGER)
   RETURNS INTEGER AS $$
DECLARE
  rental_duration INTEGER;
BEGIN

   SELECT INTO rental_duration SUM(EXTRACT(DAY FROM return_date - rental_date))
   FROM rental
   WHERE customer_id = p_customer_id;

   RETURN rental_duration;
END; $$
LANGUAGE plpgsql;

	
SELECT get_rental_duration(232);

CREATE OR REPLACE FUNCTION get_rental_duration(p_customer_id INTEGER, p_from_date DATE)
 RETURNS INTEGER AS $$
DECLARE 
 rental_duration integer;
BEGIN
 -- get the rental duration based on customer_id and rental date
 SELECT INTO rental_duration
             SUM( EXTRACT( DAY FROM return_date - rental_date)) 
 FROM rental 
 WHERE customer_id= p_customer_id AND 
   rental_date >= p_from_date;
 
 RETURN rental_duration;
END; $$
LANGUAGE plpgsql;

SELECT get_rental_duration(232,'2005-07-01');


CREATE OR REPLACE FUNCTION get_rental_duration(
 p_customer_id INTEGER, 
 p_from_date DATE DEFAULT '2005-01-01'
 )
 RETURNS INTEGER AS $$
DECLARE 
 rental_duration integer;
BEGIN
 -- get the rental duration based on customer_id and rental date
 SELECT INTO rental_duration
             SUM( EXTRACT( DAY FROM return_date - rental_date)) 
 FROM rental 
 WHERE customer_id= p_customer_id AND 
   rental_date >= p_from_date;
 
 RETURN rental_duration;
END; $$
LANGUAGE plpgsql;

SELECT get_rental_duration(232);

DROP FUNCTION get_rental_duration(INTEGER,DATE);

CREATE OR REPLACE FUNCTION get_film (p_pattern VARCHAR) 
 RETURNS TABLE (
 film_title VARCHAR,
 film_release_year INT
) 
AS $$
BEGIN
 RETURN QUERY SELECT
 title,
 cast( release_year as integer)
 FROM
 film
 WHERE
 title LIKE p_pattern ;
END; $$  
LANGUAGE 'plpgsql';

SELECT get_film ('Al%');


CREATE OR REPLACE FUNCTION get_film (p_pattern VARCHAR,p_year INT) 
 RETURNS TABLE (
 film_title VARCHAR,
 film_release_year INT
) 
AS $$
DECLARE 
    var_r record;
BEGIN
   FOR var_r IN(SELECT title, release_year 
                       FROM film WHERE title LIKE p_pattern AND 
                        release_year = p_year)  
     LOOP
              film_title := upper(var_r.title) ; 
       film_release_year := var_r.release_year;
              RETURN NEXT;
            END LOOP;
END; $$  
LANGUAGE 'plpgsql';

SELECT * FROM get_film ('%er', 2006);

DO $$
DECLARE
	a integer := 10;
	b integer := 10;
BEGIN
	IF a > b THEN 
		RAISE NOTICE 'a is greater than b';
	ELSIF a < b THEN
		RAISE NOTICE 'a is less than b';
	ELSE
		RAISE NOTICE 'a is equal to b';
	END IF;
END $$;


CREATE OR REPLACE FUNCTION get_price_segment(p_film_id integer)
	RETURNS VARCHAR(50) AS $$
DECLARE
	rate NUMERIC;
	price_segment VARCHAR(50);
BEGIN

    SELECT INTO rate rental_rate
    FROM film
    WHERE film_id = p_film_id;

    CASE rate
	WHEN 0.9 THEN price_segment = 'Mass';
	WHEN 2.99 THEN price_segment = 'Mainstream';
	WHEN 4.99 THEN price_segment = 'High End';
    ELSE
	price_segment = 'Unspecified';
    END CASE;

    RETURN price_segment;
END; $$
LANGUAGE plpgsql;
SELECT get_price_segment(123) AS "Price Segment";
    
SELECT film_id,rental_rate
FROM film
WHERE film_id = 123;

CREATE OR REPLACE FUNCTION fibonacci (n INTEGER) 
 RETURNS INTEGER AS $$ 
DECLARE
   counter INTEGER := 0 ; 
   i INTEGER := 0 ; 
   j INTEGER := 1 ;
BEGIN
 
 IF (n < 1) THEN
 RETURN 0 ;
 END IF; 
 
 LOOP 
 EXIT WHEN counter = n ; 
 counter := counter + 1 ; 
 SELECT j, i + j INTO i, j ;
 END LOOP ; 
 
 RETURN i ;
END ; 
$$ LANGUAGE plpgsql;
SELECT fibonacci(8);


CREATE OR REPLACE FUNCTION fibonacci_while (n INTEGER) 
 RETURNS INTEGER AS $$ 
DECLARE
   counter INTEGER := 0 ; 
   i INTEGER := 0 ; 
   j INTEGER := 1 ;
BEGIN
 
 IF (n < 1) THEN
 RETURN 0 ;
 END IF; 
 
 WHILE counter <= n LOOP
 counter := counter + 1 ; 
 SELECT j, i + j INTO i, j ;
 END LOOP ; 
 
 RETURN i ;
END ;
$$ LANGUAGE plpgsql;
SELECT fibonacci_while(8);

DO $$
BEGIN
   FOR counter IN 1..5 LOOP
	RAISE NOTICE 'Counter: %', counter;
   END LOOP;
END; $$

DO $$
BEGIN
   FOR counter IN REVERSE 5..1 LOOP
      RAISE NOTICE 'Counter: %', counter;
   END LOOP;
END; $$

CREATE OR REPLACE FUNCTION for_loop_through_query(
   n INTEGER DEFAULT 10
) 
RETURNS VOID AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT title 
        FROM film 
        ORDER BY title
        LIMIT n 
    LOOP 
	RAISE NOTICE '%', rec.title;
    END LOOP;
END;
$$ LANGUAGE plpgsql;
SELECT for_loop_through_query(5);

SELECT title FROM film ORDER BY title LIMIT 5;

CREATE OR REPLACE FUNCTION for_loop_through_dyn_query(
   sort_type INTEGER,
   n INTEGER
) 
RETURNS VOID AS $$
DECLARE
    rec RECORD;
    query text;
BEGIN

 --SEZIONE SELEZIONE
 query := 'SELECT title, release_year FROM film ';
 IF sort_type = 1 THEN
	query := query || 'ORDER BY title';
 ELSIF sort_type = 2 THEN
	query := query || 'ORDER BY release_year';
 ELSE 
	RAISE EXCEPTION 'Invalid sort type %s', sort_type;
 END IF;
 
 query := query || ' LIMIT $1';
 
 FOR rec IN EXECUTE query USING n 
    LOOP
	RAISE NOTICE '% - %', rec.release_year, rec.title;
    END LOOP;
   
END;
$$ LANGUAGE plpgsql;
SELECT for_loop_through_dyn_query(1,5);

DECLARE
    cur_films  CURSOR FOR SELECT * FROM film;
    cur_films2 CURSOR (year integer) FOR SELECT * FROM film WHERE release_year = year;

OPEN cur_films;
OPEN cur_films2(year:=2005);

FETCH cur_films INTO row_film;
FETCH LAST FROM row_film INTO title, release_year;

CREATE OR REPLACE FUNCTION get_film_titles(p_year INTEGER)
   RETURNS text AS $$
DECLARE 
 titles TEXT DEFAULT '';
 rec_film   RECORD;
 cur_films CURSOR(p_year INTEGER) 

 FOR SELECT 
 FROM film
 WHERE release_year = p_year;
BEGIN
   -- Open the cursor
   OPEN cur_films(p_year);
 
   LOOP
    -- fetch row into the film
      FETCH cur_films INTO rec_film;
    -- exit when no more row to fetch
      EXIT WHEN NOT FOUND;
 
    -- build the output
      IF rec_film.title LIKE '%ful%' THEN 
         titles := titles || ',' || rec_film.title || ':' || rec_film.release_year;
      END IF;
   END LOOP;
  
   -- Close the cursor
   CLOSE cur_films;
 
   RETURN titles;
END; $$ 
LANGUAGE plpgsql;

SELECT get_film_titles(2006);