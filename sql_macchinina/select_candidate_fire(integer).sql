-- Function: effis.select_candidate_fire(integer)

-- DROP FUNCTION effis.select_candidate_fire(integer);

CREATE OR REPLACE FUNCTION effis.select_candidate_fire(ba_code integer)
  RETURNS integer AS
$BODY$
	SELECT punti.fire_id 
	FROM effis.current_burntareaspoly poly, effis.fire punti
	WHERE poly.objectid = ba_code 
	AND ST_DWithin(poly.shape, punti.geom, 10000)
	ORDER BY ST_Distance(poly.shape, punti.geom) LIMIT 1;
$BODY$
  LANGUAGE sql VOLATILE
  COST 100;
ALTER FUNCTION effis.select_candidate_fire(integer)
  OWNER TO postgres;
