﻿select year_stats, sum(hectares_stats) from nasa_modis_ba.gwis_stats where country in ('Mexico','Honduras','El Salvador','Nicaragua','Costa Rica','Panama','Guatemala','Belize','Haiti','Dominican Republic') group by year_stats;