--SELECT count (1)
--    FROM table_a a
--    FULL OUTER JOIN table_b b 
--        USING (<list of columns to compare>)
--    WHERE a.id IS NULL
--        OR b.id IS NULL ;		

SELECT count (1)
    FROM rdaprd_esposito.current_burntareaspoly a
    FULL OUTER JOIN effis.current_burnt_area b ON a.id = b.ba_id
    WHERE a.id IS NULL
        OR b.ba_id IS NULL;