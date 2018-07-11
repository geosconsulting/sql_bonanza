EXPLAIN SELECT modis_id,acq_date FROM modis_viirs.modis WHERE acq_date > '2014-04-15'::date AND acq_date < '2014-06-22'::date;

EXPLAIN SELECT modis_id,acq_date FROM modis_viirs.modis WHERE acq_date > '2016-04-15'::date AND acq_date < '2016-06-22'::date;

EXPLAIN SELECT objectid,hs_date FROM rdaprd.filtered_modis_hotspots WHERE hs_date > '2016-04-15'::date AND hs_date < '2016-06-22'::date;

EXPLAIN SELECT objectid,hs_date FROM rdaprd.filtered_modis_hotspots WHERE hs_date > '2014-04-15'::date AND hs_date < '2014-06-22'::date;

