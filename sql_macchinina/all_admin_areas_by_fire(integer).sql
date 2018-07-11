-- Function: effis.all_admin_areas_by_fire(integer)

-- DROP FUNCTION effis.all_admin_areas_by_fire(integer);

CREATE OR REPLACE FUNCTION effis.all_admin_areas_by_fire(IN search_fire_id integer)
  RETURNS TABLE(fid integer, admin_id integer, fire_date date, fire_update date, adm3_name character varying, adm2_name character varying, adm1_name character varying, country_name character varying) AS
$BODY$
BEGIN
   RETURN QUERY
	SELECT a.fire_id,a.adm3_id,
	       b.firedate::date,b.lastupdate::date,
	       c.name_en,d.name_en,e.name_local,f.name_en
	FROM mm.fire_adm3 a
	   LEFT JOIN effis.burnt_area_spatial b ON(a.fire_id = b.id)
	   LEFT JOIN effis.adm3 c ON(a.adm3_id = c.id)
	   LEFT JOIN effis.adm2 d ON(c.admin2_id = d.id)
	   LEFT JOIN effis_ext_public.countries_adminsublevel1 e ON(c.admin1_id = e.id)
	   LEFT JOIN effis_ext_public.countries_country f ON(c.country_id = f.id)
	WHERE a.fire_id = search_fire_id
	ORDER BY d.name_en;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION effis.all_admin_areas_by_fire(integer)
  OWNER TO postgres;
