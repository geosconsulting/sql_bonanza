SELECT s.ba_id, s.firedate , s.area_ha, l.countryfullname, l.province, l.place_name
FROM effis.archived_burnt_area s, rdaprd.from2000_burntareas l
WHERE s.ba_id = l.id
LIMIT 100;

SELECT s.ba_id, s.firedate , s.area_ha, avg(s.area_ha) OVER(), l.countryfullname, l.province, l.place_name
FROM effis.archived_burnt_area s, rdaprd.from2000_burntareas l
WHERE s.ba_id = l.id
AND l.countryfullname = 'Italy';

SELECT s.ba_id, s.firedate , s.area_ha, avg(s.area_ha) OVER(PARTITION BY l.province), l.countryfullname, l.province, l.place_name
FROM effis.archived_burnt_area s, rdaprd.from2000_burntareas l
WHERE s.ba_id = l.id
AND l.countryfullname = 'Italy';

SELECT s.ba_id, s.firedate , s.area_ha, avg(s.area_ha) OVER(PARTITION BY l.countryfullname), l.countryfullname
FROM effis.archived_burnt_area s, rdaprd.from2000_burntareas l
WHERE s.ba_id = l.id;

SELECT l.countryfullname AS nome, EXTRACT(YEAR FROM s.firedate::date) AS year , sum(s.area_ha) OVER(PARTITION BY EXTRACT(YEAR FROM s.firedate::date)), avg(s.area_ha) OVER(PARTITION BY EXTRACT(YEAR FROM s.firedate::date)) 
FROM effis.archived_burnt_area s, rdaprd.from2000_burntareas l
WHERE s.ba_id = l.id
ORDER BY nome;