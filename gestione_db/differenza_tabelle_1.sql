SELECT ba_id,firedate,area_ha,lastupdate
FROM effis.current_burnt_area
EXCEPT 
SELECT id,firedate,area_ha,lastupdate
FROM rdaprd.current_burntareaspoly
ORDER BY 2;

SELECT count(ba_id) FROM effis.current_burnt_area;
SELECT count(id) FROM rdaprd.current_burntareaspoly;
 

SELECT ba_id,firedate FROM effis.current_burnt_area ORDER BY ba_id;

SELECT ID,firedate FROM RDAPRD.CURRENT_BURNTAREASPOLY ORDER BY ID;

SELECT CASE WHEN EXISTS
            ( SELECT *
              FROM effis.current_burnt_area a NATURAL FULL JOIN rdaprd.current_burntareaspoly b
              WHERE a.ba_id IS NULL 
                 OR b.id IS NULL
            )
            THEN 'different'
            ELSE 'same'
       END AS result ;

SELECT *
FROM effis.current_burnt_area a 
     NATURAL FULL JOIN rdaprd.current_burntareaspoly b
WHERE a.ba_id IS NULL 
OR b.id IS NULL;

ROLLBACK;