SELECT * FROM dblink('dbname=modis_virs', 'SELECT gid,type,idate FROM public."Fires_Europe_1_10_2001"') 
AS t1(gid numeric,type text,idate date)
WHERE type = 'ActiveArea'
LIMIT 10; 