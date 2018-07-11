create function egeos.jsonb_array_append(j jsonb, e text)
returns jsonb language sql immutable
as $$
    select array_to_json(array_append(array(select * from jsonb_array_elements_text(j)), e))::jsonb 
$$;

create function egeos.jsonb_array_remove(j jsonb, e text)
returns jsonb language sql immutable
as $$
    select array_to_json(array_remove(array(select * from jsonb_array_elements_text(j)), e))::jsonb 
$$;

create function egeos.jsonb_array_replace(j jsonb, e1 text, e2 text)
returns jsonb language sql immutable
as $$
    select array_to_json(array_replace(array(select * from jsonb_array_elements_text(j)), e1, e2))::jsonb 
$$;