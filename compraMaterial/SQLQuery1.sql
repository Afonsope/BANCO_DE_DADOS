CREATE DATABASE vendas_manha
GO

USE vendas_manha
GO

CREATE TABLE pessoas (
	id		INT			NOT NULL IDENTITY,
	nome	VARCHAR(50) NOT NULL,
	cpf		VARCHAR(12) NOT NULL,
	status	INT 

	-- RESTRIÇÕES --
	CONSTRAINT pk_pessoas PRIMARY KEY(id),
	CONSTRAINT uq_pessoas_cpf UNIQUE(cpf),
	CONSTRAINT ck_pessoas_status CHECK(status IN(1,2,3,4)) 
);
GO

CREATE TABLE clientes(
	id_pessoas	INT		NOT NULL,
	renda		DECIMAL (10,2) NOT NULL,
	credito	AS renda * 0.25

	-- RESTRIÇÕES --

	CONSTRAINT pk_clientes PRIMARY KEY (id_pessoas),
	CONSTRAINT fk_clientes_pessoas 
				FOREIGN KEY (id_pessoas) REFERENCES pessoas(id),
	CONSTRAINT ck_clientes_renda CHECK (RENDA > 0)
);
GO

CREATE TABLE vendedores(
	id_pessoas INT NOT NULL,
	salario DECIMAL (10,2) NOT NULL,

	-- RESTRIÇÕES --

	CONSTRAINT pk_vendedores PRIMARY KEY (id_pessoas),
	CONSTRAINT fk_vendedores_pessoas
				FOREIGN KEY (id_pessoas) REFERENCES pessoas(id),
	CONSTRAINT ck_vendedores_salario CHECK (SALARIO > 0)
);
GO

--INSERTS--

INSERT INTO pessoas VALUES ('Batman','1010', 1)
INSERT INTO pessoas VALUES ('Coringa', '2020', 1)
INSERT INTO pessoas VALUES ('Mulher Maravilha', '3030', 1)
INSERT INTO pessoas VALUES ('Robin', '4040', 1)
INSERT INTO pessoas VALUES ('Super Main', '5050', 1)


INSERT INTO clientes (id_pessoas, renda) VALUES (1, 10000)
INSERT INTO clientes (id_pessoas, renda) VALUES (3, 15000)
INSERT INTO clientes (id_pessoas, renda) VALUES (5, 1501)


INSERT INTO vendedores (id_pessoas, salario) VALUES (2, 23000)
INSERT INTO vendedores (id_pessoas, salario) VALUES (4, 14251)

SELECT * FROM pessoas
SELECT * FROM clientes
SELECT * FROM vendedores