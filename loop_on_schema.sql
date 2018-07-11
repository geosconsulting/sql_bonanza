-- select count(id) from nasa_modis_ba.final_burnt_areas_2001;

DO $$
DECLARE
    tables CURSOR FOR
        SELECT tablename
        FROM pg_tables
        --WHERE tablename NOT LIKE 'pg_%'
        WHERE schemaname = 'nasa_modis_ba'
        AND tablename LIKE 'final_burnt_%'
        ORDER BY tablename;
    nbRow int;
BEGIN
    FOR table_record IN tables LOOP
        EXECUTE 'SELECT count(*) FROM nasa_modis_ba.' || table_record.tablename INTO nbRow;
        raise notice 'Num records % in %', nbRow,table_record;
    END LOOP;
END$$;