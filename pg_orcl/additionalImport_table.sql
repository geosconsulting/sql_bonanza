﻿IMPORT FOREIGN SCHEMA "RDAPRD" 
--LIMIT TO(CURRENT_BURNTAREASPOLY,EMISSIONS,EMISSIONS_FIRES,FROM2000_BURNTAREAS)
--LIMIT TO(FROM2000_BURNTAREAS)
LIMIT TO(FROM2000_BURNTAREAS)
FROM SERVER esposito_orcl 
INTO rdaprd;