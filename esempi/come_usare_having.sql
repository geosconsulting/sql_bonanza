SELECT country_id,count(country_id) 
FROM city 
WHERE city LIKE 'A%' 
GROUP BY country_id 
HAVING count(country_id)>1;

SELECT * FROM city WHERE city LIKE 'A%' ORDER BY country_id;