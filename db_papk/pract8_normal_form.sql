select * from trip;
select * from trip_days;
alter table pass_in_trip alter column date type date;
alter table trip alter column time_out type time;
alter table trip alter column time_in type time;

create table trip_days (
	trip_no int not null,
	day int not null check (day between 1 and 7),
	primary key(trip_no, day)
)

select trip_no,string_to_table from trip, string_to_table(days, ',')
insert into trip_days 
select trip_no,string_to_table::int from trip, string_to_table(days, ',')

alter table trip drop column days