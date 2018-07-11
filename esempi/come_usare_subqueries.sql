SELECT * 
FROM company
WHERE id IN (SELECT id 
	     FROM company
	     WHERE salary > 45000);