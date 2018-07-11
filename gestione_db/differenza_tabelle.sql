CREATE TABLE z (id int, val text);
INSERT INTO z VALUES (1, 'foo'), (2, 'bar');

CREATE TABLE v (id int, val text);
INSERT INTO v VALUES (1, 'foo'), (3, 'bar');

SELECT id--,count(1)
FROM z
FULL OUTER JOIN v 
     USING (id, val)
WHERE z.id IS NULL
OR v.id IS NULL;

SELECT * FROM z EXCEPT SELECT * FROM v;

SELECT CASE WHEN EXISTS(TABLE z EXCEPT TABLE v)
              OR EXISTS(TABLE v EXCEPT TABLE z) 
            THEN 'different'
            ELSE 'same'
        END AS result;              

(TABLE z EXCEPT TABLE v)
UNION ALL
(TABLE v EXCEPT TABLE z);
