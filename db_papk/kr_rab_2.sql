--1. Вычислить среднюю стоимость билета на рейсы для каждой авиакомпании. 
-- Если у авиакомпании рейсов нет – среднее значение стоимости билета должно быть равно 0. 
-- В списке должны быть представлены колонки: Название авиакомпании, средняя стоимость билета. 
-- Отсортировать список сначала по стоимости билета в обратном порядке, потом по названию а/к

select name, coalesce((select avg(price) from trip t where t.id_comp = c.id_comp), '0') from company c 
order by coalesce((select avg(price) from trip t where t.id_comp = c.id_comp), '0') desc, name

select c.name, coalesce(avg(t.price), '0') from company c
left join trip t on t.id_comp = c.id_comp
group by c.name
order by coalesce(avg(t.price), '0') desc , c.name




--2. Вывести список авиакомпаний, у которых количество рейсов меньше или равно, чем среднее количество рейсов по всем авиакомпаниям. 
-- Список должен содержать только наименования а/к, отсортированные по алфавиту.
-- А/к не имеющие рейсов, если такие имеются, должны также отображаться в представленном списке

select name from company c where 
	(select count(trip_no) from trip t where c.id_comp = t.id_comp) <= 
	(select avg(cnt) from (select id_comp, count(trip_no) as cnt from trip group by id_comp))
OR 
(SELECT COUNT(trip_no) FROM trip t WHERE t.id_comp = c.id_comp) IS NULL
ORDER BY name;

-- SELECT name
-- FROM company c
-- WHERE (SELECT COUNT(trip_no) FROM trip t WHERE c.id_comp = t.id_comp) <= 
--       (SELECT AVG(cnt) FROM (SELECT id_comp, COUNT(trip_no) AS cnt FROM trip GROUP BY id_comp))
-- UNION
-- SELECT name
-- FROM company c
-- WHERE (SELECT COUNT(trip_no) FROM trip t WHERE t.id_comp = c.id_comp) IS NULL
-- ORDER BY name;


-- SELECT id_comp, COUNT(trip_no) AS cnt 
-- FROM trip 
-- GROUP BY id_comp;


--3. Найти всех пассажиров, которые летали на рейсах, цена на билеты на которых выше, чем средняя цена по всей базе данных. 
-- В списке должны быть представлены: фамилия и имя пассажира. Список отсортировать сначала по фамилии, потом по имени пассажира.

select lname,name from passenger where id_psg in (select id_psg from pass_in_trip where trip_no in (select trip_no from trip where price > (select avg(price) from trip))) order by lname,name

--4. Найти количество уникальных пассажиров, которые летали на рейсах авиакомпании "Don_avia". Запрос должен выводить одно значение.

select count(*) from passenger where id_psg in (select id_psg from pass_in_trip where trip_no in (select trip_no from trip where id_comp in (select id_comp from company where name='Don_avia')))


--5. Вывести страны, в которых зарегистрировано больше авиакомпаний, чем в France. Список должен содержать только одну колонку - название страны, 
--в которой сведения должны быть отсортированы по алфавиту.

select name 
from country where id_country in 
(
	select id_country 
	from company 
	group by id_country 
	having count(id_comp) > (
		select count(id_comp)
		from company 
		where id_country in (
			select id_country 
			from country
			where name = 'France'
			)
		)
	) 
order by name;




--6. Найти всех пассажиров, которые летали на рейсах, стоимость билета на которые выше средней стоимости билетов на рейсы той же авиакомпании. В списке должны быть представлены: идентификатор, имя пассажира и фамилия. Список отсортировать сначала по фамилии, потом по имени пассажира.

--7. Определить минимальное время вылета среди всех рейсов, выполняемых в понедельник. Запрос должен выводить только одно значение


