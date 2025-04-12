create or replace view pass1 as 
select id_psg, 
	trim(coalesce(name, '') || ' '|| coalesce (lname, '')) as name, 
	sex
from passenger 

select * from pass1 order by id_psg
update passenger set lname = 'Willis-1' where id_psg = 1

create materialized view pass2 as 
select id_psg as id_psg,
		trim(coalesce(name, '') || ' '|| coalesce (lname, '')) as name, 
	sex
from passenger 

select * from pass1 order by id_psg;
select * from pass2 order by id_psg;
refresh materialized view pass2;
update passenger set lname = 'Willis' where id_psg = 1


create temporary table temTable(
	id int not null,
	name text
)
insert into temTable values(1, '1-1'), (2, '2-2')
select * from temTable


with pass3 as (select id_psg as id_psg,
		trim(coalesce(name, '') || ' '|| coalesce (lname, '')) as name, 
	sex
from passenger 
)
select * from pass3;


--найти а/к у которых кол-во рейсов больше чем среднее по всем а/к

with trip_count as (
select id_comp, count(*) as count
from trip
group by id_comp
)
select c.name
from trip_count
	join company c on c.id_comp = trip_count.id_comp
where count > (select avg(count) from trip_count)

