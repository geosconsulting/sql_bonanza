                                                                         Table "public.fire_environmental_damage_statistic"
         Column          |       Type       | Collation | Nullable |                             Default                             | Storage | Stats target |             Description              
-------------------------+------------------+-----------+----------+-----------------------------------------------------------------+---------+--------------+--------------------------------------
 feds_id                 | integer          |           | not null | nextval('fire_environmental_damage_statistic_id_seq'::regclass) | plain   |              | FEDS                                +
                         |                  |           |          |                                                                 |         |              | Fire Environmental Damage Statistics
 burnt_area              | integer          |           |          |                                                                 | plain   |              | 
 agricultural_area       | double precision |           |          |                                                                 | plain   |              | 
 artificial_surface      | double precision |           |          |                                                                 | plain   |              | 
 broad_leaved_forest     | double precision |           |          |                                                                 | plain   |              | 
 coniferous              | double precision |           |          |                                                                 | plain   |              | 
 mixed                   | double precision |           |          |                                                                 | plain   |              | 
 other_land_cover        | double precision |           |          |                                                                 | plain   |              | 
 other_natural_landcover | double precision |           |          |                                                                 | plain   |              | 
 percentage_natura2k     | double precision |           |          |                                                                 | plain   |              | 
 sclerophyllous          | double precision |           |          |                                                                 | plain   |              | 
 transitional            | double precision |           |          |                                                                 | plain   |              | 
Indexes:
    "fire_environmental_damage_statistic_pk" PRIMARY KEY, btree (feds_id)
Foreign-key constraints:
    "feds_burntarea_fk" FOREIGN KEY (feds_id) REFERENCES burnt_area(gid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE

                                                                   Table "public.fire_population_damage_statistic"
         Column         |   Type   | Collation | Nullable |                           Default                            | Storage | Stats target |            Description            
------------------------+----------+-----------+----------+--------------------------------------------------------------+---------+--------------+-----------------------------------
 fpds_id                | integer  |           | not null | nextval('fire_population_damage_statistic_id_seq'::regclass) | plain   |              | FPDS                             +
                        |          |           |          |                                                              |         |              |                                  +
                        |          |           |          |                                                              |         |              | Fire Population Damage Statistics
 buffer_size            | integer  |           |          |                                                              | plain   |              | 
 fire_builtup_area      | integer  |           |          |                                                              | plain   |              | 
 fire_forecast          | smallint |           |          |                                                              | plain   |              | 
 fire_pop_avg           | integer  |           |          |                                                              | plain   |              | 
 fire_pop_peak          | integer  |           |          |                                                              | plain   |              | 
 fire_pop_total         | integer  |           |          |                                                              | plain   |              | 
 on_forecast            | boolean  |           |          |                                                              | plain   |              | 
 potential_builtup_area | integer  |           |          |                                                              | plain   |              | 
 potential_pop_avg      | integer  |           |          |                                                              | plain   |              | 
 potential_pop_peak     | integer  |           |          |                                                              | plain   |              | 
 potential_pop_total    | integer  |           |          |                                                              | plain   |              | 
 integer                | smallint |           |          |                                                              | plain   |              | 
Indexes:
    "firePopulationDamageStatistic_pk" PRIMARY KEY, btree (fpds_id)
Foreign-key constraints:
    "fpds_burntarea_fk" FOREIGN KEY (fpds_id) REFERENCES burnt_area(gid) MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE