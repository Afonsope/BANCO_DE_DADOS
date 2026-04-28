/* 
   Este BD é somente para uso didático. Por exemplo, ele não contém herança ou agregação. Será utilizado
   para o ensino e aprendizagem de consultas (select) SQL. Por isso, o BD é simples.
   Neste arquivo há 30 consultas SQL que subsidiarão o conhecimento necessário para a avaliação.
*/


use [ConsultasSQL26.1]

1.	Consultar as disciplinas do curso 1. Apresente: código da disciplina, nome da disciplina, carga horária. 
    Ordene a saída pelo nome da disciplina em ordem crescente.

select dis_codigo Codigo, dis_nome Disciplina, dis_ch Carga_Horaria
from disciplinas
order by dis_nome asc


2.	Consultar as disciplinas e os respectivos cursos. Apresente: nome do curso, código da disciplina, nome da disciplina e carga horária. 
    Ordene a saída pelo código da discilina em ordem decrecente

select c.cur_nome Curso, d.dis_codigo Codigo, d.dis_nome Disciplina, dis_ch Carga_Horaria
from cursos c, disciplinas d
where c.cur_codigo = d.cur_codigo
order by d.dis_codigo desc


3.	Consultar os alunos que começam com a letra P. Apresente o rm e o nome dos alunos. 
    Ordene a saída pelo nome do aluno em ordem crescente.

select alu_rm RM, alu_nome Aluno
from alunos
where alu_nome like 'P%'
order by alu_nome asc


4.	Consultar todas as disciplinas cursadas aluno com RM = 5. 
    Apresente nome da disciplina, nome do professor, nota e frequência.
	Ordene a saída pela frequência em ordem crescente.

select
	d.dis_nome Disciplina,
	p.prf_nome Professor,
	a.apr_nota Nota,
	convert(
		varchar(5),
		convert(
			decimal(4,1),
			((1 - a.apr_falta * 1.0 / d.dis_ch) * 100)
		)
	) + '%' Frequencia
from
	aproveitamentos a,
	disciplinas d,
	professores p
where
	a.dis_codigo = d.dis_codigo and
	d.prf_codigo = p.prf_codigo and
	a.alu_rm = 5
Order by 
    Frequencia asc


5.	Consultar todos os alunos que cursaram a disciplina com código = 1. 
    Apresente o ano, semestre, nome do aluno, nota, frequência. 
	Ordene a saída pelo ano e sem, ambos de maneira ascendente.

select
	ap.apr_ano  Ano,
	ap.apr_sem  Semestre,
	a.alu_nome  Aluno,
	ap.apr_nota Nota,	
	convert(varchar(5),convert(decimal(4,1),((1 - ap.apr_falta * 1.0 / d.dis_ch) * 100))) + '%' Frequencia
	
from
	aproveitamentos ap,
	alunos a,
	disciplinas d
where
	ap.dis_codigo = 1 and
	ap.alu_rm = a.alu_rm and
	ap.dis_codigo = d.dis_codigo
Order by
    ap.apr_ano asc, ap.apr_sem asc


6.	Consultar os alunos que reprovaram somente por falta na disciplina 7 no primeiro semestre de 2024 
    Apresente o nome do aluno, ano, semestre, nota e a frequência.

select
	al.alu_nome Aluno,
	ap.apr_ano  Ano,
	ap.apr_sem  Semestre,
	ap.apr_nota Nota,
	convert(varchar(5),convert(decimal(4,1),((1 - ap.apr_falta * 1.0 / d.dis_ch) * 100))) + '%' Frequencia
from
	aproveitamentos ap,
	disciplinas d,
	alunos al
where
	ap.dis_codigo = 7 and
	ap.apr_ano = 2024 and
	ap.apr_sem = 1 and
	ap.dis_codigo = d.dis_codigo and
	ap.alu_rm = al.alu_rm and
	(1 - ap.apr_falta * 1.0 / d.dis_ch) < 0.75 and  ap.apr_nota >= 7


