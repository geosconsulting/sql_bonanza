-- create a copy of the result of view_a

CREATE TABLE macro_regions_stable AS SELECT * FROM macro_regions;

CREATE TABLE regions_stable AS SELECT * FROM regions;

CREATE TABLE provinces_stable AS SELECT * FROM provinces;