SET timescaledb.allow_install_without_preload = 'on';

CREATE FUNCTION myCursor(cur refcursor)
 RETURNS VOID AS $$
 BEGIN
    OPEN cur FOR SELECT * FROM t_person;
END;
$$ LANGUAGE plpgsql;


create table fiverows(id serial primary key, data text);
insert into fiverows(data) values ('one'), ('two'),
('three'), ('four'), ('five');

CREATE FUNCTION curtest1(cur refcursor,tag text)
   RETURNS refcursor
AS $$
BEGIN
  OPEN cur FOR SELECT id,data || '+' || tag FROM fiverows;
  RETURN cur;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION curtest2(tag1 text, tag2 text)
RETURNS SETOF fiverows
AS $$
DECLARE
 cur1 refcursor;
 cur2 refcursor;
 row record;
BEGIN
 cur1 = curtest1(NULL, tag1);
 cur2 = curtest1(NULL, tag2);
LOOP
 FETCH cur1 INTO row;
  EXIT WHEN NOT FOUND ;
 RETURN NEXT row;
 FETCH cur2 INTO row;
  EXIT WHEN NOT FOUND ;
 RETURN NEXT row;
END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT table_to_xml('fiverows',true,false,'')AS s;