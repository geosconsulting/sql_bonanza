SELECT * FROM (SELECT objectid,ROW_NUMBER() OVER(PARTITION BY objectid ORDER BY id ASC) AS Row FROM rdaprd.from2000_burntareas) dups WHERE dups.Row > 1;