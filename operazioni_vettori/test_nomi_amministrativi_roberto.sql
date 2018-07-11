SELECT a3.country_id,a3.name_en,a3.name_local,c.name_en 
FROM countries_adminsublevel3 a3 
	LEFT JOIN countries_country c ON(a3.country_id = c.id) 
WHERE a3.name_local LIKE '%touna%';

SELECT a3.country_id,a3.name_en,a3.name_local,c.name_en 
FROM countries_adminsublevel3 a3 
	LEFT JOIN countries_country c ON(a3.country_id = c.id) 
WHERE c.name_en = 'Alg%';

SELECT c.name_en FROM countries_country c WHERE c.name_en LIKE 'Alge%';

SELECT count(*) FROM public.burnt_area;

SELECT brnt.commune,adm3.name_en
FROM public.burnt_area brnt 
	INNER JOIN public.countries_adminsublevel3 adm3 ON brnt.commune = adm3.name_local;

SELECT brnt.commune,adm3.name_en,adm3.name_local,brnt.countryful
FROM public.burnt_area brnt 
	LEFT JOIN public.countries_adminsublevel3 adm3 ON brnt.commune = adm3.name_local
WHERE adm3.name_local IS NULL
ORDER BY brnt.countryful;

SELECT brnt.countryful,brnt.province,brnt.commune,adm3.name_en,adm3.name_local
FROM public.burnt_area brnt 
	LEFT JOIN public.countries_adminsublevel3 adm3 ON initcap(brnt.commune) = adm3.name_local
WHERE adm3.name_local IS NULL
ORDER BY brnt.countryful;

SELECT brnt.countryful,brnt.province,brnt.commune,adm2.name_en,adm2.name_local
FROM public.burnt_area brnt 
	LEFT JOIN public.countries_adminsublevel2 adm2 ON initcap(brnt.commune) = adm2.name_local
WHERE adm2.name_local IS NULL
ORDER BY brnt.countryful;

SELECT brnt.countryful,brnt.province,brnt.commune,adm3.name_en,adm3.name_local
FROM public.burnt_area brnt 
	INNER JOIN public.countries_adminsublevel3 adm3 ON brnt.commune = adm3.name_local
WHERE adm3.name_local is NOT NULL;

SELECT brnt.commune,adm3.name_en,adm3.name_local
FROM public.burnt_area brnt 
	LEFT JOIN public.countries_adminsublevel3 adm3 ON brnt.commune = adm3.name_local
WHERE adm3.name_local is NULL;
