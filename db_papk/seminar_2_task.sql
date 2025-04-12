
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

