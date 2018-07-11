SELECT topology.CreateTopology('countries',4326,0.00028,FALSE);

SELECT ST_IsValidReason(geom) FROM public.countries_country_simple WHERE ST_IsValid(geom) = FALSE;

SELECT name_en,ST_IsSimple(geom) FROM public.countries_country_simple;

--SELECT ST_IsValidReason(geom) FROM public.countries_country WHERE ST_IsValid(geom) = FALSE;

SELECT ST_IsValidReason(geom) FROM public.countries_country_simple WHERE ST_IsValid(geom) = FALSE;

UPDATE public.countries_country_simple
SET geom = ST_Collectionextract(ST_MakeValid(geom), 3)
WHERE NOT ST_IsValid(geom);

--UPDATE public.countries_country_simple SET geom = ST_MakeValid(geom) WHERE ST_IsValid(geom) IS FALSE;

SELECT topology.AddTopoGeometryColumn('countries','public','countries_country_simple','topogeom','POLYGON');

UPDATE public.countries_country_simple SET topogeom = topology.toTopoGeom(geom,'countries',1,0.00028);