create table instructor
(
Id int primary key identity,
BD date,
fname varchar(20),
lname varchar(20),
address varchar(20),
age as(year(getdate())-year(BD)),
overtime int unique,
Netsalary as salary+ isnull (overtime,0) ,
salary int default 3000,
hireDate date default getdate(),
constraint c1 check( salary between 1000 and 5000),
constraint c2 check (address = 'cairo' or address = 'alex')
 


create table course(
Cid int primary key identity,
Cname varchar(20),
duration int unique

)
create table lab
(
lid int identity,
Cid int,
capacity int,
location varchar(20),

constraint c3 check(capacity <20),
constraint c4 foreign key (cid) references course(cid)
			on delete cascade on update cascade,
primary key(Lid,Cid)
)

create table [instructorcourse](
Cid int,
id int,
 constraint c5 foreign key(Id) references instructor(Id)
			on delete cascade on update cascade,
 constraint c6 foreign key(Cid) references course(Cid)
			on delete cascade on update cascade,
			primary key (cid,Id)

)
