                                                             Table "public.fire"
    Column    |         Type          | Collation | Nullable |                Default                | Storage  | Stats target | Description 
--------------+-----------------------+-----------+----------+---------------------------------------+----------+--------------+-------------
 fire_id      | integer               |           | not null | nextval('fire_fire_id_seq'::regclass) | plain    |              | 
 updated      | date                  |           |          |                                       | plain    |              | 
 area         | double precision      |           |          |                                       | plain    |              | 
 country      | character varying(14) |           |          |                                       | extended |              | 
 detected     | date                  |           |          |                                       | plain    |              | 
 meta         | integer               |           |          |                                       | plain    |              | 
 geom         | geometry(Point,4326)  |           |          |                                       | main     |              | 
 macro_region | character varying(14) |           |          |                                       | extended |              | 
 region       | character varying(14) |           |          |                                       | extended |              | 
 province     | character varying(14) |           |          |                                       | extended |              | 
Indexes:
    "fire_pk" PRIMARY KEY, btree (fire_id)
    "unique_fire" UNIQUE CONSTRAINT, btree (fire_id)
    "sidx_fire_geom" gist (geom)
Foreign-key constraints:
    "fire_metadata_fk" FOREIGN KEY (meta) REFERENCES metadata(metadata_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE
Referenced by:
    TABLE "burnt_area_forecast" CONSTRAINT "burnt_area_forecast_fire_fk" FOREIGN KEY (fire) REFERENCES fire(fire_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE
    TABLE "burnt_area_spatial" CONSTRAINT "burnt_area_spatial_fk" FOREIGN KEY (fire) REFERENCES fire(fire_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE
    TABLE "emission" CONSTRAINT "emission_fire_fk" FOREIGN KEY (fire_id) REFERENCES fire(fire_id) MATCH FULL
    TABLE "fire_emission_statistic" CONSTRAINT "fire_emission_statistics_fire_fk" FOREIGN KEY (fire) REFERENCES fire(fire_id) MATCH FULL
    TABLE "hotspot_cluster" CONSTRAINT "hotspotCluster_fire_fk" FOREIGN KEY (fire_id) REFERENCES fire(fire_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE
    TABLE "report" CONSTRAINT "report_fire_fk" FOREIGN KEY (fire) REFERENCES fire(fire_id) MATCH FULL
