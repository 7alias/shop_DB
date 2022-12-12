CREATE OR REPLACE PROCEDURE create_table(name TEXT)
AS
$$ DECLARE
txt TEXT;
     BEGIN
     EXECUTE ('drop table if exists ' || name);
     EXECUTE ('create table ' || name || '(str varchar(100));');
     txt = gen_abra_cadabra(35);
     RAISE NOTICE 'txt = %', txt;
     EXECUTE ('insert into ' || name || ' values(''' || txt || ''');');
END $$
LANGUAGE 'plpgsql';

--вызов
CREATE 
OR REPLACE PROCEDURE just_print() AS $$ DECLARE txt TEXT;
BEGIN 
SELECT 
  gen_abra_cadabra(35) INTO txt;
RAISE NOTICE 'txt = %', 
txt;
END $$ LANGUAGE 'plpgsql';

CREATE 
OR REPLACE PROCEDURE get_Kuropatkin_phone() AS $$ DECLARE txt TEXT;
BEGIN 
SELECT 
  phone 
FROM 
  clients 
WHERE 
  name = 'Куропаткин В В' INTO txt;
RAISE NOTICE 'txt = %', 
txt;
END $$ LANGUAGE 'plpgsql';

CREATE 
OR REPLACE FUNCTION print_client_data() RETURNS VOID AS $$ DECLARE client RECORD;
BEGIN 
SELECT 
  * 
FROM 
  clients 
WHERE 
  name = 'Иван Владиморович К' INTO client;
RAISE NOTICE 'Имя клиента = %, телефон = %', 
client.name, 
client.phone;
EXCEPTION WHEN OTHERS THEN RAISE NOTICE 'You made a mistake!';
END $$ LANGUAGE 'plpgsql';

CREATE 
OR REPLACE FUNCTION print_client_name() RETURNS VOID AS $$ DECLARE client RECORD;
BEGIN 
SELECT 
  * 
FROM 
  clients 
WHERE 
  name = 'Иван Владиморович К' INTO client;
RAISE NOTICE 'Имя клиента = %', 
client.x;
EXCEPTION WHEN OTHERS THEN RAISE NOTICE 'field doesn''t exist';
END $$ LANGUAGE 'plpgsql';
--вызов
DO $$ BEGIN PERFORM print_client_name();
END $$;

DO $$ DECLARE rec RECORD;
BEGIN FOR rec IN 
SELECT 
  id, 
  name, 
  phone 
FROM 
  clients 
ORDER BY 
  name DESC LOOP RAISE NOTICE 'id = %, name = %, phone = %', 
  rec.id, 
  rec.name, 
  record.phone;
END LOOP;
END $$;