7.	Consultar os alunos que reprovaram somente por nota na disciplina 1 no segundo semestre de 2023. 
    Apresente o nome do aluno, ano, semestre, nota e frequência.

select
	al.alu_nome Aluno,
	ap.apr_ano  Ano,
	ap.apr_sem  Semestre,
	ap.apr_nota Nota,
	convert(varchar(5),convert(decimal(4,1),((1 - ap.apr_falta * 1.0 / d.dis_ch) * 100))) + '%' frequencia
from
	aproveitamentos ap,
	alunos al,
	disciplinas d
where
	ap.dis_codigo = 1 and
	ap.apr_ano = 2023 and
	ap.apr_sem = 2 and
	ap.alu_rm = al.alu_rm and
	ap.dis_codigo = d.dis_codigo and 
	ap.apr_nota < 7 and not (1 - ap.apr_falta * 1.0 / d.dis_ch) < 0.75


8. Consultar os alunos que reprovaram por nota e também por frequência na disciplina 1 no primeiro semestre de 2023. 
   Apresente o nome do aluno, ano, semestre, nota e frequencia

select
	al.alu_nome Aluno,
	ap.apr_ano  Ano,
	ap.apr_sem  Semestre,
	ap.apr_nota Nota,
	convert(varchar(5),convert(decimal(4,1),((1 - ap.apr_falta * 1.0 / d.dis_ch) * 100))) + '%' Frequencia
from
	aproveitamentos ap,
	disciplinas d,
	alunos al
where
	ap.dis_codigo = 1 and
	ap.apr_ano = 2023 and
	ap.apr_sem = 1 and
	ap.dis_codigo = d.dis_codigo and
	ap.alu_rm = al.alu_rm and
	ap.apr_nota < 7 and (1 - ap.apr_falta * 1.0 / d.dis_ch) < 0.75


9. Consultar os alunos que reprovaram por nota ou frequência na disciplina 1 no primeiro semestre de 2023. 
   Apresente o nome do aluno, ano, semestre, nota e frequencia.
   Ordene a saída pela nota em ordem crescente.

select
	al.alu_nome Aluno,	
	ap.apr_ano  Ano,
	ap.apr_sem  Semestre,
	ap.apr_nota Nota,
	convert(varchar(5),convert(decimal(4,1),((1 - ap.apr_falta * 1.0 / d.dis_ch) * 100))) + '%' Frequencia
from
	aproveitamentos ap,
	disciplinas d,
	alunos al
where
	ap.dis_codigo = 1 and
	ap.apr_ano = 2023 and
	ap.apr_sem = 1 and
	ap.dis_codigo = d.dis_codigo and
	ap.alu_rm = al.alu_rm and
	(ap.apr_nota < 7 or	(1 - ap.apr_falta * 1.0 / d.dis_ch) < 0.75)
Order by
    ap.apr_nota asc


10.	Consultar a média de cada aluno. Apresente o RM, nome do aluno e a média. 
    Ordene a saída pela média em ordem decrescente.

select
	al.alu_rm    RM,
	al.alu_nome  Aluno,
	Convert(decimal(4,2),avg(ap.apr_nota)) Media
from
	aproveitamentos ap,
	alunos al
where
	ap.alu_rm = al.alu_rm
group by
	al.alu_rm,
	al.alu_nome
order by media desc


11. Consultar a média de cada aluno que possui média inferior a 7.5. Apresente o RM, nome do aluno e média.
    Ordene a saída pela média em ordem decrescente.

select
	al.alu_rm,
	al.alu_nome,
	Convert(decimal(4,2),avg(ap.apr_nota)) media
from
	aproveitamentos ap,
	alunos al
where
	ap.alu_rm = al.alu_rm
group by
	al.alu_rm,
	al.alu_nome
having
	avg(ap.apr_nota) < 7.5
order by 
     Media desc


12.	Consultar a média de cada aluno. Apresente o RM, nome e média somente dos alunos que possuem média superior ou igual a 7.5 
    e que cursaram três ou mais disciplinas no primeiro semestre de 2023. Ordene a saída pela média em ordem crescente.

