select count(id) from rdaprd.emissions_fires;

select count(id) from rdaprd.current_burntareaspoly;

SELECT id 
FROM rdaprd.emissions_fires a
WHERE NOT EXISTs (SELECT id
                 FROM rdaprd.current_burntareaspoly b
                 WHERE a.id = b.id);