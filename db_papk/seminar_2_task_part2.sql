--- станция то
create table towns (
	town_id serial not null,
	name text not null,
	primary key(town_id)
);

create table station (
	id serial not null,
	name text not null,
	town_id int not null references towns (town_id),
	address text not null,
	director text not null,
	telephone char(11) not null,
	primary key (id)
);

create table schedule(
	station_id int not null references station (id),
	day int not null check (day > 0 and day < 8),
	time_start time not null,
	time_end time not null,
	primary key (station_id, day)
);
---

---price list sto
create table type_tc (
	id serial primary key,
	name text not null
);

create table name_work (
	id serial primary key,
	name text not null,
	description text not null
);

create table price (
	type_tc int not null references type_tc(id),
	name_work_id int not null references name_work(id),
	station_id int not null references station(id),
	price int not null,
	primary key (type_tc, name_work_id, station_id)
);
---

--- vehicle
create table mark (
	id serial primary key,
	name text not null
);

create table model (
	id serial primary key,
	name text not null,
	mark_id int not null references mark(id),
	type_tc_id int not null references type_tc(id)
);

create table person (
	id serial primary key,
	f_name text not null,
	l_name text not null,
	phone char(11) not null 
);

create table tc (
	id serial primary key,
	register_number char(9) not null,
	model_id int not null references model(id),
	person_id int not null references person(id)
);
---

--- service_visit


---


