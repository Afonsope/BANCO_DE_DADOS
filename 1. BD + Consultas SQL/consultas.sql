use [ConsultasSQL26.1]

select * from aproveitamentos

select AVG(apr_nota) Media, COUNT(*) QTD
from aproveitamentos


select AVG(apr_nota) Media, COUNT(*) QTD
from aproveitamentos
where alu_rm = 3


select AVG(apr_nota) Media, COUNT(*) QTD
from aproveitamentos
where alu_rm = 3 and apr_ano = 2024


select AVG(apr_nota) Media, COUNT(*) QTD
from aproveitamentos
where alu_rm = 3 and apr_ano = 2024 and apr_sem = 1


select AVG(apr_nota) media, COUNT (*) Qtd
from aproveitamentos
where dis_codigo = 7


select AVG(apr_nota) media, COUNT (*) Qtd
from aproveitamentos
where dis_codigo = 7 and apr_ano = 2024 and apr_sem = 1

--------------------------------------------------------------

select AVG (apr_nota) Media from aproveitamentos

select AVG (apr_nota) media from aproveitamentos
where dis_codigo = 1

select AVG (apr_nota) media from aproveitamentos
where dis_codigo in (3,7)


select * from aproveitamentos
where dis_codigo in (3,7)
group by dis_codigo

select * from aproveitamentos

select dis_codigo, apr_ano, AVG(apr_nota) Media, COUNT(*) qtd from aproveitamentos
where dis_codigo in (3,7)
group by dis_codigo, apr_ano

select dis_codigo, apr_ano, AVG(apr_nota) Media, COUNT(*) qtd from aproveitamentos
group by dis_codigo, apr_ano
order by dis_codigo, apr_ano


select AVG(apr_nota) media
from aproveitamentos
group by apr_ano, apr_sem

-- Having --
select dis_codigo, AVG(apr_nota) Media, COUNT(*) Qtd
from aproveitamentos
where apr_nota >= 4
group by dis_codigo
having AVG (apr_nota) >= 8 and count (*) > 5


----------
select alu_rm RM, alu_nome Nome, AVG(apr_nota)
from alunos, aproveitamentos
 

select apr_ano, AVG(apr_nota) Media, COUNT(*) qtd from aproveitamentos
where dis_codigo in (3,7)
group by dis_codigo, apr_ano

select a.alu_nome Nome, a.alu_rm rm , AVG(apr_nota) Media  
from  aproveitamentos apr, alunos a
where apr.apr_ano = 2023 and a.alu_rm = apr.alu_rm and apr.apr_sem = 1
group by a.alu_rm, a.alu_nome
having AVG(apr_nota) > 4
order by Media asc

