CREATE OR REPLACE FUNCTION mysum(int, int)                                                                                                                                                                 RETURNS int AS                                                                                                                                                               $__$     
     SELECT $1 + $2;  
$__$ LANGUAGE 'sql'; 

SELECT mysum(10, 20); 