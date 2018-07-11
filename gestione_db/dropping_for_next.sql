DROP FUNCTION public.dsp_fcn_9_source_trigger() CASCADE;
DROP FUNCTION public.dsp_fcn_9_target_trigger() CASCADE;

DO $$
DECLARE 
  nome_tab text;
BEGIN 
FOR i IN 4..9 LOOP
  nome_tab := 'public.dsp_fcn_' || i || '_source_trigger()';
  RAISE NOTICE 'Dropping %',nome_tab;
  --DROP FUNCTION nome_tab || CASCADE;
END LOOP;
END
$$;

SELECT CONCAT('public.dsp_fcn_', 4 , '_source_trigger()');