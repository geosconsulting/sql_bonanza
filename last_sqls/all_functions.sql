--DROP FUNCTION effis.effis_burntarea_aggregate(text);

CREATE OR REPLACE FUNCTION effis.effis_burntarea_aggregate(IN country_txt text)
  RETURNS TABLE(num_ba bigint, summed_area double precision) AS
$BODY$
BEGIN
     RETURN QUERY
     SELECT COUNT(ba.geom), 
	SUM(ST_Area(ba.geom))
     FROM effis.burnt_area_spatial ba, public.countries_country_simple cnt
     WHERE cnt.name_en = country_txt 
     AND ST_Within(ba.geom, cnt.geom);  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.effis_burntarea_aggregate(text)
  OWNER TO postgres;

-- DROP FUNCTION effis.effis_burntarea_aggregate(text, date, date);

CREATE OR REPLACE FUNCTION effis.effis_burntarea_aggregate(
    IN country_txt text,
    IN from_date date,
    IN to_date date)
  RETURNS TABLE(num_ba bigint, summed_area double precision) AS
$BODY$
BEGIN
     RETURN QUERY
     SELECT COUNT(ba.geom), 
	SUM(ST_Area(ba.geom))
     FROM public.burnt_area ba, effis.countries_country_simple cnt
     WHERE cnt.name_en = country_txt  
     AND firedate BETWEEN(from_date) AND (to_date)
     AND ST_Within(ba.geom, cnt.geom);  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.effis_burntarea_aggregate(text, date, date)
  OWNER TO postgres;

-- DROP FUNCTION effis.effis_burntarea_aggregate(text, date, date, character varying);

CREATE OR REPLACE FUNCTION effis.effis_burntarea_aggregate(
    IN country_txt text,
    IN from_date date,
    IN to_date date,
    IN split character varying)
  RETURNS TABLE(id integer, fire_date date, conifer numeric, broadleaf numeric, mixed numeric) AS
$BODY$
BEGIN
     RETURN QUERY
     SELECT ba.id, ba.firedate, ba.conifer, ba.broadlea , ba.mixed 
     FROM public.burnt_area ba, public.countries_country_simple cnt
     WHERE cnt.name_en = country_txt  
     AND firedate BETWEEN(from_date) AND (to_date)
     AND ST_Within(ba.geom, cnt.geom);  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.effis_burntarea_aggregate(text, date, date, character varying)
  OWNER TO postgres;

-- DROP FUNCTION effis.effis_burntarea_aggregate_rec(text, date, date);
CREATE OR REPLACE FUNCTION effis.effis_burntarea_aggregate_rec(
    IN country_txt text,
    IN from_date date,
    IN to_date date,
    OUT num_ba bigint,
    OUT sum_area_ba double precision)
  RETURNS record AS
$BODY$
BEGIN 
     SELECT COUNT(ba.geom), SUM(ST_Area(ba.geom))
     INTO num_ba, sum_area_ba
     FROM public.burnt_area ba, effis.countries_country_simple cnt
     WHERE cnt.name_en = country_txt  
     AND firedate BETWEEN(from_date) AND (to_date)
     AND ST_Within(ba.geom, cnt.geom);  
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION effis.effis_burntarea_aggregate_rec(text, date, date)
  OWNER TO postgres;

-- DROP FUNCTION effis.effis_burntarea_fireid_clc(integer);
CREATE OR REPLACE FUNCTION effis.effis_burntarea_fireid_clc(IN fire_id integer)
  RETURNS TABLE(landcover_code double precision, landcover_description character varying, landcover_pixel bigint, landcover_percentage double precision) AS
$BODY$
DECLARE
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- feature of interest
     burnt_area AS(SELECT id As area_id, 
		          ST_Transform(geom,3035) as geom_proj
	           FROM effis.burnt_area_spatial as b
	           WHERE b.fire= fire_id),
     -- clip all bands to boundaries then get stats for these clipped regions
     values_area AS(SELECT (stats).*,rastpixwidth,rastpixheight
			 FROM (SELECT ST_ValueCount(ST_Clip(rast, geom_proj)) AS stats,
				      ST_ScaleX(rast) As rastpixwidth, 
		                      ST_ScaleY(rast) As rastpixheight
		               FROM rst.clc_1x1k
				  INNER JOIN burnt_area ON ST_Intersects(burnt_area.geom_proj, rast)) AS foo)
     -- finally summarize stats
     SELECT values_area.value,	 
	       clc_legend.label_specific,
	       SUM(count) as num_pixels,
	       SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels
	       FROM values_area
		  INNER JOIN rst.clc_legend ON clc_legend.grid_code = values_area.value 
     WHERE count > 0
	   GROUP BY values_area.value, rastpixwidth, rastpixheight, clc_legend.label_specific
	   ORDER BY values_area.value;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.effis_burntarea_fireid_clc(integer)
  OWNER TO postgres;

-- DROP FUNCTION effis.effis_burntarea_fireid_glc(integer);
CREATE OR REPLACE FUNCTION effis.effis_burntarea_fireid_glc(IN fire_id integer)
  RETURNS TABLE(landcover_code double precision, landcover_description character varying, landcover_pixel bigint, landcover_percentage double precision) AS
