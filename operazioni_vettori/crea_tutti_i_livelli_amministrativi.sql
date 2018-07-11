CREATE VIEW countries AS SELECT * FROM nuts_attr WHERE nuts_attr.stat_levl_= 0;
CREATE VIEW macro_regions AS SELECT *  FROM nuts_attr WHERE nuts_attr.stat_levl_= 1;
CREATE VIEW regions AS SELECT * FROM nuts_attr WHERE nuts_attr.stat_levl_= 2;
CREATE VIEW provinces AS SELECT * FROM nuts_attr WHERE nuts_attr.stat_levl_= 3;