select
	al.alu_rm    RM,
	al.alu_nome  Aluno,
	Convert(decimal(4,2),avg(ap.apr_nota)) Media
from
	aproveitamentos ap,
	alunos al
where
	ap.alu_rm = al.alu_rm and
	ap.apr_ano = 2023 and
	ap.apr_sem = 1
group by
	al.alu_rm,
	al.alu_nome
having
	avg(ap.apr_nota) >= 7.5 and count(*) >= 3
order by 
	media asc


13. Consultar a média de cada disciplina no primeiro semestre de 2024. Apresente o codigo, nome da disciplina e a média. 
    Ordene a saída pelo nome da disciplina em ordem crescente.

select
	d.dis_codigo  Codigo,
	d.dis_nome    Disciplina,
	Convert(decimal(4,2),avg(ap.apr_nota)) Media
from
	aproveitamentos ap,
	disciplinas d
where
	ap.dis_codigo = d.dis_codigo and
	ap.apr_ano = 2024 and
	ap.apr_sem = 1
group by
	d.dis_codigo,
	d.dis_nome
order by d.dis_nome asc


14.	Consultar os alunos que foram reprovados na disciplina 1 no segundo primeiro de 2023. Apresente o nome do aluno, ano, semestre, nota, 
    frequência e o nome do professor. Ordene a saída pelo nome do aluno em ordem crescente.

select
	al.alu_nome  Aluno,
	ap.apr_ano   Ano,
	ap.apr_sem   Semestre,
	ap.apr_nota  Nota,
	convert(varchar(5),convert(decimal(4,1),((1 - ap.apr_falta * 1.0 / d.dis_ch) * 100))) + '%' Frequencia,
	p.prf_nome   Professor
from
	aproveitamentos ap,
	disciplinas d,
	alunos al,
	professores p
where
	ap.dis_codigo = 2 and
	ap.apr_ano = 2023 and
	ap.apr_sem = 1 and
	ap.dis_codigo = d.dis_codigo and
	ap.alu_rm = al.alu_rm and
	d.prf_codigo = p.prf_codigo and
	(ap.apr_nota < 7 or (1 - ap.apr_falta * 1.0 / d.dis_ch) < 0.75)
Order by al.alu_nome asc



15.	Consultar a quantidade de reprovações por nota das disciplinas oferecidas no ano de 2023. 
    Apresente o código da disciplina, nome da disciplina e a quantidade de reprovações. 
	Ordene a saída pela quantidade de reprovações em ordem decrescente.

select
    d.dis_codigo Codigo, 
	d.dis_nome   Disciplina,
	count(*)     Qtd
from
	aproveitamentos ap,
	disciplinas d
where
	ap.apr_nota < 7 and
	ap.dis_codigo = d.dis_codigo and
	ap.apr_ano = 2023 
group by
	d.dis_codigo,
	d.dis_nome
order by
	qtd desc


16.	Consultar a quantidade de reprovações por nota das disciplinas oferecidas no primeiro semestre de 2023. 
    Apresente o código, nome da disciplina e a quantidade de reprovações. 
	Ordene a saída pela quantidade de reprovações em ordem decrescente.

select
    d.dis_codigo Codigo, 
	d.dis_nome   Disciplina,
	count(*)     Qtd
from
	aproveitamentos ap,
	disciplinas d
where
	ap.apr_nota < 7 and
	ap.dis_codigo = d.dis_codigo and
	ap.apr_ano = 2023 and
	ap.apr_sem = 1
group by
	d.dis_codigo,
	d.dis_nome
order by
	qtd desc

	
17.	 Consultar os 3 alunos mais faltosos da disciplina 1 no primeiro semestre de 2023. Apresente o nome do aluno, 
     a quantidade de falta e a frequência. Ordene a saída pela frequência em ordem decrescente.

select top 3
	al.alu_nome   Aluno,
	ap.apr_falta  Falta,
	convert(varchar(5),convert(decimal(4,1),((1 - ap.apr_falta * 1.0 / d.dis_ch) * 100))) + '%' Frequencia
