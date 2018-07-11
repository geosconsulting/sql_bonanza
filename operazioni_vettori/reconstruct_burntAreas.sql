SELECT f.fire_id,b.id, l.broadlea, l.conifer, c.countryful
FROM effis.fire f, effis.burnt_area_spatial b 
	LEFT JOIN effis.burnt_area_landcover l ON (b.id = l.id)
	LEFT JOIN effis.burnt_area_location c ON (b.id = c.id) 
WHERE f.fire_id = b.fire;