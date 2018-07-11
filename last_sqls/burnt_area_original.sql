                                             Table "public.burnt_area"
   Column   |            Type             | Collation | Nullable | Default | Storage  | Stats target | Description 
------------+-----------------------------+-----------+----------+---------+----------+--------------+-------------
 gid        | integer                     |           | not null |         | plain    |              | 
 objectid   | numeric(10,0)               |           |          |         | main     |              | 
 id         | integer                     |           |          |         | plain    |              | 
 country    | character varying(2)        |           |          |         | extended |              | 
 countryful | character varying(100)      |           |          |         | extended |              | 
 province   | character varying(60)       |           |          |         | extended |              | 
 commune    | character varying(50)       |           |          |         | extended |              | 
 firedate   | date                        |           |          |         | plain    |              | 
 area_ha    | integer                     |           |          |         | plain    |              | 
 broadlea   | numeric                     |           |          |         | main     |              | 
 conifer    | numeric                     |           |          |         | main     |              | 
 mixed      | numeric                     |           |          |         | main     |              | 
 scleroph   | numeric                     |           |          |         | main     |              | 
 transit    | numeric                     |           |          |         | main     |              | 
 othernatlc | numeric                     |           |          |         | main     |              | 
 agriareas  | numeric                     |           |          |         | main     |              | 
 artifsurf  | numeric                     |           |          |         | main     |              | 
 otherlc    | numeric                     |           |          |         | main     |              | 
 percna2k   | numeric                     |           |          |         | main     |              | 
 lastupdate | character varying(10)       |           |          |         | extended |              | 
 class      | character varying(6)        |           |          |         | extended |              | 
 mic        | character varying(5)        |           |          |         | extended |              | 
 critech    | character varying(3)        |           |          |         | extended |              | 
 shape_area | numeric                     |           |          |         | main     |              | 
 shape_len  | numeric                     |           |          |         | main     |              | 
 geom       | geometry(MultiPolygon,4326) |           |          |         | main     |              | 
 fire       | integer                     |           |          |         | plain    |              | 
Indexes:
    "burnt_area_pk" PRIMARY KEY, btree (gid)
    "id_UQ" UNIQUE CONSTRAINT, btree (id)
    "sidx_burnt_area_geom" gist (geom)
Foreign-key constraints:
    "burnt_area_fk" FOREIGN KEY (fire) REFERENCES fire(fire_id) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE
Referenced by:
    TABLE "fire_environmental_damage_statistic" CONSTRAINT "feds_burntarea_fk" FOREIGN KEY (feds_id) REFERENCES burnt_area(gid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE
    TABLE "fire_population_damage_statistic" CONSTRAINT "fpds_burntarea_fk" FOREIGN KEY (fpds_id) REFERENCES burnt_area(gid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE
    TABLE "intensity" CONSTRAINT "intensity_burntarea_fk" FOREIGN KEY (evo_id) REFERENCES burnt_area(id) MATCH FULL

