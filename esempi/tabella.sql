CREATE SEQUENCE user_id_seq;

CREATE TABLE test_table (
    code        char(5) CONSTRAINT firstkey PRIMARY KEY,
    test_char   varchar(40) NOT NULL,    
    test_date   date,
    test_auto   smallint NOT NULL DEFAULT nextval('user_id_seq')
);