from
	aproveitamentos ap,
	alunos al,
	disciplinas d
where
	ap.apr_ano = 2023 and
	ap.apr_sem = 1 and
	ap.dis_codigo = 1 and
	ap.alu_rm = al.alu_rm and
	ap.dis_codigo = d.dis_codigo
order by
	frequencia desc


18. Consultar a quantidade de alunos da disciplina 1 no primeiro semestre de 2023. Apresente a quantidade de alunos 
    que cursaram a disciplina.

select
	count(*) qtd
from
	aproveitamentos a
where
	a.dis_codigo = 1 and
	a.apr_ano = 2023 and
	a.apr_sem = 1


19.	Consultar a quantidade de disciplina que cada aluno cursou no primeiro semestre de 2024. Apresente o RM do aluno, nome do aluno 
    e a quantidade de disciplinas cursadas. Ordene a saída pelo nome do aluno em ordem decrescente.

select
	ap.alu_rm   RM,
	al.alu_nome Aluno,
	count(*) [Disciplinas Cursadas]
from
	aproveitamentos ap,
	alunos al
where
	ap.alu_rm = al.alu_rm and
	ap.apr_ano = 2024 and
	ap.apr_sem = 1
group by
	ap.alu_rm,
	al.alu_nome
Order by [Disciplinas Cursadas] desc


20. Consultar a quantidade de alunos reprovados de cada disciplina no segundo semestre de 2023.  
    Apresente o nome da disciplina e a quantidade de alunos reprovados. 
	Ordene a saída pelo nome da disciplina em ordem crescente.

select
	d.dis_nome Disciplina,
	count(*) Qtd_Reprovados
from
	aproveitamentos ap,
	disciplinas d
where
	ap.dis_codigo = d.dis_codigo and
	ap.apr_ano = 2023 and
	ap.apr_sem = 2 and
	(ap.apr_nota < 7 or (1 - ap.apr_falta * 1.0 / d.dis_ch) < 0.75)
group by
	d.dis_codigo,
	d.dis_nome
order by d.dis_nome


21.	Consultar a quantidade de alunos de cada disciplina no primeiro semestre de 2024. 
    Apresente o nome da disciplina e quantidade de alunos. 
    Ordene a saída pela quantidade de alunos em ordem decrescente.

select
	d.dis_nome Disciplina, 
	count(*) qtd
from
	aproveitamentos ap,
	disciplinas d
where
    ap.dis_codigo = d.dis_codigo and
	ap.apr_ano = 2024 and
	ap.apr_sem = 1
group by d.dis_nome
order by qtd desc


22.  Consultar as disciplinas do curso 1. Apresente o código da disciplina, nome da disciplina, carga horária, limite de faltas e o nome do professor que a lecionou.

select
	d.dis_codigo	  Codigo,
	d.dis_nome		  Disciplina,
	d.dis_ch		  Carga_Horária,
	(d.dis_ch * 0.25) Limite_faltas,
	p.prf_nome        Professor
from
	cursos c,
	disciplinas d,
	professores p
where
	c.cur_codigo = 1 and
	d.cur_codigo = c.cur_codigo and
	d.prf_codigo = p.prf_codigo


23. Consultar somente as disciplinas que reprovaram mais do que dois alunos no primeiro semestre de 2024. 
    Apresente o codigo da disciplina, nome da disciplina e a quantidade de alunos reprovados.

select
    d.dis_codigo Codigo,
	d.dis_nome Disciplina,
	count(*)   Qtd_Reprovados
from
	aproveitamentos ap,
	disciplinas d
where
	ap.apr_ano = 2024 and
	ap.apr_sem = 1 and
	ap.dis_codigo = d.dis_codigo and
	(ap.apr_nota < 7 or
	(1 - ap.apr_falta * 1.0 / d.dis_ch) < 0.75)
group by
	d.dis_codigo,
	d.dis_nome
having
	count(*) > 2


24. Consultar somente os alunos que foram reprovados duas ou mais disciplinas no primeiro semestre de 2024. 
    Apresente o RM, nome do aluno e a quantidade de reprovação. Ordene a saída pelo nome dos alunos em ordem crescente.

