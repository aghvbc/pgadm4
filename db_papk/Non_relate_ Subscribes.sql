-- 1. Вывести список пассажиров, которые не летали на рейсах авиакомпании "Аэрофлот"
-- select * from passenger 
-- where id_psg not in 
-- (
-- 	select id_psg from pass_in_trip
-- 	where trip_no in (
-- 		select trip_no from trip
-- 		where id_comp in (
-- 			select id_comp from company 
-- 			where name = 'Aeroflot'
-- 		)
-- 	)
-- )

-- 2. Найти города в которые стоимость перелета больше чем средняя стоимость перелета в город Москва
-- select * from tow	ns 
-- where id_town in 
-- (
-- 	select id_town_to from trip
-- 	where price > (select avg(price) from trip where id_town_to in (select id_town from towns where name='Moscow'))
-- );
-- --*
-- select distinct twn.name from trip t
-- join towns twn on twn.id_town = t.id_town_to
-- where price > 
-- (
-- 	select AVG(price) from trip tr
-- 	join towns twns on twns.id_town = tr.id_town_to
-- 	where twns.name = 'Moscow'
-- )


--3. Найти всех пассажиров, которые летали на рейсах, стоимость билета на которые выше средней стоимости всех билетов в базе данных
-- select * from passenger 
-- where id_psg in 
-- (
-- 	select id_psg from pass_in_trip
-- 	where trip_no in (
-- 		select trip_no from trip 
-- 		where price > 
-- 			(select AVG(price) from trip)
-- 	)
-- )

--4. Найти все рейсы, которые выполняются в те же дни недели, что и рейс с номером 1101.

-- select t.trip_no, string_agg(day::text, ',') as days
-- from trip t
-- 	join trip_days td on td.trip_no = t.trip_no
-- group by t.trip_no



-- select trip_no from trip t 
-- where (trip_no != 1101) and (trip_no in 
-- 	(select trip_no from trip_days  group by trip_days.trip_no
-- 	having string_agg(day::text, ',') = 
-- 		(select  string_agg(day::text, ',') as t_d 
-- 		from trip_days where (trip_no = 1101) 
-- 		and 
-- 		(trip_no in (select trip_no from trip)))))

--5. Найти города, из которых вылетает больше рейсов, чем в среднем по всем городам
-- select * from towns where id_town in 
-- (
-- 	select id_town_from from trip
-- 	group by id_town_from
-- 	having count(*) > 
-- 	(
-- 		select avg(count) from 
-- 		(
-- 			select count(trip_no) from trip
-- 			group by id_town_from
-- 		)
-- 	)
-- )
--6. Вывести список авиакомпаний, у которых количество рейсов больше, чем среднее количество рейсов у всех авиакомпаний
select * from company
where id_comp in
(
	select id_comp from trip
	group by id_comp
	having count(*) > (select avg(count) from (select count(*) from trip group by id_comp)))



-- select * from passenger
-- select * from pass_in_trip
-- select * from trip
-- select * from company
-- select * from country
-- select * from towns
-- select * from trip_days