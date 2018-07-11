BEGIN;
DROP VIEW IF EXISTS effis.modis_burnt_areas CASCADE;
CREATE VIEW effis.modis_burnt_areas AS (
            SELECT CASE 
			WHEN extract(year FROM firedate::DATE) IS NULL THEN '9999_' || archived_and_current.ba_id
			ELSE extract(year FROM firedate::DATE) || '_' || archived_and_current.ba_id
		      END AS global_id,                      
              archived_and_current.ba_id AS ba_id,
		      archived_and_current.area_ha AS area_ha,
		      archived_and_current.firedate AS firedate,
		      archived_and_current.lastupdate AS lastupdate,
		      archived_and_current.geom As geom
                    FROM (
			 SELECT ba_id,
			        area_ha,
				firedate,
				lastupdate,
				geom
			 FROM effis.current_burnt_area
			 UNION
			 SELECT ba_id,
			        area_ha,
			        firedate,
			        lastupdate,
			        geom
			 FROM effis.archived_burnt_area
			 ) AS archived_and_current);
COMMIT;

BEGIN;
DROP TABLE IF EXISTS effis.burnt_areas CASCADE;
CREATE TABLE effis.burnt_areas AS SELECT * FROM effis.modis_burnt_areas;
ALTER TABLE effis.burnt_areas ADD PRIMARY KEY(global_id);

CREATE INDEX sidx_burnt_areas
  ON effis.burnt_areas
  USING gist
  (geom);

CREATE INDEX idx_burnt_areas_firedate
  ON effis.burnt_areas
  USING btree
  (firedate);

CREATE INDEX idx_burnt_areas_lastupdate
  ON effis.burnt_areas
  USING btree
  (lastupdate);
COMMIT;


DROP VIEW IF EXISTS effis.modis_burnt_areas CASCADE;
DROP TABLE IF EXISTS effis.burnt_areas CASCADE;