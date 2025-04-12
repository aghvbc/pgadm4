select * from trip
order by trip_no
select * from plane

create table plane (
  id_plane serial primary key,
  plane_name text not null
)

select distinct plane from trip
insert into plane (plane_name) select distinct plane from trip

ALTER TABLE trip ADD COLUMN id_plane int;

UPDATE trip
SET id_plane = plane.id_plane
FROM plane
WHERE trip.plane = plane.plane_name;

ALTER TABLE trip DROP COLUMN plane;
alter table trip alter column id_plane set not null


create table town (
  id_town serial primary key,
  town_name text not null
)

select * from town

select town_from from trip
union 
select town_to from trip

insert into town (town_name) 
select town_from from trip
union 
select town_to from trip

ALTER TABLE trip ADD COLUMN id_town_to int;
ALTER TABLE trip ADD COLUMN id_town_from int; --добавил сам(не автор)


UPDATE trip
SET id_town_from = town.id_town
FROM town
WHERE trip.town_from = town.town_name;

UPDATE trip
SET id_town_to = town.id_town
FROM town
WHERE trip.town_to = town.town_name;

ALTER TABLE trip DROP COLUMN town_from;
ALTER TABLE trip DROP COLUMN town_to;

alter table trip alter column id_town_from set not null
alter table trip alter column id_town_to set not null