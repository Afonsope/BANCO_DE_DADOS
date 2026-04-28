create database [ConsultasSQL26.1]
go

use [ConsultasSQL26.1]
go

create table alunos
(
	alu_rm   int not null primary key identity,
	alu_nome varchar(100) not null,
)

create table professores
(
	prf_codigo   int not null primary key identity,
	prf_nome     varchar(100) not null
)

create table cursos
(
	cur_codigo   int not null primary key identity,
	cur_nome     varchar(100) not null
)

create table disciplinas
(
	dis_codigo   int not null primary key identity,
	dis_nome     varchar(100) not null,
	dis_ch       int not null,
	cur_codigo   int,
	prf_codigo   int,
	periodo      int,
	foreign key(cur_codigo) references cursos(cur_Codigo),
	foreign key(prf_codigo) references professores(prf_codigo)
)

create table aproveitamentos
(
    dis_codigo int not null,		
    alu_rm     int not null,	
	apr_ano    int not null,
	apr_sem    int not null,
	apr_nota   decimal(4,2) not null,
	apr_falta  int not null,
	primary key(dis_codigo, alu_rm, apr_ano, apr_sem),
	foreign key(dis_Codigo) references disciplinas(dis_Codigo),
	foreign key(alu_Rm) references alunos(alu_Rm)
)

insert into alunos values ('Paty')
insert into alunos values ('Sergio')
insert into alunos values ('Pedro')
insert into alunos values ('Loopy')
insert into alunos values ('Tuca')

select * from alunos

insert into cursos values ('Tecnologia em Análise e Desenvolvimento de Sistemas')
select * from cursos

insert into professores values ('Homem de Ferro')
insert into professores values ('Mulher Maravilha')
insert into professores values ('Capitão América')
select * from professores

insert into disciplinas values ('Algoritmos', 80, 1, 1, 1)
insert into disciplinas values ('Matemática Discreta', 80, 1, 2, 1)
insert into disciplinas values ('Engenharia de Software', 80, 1, 3, 1)
insert into disciplinas values ('Banco de Dados', 80, 1, 1, 2)
insert into disciplinas values ('IHC', 80, 1, 2, 2)
insert into disciplinas values ('LP I', 80, 1, 3, 3)
insert into disciplinas values ('ED', 80, 1, 1, 3)

select * from Disciplinas


/* 
Os inserts abaixo alimenta o BD com as seguintes informações: 
Aluno 1 - Não tem DP (melhor aluno)
Aluno 2 - DPs: 1, 2, 4 
Aluno 3 - DPs: 6, 7
Aluno 4 - DPs: 1, 2, 4, 5, 7 
Aluno 5 - DPs: 1, 2, 4, 5, 6, 7 (ainda não se formou)
*/


-- 23.1 --
insert into aproveitamentos values (1, 1, 2023, 1, 8.5, 10) -- Aprovado 
insert into aproveitamentos values (1, 2, 2023, 1, 4.5, 4)  -- Reprovado por nota
insert into aproveitamentos values (1, 3, 2023, 1, 7.0, 0)  -- Aprovado
insert into aproveitamentos values (1, 4, 2023, 1, 7.5, 40) -- Reprovado por falta
insert into aproveitamentos values (1, 5, 2023, 1, 1, 50)   -- Reprovado por nota e falta

insert into aproveitamentos values (2, 1, 2023, 1, 7.5, 10) -- Aprovado 
insert into aproveitamentos values (2, 2, 2023, 1, 3.0, 2)  -- Reprovado por nota
insert into aproveitamentos values (2, 3, 2023, 1, 8.0, 6)  -- Aprovado
insert into aproveitamentos values (2, 4, 2023, 1, 7.0, 24) -- Reprovado por falta
insert into aproveitamentos values (2, 5, 2023, 1, 3, 28)   -- Reprovado por nota e falta

insert into aproveitamentos values (3, 1, 2023, 1, 10, 2)  -- Aprovado 
insert into aproveitamentos values (3, 2, 2023, 1, 9.0, 2) -- Aprovado 
insert into aproveitamentos values (3, 3, 2023, 1, 9.5, 4) -- Aprovado 
insert into aproveitamentos values (3, 4, 2023, 1, 8.0, 4) -- Aprovado 
insert into aproveitamentos values (3, 5, 2023, 1, 9.5, 2) -- Aprovado 

-- 23.2 --
insert into aproveitamentos values (4, 1, 2023, 2, 10, 0)   -- Aprovado 
insert into aproveitamentos values (4, 2, 2023, 2, 1.5, 8)  -- Reprovado por nota
insert into aproveitamentos values (4, 3, 2023, 2, 8.5, 2)  -- Aprovado
insert into aproveitamentos values (4, 4, 2023, 2, 9.0, 22) -- Reprovado por falta
insert into aproveitamentos values (4, 5, 2023, 2, 1, 22)   -- Reprovado por nota e falta

insert into aproveitamentos values (5, 1, 2023, 2, 10, 0)   -- Aprovado 
insert into aproveitamentos values (5, 2, 2023, 2, 7.5, 2)  -- Aprovado
insert into aproveitamentos values (5, 3, 2023, 2, 9.5, 4)  -- Aprovado
insert into aproveitamentos values (5, 4, 2023, 2, 1.0, 32) -- Reprovado por nota e falta
insert into aproveitamentos values (5, 5, 2023, 2, 2.5, 2)  -- Reprovado por nota

