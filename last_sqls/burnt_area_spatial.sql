                                Materialized view "public.burnt_area_spatial"
   Column   |         Type          | Collation | Nullable | Default | Storage  | Stats target | Description 
------------+-----------------------+-----------+----------+---------+----------+--------------+-------------
 id         | integer               |           |          |         | plain    |              | 
 area_ha    | integer               |           |          |         | plain    |              | 
 firedate   | character varying(10) |           |          |         | extended |              | 
 lastupdate | character varying(10) |           |          |         | extended |              | 
 class      | character varying(6)  |           |          |         | extended |              | 
 geom       | geometry              |           |          |         | main     |              | 
View definition:
 SELECT current_burntareaspoly.id,
    current_burntareaspoly.area_ha,
    current_burntareaspoly.firedate,
    current_burntareaspoly.lastupdate,
    current_burntareaspoly.class,
    current_burntareaspoly.shape AS geom
   FROM rdaprd.current_burntareaspoly;

