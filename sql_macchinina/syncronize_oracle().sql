-- Function: effis.syncronize_oracle()

-- DROP FUNCTION effis.syncronize_oracle();

CREATE OR REPLACE FUNCTION effis.syncronize_oracle()
  RETURNS character varying AS
$BODY$
--declare stato varchar;
begin
     select 
     result,
     CASE
     WHEN EXISTS
            ( SELECT *
              FROM effis.current_burnt_area a NATURAL FULL JOIN rdaprd.current_burntareaspoly b
              WHERE a.ba_id IS NULL 
                 OR b.id IS NULL
            )
            THEN 'different'
            ELSE 'same'
       END AS result;
              
       return result;
end;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION effis.syncronize_oracle()
  OWNER TO postgres;
