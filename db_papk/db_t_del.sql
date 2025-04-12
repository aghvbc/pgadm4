select * from pass_in_trip
select * from trip
select * from passenger
select * from trip_days
select * from company
select * from country
select * from towns
select * from planes

--1. Вывести список всех рейсов с указанием: номера рейса, названий авиакомпаний и страны регистрации, стоимость билета, отсортированный по стоимости билета
--(trip, company, country)
select t.trip_no, c.name, cntr.name, t.price from trip t 
        left join company c on c.id_comp = t.id_comp
        left join country cntr on cntr.id_country = c.id_country
order by price

--2. Вывести список рейсов (номер, время вылета, время прилета, типа самолета и название авиакомпании), которые выполняются из Moscow в Rostov. Список отсортировать по времени вылета
--(trip, company, planes, towns)
select t.trip_no, t.time_out, t.time_in, p.name as plane_name, c.name as company_name from trip t
	left join planes p on p.id_plane = t.id_plane
	left join company c on c.id_comp = t.id_comp
	left join towns t_to on t_to.id_town = t.id_town_to
	left join towns t_from on t_from.id_town = t.id_town_from
where t_to.name = 'Rostov' and t_from.name = 'Moscow'
order by t.time_out


--3. Показать всех пассажиров мужского пола или пол которых не определен, которые летали на самолетах типа "TU- 154". Список предоставить в формате: фамилия, имя, дата полета, номер рейса, отсортированный по дате полета, фамилии и имени пассажира
select p.lname, p.name, pit.date from pass_in_trip pit
	left join passenger p on p.id_psg = pit.id_psg
	left join trip t on t.trip_no = pit.trip_no
	left join planes pl on pl.id_plane = t.id_plane
where pl.name = 'TU-154' and (p.sex is null or p.sex = 'm')
order by pit.date, p.lname, p.name

--4. Найти все рейсы, которые выполняются по средам в виде: номер рейса, название авиакомпании, тип самолета, время вылета, время прилета. Список отсортировать по времени вылета.
select t.trip_no, c.name, pl.name, t.time_out, t.time_in from trip t
	left join trip_days td on td.trip_no = t.trip_no
	left join planes pl on pl.id_plane = t.id_plane
	left join company c on c.id_comp = t.id_comp
where td.day = 3
order by t.time_out

--5. Вывести всех пассажиров в формате: имя, фамилия, дата полета, номер рейса, которые летали рейсами авиакомпании "Aeroflot". Список отсортировать сначала по дате полета в обратном порядке, потом по фамилии пассажира
select p.name, p.lname, pit.date, t.trip_no from trip t
	left join pass_in_trip pit on pit.trip_no = t.trip_no
	left join passenger p on p.id_psg = pit.id_psg
	left join company c on c.id_comp = t.id_comp
where c.name = 'Aeroflot'
order by pit.date desc, p.lname

--6. Показать полеты пассажиров в виде: имя, фамилия, номер рейса, город вылета, город прилета, стоимость билета. 
--Список отсортировать по дате вылета и фамилии пассажира.
select p.name,p.lname, t.trip_no, t_to.name, t_from.name, t.price from trip t
	right join pass_in_trip pit on pit.trip_no = t.trip_no
	left join passenger p on p.id_psg = pit.id_psg
	left join towns t_to on t_to.id_town = t.id_town_to
	left join towns t_from on t_from.id_town = t.id_town_from
order by pit.date, p.lname

