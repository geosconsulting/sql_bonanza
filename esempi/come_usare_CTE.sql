SELECT * FROM address WHERE city_id = 70;

SELECT * FROM address
INNER JOIN city 
ON address.city_id = city.city_id
WHERE address.city_id = 70;

WITH selezione_citta_italia AS (
		SELECT * FROM city WHERE country_id = 49)
SELECT city_id,city 
FROM selezione_citta_italia 
WHERE city LIKE 'B%';

WITH selezione_citta_italia AS (
	     SELECT * FROM city WHERE country_id = 49),
     join_address AS (
	     SELECT * FROM selezione_citta_italia
	     INNER JOIN address 
	     ON selezione_citta_italia.city_id = address.city_id
	)
SELECT * FROM join_address WHERE city LIKE 'B%';

SELECT film_id,title,rating,AVG(rental_duration) OVER(PARTITION BY rating) FROM film;



