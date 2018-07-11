SELECT max(area_ha),min(area_ha),avg(area_ha) FROM burnt_area;

SELECT area_ha,
	CASE WHEN area_ha<100 THEN 'piccolo'
	     WHEN area_ha>100 AND area_ha<10000 THEN 'medio'
	     WHEN area_ha>10000 THEN 'grande'
	END
FROM burnt_area;

SELECT area_ha,
	CASE WHEN area_ha<100 THEN 'piccolo'
	     WHEN area_ha>100 AND area_ha<10000 THEN 'medio'
	     ELSE 'grande'
	END
FROM burnt_area;

SELECT GREATEST(area_ha),LEAST(area_ha) FROM burnt_area;

SELECT GREATEST(broadlea),LEAST(conifer) FROM burnt_area;