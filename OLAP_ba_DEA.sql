INSERT INTO effis.current_burnt_area 
SELECT id,
    area_ha,    
    firedate,    
    lastupdate,
    --ST_Transform(shape,4326)
    ST_SetSRID(shape,4326)
FROM rdaprd.rob_burntareas;

create table effis.rob_firesevolution (like rdaprd.rob_firesevolution);

INSERT INTO effis.rob_firesevolution
SELECT *
FROM rdaprd.rob_firesevolution;

select lo.countryfullname as paese,
       extract(year from lo.firedate::date) as "Anno",
       extract(Month from lo.firedate::date) as "Mese",
       SUM(s.area_ha) as "Sum Ha"
from rdaprd.rob_burntareas s
     left join effis.rob_firesevolution lo on (lo.id = s.id)     
group by grouping sets ((paese, "Anno","Mese"), paese);