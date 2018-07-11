SELECT 
  n.nuts_id
FROM 
  public.nuts n
WHERE NOT EXISTS (
    SELECT 1
    FROM public.nuts_attr a
    WHERE n.nuts_id = a.nuts_id
);
