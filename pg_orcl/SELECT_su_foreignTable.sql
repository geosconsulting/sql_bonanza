SELECT * FROM rdaprd.emissions_nuts LIMIT 10;

SELECT DISTINCT(year) FROM rdaprd.emissions_nuts;

SELECT avg(co2),avg(co) FROM rdaprd.emissions_nuts WHERE substring(nuts_code,0,2) = 'IT';

EXPLAIN ANALYZE SELECT avg(co2),avg(co) FROM rdaprd.emissions_nuts WHERE substring(nuts_code,0,2) = 'IT';