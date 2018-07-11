SELECT ba.ba_id,ba.firedate,ba.lastupdate,em.* FROM effis.current_burnt_area ba
LEFT JOIN effis.current_burnt_area_emission em
ON ba.ba_id = em.id;