-- DP das disciplinas 1 e 2 em 23.2 --
insert into aproveitamentos values (1, 2, 2023, 2, 8.0, 4)  -- Aprovado
insert into aproveitamentos values (1, 4, 2023, 2, 3.0, 4)  -- Reprovado por nota
insert into aproveitamentos values (1, 5, 2023, 2, 7.0, 50) -- Reprovado por falta

insert into aproveitamentos values (2, 2, 2023, 2, 8.5, 2)  -- Aprovado
insert into aproveitamentos values (2, 4, 2023, 2, 7.5, 4)  -- Aprovado
insert into aproveitamentos values (2, 5, 2023, 2, 3, 8)    -- Reprovado por nota

-- 24.1 -- 
insert into aproveitamentos values (6, 1, 2024, 1, 0.5, 22) -- Reprovado por nota e falta
insert into aproveitamentos values (6, 2, 2024, 1, 9.5, 0)  -- Aprovado
insert into aproveitamentos values (6, 3, 2024, 1, 4.5, 2)  -- Reprovado por nota
insert into aproveitamentos values (6, 4, 2024, 1, 9.0, 4)  -- Aprovado
insert into aproveitamentos values (6, 5, 2024, 1, 8.0, 22) -- Reprovado por falta

insert into aproveitamentos values (7, 1, 2024, 1, 9.5, 2)  -- Aprovado
insert into aproveitamentos values (7, 2, 2024, 1, 10, 0)   -- Aprovado
insert into aproveitamentos values (7, 3, 2024, 1, 3.5, 2)  -- Reprovado por nota
insert into aproveitamentos values (7, 4, 2024, 1, 7.5, 44) -- Reprovado por falta
insert into aproveitamentos values (7, 5, 2024, 1, 9.0, 22) -- Reprovado por falta

-- DPs 24.1 --
insert into aproveitamentos values (4, 2, 2024, 1, 9.5, 8)  -- Aprovado
insert into aproveitamentos values (4, 4, 2024, 1, 8.0, 4)  -- Aprovado
insert into aproveitamentos values (4, 5, 2024, 1, 10, 0)   -- Reprovado por nota

insert into aproveitamentos values (5, 4, 2024, 1, 9.0, 2)  -- Aprovado
insert into aproveitamentos values (5, 5, 2024, 1, 1.5, 2)  -- Reprovado por nota

insert into aproveitamentos values (1, 4, 2024, 1, 9.0, 4)  -- Aprovado
insert into aproveitamentos values (1, 5, 2024, 1, 7.5, 0)  -- Aprovado
insert into aproveitamentos values (2, 5, 2024, 1, 0.5, 8)  -- Reprovado por nota


-- DPs 24.2 --
insert into aproveitamentos values (6, 3, 2024, 2, 9.5, 0)  -- Aprovado
insert into aproveitamentos values (6, 5, 2024, 2, 7.0, 30) -- Reprovado por falta

insert into aproveitamentos values (7, 3, 2024, 2, 3.5, 2)  -- Aprovado
insert into aproveitamentos values (7, 4, 2024, 2, 2.0, 44) -- Aprovado
insert into aproveitamentos values (7, 5, 2024, 2, 1.5, 22) -- Reprovado por nota

-- DPs 25.1 --
insert into aproveitamentos values (7, 3, 2025, 1, 7.5, 4)   -- Aprovado
insert into aproveitamentos values (7, 4, 2025, 1, 10, 0)    -- Aprovado
insert into aproveitamentos values (2, 5, 2025, 1, 0, 0)     -- Reprovado por nota
insert into aproveitamentos values (5, 5, 2025, 1, 8.0, 28)  -- Reprovado por falta
insert into aproveitamentos values (6, 5, 2025, 1, 0, 24)    -- Reprovado por falta e falta
insert into aproveitamentos values (7, 5, 2025, 1, 1.5, 0)   -- Reprovado por falta

select * from aproveitamentos

-- ordem decrescenste
select * from disciplinas
order by dis_nome desc

-- IF
select * from aproveitamentos
where apr_nota >= 4 and apr_nota < 6

-- ordem decrescenste
select * from aproveitamentos
order by apr_nota desc

-- JOIN
select * from aproveitamentos a, alunos al
where a.alu_rm = al.alu_rm

select * from disciplinas d, professores p
where d.prf_codigo = p.prf_codigo

create view v_disciplinas
as
select d.dis_nome Disciplina, d.dis_ch CH,
	   d.periodo Periodo, p.prf_nome Professor
from disciplinas d, professores p
where d.prf_codigo = p.prf_codigo

select * from v_disciplinas

select a.apr_ano Ano, a.apr_sem Semestre,
	   d.dis_nome Disciplina, al.alu_nome Aluno,
	   a.apr_nota Nota, a.apr_falta Faltas,
	   f.prf_nome Professor
from aproveitamentos a, alunos al, disciplinas d, professores f
where al.alu_rm = a.alu_rm and
	  a.dis_codigo = d.dis_codigo and
	  d.prf_codigo = f.prf_codigo
order by Ano, Semestre, dis_nome, Nota desc

-- frequencia
select *, (1 - a.apr_falta * 1.0 / d.dis_ch) * 100 Frequência
from aproveitamentos a, disciplinas d
where a.dis_codigo = d.dis_codigo and
	  a.apr_nota >= 6 and
	  (1 - a.apr_falta * 1.0 / d.dis_ch) * 100 >= 75