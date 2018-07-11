select c.id,c.name_en,r.region 
from admin_level_0 c, region r , admin_level_0_regions l 
where r.region = 'Western Africa' 
and c.id = l.country_id
and r.id = l.region_id;

select * from nasa_modis_ba.stats_modis_ba_view(2001,2001,'Central America');

drop function nasa_modis_ba.glc_by_finalba_id_by_region(integer,varchar);

CREATE OR REPLACE FUNCTION nasa_modis_ba.glc_by_finalba_id_by_region(    
    IN year_of_interest integer,
    IN region_of_interest varchar)
  RETURNS TABLE(ba_id integer,landcover_code double precision, landcover_description character varying, landcover_pixel bigint, landcover_percentage double precision) AS
$BODY$
DECLARE
    starting_date date := year_of_interest || '-01-01';
    --ending_date date := year_of_interest || '-12-31';
    ending_date date := year_of_interest || '-01-05';
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- feature of interest
     ba_area AS(SELECT b.ogc_fid As area_id, b.geom
	      FROM nasa_modis_ba.final_ba as b
	        join public.admin_level_0 as a on st_contains(a.geom,b.geom)
	      WHERE b.initialdate between starting_date and ending_date 
	      and a.name_en in (select country_name from region_aggregate(region_of_interest))),
     -- clip all bands to boundaries then get stats for these clipped regions
     values_area AS(SELECT area_id, (stats).*,rastpixwidth,rastpixheight
	         FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS stats,
		       ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		       FROM rst.glc_1x1k
		          INNER JOIN ba_area ON ST_Intersects(ba_area.geom, rast)) AS foo)
     -- finally summarize stats
	SELECT --ba_area.area_id,
	       values_area.area_id,
	       values_area.value,
	       glc_legend.label,
	       SUM(count) as num_pixels,
	       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
	       FROM values_area
	       INNER JOIN rst.glc_legend ON glc_legend.value = values_area.value
	WHERE count > 0
	   GROUP BY area_id, values_area.value, rastpixwidth, rastpixheight, glc_legend.value, glc_legend.label
	   ORDER BY values_area.value;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION nasa_modis_ba.glc_by_finalba_id(integer, integer)
  OWNER TO postgres;

select * from nasa_modis_ba.glc_by_finalba_id_by_region(2001,'Central America');



