SELECT * FROM city INNER JOIN(
	SELECT * FROM country WHERE country.country_id = 49) subq 
ON city.country_id = subq.country_id;


SELECT * FROM city 
	JOIN country ON city.country_id = country.country_id 
	JOIN address ON address.city_id = city.city_id 
WHERE country.country_id=49;

SELECT C.city, C.last_update FROM city C 
	JOIN country ON C.country_id = country.country_id 
	JOIN address ON address.city_id = C.city_id 
WHERE country.country_id=49;


SELECT country, count(city) 
FROM city ,country 
WHERE city.country_id = country.country_id 
GROUP BY country.country;


SELECT country, count(*) 
FROM city,country 
WHERE city.country_id = country.country_id 
GROUP BY country.country 
ORDER BY country.country;

SELECT country, count(*) 
FROM city, country 
WHERE city.country_id = country.country_id 
GROUP BY country.country 
HAVING count(*)>10 
ORDER BY count(*) DESC;

SELECT country, count(*) AS conteggio 
FROM city, country 
WHERE city.country_id = country.country_id 
GROUP BY country.country 
HAVING count(*)>10 
ORDER BY count(*) 
DESC LIMIT 5;

SELECT city FROM city WHERE country_id IN (34,49,53);

SELECT city 
FROM city 
WHERE country_id IN (
	SELECT country_id 
	FROM country 
	WHERE country IN ('Italy','Germany','France'));

SELECT country,
		(SELECT count(*) 
         FROM city 
		 WHERE country_id = main.country_id) 
FROM country AS main LIMIT 25;

SELECT city 
FROM city 
WHERE country_id = 49 
UNION 
SELECT country 
FROM country 
WHERE country_id=49;

SELECT city 
FROM city 
WHERE country_id = 49 UNION 
SELECT country 
FROM country 
WHERE country_id IN (49,5,64);

WITH selezione_citta_italia AS (
		SELECT * FROM city WHERE country_id = 49)
SELECT city_id,city 
FROM selezione_citta_italia 
WHERE city LIKE 'B%';


sqlplus effis/FF19may@//139.191.254.54/esposito