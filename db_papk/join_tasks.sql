

-- --1. Выбрать все рейсы (номера) с указанием названия авиакомпании, которая этот рейс выполняет
-- select trip_no, name from trip t left join company c on c.id_comp = t.id_comp 

-- --2. Выбрать фамилии и имена пассажиров и все места, на которых они летали
-- select name,lname,place from passenger left join pass_in_trip on pass_in_trip.id_psg = passenger.id_psg 

-- --3. Выбрать всех пассажиров (имя и фамилия) которые летали в апреле 2003-го года
-- select name,lname from passenger  left join pass_in_trip on passenger.id_psg = pass_in_trip.id_psg where extract(month from date)=04 and extract(year from date)=2003

-- --4. Вывести всех пассажиров (имя и фамилия), которые летали на местах 4-го ряда
	
	
-- --5.Выбрать города куда летал Bruce Willis
-- select towns.name
-- from passenger 
-- 	left join pass_in_trip on pass_in_trip.id_psg = passenger.id_psg
-- 	left join trip on trip.trip_no = pass_in_trip.trip_no
-- 	left join towns on towns.id_town = trip.id_town_to
-- where passenger.name = 'Bruce'

-- --6. Выбрать названия авиакомпаний, услугами которых пользовался Bruce Willis
-- select c.name
-- from pass_in_trip pit
-- 	inner join passenger p on p.id_psg = pit.id_psg
-- 	left join trip t on t.trip_no = pit.trip_no
-- 	left join company c on c.id_comp = t.id_comp
-- where p.name = 'Bruce'

-- --7. Найти всех пассажиров, которые летали в Париж (город прилета) на рейсах, выполняемых авиакомпаниями, зарегистрированными в России
-- select p.name, p.lname
-- from pass_in_trip pit
-- 	left join trip t on t.trip_no = pit.trip_no
-- 	left join towns tow on tow.id_town = t.id_town_to
-- 	left join company c on c.id_comp = t.id_comp
-- 	left join country cntr on cntr.id_country = c.id_country
-- 	left join passenger p on p.id_psg = pit.id_psg
-- where cntr.name = 'France' and tow.name = 'Paris' 






-- --8. Вывести список всех рейсов, которые выполняются по понедельникам, с указанием авиакомпании и страны ее регистрации

-- --(trip_days, company, country, trip  )

-- select c.name, cntr.name from trip t
-- 	left join trip_days td on t.trip_no = td.trip_no
-- 	left join company c on t.id_comp = c.id_comp
-- 	left join country cntr on cntr.id_country = c.id_country
-- where td.day = '1'

-- --9. Найти всех пассажиров, которые летали на рейсах с вылетом из Москвы и прилетом в Санкт-Петербург

-- --(passenger, trip,towns, pass_in_trip )

-- select  p.name, p.lname, t.id_town_from, t.id_town_to, twn_from.name, twn_to.name from pass_in_trip pit
-- 	left join passenger p on pit.id_psg = p.id_psg
-- 	left join trip t on t.trip_no = pit.trip_no
-- 	left join towns twn_from on twn_from.id_town = t.id_town_from
-- 	left join towns twn_to on twn_to.id_town = t.id_town_to
-- where t.id_town_from = '4' and t.id_town_to = '6'

-- --10. Вывести список всех рейсов, которые выполняются авиакомпаниями, зарегистрированными в России в составе: номер рейса, город вылета, город прилета и стоимость


--(trip, country, company, towns)

-- select t.trip_no, twns_from.name, twns_to.name, t.price from trip t
-- 	left join company c on t.id_comp = c.id_comp
-- 	left join country cntr on cntr.id_country = c.id_country
-- 	left join towns twns_from on t.id_town_from = twns_from.id_town
-- 	left join towns twns_to on t.id_town_to = twns_to.id_town
-- where c.id_country = '1'

-- 11. Найти всех пассажиров, которые летали на рейсах, выполняемых в среду, с указанием места в самолете

-- select * from pass_in_trip
-- select * from passenger
-- select * from trip
-- select * from trip_days
-- select * from company
-- select * from towns
-- select * from country
-- select * from planes

--(passenger, pit,trip_days)

select pit.trip_no, p.name,p.lname, pit.place, td.day  from pass_in_trip pit
	left join passenger p on p.id_psg = pit.id_psg
	left join trip_days td on td.trip_no = pit.trip_no
where td.day = 3