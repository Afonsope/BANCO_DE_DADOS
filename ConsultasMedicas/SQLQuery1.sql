CREATE DATABASE clinica_manha
GO

USE clinica_manha
GO

create table pacientes (
	codigo	INT			NOT NULL PRIMARY KEY IDENTITY,
	nome	VARCHAR(50) NOT NULL,
	cpf		VARCHAR(12) NOT NULL UNIQUE,
	fone	VARCHAR(20) NOT NULL
);
go

INSERT INTO pacientes VALUES ('Arthur', '6582',	'17-7070-7070')
INSERT INTO pacientes VALUES ('Pedor Fonsino', '9875',	'17-2345-5648')
INSERT INTO pacientes VALUES ('Cheguevara', '6769',	'12-2524-2221')
INSERT INTO pacientes VALUES ('Laura', '7685', '12-1212-1212')
INSERT INTO pacientes VALUES ('Lanterna bosta', '5473', '17-6060-6060')
INSERT INTO pacientes VALUES ('Maria', '1234', '17-3333-3333')
INSERT INTO pacientes VALUES ('Matheus', '0987', '17-3344-3344')

UPDATE pacientes SET nome = 'Batman', fone = '17-0000-0000' WHERE codigo = 5

DELETE FROM pacientes WHERE codigo = 5

SELECT * FROM pacientes

CREATE TABLE especialidades (
	codigo	INT			NOT NULL PRIMARY KEY IDENTITY,
	nome	VARCHAR(50) NOT NULL
);
GO

INSERT INTO especialidades VALUES ('Cardiologia'), ('Ortopedia'), ('Pediatria')

SELECT * FROM especialidades

DECLARE @i INT
SET @i = 1
WHILE @i < 2
	INSERT INTO especialidades VALUES ('Cardiologia'), ('Ortopedia'), ('Pediatria')

SELECT * FROM especialidades
WHERE codigo BETWEEN 1000 AND 2000 

DELETE FROM especialidades WHERE codigo > 3

SELECT * FROM especialidades

CREATE TABLE medicos (
	crm	VARCHAR(10) NOT NULL PRIMARY KEY,
	nome VARCHAR(50) NOT NULL, 
	especialidade_codigo INT NOT NULL
							REFERENCES especialidades
)
GO

SELECT * FROM especialidades
SELECT * FROM medicos
SELECT * FROM medicos

INSERT INTO medicos VALUES ('100.100', 'Matheus', 1)
INSERT INTO medicos VALUES ('100.200', 'Mariana', 3)
INSERT INTO medicos VALUES ('100.300', 'Samuel', 2)
INSERT INTO medicos VALUES ('100.400', 'Barbara', 2)
INSERT INTO medicos VALUES ('100.500', 'Sergio', 1)

CREATE TABLE consultas (
	nr				INT				NOT NULL	IDENTITY,
	data_hora		DATETIME		NOT NULL,
	valor			DECIMAL(10,2)	NOT NULL	DEFAULT 150,
	status			INT				NULL		DEFAULT 1,
	paciente_codigo INT				NOT NULL,
	medico_crm		VARCHAR(10)		NOT NULL,

	-- RESTRIÇÕES --
	CONSTRAINT pk_consulta PRIMARY KEY(nr),
	CONSTRAINT fk_consultas_pacientes FOREIGN KEY(paciente_codigo) REFERENCES pacientes(codigo),
	CONSTRAINT fk_consultas_medicos FOREIGN KEY(medico_crm) REFERENCES medicos(crm),

	CHECK (valor >= 150),
	CHECK (STATUS in(1, 2, 3, 4))
);
GO

INSERT INTO consultas (data_hora, paciente_codigo, medico_crm)VALUES(GETDATE()+1, 2, '100.300')

select * from consultas


INSERT INTO consultas VALUES ('08/03/2026 15:30' , 300, 1, 3, '100.400')


------------------------------------------------------------------------

SELECT * FROM especialidades
SELECT * FROM medicos



CREATE VIEW v_medicos
AS
	SELECT m.crm, m.nome Medico, e.nome Especialidade
	FROM medicos m, especialidades e
	WHERE m.especialidade_codigo = e.codigo
GO

SELECT * FROM v_medicos