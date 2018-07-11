-- FUNCTION: pop_calculation.sum_population_by_baid_buffer(character varying)

-- DROP FUNCTION pop_calculation.sum_population_by_baid_buffer(character varying);

CREATE OR REPLACE FUNCTION pop_calculation.sum_population_by_baid_buffer(
	fire_id character varying)
    RETURNS TABLE (pop_tot double precision) -- (pop_value_pixel double precision , number_pixel bigint, sum_pop_pixel double precision) --
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$

DECLARE
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- ba of interest
     burnt_area AS(SELECT ba_id As area_id, 
		          ST_Transform(geom,54009) as geom_proj
	           FROM pop_calculation.burnt_areas as b
	           WHERE b.global_id=fire_id),
     -- clip band to boundaries then get stats for these clipped regions
     values_area AS(SELECT (stats).* 
			 FROM (SELECT ST_ValueCount(ST_Clip(rast, ST_Buffer(geom_proj,1000))) AS stats, 
				          ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		           FROM rst.ghs_pop1kx1k
				          INNER JOIN burnt_area ON ST_Intersects(burnt_area.geom_proj, rast)) AS foo)
     -- finally summarize stats
     SELECT SUM(somma_pop) FROM (
		   SELECT 
		      SUM(count) * values_area.value as somma_pop
	       FROM values_area
		   WHERE value > 0
		   GROUP BY values_area.value
	      --ORDER BY values_area.value;
		   ) t; 
END; 

$BODY$;

ALTER FUNCTION pop_calculation.sum_population_by_baid_buffer(character varying)
    OWNER TO postgres;

	
	-- FUNCTION: pop_calculation.sum_population_by_baid(character varying)

-- DROP FUNCTION pop_calculation.sum_population_by_baid(character varying);

CREATE OR REPLACE FUNCTION pop_calculation.sum_population_by_baid(
	fire_id character varying)
    RETURNS TABLE(pop_tot double precision) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$

DECLARE
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- feature of interest
     burnt_area AS(SELECT ba_id As area_id, 
		          ST_Transform(geom,54009) as geom_proj
	           FROM pop_calculation.burnt_areas as b
	           WHERE b.global_id= fire_id),
     -- clip all bands to boundaries then get stats for these clipped regions
     values_area AS(SELECT (stats).*
			 FROM (SELECT ST_ValueCount(ST_Clip(rast, geom_proj)) AS stats, ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		           FROM rst.ghs_pop1kx1k
				          INNER JOIN burnt_area ON ST_Intersects(burnt_area.geom_proj, rast)) AS foo)
     -- finally summarize stats
     SELECT SUM(somma_pop) FROM (
		   SELECT 
		      SUM(count) * values_area.value as somma_pop
	       FROM values_area
		   WHERE value > 0
		   GROUP BY values_area.value
	      --ORDER BY values_area.value;
		   ) t; 
END; 

$BODY$;

ALTER FUNCTION pop_calculation.sum_population_by_baid(character varying)
    OWNER TO postgres;

	
-- FUNCTION: pop_calculation.population_by_baid_buffer(character varying)

-- DROP FUNCTION pop_calculation.population_by_baid_buffer(character varying);

CREATE OR REPLACE FUNCTION pop_calculation.population_by_baid_buffer(
	fire_id character varying)
    RETURNS TABLE(pop_value_pixel double precision, number_pixel bigint, sum_pop_pixel double precision) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$

DECLARE
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- feature of interest
     burnt_area AS(SELECT ba_id As area_id, 
		          ST_Transform(geom,54009) as geom_proj
	           FROM pop_calculation.burnt_areas as b
	           WHERE b.global_id=fire_id),
     -- clip all bands to boundaries then get stats for these clipped regions
     values_area AS(SELECT (stats).* 
			 FROM (SELECT ST_ValueCount(ST_Clip(rast, ST_Buffer(geom_proj,1000))) AS stats, 
				          ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		           FROM rst.ghs_pop1kx1k
				          INNER JOIN burnt_area ON ST_Intersects(burnt_area.geom_proj, rast)) AS foo)
     -- finally summarize stats
     SELECT values_area.value,	       
	       SUM(count),
	       SUM(count) * values_area.value 
	       FROM values_area		  
     WHERE count > 0
	   GROUP BY values_area.value
	   ORDER BY values_area.value;
END; 

$BODY$;

ALTER FUNCTION pop_calculation.population_by_baid_buffer(character varying)
    OWNER TO postgres;

-- FUNCTION: pop_calculation.population_by_baid(character varying)

-- DROP FUNCTION pop_calculation.population_by_baid(character varying);

CREATE OR REPLACE FUNCTION pop_calculation.population_by_baid(
	fire_id character varying)
    RETURNS TABLE(pop_value_pixel double precision, number_pixel bigint, sum_pop_pixel double precision) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
    ROWS 1000
AS $BODY$

DECLARE
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- feature of interest
     burnt_area AS(SELECT ba_id As area_id, 
		          ST_Transform(geom,54009) as geom_proj
	           FROM pop_calculation.burnt_areas as b
	           WHERE b.global_id= fire_id),
     -- clip all bands to boundaries then get stats for these clipped regions
     values_area AS(SELECT (stats).*,rastpixwidth,rastpixheight
			 FROM (SELECT ST_ValueCount(ST_Clip(rast, geom_proj)) AS stats, ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		           FROM rst.ghs_pop1kx1k
				          INNER JOIN burnt_area ON ST_Intersects(burnt_area.geom_proj, rast)) AS foo)
     -- finally summarize stats
     SELECT values_area.value,	       
	       SUM(count),
	       SUM(count) * values_area.value
	       FROM values_area		  
     WHERE count > 0
	   GROUP BY values_area.value, rastpixwidth, rastpixheight
	   ORDER BY values_area.value;
END; 

$BODY$;

ALTER FUNCTION pop_calculation.population_by_baid(character varying)
    OWNER TO postgres;
	