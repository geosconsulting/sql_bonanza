SELECT a3.id,a3.name_en,a3.admin2_id,a2.id,a2.name_en,a3.admin1_id,a1.id,a1.name_en,a0.id,a0.name_en
FROM public.countries_adminsublevel3 a3 
     LEFT JOIN public.countries_adminsublevel2 a2 ON a2.id = a3.admin2_id
     LEFT JOIN public.countries_adminsublevel1 a1 ON a1.id = a3.admin1_id
     LEFT JOIN public.countries_country a0 ON a0.id = a3.country_id
WHERE a0.name_en = 'Italy';

SELECT a3.id,a3.name_en,a3.admin2_id,
       a2.id,a2.name_en,a3.admin1_id,
       a1.id,a1.name_en,
       a0.id,a0.name_en
FROM public.countries_adminsublevel3 a3 
     LEFT JOIN public.countries_adminsublevel2 a2 ON a2.id = a3.admin2_id
     LEFT JOIN public.countries_adminsublevel1 a1 ON a1.id = a3.admin1_id
     LEFT JOIN public.countries_country a0 ON a0.id = a3.country_id
WHERE a3.name_en = 'Sagunto';

SELECT a3.id,a3.name_en,a3.admin2_id,a3.admin1_id       
FROM public.countries_adminsublevel3 a3      
WHERE a3.name_en = 'Sagunto';

SELECT a3.id,a3.name_en,a3.admin2_id,
       a2.id,a2.name_en,a3.admin1_id,
       a1.id,a1.name_en,
       a0.id,a0.name_en
FROM public.countries_adminsublevel3 a3 
     LEFT JOIN public.countries_adminsublevel2 a2 ON a2.id = a3.admin2_id
     LEFT JOIN public.countries_adminsublevel1 a1 ON a1.id = a3.admin1_id
     LEFT JOIN public.countries_country a0 ON a0.id = a3.country_id
WHERE a1.name_en = 'Agusan del Sur';





