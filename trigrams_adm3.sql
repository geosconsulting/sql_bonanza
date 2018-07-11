DROP INDEX effis.trgm_idx;

CREATE INDEX trgm_idx_adm3 ON effis.adm3 USING GIST (name_en gist_trgm_ops);

CREATE INDEX trgm_idx_adm2 ON effis.adm2 USING GIST (name_en gist_trgm_ops);

SELECT id,name_en, similarity(name_en, 'roma') AS sml
FROM effis.adm3
WHERE name_en % 'roma'
ORDER BY sml DESC, name_en
LIMIT 10;

SELECT id,name_en, name_en <-> 'firenze' AS dist
FROM effis.adm3
ORDER BY dist LIMIT 10;

SELECT a3.id,a3.name_en,a3.admin2_id,a2.id,a2.name_en,a3.admin1_id,a1.id,a1.name_en FROM effis.adm3 a3 
     LEFT JOIN effis.adm2 a2 ON a2.id = a3.admin2_id
     LEFT JOIN effis_ext_public.countries_adminsublevel1 a1 ON a1.id = a3.admin1_id
WHERE a3.id IN (111297,129120,115186,132242);


SELECT a3.id,a3.name_en,a3.admin2_id,a2.id,a2.name_en,a3.admin1_id,a1.id,a1.name_en FROM effis.adm3 a3 
     LEFT JOIN effis_ext_public.countries_adminsublevel2 a2 ON a2.id = a3.admin2_id
     LEFT JOIN effis_ext_public.countries_adminsublevel1 a1 ON a1.id = a3.admin1_id
WHERE a3.id IN (SELECT id
	        FROM effis.adm3
                WHERE 'firenze' <% name_en
                LIMIT 10);


SELECT a3.id,a3.name_en,a3.admin2_id,a2.id,a2.name_en,a3.admin1_id FROM effis.adm3 a3 
     LEFT JOIN effis_ext_public.countries_adminsublevel2 a2 ON a2.id = a3.admin2_id
WHERE a3.id IN (SELECT id
	        FROM effis.adm3
                WHERE 'firenze' <% name_en
                LIMIT 10);

SELECT a3.id,a3.name_en,a3.admin2_id,a2.id,a2.name_en,a3.admin1_id,a1.id,a1.name_en,a0.id,a0.name_en
FROM effis_ext_public.countries_adminsublevel3 a3 
     LEFT JOIN effis_ext_public.countries_adminsublevel2 a2 ON a2.id = a3.admin2_id
     LEFT JOIN effis_ext_public.countries_adminsublevel1 a1 ON a1.id = a3.admin1_id
     LEFT JOIN effis_ext_public.countries_country a0 ON a0.id = a3.country_id
WHERE a0.name_en = 'Italy';

SELECT a3.id,a3.name_en,a3.admin2_id,a2.id,a2.name_en,a3.admin1_id,a1.id,a1.name_en,a3.country_id,a0.id,a0.name_en
FROM effis_ext_public.countries_adminsublevel3 a3 
     LEFT JOIN effis_ext_public.countries_adminsublevel2 a2 ON a2.id = a3.admin2_id
     LEFT JOIN effis_ext_public.countries_adminsublevel1 a1 ON a1.id = a3.admin1_id
     LEFT JOIN effis_ext_public.countries_country a0 ON a0.id = a3.country_id
WHERE a3.id IN (SELECT id
	        FROM effis.adm3
                WHERE 'roma' <% name_en
                LIMIT 10);

SELECT * FROM effis_ext_public.countries_adminsublevel2 WHERE id = 33850;
SELECT * FROM effis_ext_public.countries_adminsublevel3 WHERE admin2_id = 33850;

SELECT name_local,name_local <-> 'gllate' AS dist FROM effis.adm3 ORDER BY dist LIMIT 10;

SELECT name_local,name_local <-> 'bishop storford' AS dist FROM effis.adm3 ORDER BY dist LIMIT 10;

CREATE EXTENSION pg_trgm;

CREATE INDEX trgm_idx_adm3 ON public.countries_adminsublevel3 USING GIST (name_en gist_trgm_ops);
CREATE INDEX trgm_idx_adm2 ON public.countries_adminsublevel2 USING GIST (name_en gist_trgm_ops);
CREATE INDEX trgm_idx_adm1 ON public.countries_adminsublevel1 USING GIST (name_en gist_trgm_ops);

SELECT id,name_local,admin2_id,admin1_id,name_local <-> 'sagunto' AS dist FROM public.countries_adminsublevel3 ORDER BY dist LIMIT 10;

SELECT * FROM public.countries_adminsublevel3 WHERE id = 98812;

SELECT * FROM public.countries_adminsublevel2 WHERE id = 44873;