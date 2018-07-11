SELECT c.id AS "ID Country",name_en,iso,iso2,m.id AS "Internal ID Macroarea", m.macroarea_id AS "ID Macroarea", a.name 
FROM public.countries_country c, public.countries_macro_areas m, public.countries_macroarea a 
WHERE c.id = m.country_id 
AND m.macroarea_id = a.id 
GROUP BY c.id, m.id, a.name 
ORDER BY c.name_en;
