SELECT cnt.id,cnt.name_en,adm.id,adm.name_local,adm.name_en
FROM public.countries_country cnt, public.countries_adminsublevel1 adm
WHERE cnt.id = adm.country_id
AND cnt.iso = 'ITA'
ORDER BY adm.name_local;

SELECT cnt.id,cnt.name_en, brnt.gid, brnt.area_ha, brnt.broadlea As "Broadleaf",brnt.conifer AS "Conifer"
FROM public.countries_country cnt, public.burnt_area brnt
WHERE cnt.iso2 = brnt.country
AND cnt.iso2 = 'IT'
ORDER BY cnt.name_local;

SELECT cnt.name_en, SUM(brnt.area_ha) "Total HA", SUM(brnt.broadlea) As "Broadleaf", SUM(brnt.conifer) AS "Conifer"
FROM public.countries_country cnt, public.burnt_area brnt
WHERE cnt.iso2 = brnt.country
AND cnt.iso2 = 'IT'
GROUP BY cnt.name_en;

SELECT brnt.area_ha, brnt.broadlea, brnt.conifer, brnt.firedate
FROM   public.burnt_area brnt
WHERE  EXTRACT(MONTH FROM CAST(firedate AS timestamp)) > 2
AND EXTRACT(MONTH FROM CAST(firedate AS timestamp)) <= 5
ORDER BY EXTRACT(MONTH FROM CAST(firedate AS timestamp));
