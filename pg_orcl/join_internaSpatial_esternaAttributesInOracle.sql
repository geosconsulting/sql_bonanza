SELECT i.ba_id,i.area_ha,i.firedate
      ,e.broadlea,e.conifer,e.mixed,e.scleroph,e.transit,e.othernatlc,e.agriareas,e.artifsurf,e.otherlc,e.percna2k
FROM effis.current_burnt_area i, rdaprd.current_burntareaspoly e 
WHERE i.ba_id = e.id;


SELECT i.ba_id,i.area_ha,i.firedate
      ,e.country,e.countryful,e.province,e.commune
FROM effis.current_burnt_area i, rdaprd.current_burntareaspoly e 
WHERE i.ba_id = e.id;


SELECT i.ba_id,i.area_ha,i.firedate
      ,e.countryfullname,e.province,e.place_name
FROM effis.current_burnt_area_evolution i, rdaprd.current_firesevolution e 
WHERE i.ba_id = e.id;


SELECT i.ba_id,i.area_ha,i.firedate
      ,e.broadleavedforest,e.coniferous,e.mixed,e.sclerophyllous,e.transitional
      ,e.othernatland,e.agriareas,e.artsurf,e.otherlandcover,e.percnat2k
FROM effis.current_burnt_area_evolution i, rdaprd.current_firesevolution e 
WHERE i.ba_id = e.id;

