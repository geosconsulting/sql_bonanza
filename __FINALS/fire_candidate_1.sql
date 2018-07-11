SELECT foo.* from 
  (SELECT MIN(ST_DISTANCE(a.geom,ST_ClosestPoint(b.geom,a.geom))) 
   FROM effis.burnt_area_spatial a,effis.fire b 
   WHERE a.fire = 2357) foo;

SELECT punti.fire_id 
FROM effis.burnt_area_spatial poly, effis.fire punti
WHERE poly.id = 2357 
AND ST_DWithin(poly.geom, punti.geom, 1000)
ORDER BY ST_Distance(poly.geom, punti.geom) LIMIT 5;

SELECT * FROM effis.burnt_area_spatial poly WHERE poly.id = 2357;

SELECT MAX(id) FROM effis.burnt_area_spatial;

DROP FUNCTION effis.select_candidate_fire(integer);

CREATE OR REPLACE FUNCTION effis.select_candidate_fire(ba_code integer)
    RETURNS integer AS $$
	SELECT punti.fire_id 
	FROM effis.current_burntareaspoly poly, effis.fire punti
	WHERE poly.objectid = ba_code 
	AND ST_DWithin(poly.shape, punti.geom, 10000)
	ORDER BY ST_Distance(poly.shape, punti.geom) LIMIT 1;
$$ LANGUAGE sql;

CREATE OR REPLACE FUNCTION effis.select_candidate_fire_options(node_selection character,ba_id integer)
    RETURNS integer AS $$
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
    END IF;

    RAISE NOTICE 'Candidate for burnt area % is node %', ba_id,candidate_node;
    UPDATE effis.current_burntareaspoly SET fire = candidate_node WHERE objectid = ba_id;     

    RETURN candidate_node;
       
END;	
$$ LANGUAGE plpgsql;