select
	al.alu_rm   RM,  
	al.alu_nome Aluno,
	count(*)    Qtd_Reprovação
from
	aproveitamentos ap,
	alunos al,
	disciplinas d
where
	ap.apr_ano = 2024 and
	ap.apr_sem = 1 and
	ap.alu_rm = al.alu_rm and
	ap.dis_codigo = d.dis_codigo and
	(ap.apr_nota < 7 or	(1 - ap.apr_falta * 1.0 / d.dis_ch) < 0.75)
group by
	al.alu_rm,
	al.alu_nome
having
	count(*) >= 2
order by al.alu_nome asc


25.	Consultar os professores que ministram três ou mais disciplinas.
    Apresente o código, nome do professor e a quantidade de disciplina lecionada.

select
	p.prf_codigo, p.prf_nome,
	count(*) qtd
from
	disciplinas d,
	professores p
where
	d.prf_codigo = p.prf_codigo
group by
	p.prf_codigo,
	p.prf_nome
having
	count(*) >= 3


26. Consultar as disciplinas que foram cursadas por no mínimo três alunos no segundo semestre de 2023. 
    Apresente o nome da disciplina e a quantidade de alunos. 
	Ordene a saída pela quantidade de disciplinas cursadas em ordem decrescente.

select
	d.dis_nome Disciplina,
	count(*)   Qtd
from
	aproveitamentos a,
	disciplinas d
where
	a.apr_ano = 2023 and
	a.apr_sem = 2 and
	a.dis_codigo = d.dis_codigo
group by
	d.dis_codigo,
	d.dis_nome
having
	count(*) >= 3
order by
    qtd desc


27. Consultar a quantidade de disciplina de cada curso. Apresente o nome do curso e a quantidade de disciplinas.
    Ordem a saída pelo nome do curso em ordem decrescente.

select c.cur_nome Curso, 
       count(*) Qtd
from cursos c, disciplinas d
where
    c.cur_codigo = d.cur_codigo
group by c.cur_nome
order by Curso


28.	Consultar a média de cada aluno considerando somente as notas acima de 3. 
    Apresente o RM, nome do aluno e a média.
    Ordene a saída pela média em ordem decrescente.

select al.alu_rm		RM, 
       al.alu_nome		Aluno,
       Convert (decimal(10,2), avg(ap.apr_nota)) Media
from alunos al, aproveitamentos ap, disciplinas d
where
    al.alu_rm = ap.alu_rm and
	ap.dis_codigo = d.dis_codigo and
	ap.apr_nota > 3
group by al.alu_rm, al.alu_nome
order by Media desc


29.	Consultar a média de cada aluno considerando somente as notas acima de 5. 
    Apresente o RM, nome do aluno e a média somente dos alunos com média 8.
	Ordene a saída pela média em ordem ascendente.

select al.alu_rm		RM, 
       al.alu_nome		Aluno,
       Convert (decimal(10,2), avg(ap.apr_nota)) Media
from alunos al, aproveitamentos ap, disciplinas d
where
    al.alu_rm = ap.alu_rm and
	ap.dis_codigo = d.dis_codigo and
	ap.apr_nota > 5
group by al.alu_rm, al.alu_nome
having avg(ap.apr_nota) > 8
order by media asc


30.	Consultar a média de cada aluno considerando somente as notas acima de 2 e inferiores a 6. 
    Apresente o RM, nome do aluno e a média somente dos alunos que obtiveram média superior a 5.0.
	Ordene a saída pela média em ordem decrescente.

select al.alu_rm		RM, 
       al.alu_nome		Nome,
       Convert (decimal(10,2), avg(ap.apr_nota)) Media
from alunos al, aproveitamentos ap, disciplinas d
where
    al.alu_rm = ap.alu_rm and
	ap.dis_codigo = d.dis_codigo and
	(ap.apr_nota > 2 and ap.apr_nota < 8)
group by al.alu_rm, al.alu_nome
having avg(ap.apr_nota) > 5
order by media desc

