select effis_index,gwis_index,effis_start_date,gwis_start_date,effis_last_date,gwis_last_date,initial_days_diff,final_days_diff,distance,similarity
from cross_effis_nasamodis.cross_distance 
where effis_start_date between '2015-01-01' and '2016-06-30' 
and distance < 1500 
and initial_days_diff between -2 and  5 limit 50;

select avg(initial_days_diff),avg(final_days_diff)
from cross_effis_nasamodis.cross_distance 
where effis_start_date between '2015-01-01' and '2016-06-30' 
and distance < 1500 
and initial_days_diff between -2 and 5;

select avg(initial_days_diff),avg(final_days_diff)
from cross_effis_nasamodis.cross_distance 
where effis_start_date between '2015-01-01' and '2016-06-30' 
and distance < 1500;

select avg(initial_days_diff),avg(final_days_diff)
from cross_effis_nasamodis.cross_distance 
where effis_start_date between '2015-01-01' and '2016-06-30' 
and distance < 500;

select avg(initial_days_diff),avg(final_days_diff)
from cross_effis_nasamodis.cross_distance 
where effis_start_date between '2015-01-01' and '2016-06-30' 
and distance = 0;

select avg(initial_days_diff),avg(final_days_diff)
from cross_effis_nasamodis.cross_distance 
where effis_start_date between '2016-01-01' and '2016-12-31';

