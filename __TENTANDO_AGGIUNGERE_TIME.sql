select *
from effis.burnt_areas ba_int 
  join (select id as id_dea,lastfiredate,lastfiretime 
		from rdaprd.rob_burntareas) as ba_ext 
on ba_int.ba_id = ba_ext.id_dea;

select *
from effis.modis_burnt_areas ba_int 
  join (select id as id_dea,lastfiredate,lastfiretime 
		from rdaprd.rob_burntareas) as ba_ext 
on ba_int.ba_id = ba_ext.id_dea;

SELECT 
    CASE 
      WHEN yearseason IS NULL THEN '9999_' || archived_and_current.ba_id
      ELSE yearseason || '_' || archived_and_current.ba_id
    END AS global_id,                      
    archived_and_current.ba_id AS ba_id,
    archived_and_current.area_ha AS area_ha,
    archived_and_current.firedate AS firedate,
    archived_and_current.lastupdate AS lastupdate,
    archived_and_current.geom As geom
    FROM (SELECT ba_id,area_ha,firedate,lastupdate,extract(year from firedate::DATE) as yearseason,geom 
          FROM effis.current_burnt_area 
          UNION 
          SELECT ba_id,area_ha,firedate,lastupdate,yearseason,geom        
          FROM effis.archived_burnt_area) AS archived_and_current;
		  
SELECT 
    CASE 
      WHEN yearseason IS NULL THEN '9999_' || archived_and_current.ba_id
      ELSE yearseason || '_' || archived_and_current.ba_id
    END AS global_id,                      
    archived_and_current.ba_id AS ba_id,
    archived_and_current.area_ha AS area_ha,
    archived_and_current.firedate AS firedate,
    archived_and_current.lastupdate AS lastupdate,
    archived_and_current.geom As geom
    FROM (SELECT ba_id,area_ha,firedate,lastupdate,extract(year from firedate::DATE) as yearseason,geom 
          FROM effis.current_burnt_area 
          UNION 
          SELECT ba_id,area_ha,firedate,lastupdate,yearseason,geom        
          FROM effis.archived_burnt_area) AS archived_and_current; 
		  
