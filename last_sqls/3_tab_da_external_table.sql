SELECT ba.id, fi.fire_id
FROM
  effis.current_burntareaspoly ba,
  effis.fire fi
WHERE ba.objectid = 450
ORDER BY ST_Distance(ba.shape, fi.geom) ASC
LIMIT 1;