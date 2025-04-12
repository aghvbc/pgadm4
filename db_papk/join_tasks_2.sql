select * from pass_in_trip
select * from trip
select * from passenger
select * from trip_days
select * from company
select * from country
select * from towns
select * from planes
--1. Вывести список всех пассажиров с указанием авиакомпаний, на рейсах которых они летали
--(passenger, company, trip, pit)
select p.name, p.lname, c.name from pass_in_trip pit
	left join trip t on t.trip_no = pit.trip_no
	left join passenger p on pit.id_psg = p.id_psg
	left join company c on c.id_comp = t.id_comp

--2. Вывести список всех рейсов, которые выполняются в среду или пятницу, с указанием страны регистрации авиакомпании
	
--3. Вывести список всех пассажиров, которые летали на рейсах, выполняемых авиакомпаниями из России
--4. Вывести список всех рейсов с указанием дней недели, в которые они выполняются
--5. Вывести список всех пассажиров, которые летали на рейсах с вылетом из Москвы
--6. Вывести список всех рейсов с указанием города вылета, города прилета и авиакомпании
