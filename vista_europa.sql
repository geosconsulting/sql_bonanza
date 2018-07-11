SELECT * FROM public.admin_level_0_macroareas mm_ma
   LEFT JOIN public.admin_level_0 adm ON adm.id = mm_ma.country_id
   LEFT JOIN public.macroareas ma ON ma.id = mm_ma.macroarea_id
WHERE  adm.name_en = 'Italy';

SELECT mm_ma.id,adm.name_en,ma.name,ST_AsGeoJSON(adm.geom) FROM public.admin_level_0_macroareas mm_ma
   LEFT JOIN public.admin_level_0 adm ON adm.id = mm_ma.country_id
   LEFT JOIN public.macroareas ma ON ma.id = mm_ma.macroarea_id
WHERE  ma.name = 'EU';

SELECT mm_ma.id,adm.name_en,ma.name,ST_AsGeoJSON(adm.geom) FROM public.admin_level_0_macroareas mm_ma
   LEFT JOIN public.admin_level_0 adm ON adm.id = mm_ma.country_id
   LEFT JOIN public.macroareas ma ON ma.id = mm_ma.macroarea_id
WHERE  ma.name = 'EU';

CREATE MATERIALIZED VIEW public.european_countries as 
	SELECT mm_ma.id,adm.name_en,ma.name,adm.geom FROM public.admin_level_0_macroareas mm_ma
	   LEFT JOIN public.admin_level_0 adm ON adm.id = mm_ma.country_id
	   LEFT JOIN public.macroareas ma ON ma.id = mm_ma.macroarea_id
	WHERE  ma.name = 'EU';

DROP MATERIALIZED VIEW public.effis_countries;

CREATE VIEW public.effis_countries as 
	SELECT mm_ma.id,adm.name_en,ma.name,adm.geom FROM public.admin_level_0_macroareas mm_ma
	   LEFT JOIN public.admin_level_0 adm ON adm.id = mm_ma.country_id
	   LEFT JOIN public.macroareas ma ON ma.id = mm_ma.macroarea_id
	WHERE  ma.name = 'EU'
	or adm.iso2 in ('CH','MA','DZ','TN','LY','EG','IL','PS','LB','SY','JO','S4','TR','RU','AL','RS',
	               'GE','BA','ME','RS','MK','O5','BG','RO','MD','UA','BY','NO','MO','IS','BO');


CREATE MATERIALIZED VIEW public.effis_countries as 
	SELECT adm.name_en,adm.geom FROM public.admin_level_0 adm 	   
	WHERE  adm.iso2 in (
	'IT','FR','ES','GB','PT','BE','NL','DK','NO','DE','CH','MA','DZ','TN','LY','EG','IL','PS','LB','SY','JO'
	,'S4','TR','AL','RS','GE','BA','ME','RS','MK','O5','BG','RO','MD','UA','BY','NO','MO','IS','05'
	,'PL','SK','AT','HU','SI','BA','LT','LV','EE','IE','CZ','LU','GR','SE','FI','AX','HR','CY','IM'); --'RU',

	               