CREATE table public.effis_countries_tbl AS 
 SELECT row_number() OVER (ORDER BY adm.iso2 DESC) AS oid,
    adm.iso2,
    adm.iso,
    adm.name_en
   FROM admin_level_0 adm
  WHERE adm.iso2::text = ANY (ARRAY['AD'::text, 'AL'::text, 'DZ'::text, 'AM'::text, 'AT'::text, 'AZ'::text, 'BE'::text, 'BA'::text, 'BG'::text, 'BG'::text, 'BY'::text, 'CH'::text, 'CY'::text, 'CZ'::text, 'DE'::text, 'DK'::text, 'EE'::text, 'EG'::text, 'ES'::text, 'FI'::text, 'GE'::text, 'GG'::text, 'GR'::text, 'HR'::text, 'HU'::text, 'IE'::text, 'GG'::text, 'GR'::text, 'HR'::text, 'HU'::text, 'IE'::text, 'IL'::text, 'IQ'::text, 'IR'::text, 'IS'::text, 'IT'::text, 'IE'::text, 'IL'::text, 'IQ'::text, 'IR'::text, 'IS'::text, 'IT'::text, 'JO'::text, 'KS'::text, 'KZ'::text, 'LB'::text, 'LT'::text, 'LU'::text, 'LV'::text, 'LY'::text, 'MA'::text, 'MD'::text, 'ME'::text, 'MK'::text, 'LV'::text, 'LY'::text, 'MA'::text, 'MD'::text, 'ME'::text, 'MK'::text, 'MT'::text, 'NL'::text, 'NO'::text, 'PL'::text, 'PS'::text, 'PT'::text, 'RO'::text, 'RS'::text, 'RU'::text, 'SA'::text, 'SE'::text, 'SI'::text, 'SK'::text, 'SY'::text, 'TM'::text, 'TN'::text, 'TR'::text, 'UA'::text, 'UK'::text, 'UZ'::text, 'XA'::text])
WITH DATA;

ALTER TABLE public.effis_countries_tbl
  OWNER TO postgres;
GRANT ALL ON TABLE public.effis_countries_tbl TO postgres;
GRANT SELECT ON TABLE public.effis_countries_tbl TO e1gwisro;
GRANT SELECT ON TABLE public.effis_countries_tbl TO e1gwised;
GRANT SELECT ON TABLE public.effis_countries_tbl TO e1gwis;
