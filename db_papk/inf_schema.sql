
create table trip (
	trip_no int not null,
	id_comp int 
	primary key (trip_no),
	foreign key (id_comp) references company (id_comp)
);

--*
select * from information_schema.views
where table_schema = 'information_schema'

select * from information_schema.table_constraints 
where table_name = 'trip'  

select * from information_schema.check_constraints 
where check_constraints.constraint_name = ''
--*
select * from information_schema.constraint_column_usage where table_name = 'trip' 
--*
select 'primary key ('|| string_agg(column_name, ',') || '),' from information_schema.constraint_column_usage
where constraint_name = (
	select constraint_name from information_schema.table_constraints 
	where table_name = 'trip' and constraint_type = 'PRIMARY KEY')




-------***-*-*-*-*
select 'create table trip ('
union all 
select column_name || ' ' || data_type ||	case 
		when is_nullable = 'NO' then ' not null'
		else ''
	end || ','
from information_schema.columns where table_name = 'trip'
union all
--select 'Check(' || 
select 'primary key ('|| string_agg(column_name, ',') || '),' from information_schema.constraint_column_usage
where constraint_name = (
	select constraint_name from information_schema.table_constraints 
	where table_name = 'trip' and constraint_type = 'PRIMARY KEY'
)
union all
select ');'


