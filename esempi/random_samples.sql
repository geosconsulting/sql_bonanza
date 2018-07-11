SELECT COUNT(*) from burnt_area TABLESAMPLE BERNOULLI(1);

SELECT * from burnt_area TABLESAMPLE BERNOULLI(1);

SELECT * from burnt_area TABLESAMPLE SYSTEM(1);

SELECT * from burnt_area WHERE random() < 0.01;