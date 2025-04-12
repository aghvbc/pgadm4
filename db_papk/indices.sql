--Индексы и производительность
--Простые запросы
--1. Создание таблицы и заполнение данными для тестирования
CREATE TABLE temp_table (c1 integer, c2 text);
INSERT INTO temp_table
 SELECT i, md5(random()::text)
 FROM generate_series(1, 1000000) AS i;

select * from temp_table
limit 100

--2. Выполняем анализ
EXPLAIN SELECT * FROM temp_table
--3. Добавим еще несколько строк
INSERT INTO temp_table
 SELECT i, md5(random()::text)
 FROM generate_series(1, 10) AS i;
EXPLAIN SELECT * FROM temp_table;
--4. Изменений нет поскольку статистика по таблице еще не обновлена. Выполняем
--обновление
ANALYZE temp_table;
EXPLAIN SELECT * FROM temp_table;
--5. Реальные данных
EXPLAIN ANALYZE select * from temp_table;
--6. Добавим условие
EXPLAIN ANALYZE SELECT * FROM temp_table WHERE c1 > 500;
--И вот такой запрос
EXPLAIN ANALYZE SELECT * FROM temp_table WHERE c1 < 50;
--7. Создаем индекс и повторяем анализ
CREATE INDEX ON temp_table (c1);
EXPLAIN ANALYZE SELECT * FROM temp_table WHERE c1 > 500;
--8. Индекс не используется, блокируем возможность использования последовательного
--сканирования и смотрим что получается по времени
SET enable_seqscan TO off;
EXPLAIN ANALYZE SELECT * FROM temp_table WHERE c1 > 500;
--9. Включаем последовательный поиск и еще запрос
SET enable_seqscan TO on;
EXPLAIN ANALYZE SELECT * FROM temp_table WHERE c1 < 50;
--10. Усложняем условие
EXPLAIN ANALYZE SELECT * FROM temp_table WHERE c1 < 500 AND c2 LIKE
'abcd%';

--11. В следующем запросе только последовательный поиск
EXPLAIN ANALYZE SELECT * FROM temp_table WHERE c2 LIKE 'abcd%'
--12. Создаем индекс по текстовому полю
CREATE INDEX on temp_table(c2 text_pattern_ops);
EXPLAIN ANALYZE SELECT * FROM temp_table WHERE c2 LIKE 'abcd%';
--13. Если выбирать не всю строку, а только поле, по которому построен индекс, результаты
--будут несколько иными
EXPLAIN ANALYZE SELECT c2 FROM temp_table WHERE c2 LIKE 'abcd%'

--Работа с ORDER BY
--1. Удаляем индекс и смотрим на результаты с сортировкой:
DROP INDEX temp_table_c1_idx;
EXPLAIN ANALYZE SELECT * FROM temp_table ORDER BY c1;
--2. Сортировка выполняется с использованием файла данных на диске. Увеличиваем
--размер используемой памяти:
SET work_mem TO '100MB';
EXPLAIN ANALYZE SELECT * FROM temp_table ORDER BY c1;
--3. Добавляем индекс и еще раз
CREATE INDEX on temp_table(c1);
EXPLAIN ANALYZE SELECT * FROM temp_table ORDER BY c1;
--Работа с JOIN
--1. Создаем еще одну таблицу
CREATE TABLE table2 (c1 integer, c2 boolean);
INSERT INTO table2
 SELECT i, i%2=1
 FROM generate_series(1, 500000) AS i;
ANALYZE table2;
--2. Добавляем индекс
CREATE INDEX ON table2(c1);
EXPLAIN ANALYZE SELECT * FROM temp_table t1 JOIN table2 t2 ON
t1.c1=t2.c1;
--3. Меняем объединение на LEFT JOIN
EXPLAIN ANALYZE SELECT * FROM temp_table t1 LEFT JOIN table2 t2 ON
t1.c1=t2.c1;
--4. Опять вернулся Seq Scan!!! Если запретить планировщику использовать
--последовательно сканирование?
SET enable_seqscan TO OFF;
EXPLAIN ANALYZE SELECT * FROM temp_table t1 LEFT JOIN table2 t2 ON
t1.c1=t2.c1;
--5. Так быстрее, но планировщик неправильно принимает решение потому, что у него
--слишком много памяти – убираем память, возвращаем возможность использовать
--последовательный поиск и посмотрим что он будет делать
SET work_mem TO '10MB';
SET enable_seqscan TO ON;
EXPLAIN ANALYZE SELECT * FROM temp_table t1 LEFT JOIN table2 t2 ON
t1.c1=t2.c1;