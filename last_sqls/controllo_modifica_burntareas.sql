SELECT id,activity,time_activity,
	   before_value->>'objectid' AS "Assigned ID",
	   after_value->>'objectid' AS "Modified ID",
	   after_value->>'fire' AS "Assigned Fire ID" 
FROM effis.burnt_area_registry;


SELECT id,activity,time_activity,
before_value->>'objectid' AS "Original ID",
after_value->>'objectid' AS "Modified ID",
after_value->>'Fire' AS "Connected Fire" 
FROM effis.burnt_area_registry;

SELECT effis.select_candidate_fire_options('n',100);

SELECT id,activity,time_activity,
before_value->>'objectid' AS "Original ID",
after_value->>'objectid' AS "Modified ID",
after_value->>'fire' AS "Connected Fire" 
FROM effis.burnt_area_registry;

SELECT id,activity,ST_Equals(before_value->>'shape', after_value->>'shape') FROM effis.burnt_area_registry ORDER BY time_activity;