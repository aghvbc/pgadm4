--Многие ко многим

create table s_group (
	id serial primary key,
	name text not null
);

create table discipline (
	id serial primary key,
	name text not null
);

select * from discipline 
insert into s_group (name) values ('k0709-23-1'), ('k0709-23-2'),('k0709-23-3');
insert into discipline (name) values ('Databases'), ('Literature');

create table group_discipline (
	id_group int not null,
	id_discipline int not null,
	primary key (id_group, id_discipline)
);

--- реализация многие ко многим
alter table group_discipline
	add foreign key (id_group) references s_group (id);
alter table group_discipline
	add foreign key (id_discipline) references discipline (id);
---

insert into group_discipline (id_group, id_discipline) values
	(1,1), (1,2),
	(2,1), (2,2),
	(3,2);

select * from group_discipline where id_discipline = 3
