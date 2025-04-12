create table student(
	id serial primary key,
	fio text not null,
	id_grp integer
);

create table s_group(
	id serial primary key,
	name text not null
);
insert into s_group (name) values ('k-0709-23-1'), ('k-0709-23-2'), ('k-0709-23-3')
insert into student (fio, id_grp) values
	('student 001', 2),
	('student 011', 1),
	('student 021', 3),
	('student 052', 3);
select * from s_group;
select * from student;

--внешний ключ
alter table student
	add foreign key (id_grp) references s_group(id);

--ключи
alter table student
	add foreign key (id_grp) references s_group(id) on delete set null; --удаляемый идентификатор станет null(если не not null)

alter table student
	add foreign key (id_grp) references s_group(id) on delete set default; --ставит заранее установленное дефолтное значение
																			--(если удалить дефолтное значение, то будет ошибка)
alter table student
	add foreign key (id_grp) references s_group(id) on delete set no action; -- означает, что если какие -либо ссылки на строки все еще существуют при проверке ограничения, возникает ошибка;
--(даёт специальный режим в котором можно выполнять действия без проверки от базы, чтобы можно было делать что нибудь запрещённое(потом база проверит))
	
alter table student
	add foreign key (id_grp) references s_group(id) on delete set restrict; --предотвращает удаление указанной колонки

alter table student
	add foreign key (id_grp) references s_group(id) on delete set cascade; -- ON DELETE CASCADE означает автоматическое удаление зависимых записей, когда родительская запись удаляется. 


alter table student 
	drop constraint student_id_grp_fkey6,
	add foreign key (id_grp) references s_group (id) on delete set null;

alter table student 
	drop constraint student_id_grp_fkey,
	add foreign key (id_grp) references s_group (id) on delete cascade;

delete from s_group where id = 2
select * from student
select * from s_group

select * from company
select * from country
select * from trip
select * from trip_days

alter table company
	add foreign key (id_country) references country (id_country) on delete no action

alter table trip 
	add foreign key (trip_no) references trip_days (days) on delete cascade