$BODY$
DECLARE
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- feature of interest
     regione AS(SELECT id As area_id, geom
	      FROM effis.burnt_area_spatial as b
	      WHERE b.fire=fire_id),
     -- clip all bands to boundaries then get stats for these clipped regions
	  values_area AS(SELECT area_id, (stats).*,rastpixwidth,rastpixheight
	 	 FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS stats,
		       rid, ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		       FROM rst.glc_1x1k
		       INNER JOIN regione ON ST_Intersects(regione.geom, rast)) AS foo)
     -- finally summarize stats
	SELECT values_area.value as landcover,
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
ALTER FUNCTION effis.effis_burntarea_fireid_glc(integer)
  OWNER TO postgres;

-- DROP FUNCTION effis.effis_landcover_area(character varying);

CREATE OR REPLACE FUNCTION effis.effis_landcover_area(IN adm_name character varying)
  RETURNS TABLE(landcover_code double precision, landcover_description character varying, landcover_pixel bigint, landcover_percentage double precision) AS
$BODY$
DECLARE
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- feature of interest
     regione AS(SELECT id As area_id, geom
	      FROM public.countries_adminsublevel1  as b
	      WHERE b.name_local= adm_name),
     -- clip all bands to boundaries then get stats for these clipped regions
	  values_area AS(SELECT area_id, (stats).*,rastpixwidth,rastpixheight
	 	 FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS stats,
		       rid, ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		       FROM rst.glc_1x1k
		       INNER JOIN regione ON ST_Intersects(regione.geom, rast)) AS foo)
     -- finally summarize stats
	SELECT values_area.value as landcover,
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
ALTER FUNCTION effis.effis_landcover_area(character varying)
  OWNER TO postgres;

-- DROP FUNCTION effis.effis_landcover_fire(integer);

CREATE OR REPLACE FUNCTION effis.effis_landcover_fire(IN fire_id integer)
  RETURNS TABLE(landcover_code double precision, landcover_description character varying, landcover_pixel bigint, landcover_percentage double precision) AS
$BODY$
DECLARE
    var_r record;
BEGIN
   RETURN QUERY
     WITH
     -- feature of interest
     regione AS(SELECT id As area_id, geom
	      FROM modis_viirs.fires_1_1_2001 as b
	      WHERE b.id= fire_id),
     -- clip all bands to boundaries then get stats for these clipped regions
	  values_area AS(SELECT area_id, (stats).*,rastpixwidth,rastpixheight
	 	 FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS stats,
		       rid, ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight
		       FROM rst.glc_1x1k
		       INNER JOIN regione ON ST_Intersects(regione.geom, rast)) AS foo)
     -- finally summarize stats
	SELECT values_area.value as landcover,
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
ALTER FUNCTION effis.effis_landcover_fire(integer)
  OWNER TO postgres;

-- DROP FUNCTION effis.effis_names_amd3(character varying);

CREATE OR REPLACE FUNCTION effis.effis_names_amd3(IN adm_name character varying)
  RETURNS TABLE(name_iso character varying, name_local character varying, cca character varying, iso3 character varying) AS
$BODY$
BEGIN
 RETURN QUERY
 SELECT
	cnt.name_iso,
  adm1.name_local,
  adm1.cca,
  cnt.iso
	FROM countries_adminsublevel1 adm1
	RIGHT JOIN countries_country_simple cnt ON adm1.country_id = cnt.id
	WHERE adm1.name_local LIKE adm_name;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.effis_names_amd3(character varying)
  OWNER TO postgres;

-- DROP FUNCTION effis.effis_sum_values(text, text, text);

CREATE OR REPLACE FUNCTION effis.effis_sum_values(
    region text,
    usr text,
    pwd text)
  RETURNS double precision AS
$BODY$
	import psycopg2
	import pandas as pd

	def create_connection_db():

		params = {
			'database': 'effis',
			'user': usr,
			'password': pwd,
			'host': 'localhost',
			'port': 5432}
		conn = psycopg2.connect(**params)
		cur = conn.cursor()	    
		return conn, cur


	def query_gen(val):

		query = "WITH " \
			"region AS(SELECT id As area_id, geom" \
			" FROM public.countries_adminsublevel1  as b" \
			" WHERE b.name_local= '" + val + "')," \
                                               " values_area AS(SELECT area_id, (stats).*,rastpixwidth,rastpixheight" \
                                               " FROM (SELECT area_id, ST_ValueCount(ST_Clip(rast, geom)) AS stats," \
                                               " rid, ST_ScaleX(rast) As rastpixwidth, ST_ScaleY(rast) As rastpixheight" \
                                               " FROM rst.glc_1x1k" \
                                               " INNER JOIN region ON ST_Intersects(region.geom, rast)) AS foo)" \
                                               " SELECT values_area.value as landcover, glc_legend.value as check_legend, glc_legend.label," \
                                               "SUM(count) as num_pixels, SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels" \
                                               " FROM values_area INNER JOIN rst.glc_legend ON glc_legend.value = values_area.value" \
                                               " WHERE count > 0" \
                                               " GROUP BY area_id, values_area.value, rastpixwidth, rastpixheight, glc_legend.value, glc_legend.label" \
                                               " ORDER BY values_area.value;"

		return query

	def read_table_df(conn_pass, query):
		
		df = pd.read_sql_query(query, conn_pass)
		return df['area_pixels'].sum()    

	conn, cur = create_connection_db()
	qry = query_gen(region)	

	return read_table_df(conn, qry)
$BODY$
  LANGUAGE plpythonu VOLATILE
  COST 100;
ALTER FUNCTION effis.effis_sum_values(text, text, text)
  OWNER TO postgres;  