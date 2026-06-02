create database bdjoin
go

use bdjoin
go

create table departamentos(
	id		int			not null primary key identity,
	nome	varchar(50) not null
);
go

insert into departamentos values('RH'), ('TI'), ('MKT'), ('Vendas')

select * from departamentos

create table funcionarios(
	id		int				not null primary key identity,
	nome	varchar(50)		not null,
	salario decimal(10,2)	not null,
	dep_id	int references departamentos
);
go

insert into funcionarios values ('Batman', 7000, 4)
insert into funcionarios values ('Wolverine', 5000, 3)
insert into funcionarios values ('Mulher Maravilha', 15000, 1)
insert into funcionarios values ('Coringa', 2000, null)
insert into funcionarios values ('Robin', 7000, 4)

select * from departamentos
select * from funcionarios

-- inner join --
select f.id, f.nome, f.salario, f.dep_id, d.nome
from funcionarios f, departamentos d
where 
	d.id = f.dep_id

select f.id, f.nome, f.salario, f.dep_id, d.nome
from funcionarios f inner join departamentos d on f.dep_id = d.id

-- outer join --
select *
from funcionarios f left outer join departamentos d on f.dep_id = d.id

select *
from funcionarios f right outer join departamentos d on f.dep_id = d.id

select *
from funcionarios f full outer join departamentos d on f.dep_id = d.id
