GRANT USAGE ON SCHEMA effis TO effis_viewers;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA effis TO effis_viewers;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA effis TO effis_viewers;
GRANT SELECT ON ALL TABLES IN SCHEMA effis TO effis_viewers;

GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO effis_viewers;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO effis_viewers;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO effis_viewers;

GRANT USAGE ON SCHEMA modis_viirs TO effis_viewers;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA modis_viirs TO effis_viewers;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA modis_viirs TO effis_viewers;
GRANT SELECT ON ALL TABLES IN SCHEMA modis_viirs TO effis_viewers;

GRANT USAGE ON SCHEMA nasa_modis_ba TO effis_viewers;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA nasa_modis_ba TO effis_viewers;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA nasa_modis_ba TO effis_viewers;
GRANT SELECT ON ALL TABLES IN SCHEMA nasa_modis_ba TO effis_viewers;