SELECT ST_Npoints(geom) As num_punti FROM public.countries_country WHERE iso = 'ITA';


SELECT ST_Npoints(geom) As num_punti, 
       ST_NPoints(ST_Simplify(geom,0.001)) As np0001, 
       ST_NPoints(ST_Simplify(geom,0.01)) As np001,
       ST_NPoints(ST_Simplify(geom,0.1)) As np01, 
       ST_NPoints(ST_Simplify(geom,0.5)) As np05,
       ST_NPoints(ST_Simplify(geom,1)) As np1,
       ST_NPoints(ST_Simplify(geom,5)) As np5 
       FROM public.countries_country WHERE iso = 'ITA';

CREATE OR REPLACE VIEW italia_001_1 AS
SELECT name_en, ST_Simplify(geom,0.001) as geom
       FROM public.countries_country 
       WHERE iso = 'ITA';

CREATE OR REPLACE VIEW italia_01 AS
SELECT name_en, ST_Simplify(geom,0.01) as geom
       FROM public.countries_country 
       WHERE iso = 'ITA';

CREATE OR REPLACE VIEW italia_1 AS
SELECT name_en, ST_Simplify(geom,0.1) as geom
       FROM public.countries_country 
       WHERE iso = 'ITA';


