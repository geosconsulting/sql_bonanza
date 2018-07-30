select extract(year from fba.initialdate),count(fba.id),sum(ST_Area(fba.geom::geography))*0.0001 as "cumulated area"
from nasa_modis_ba.final_ba fba
inner join public.admin_level_0 ad0 on ST_Within(fba.geom,ad0.geom)
where ad0.iso2='SK'
group by extract(year from initialdate);

select extract(year from fba.initialdate),fba.id,ST_Area(fba.geom::geography)*0.0001 as area
from nasa_modis_ba.final_ba fba
inner join public.admin_level_0 ad0 on ST_Within(fba.geom,ad0.geom)
where ad0.iso2='SK';

SELECT ba_id As area_id, ST_Transform(fba.geom,3035) as geom_proj
	      FROM effis.current_burnt_area as fba
	         inner join public.admin_level_0 ad0 on ST_Within(fba.geom,ad0.geom)
              where ad0.iso2='FR';

CREATE OR REPLACE FUNCTION nasa_modis_ba.clc_by_bas_country_landcover_aggregate(
	country_iso2 character varying)
    RETURNS TABLE(landcover_code double precision, landcover_description character varying, landcover_pixel bigint) --, landcover_percentage double precision
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
     ba_area AS(SELECT extract(year from fba.initialdate) as year_analysis, ST_Transform(fba.geom,3035) as geom_proj
	      FROM nasa_modis_ba.final_ba as fba
	         inner join public.admin_level_0 ad0 on ST_Within(fba.geom,ad0.geom)
              where ad0.iso2=country_iso2),
     -- clip all bands to boundaries then get stats for these clipped regions
	  values_area AS(SELECT year_analysis, (stats).*, rastpixwidth, rastpixheight
	 	 FROM (SELECT year_analysis, ST_ValueCount(ST_Clip(rast, geom_proj)) AS stats,
		       ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		       FROM rst.clc_1x1k
		          INNER JOIN ba_area ON ST_Intersects(ba_area.geom_proj, rast)) AS foo)
     -- finally summarize stats
	SELECT values_area.value,
	       clc_legend.label,
	       SUM(count) as num_pixels--,
	       --SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
	       FROM values_area
	       INNER JOIN rst.clc_legend ON clc_legend.id = values_area.value
	WHERE count > 0
	   GROUP BY values_area.value , rastpixwidth, rastpixheight, clc_legend.label -- area_id,
	   ORDER BY values_area.value;
END; 

$BODY$;

ALTER FUNCTION effis.clc_by_bas_country_landcover_aggregate(character varying)
    OWNER TO postgres;

    
