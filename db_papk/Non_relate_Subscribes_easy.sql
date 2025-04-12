--1. Вывести авиакомпании, у которых нет ни одного рейса	
select * from company
where id_comp not in (
	select distinct id_comp from trip
)

--2. Вывести всех пассажиров, которые вообще не летали

select * from passenger
where id_psg not in (
	select id_psg from pass_in_trip
)

--доп. Найти всех пассажиров, которые летали рейсами дороже среднего билета
select trip_no from trip
where price > (select avg(price) from trip)

--3.Найти всех пассажиров, которые летали рейсами дороже среднего билета
select * from passenger 
where id_psg in (
	select id_psg from pass_in_trip 
	where trip_no in (
		select trip_no from trip
		where price > (select avg(price) from trip)
	)
)

select  distinct p.* from passenger p
	left join pass_in_trip pit on pit.id_psg = p.id_psg
	left join trip t on t.trip_no = pit.trip_no
where t.price > (select avg(price) from trip)

--4. Вывести всех пассажиров, которые не летали в Париж
select * from passenger 
where id_psg not in (
	select id_psg from pass_in_trip
	where trip_no in (
		select trip_no from trip
		where id_town_to in (select id_town from towns where name = 'Paris')
	)
)
--5. Вывести страны, в которых зарегистрированы авиакомпании, выполняющие рейсы в Москву
select * from country where id_country in 
(select id_country from company where id_comp in 
(select id_comp from trip where id_town_to in 
(select id_town from towns where name = 'Moscow')))

--6. Вывести список авиакомпаний, у которых количество рейсов больше, чем у авиакомпании "Аэрофлот"
select * from company
where id_comp in
(
	select id_comp from trip
	group by id_comp
	having count(*) > (select count(*) from trip where id_comp = (select id_comp from company where name = 'Aeroflot'))
)

select * from passenger
select * from pass_in_trip
select * from trip
select * from towns
select * from country
select * from company