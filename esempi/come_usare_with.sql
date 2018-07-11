WITH citta_con_ad AS 
	(SELECT * FROM city WHERE city LIKE 'Ad%')
SELECT city
FROM citta_con_ad
WHERE country_id>40 AND country_id <100;


EXPLAIN SELECT * FROM city WHERE city LIKE 'Ad%' ORDER BY country_id;