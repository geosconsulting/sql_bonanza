SELECT ba_id,firedate,area_ha,lastupdate
FROM effis.burnt_area_spatial
EXCEPT 
SELECT id,firedate,area_ha,lastupdate
FROM rdaprd.current_burntareaspoly
ORDER BY 2;

SELECT count(ba_id) FROM effis.burnt_area_spatial;

SELECT count(id) FROM rdaprd.current_burntareaspoly; 

SELECT ba_id,firedate FROM effis.current_burnt_area ORDER BY ba_id;

SELECT ID,firedate FROM RDAPRD.CURRENT_BURNTAREASPOLY ORDER BY ID;

SELECT CASE WHEN EXISTS
            ( SELECT *
              FROM effis.burnt_area_spatial a NATURAL FULL JOIN rdaprd.current_burntareaspoly b
              WHERE a.ba_id IS NULL 
                 OR b.id IS NULL
            )
            THEN 'different'
            ELSE 'same'
       END AS result ;

SELECT *
FROM effis.burnt_area_spatial a 
     NATURAL FULL JOIN rdaprd.current_burntareaspoly b
WHERE a.ba_id IS NULL 
OR b.id IS NULL;

TRUNCATE effis.burnt_area_registry;

SELECT * FROM effis.burnt_area_registry;