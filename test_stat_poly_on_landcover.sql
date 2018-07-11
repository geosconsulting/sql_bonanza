select * from effis.bas_by_adm(0,'Spain');

select name_adm,count(f_id),sum(area_ha) 
from effis.bas_by_adm(0,'Greece') 
group by name_adm;

select name_adm,count(f_id),sum(area_ha) "SUM Area HA"
from effis.bas_by_adm(0,'Spain') 
group by name_adm;


select f_id 
from effis.bas_by_adm(0,'Greece');

select * 
from effis.stats_poly_on_landcover((select f_id 
		                    from effis.bas_by_adm(0,'Greece')),'glc');