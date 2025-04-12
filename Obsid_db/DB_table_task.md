```
Написать запросы в БД последовательно!
Создать таблицу студент в составе следующих атрибутов (все имена давать латиницей):
Идентификатор (serial)
Фамилия
Имя
Дата рождения
Добавить для таблицы первичный ключ по полю идентификатор
Изменить таблицу, установив обязательность полей фамилия и имя
Добавить в таблицу 4 произвольных записи (записи должны иметь различные имена и даты рождения), при добавлении записей использовать автоматическую генерацию значений поля «Идентификатор»
Добавить поле «Дата поступления» со следующими характеристиками:
Поле обязательно к заполнению
Значение поля по умолчанию вычисляется функцией now()
Добавить две записи в таблицу (имена должны отличаться от уже имеющихся в таблице)
Добавить поле «Пол» со следующими характеристиками:
Тип данных character(1) – один символ
Должно быть наложено ограничение: в поле может быть указан один из двух символов: f или m
Поле обязательно для заполнения
Добавить поле «Адрес электронной почты» со следующими характеристиками:
Тип данных text 
В строке обязательно должен содержаться символ @
Значения в поле должны быть уникальными
Добавить в таблицу две записи с обязательным указанием адреса электронной почты, проверив, что значение поля, не включающее символ @ базой данных не воспринимается
```


``` sql
drop table if exists student;
--1. 
create table student (
	id serial,
	lname text,
	fname text,
	birth date
);

--2. 
alter table student add primary key (id);


--3. 
alter table student alter column lname set not null, alter column fname set not null;


--4.	
insert into student (lname, fname, birth) values ('Ivanov', 'Ivan', '2000-12-31');
insert into student (lname, fname, birth) values ('Pertova', 'Olga', '2001-12-31');
	
insert into student (lname, fname, birth) values ('Ivanov', 'Ivan', '2000-12-31'), ('Pertova', 'Olga', '2001-12-31');

--5. 

alter table student add column enterance date not null default now();


--6. 

insert into student (lname, fname, enterance) values ('Grechishnikova','Uliyana', '2023-09-01');

--7
--Единственный способ заполнить это отдать кому то на ручное заполнение
alter table student add column sex character(1) check (sex= 'f' or sex = 'm');

--выполниться только после заполнения
alter table student alter column sex not null;

--8

alter table student add column e_mail text check (e_mail like '%@%') unique;

update student set e_mail = 'Uliyana123@gmail.com' where id = 5;

--
select * from student;
--




```
