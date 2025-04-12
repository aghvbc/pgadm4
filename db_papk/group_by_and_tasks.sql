--select sex, count(*) from passenger group by passenger.sex

--select sex from passenger group by sex
--select sex, name, count(*) from passenger group by sex,name

--select min(price) , max(price) from trip


--1. Выбрать кол-во записей всего в таблице пассажиров, выбрать сколько пассажиров имеют пол, вычислить сколько пассажиров пол не имеют

--select count(*), count(sex), count(*) - count(sex) from passenger;

--2.Выяснить сколько пассажиров каждого пола, в том числе сколько пассажиров пола не имееют
--select sex, count(*) from passenger group by sex

--3. Вывести перечень моделей самолетов по частоте их использования

-- 	select planes.name, count(*) from trip  join planes on trip.id_plane = planes.id_plane group by planes.id_plane

-- select planes.name, count(*) from trip
-- 		left join planes on trip.id_plane = planes.id_plane
-- 	group by planes.name

-- --4. Выяснить сколько всего рейсов вылетает в каждый из городов

-- 	select towns.name, count(*) from trip
-- 		left join towns on towns.id_town = trip.id_town_to
-- 	group by towns.name

--5. Определить максимальную и минимальную стоимость перелета, определить те-же значения для каждого города назначения


-- select towns.name, max(price), min(price) from trip
-- 	left join towns on towns.id_town = trip.id_town_to
-- group by towns.name

--6. Определить среднюю стоимость перелета


-- select avg(price) from trip

--7. Определить суммарную стоимость, потраченную на перелет для каждого пассажира

-- select p.id_psg, p.name, sum(t.price) from pass_in_trip pit
-- 	left join passenger p on p.id_psg = pit.id_psg
-- 	left join trip t on pit.trip_no = t.trip_no
-- group by p.id_psg

--8. Выбрать имена всех пассажиров через запятую для каждого пола в отдельности.



-- select string_agg(name ||  ' ' || lname , ','), sex from passenger group by sex

--9. Выбрать имена пассажиров, встречающиеся более одного раза

-- select name, count(*) 
-- from passenger 
-- group by name 
-- having count(*) = 2 

--10. Определить суммарную стоимость полученной прибыли для каждой авиакомнании для каждого месяца в 2003-м и 2005-м годах
-- select * from trip
-- select * from pass_in_trip
-- select * from towns
-- select * from passenger
-- select * from company

-- select  c.name, t.id_comp,sum(price), extract(year from date), extract(month from date) from trip t
-- 	left join company c on t.id_comp = c.id_comp
-- 	left join pass_in_trip pit on pit.trip_no = t.trip_no
-- group by c.name, t.id_comp, extract(year from date), extract(month from date)













