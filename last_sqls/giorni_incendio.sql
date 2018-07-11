SELECT objectid,id,country,firedate,lastupdate,DATE_PART('day',lastupdate::timestamp - firedate::timestamp) AS "Days" 
FROM rdaprd.current_burntareaspoly LIMIT 10;


SELECT t.id,t.date_part,t.countryful FROM 
	(SELECT objectid,id,country,countryful,firedate,lastupdate, DATE_PART('day',lastupdate::timestamp - firedate::timestamp) 
	 FROM rdaprd.current_burntareaspoly) t 
WHERE t.date_part > 50 
ORDER BY t.date_part DESC;


SELECT t.id,t."Giorni di Incendio",t.countryful FROM (
		SELECT objectid,id,country,countryful,firedate,lastupdate, DATE_PART('day',lastupdate::timestamp - firedate::timestamp) AS "Giorni di Incendio" 
        FROM rdaprd.current_burntareaspoly) t 
WHERE t."Giorni di Incendio" > 50 
ORDER BY t."Giorni di Incendio" DESC;