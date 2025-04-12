--1. Найти все рейсы для которых цена билета выше средней цены всех билетов для той-же авиакомпании

-- select * 
-- from trip t 
-- where t.price > (select avg(price) from trip t2 where t2.id_comp = t.id_comp)

--2. Найти все перелеты пассажиров в которых стоимость билета была выше, чем средняя стоимость, оплаченная пассажирами того-же пола
-- select pit.trip_no, psg.sex, t.price 
-- from pass_in_trip pit
-- 	join passenger psg on psg.id_psg = pit.id_psg
-- 	join trip t on t.trip_no = pit.trip_no
-- where t.price > (select avg(price) from pass_in_trip pit2
-- 	join passenger psg2 on psg2.id_psg = pit2.id_psg
-- 	join trip t2 on t2.trip_no = pit2.trip_no
-- 	where coalesce(psg2.sex, '-') = coalesce(psg.sex, '-')
-- 	)

--3. Вывести рейсы у которых стоимость билета больше средней стоимости для той-же страны регистрации а/к
select * from trip t
join company c on c.id_comp = t.id_comp
join country cntr on cntr.id_country = c.id_country
where t.price > (select avg(price) from trip tr
join company c2 on c2.id_comp = tr.id_comp
join country cntr2 on cntr2.id_country = c2.id_country
where cntr2.name = cntr.name
)
--4	. Найти всех пассажиров, которые летали на рейсах, стоимость билета на которые выше средней стоимости билетов на рейсы той же авиакомпании
-- select * from trip
-- select * from company

-- select * from trip t
-- 	join company c on c.id_comp = t.id_comp
-- where t.price > (
-- 	select avg(t2.price) from trip t2
-- 		join company c2 on c2.id_comp = t2.id_comp
-- )

--5. Найти все рейсы, которые выполняются в те же дни недели, что и рейс с номером 1101.
	-- select t.trip_no, string_agg(day::text, ',')
	-- from trip t
--6. Вывести список пассажиров, которые летали на всех рейсах авиакомпании "Аэрофлот"

