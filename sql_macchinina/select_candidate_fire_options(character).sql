-- Function: effis.select_candidate_fire_options(character)

-- DROP FUNCTION effis.select_candidate_fire_options(character);

CREATE OR REPLACE FUNCTION effis.select_candidate_fire_options(node_selection character)
  RETURNS integer AS
$BODY$
DECLARE
  candidate integer := 0;
BEGIN
   IF node_selection = 'n' THEN
      SELECT INTO candidate punti.fire_id 
      FROM effis.current_burntareaspoly poly, effis.fire punti
      WHERE poly.objectid = 450 
      AND ST_DWithin(poly.shape, punti.geom, 10000)
      ORDER BY ST_Distance(poly.shape, punti.geom) LIMIT 1;
      RETURN candidate;
    ELSEIF node_selection = 'c' THEN
      RAISE NOTICE 'Centroide';
    END IF;
END;	
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION effis.select_candidate_fire_options(character)
  OWNER TO postgres;
