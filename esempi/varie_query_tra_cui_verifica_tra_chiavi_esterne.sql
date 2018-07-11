SELECT * FROM regions_stable WHERE name_ascii LIKE 'Me%';

SELECT * FROM regions_stable WHERE name_ascii LIKE 'Merkez';

SELECT * FROM hotspots WHERE commune LIKE 'Mer%';

SELECT * FROM hotspots WHERE commune = 'Merkez';

select * from provinces_stable ou
where (select count(*) from provinces_stable inr
where inr.name_ascii = ou.name_ascii) > 1;

SELECT * FROM regions_stable WHERE name_ascii LIKE 'Ju%';
SELECT * FROM provinces_stable WHERE name_ascii LIKE 'Ju%';

UPDATE provinces_stable 
SET name_ascii='Kalmar lan'
WHERE nuts_id = 'SE213';

UPDATE provinces_stable 
SET name_ascii='Jura ch'
WHERE nuts_id = 'CH025';

SELECT commune 
FROM   hotspots h
WHERE  NOT EXISTS (
   SELECT 1              -- it's mostly irrelevant what you put here
   FROM   provinces_stable p
   WHERE  p.name_ascii = h.commune 
   );
   
