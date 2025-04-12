select * from company;
select * from country;
select distinct replace(country, '
', '') from company;
update company set country = 'Russia' where country like 'Russia%';

insert into country (name)
select distinct country from company


alter table company add column id_country integer;
update company set id_country = where 
select * , 'update company set id_country='|| id_country::text||'where country = ''' || name ||''' ;'
from country

update company set id_country=1 where country = 'Russia';
update company set id_country=2 where country = 'England';
update company set id_country=3 where country = 'France';

alter table company drop column country