SELECT * 
FROM rdaprd.ba_current c, rdaprd.ba_current_evolution e
WHERE c.ba_id = e.ba_id;

SELECT * 
FROM rdaprd.ba_archived c, rdaprd.ba_archived_evolution e
WHERE c.id_source = e.ba_id;

SELECT * 
FROM (SELECT year_id,
      ROW_NUMBER() OVER(PARTITION BY year_id ORDER BY year_id ASC) AS Row 
      FROM rdaprd.ba_archived) dups 
      WHERE dups.Row > 1;


SELECT *
FROM (SELECT year_id,
      ROW_NUMBER() OVER(PARTITION BY year_id ORDER BY year_id ASC) AS Row 
      FROM rdaprd.ba_archived_evolution) dups 
      WHERE dups.Row > 1;
      
SELECT * FROM rdaprd.ba_archived WHERE id_source IS NULL ORDER BY firedate;

SELECT * FROM rdaprd.ba_archived WHERE id_source IS NOT NULL ORDER BY firedate;
