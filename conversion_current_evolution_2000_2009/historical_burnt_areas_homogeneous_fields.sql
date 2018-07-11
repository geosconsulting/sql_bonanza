SELECT * FROM rdaprd.from2000_burntareas ba00
   JOIN rdaprd.from2009_firesevolution ba09 ON ba00.id_source = ba09.id_source
WHERE ba00.place_name LIKE 'Fr%'
ORDER BY ba00.country
LIMIT 25;

SELECT * FROM rdaprd.from2000_burntareas ba00
   JOIN rdaprd.from2009_firesevolution ba09 ON ba00.id_source = ba09.id_source
WHERE ba00.place_name LIKE 'Fr%'
ORDER BY ba00.country
LIMIT 25;