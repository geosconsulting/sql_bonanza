-- Function: effis.select_candidate_fire_options(character, integer)

-- DROP FUNCTION effis.select_candidate_fire_options(character, integer);

CREATE OR REPLACE FUNCTION effis.select_candidate_fire_options(
    node_selection character,
    ba_id integer)
  RETURNS integer AS
$BODY$
DECLARE
  candidate_node integer := 0;
BEGIN
   IF node_selection = 'n' THEN
      SELECT INTO candidate_node punti.fire_id 
      FROM effis.current_burntareaspoly poly, effis.fire punti
      WHERE poly.objectid = ba_id 
      AND ST_DWithin(poly.shape, punti.geom, 10000)
      ORDER BY ST_Distance(poly.shape, punti.geom) LIMIT 1;      
    ELSEIF node_selection = 'c' THEN         
      INSERT INTO effis.fire(fire_id, geom)
      SELECT objectid, ST_Centroid(shape) AS geom
      FROM effis.current_burntareaspoly
      WHERE objectid = ba_id;   

      candidate_node := ba_id; 
    ELSEIF node_selection = 'k' THEN
      --APPLICO KNN <-> e calcolo distanza
	SELECT INTO candidate_node fire_id,
	       ST_Distance(ST_Centroid(ba.shape),fi.geom) AS distance
	FROM effis.fire fi,effis.current_burntareaspoly ba
	WHERE ba.objectid = ba_id
	ORDER BY fi.geom <-> ba.shape
        OFFSET 1
	LIMIT 1;
    END IF;

    RAISE NOTICE 'Candidate for burnt area % is node %', ba_id,candidate_node;
    UPDATE effis.current_burntareaspoly SET fire = candidate_node WHERE objectid = ba_id;     

    RETURN candidate_node;
       
END;	
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION effis.select_candidate_fire_options(character, integer)
  OWNER TO postgres;
