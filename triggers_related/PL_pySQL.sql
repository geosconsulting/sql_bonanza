DROP FUNCTION __fnfileexists(text);
CREATE OR REPLACE FUNCTION __fnfileexists(IN afilename text) RETURNS boolean AS
$$
	import os	
	return os.path.exists(afilename)
$$
LANGUAGE 'plpythonu' VOLATILE;
SELECT __fnfileexists('/home/jrc/Downloads/README.oracle_fdw');

DROP FUNCTION __conta_lettere(text);
CREATE OR REPLACE FUNCTION __conta_lettere(IN stringa text) RETURNS integer AS
$$
    return len(stringa)
$$
LANGUAGE 'plpythonu' VOLATILE;
SELECT __conta_lettere('Fabio');

CREATE EXTENSION plpythonu;

DROP FUNCTION effis_sum_values(IN region TEXT,IN usr TEXT,IN pwd text);

CREATE OR REPLACE FUNCTION effis_sum_values(IN region TEXT,IN usr TEXT,IN pwd text) RETURNS float8 AS
$$
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
                                               " FROM public.glc_1x1k" \
                                               " INNER JOIN region ON ST_Intersects(region.geom, rast)) AS foo)" \
                                               " SELECT values_area.value as landcover, glc_legend.value as check_legend, glc_legend.label," \
                                               "SUM(count) as num_pixels, SUM(count) * ABS(rastpixwidth) * ABS(rastpixheight) as area_pixels" \
                                               " FROM values_area INNER JOIN glc_legend ON glc_legend.value = values_area.value" \
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
$$
LANGUAGE 'plpythonu' VOLATILE;

SELECT effis_sum_values('Sicily','postgres','antarone');