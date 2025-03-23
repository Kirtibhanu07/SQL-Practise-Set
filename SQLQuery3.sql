create database test;
drop database test; 

use test;

create table test_table  (col1 int primary key, 
col2 varchar(20),
col3 datetime);

alter table test_table add col4 varchar(25);

select * from test_table;

drop table test_table;


create database record_company;
use record_company;

create table bands(b_id int not null identity(1,1) ,
name varchar(255) not null
primary key(b_id));

select * from bands;

create table albums (bb_id int not null identity(1,1),
name varchar(25),
release_year int,
band_id int not null,
primary key(bb_id),
foreign key (band_id) references bands(b_id));

insert into bands values('Iron Maiden');
insert into bands values('Power Slave'),('Nightmare'),('The Number of the beasts');

select top 2 * from bands;

select b_id as 'ID', name as 'Band Name' from bands;

select * from bands order by name;


insert into albums (name, release_year, band_id) 
values ('Test1', 1985, 1),('Test1', 1985, 2),('Test2', 1999, 1),('Test3', 2018, 4),('Test4',Null,3 );

insert into albums (name, release_year, band_id) 
values ('Test1', 1987, 1);

insert into albums (name, release_year, band_id) 
values ('Power Slave', 1984, 2);

select * from albums;

select distinct name from albums;

update albums set release_year = 1982 where bb_id=1;

select * from albums where release_year > 1995;

select * from albums where name Like '%ve%' or band_id = 2;

select * from albums where release_year = 1984 and band_id = 2;

select* from albums where release_year is NULL;

delete from albums where release_year is NULL;



select * from bands;
select * from albums;

drop table albums;
drop table bands;

select * from bands  
join albums on bands.b_id = albums.band_id;