﻿SELECT place_name,firedate,lastupdate,ST_Area(shape) FROM effis.current_firesevolution WHERE province='Haute-Corse' AND place_name LIKE 'Sant%' ORDER BY lastupdate;