SELECT * FROM countries_adminsublevel4 LIMIT 50;

SELECT DISTINCT hasc,name_iso,name_alt,valid_to, valid_since FROM countries_adminsublevel4;

ALTER TABLE countries_adminsublevel4 DROP COLUMN name_iso CASCADE, 
				     DROP COLUMN hasc CASCADE,
                                     DROP COLUMN name_alt CASCADE, 
				     DROP COLUMN valid_to CASCADE, 
				     DROP COLUMN valid_since CASCADE; 

ALTER TABLE countries_adminsublevel4 DROP COLUMN centroid CASCADE, DROP COLUMN envelope CASCADE; 