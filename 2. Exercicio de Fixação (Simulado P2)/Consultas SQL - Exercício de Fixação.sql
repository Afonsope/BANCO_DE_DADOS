use [ConsultasSQL26.1]

/* --------------------------------------------------------------------- 
1. Consultar a média de cada disciplina no segundo semestre de 2023. 
Considere no cálculo somente as notas superiores a 3.0. 
Apresente o nome da disciplina e a média obtida somente das disciplinas 
com mais de 2 alunos. Ordene a saída pela média em ordem decrescente.
----------------------------------------------------------------------- */

select d.dis_nome, avg(apr_nota) Media   -- Apresente o nome da disciplina e a média
from aproveitamentos a, disciplinas d	 -- junção para buscar o nome da disciplina
where 
	  a.dis_codigo = d.dis_codigo and    -- nome da disciplina
	  apr_nota > 3   and				 -- notas superiores a 3.0
      apr_ano = 2023 and				 -- 2023
	  apr_sem = 2    					 -- segundo semestre
group by d.dis_nome						 -- de cada disciplina
having count(*) > 2						 -- somente das disciplinas com mais de 2 alunos.
order by								 -- Ordene a saída pela média em ordem decrescente.
    Media desc

	
/* --------------------------------------------------------------------------------------------------
2. Consultar a quantidade de reprovações somente por frequência de cada 
disciplina no segundo semestre de 2023. Apresente o nome da disciplina e a quantidade de reprovações. 
Ordene a saída pelo nome da disciplina em ordem crescente.
---------------------------------------------------------------------------------------------------- */

select d.dis_nome, count(*) Qtd
from aproveitamentos a, disciplinas d
where a.dis_codigo = d.dis_codigo and
      (1 - a.apr_falta*1.0/d.dis_ch)*100 < 75 and a.apr_nota >= 6 and
	  a.apr_ano = 2023 and a.apr_sem = 2
group by
      d.dis_nome
order by d.dis_nome asc --desc


/* --------------------------------------------------------------------------------------------
3. Consultar a quantidade de disciplina reprovadas por nota ou frequência de cada aluno 
no segundo semestre de 2023. Apresente o RM do aluno, nome do aluno e a 
quantidade de disciplinas reprovadas. Ordene a saída pela quantidade em ordem decrescente.
---------------------------------------------------------------------------------------------- */

select a.alu_rm, al.alu_nome, count(*) Qtd        
from aproveitamentos a, disciplinas d, alunos al	
where 
	  a.dis_codigo = d.dis_codigo and						           -- precisou do dis_ch (freq)			 
	  a.alu_rm = al.alu_rm and										   -- precisou do alu_nome
	  ((1 - a.apr_falta*1.0/d.dis_ch)*100 < 75 or a.apr_nota < 6)  and -- alunos reprovados
	  a.apr_ano = 2023 and											   -- ano 2023
	  a.apr_sem = 2													   -- segundo semestre
group by a.alu_rm, al.alu_nome									       -- de cada aluno
order by Qtd desc													   -- Ordene a saída pela quantidade em ordem decrescente


/* -------------------------------------------------------------------------------
4. Consultar os aproveitamentos no segundo semestre de 2023 cursados na disciplina 
com código 2 e lecionados pelo professor 2. Apresente: nome do aluno, nome do professor, 
nota, falta e a frequência somente dos aproveitamentos em que os alunos foram aprovados 
por nota e frequência. Ordene a saída pelo nome do aluno em ordem decrescente.
----------------------------------------------------------------------------------- */

select al.alu_nome Aluno, p.prf_nome Professor, a.apr_nota Nota, a.apr_falta Falta,  
      Convert (decimal(10,2),(1 - a.apr_falta*1.0/d.dis_ch)*100) Freq
from  alunos al, aproveitamentos a, disciplinas d, professores p
where
      al.alu_rm = a.alu_rm        and
	  a.dis_codigo = d.dis_codigo and 
	  d.prf_codigo = p.prf_codigo and
	  (1 - a.apr_falta*1.0/d.dis_ch)*100 >= 75 and a.apr_nota >= 6 and -- alunos aprovados
	  a.apr_ano = 2023 and											   -- ano 2023
	  a.apr_sem = 2	   and 											   -- semestre 2
	  a.dis_codigo = 2 and											   -- disciplina 2
	  d.prf_codigo = 2                                                 -- professor 2
order by 
      aluno desc


/* -------------------------------------------------------------------------------
5. Consultar o aluno com a maior média. Apresente nome e a média desse aluno.
----------------------------------------------------------------------------------- */

select top 1 a.alu_nome Aluno, avg(ap.apr_nota) Média
from aproveitamentos ap, alunos a
where ap.alu_rm = a.alu_rm
group by a.alu_nome
order by Média desc


-- Fim -------------------------------------------------------------------------------------------





