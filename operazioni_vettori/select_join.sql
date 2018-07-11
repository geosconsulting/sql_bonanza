SELECT * FROM test_table JOIN table_altra_ext ON(test_table.altra_fk = table_altra_ext.chiave_esterna) WHERE altra_fk = 200;

SELECT * FROM test_table JOIN test_table_ext ON(test_table.test_fk = test_table_ext.test_char) WHERE test_fk = 'ABCD';

SELECT * 
FROM test_table 
	LEFT JOIN table_altra_ext ON(test_table.altra_fk = table_altra_ext.chiave_esterna)
	LEFT JOIN test_table_ext ON(test_table.test_fk = test_table_ext.test_char) 
WHERE test_fk = 'OPQR';