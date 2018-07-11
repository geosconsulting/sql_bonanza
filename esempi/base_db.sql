CREATE TABLE test_table_ext (
    test_auto serial,    
    test_char varchar(4) NOT NULL PRIMARY KEY
);

INSERT INTO public.test_table_ext(test_char) VALUES ('ABCD');
INSERT INTO public.test_table_ext(test_char) VALUES ('EFGH');
INSERT INTO public.test_table_ext(test_char) VALUES ('ILMN');
INSERT INTO public.test_table_ext(test_char) VALUES ('OPQR');

CREATE SEQUENCE user_id_seq START 1;

CREATE TABLE test_table (
    test_auto integer NOT NULL DEFAULT nextval('user_id_seq') CONSTRAINT test_table_key PRIMARY KEY,    
    test_char varchar(40) NOT NULL,    
    test_date date,
    test_fk varchar(4) REFERENCES test_table_ext(test_char)
);

INSERT INTO public.test_table(
		test_auto, test_char, test_date, test_fk)
	VALUES (1, 'test1 come te pare etc....', '2015-12-21','ABCD');

INSERT INTO public.test_table(
		test_auto, test_char, test_date,test_fk)
	VALUES (2, 'test2 come te pare etc....', '2016-12-21','ABCD');

INSERT INTO public.test_table(
           test_auto, test_char, test_date,test_fk)
	VALUES (3, 'test3 come te pare etc....', '2017-12-21','OPQR');