CREATE DATABASE vendas_manha_16_03
GO

USE vendas_manha_16_03
GO

CREATE TABLE pessoas 
(
	codigo		INT			NOT NULL IDENTITY,
	nome		VARCHAR(50)	NOT NULL,
	cpf			VARCHAR(12)	NOT NULL,
	status		INT,

	-- restrições --
	CONSTRAINT pk_pessoas		 PRIMARY KEY(codigo),
	CONSTRAINT uq_pessoas_cpf	 UNIQUE(cpf),
	CONSTRAINT ck_pessoas_status CHECK(status IN (1,2,3,4))
)
GO

CREATE TABLE clientes
(
	pessoa_codigo	INT NOT NULL,
	renda			DECIMAL(10,2),
	credito AS renda * 0.25,
	
	-- restrições --
	CONSTRAINT pk_clientes PRIMARY KEY(pessoa_codigo),
	CONSTRAINT fk_clientes_pessoas 
	   FOREIGN KEY(pessoa_codigo) REFERENCES pessoas(codigo),
	CONSTRAINT ck_clientes_renda CHECK(renda > 0)
)
GO

CREATE TABLE vendedores
(
	pessoa_codigo	INT			  NOT NULL,
	salario			DECIMAL(10,2) NOT NULL,
	
	-- restrições --
	CONSTRAINT pk_vendedores PRIMARY KEY(pessoa_codigo),
	CONSTRAINT fk_vendedores_pessoas
	    FOREIGN KEY(pessoa_codigo) REFERENCES pessoas(codigo),
	CONSTRAINT ck_vendedores_salario CHECK(salario > 1500)
)
GO

CREATE TABLE categorias(
	codigo	INT			NOT NULL	IDENTITY,
	nome	VARCHAR(50)	NOT NULL,

	-- restricoes -- 
	CONSTRAINT pk_categorias PRIMARY KEY (codigo)
);
GO

CREATE TABLE produtos(
	codigo				INT				NOT NULL IDENTITY,
	descricao			VARCHAR(50)		NOT NULL,
	preco				DECIMAL(10,2)	NULL,
	estoque				INT				NULL,
	status				INT				NULL,
	categoria_codigo	INT				NOT NULL,

	-- restricoes --

	CONSTRAINT pk_produtos				PRIMARY KEY(codigo),
	CONSTRAINT ck_produtos_preco		CHECK(preco > 0),
	CONSTRAINT ck_produtos_estoque		CHECK(estoque >= 0),
	CONSTRAINT ck_produtos_status		CHECK(status IN (1,2,3,4)),
	CONSTRAINT fk_produtos_categorias
				FOREIGN KEY(categoria_codigo) REFERENCES categorias(codigo)
);
GO

-- inserts --

INSERT INTO pessoas VALUES ('Batman', '1010', 1)
INSERT INTO pessoas VALUES ('Coringa','2020', 1)
INSERT INTO pessoas VALUES ('Mulher Maravilha', '3030', 1)
INSERT INTO pessoas VALUES ('Robin', '4040', 1)
INSERT INTO pessoas VALUES ('Super Main', '5050', 1)

INSERT INTO clientes (pessoa_codigo, renda) VALUES (1, 10000)
INSERT INTO clientes (pessoa_codigo, renda) VALUES (3, 15000)
INSERT INTO clientes (pessoa_codigo, renda) VALUES (5, 1501)

INSERT INTO vendedores VALUES (2, 3000), (4, 3000)

INSERT INTO categorias VALUES ('Lápis'), ('Canetas'), ('Cadernos');

INSERT INTO produtos values	('Lápis Preto Nr. 2', 2, 100, 1, 1),
							('Caneta Azul', 3, 500, 1, 2),
							('Caderno 10 Matérias - ', 45, 100, 1, 3),
							('Caneta Vermelha', 2.5, 50, 1, 2),
							('Caderno 5 Matérias - Barbie', 120, 30, 1, 3)

SELECT * FROM pessoas
SELECT * FROM clientes
SELECT * FROM vendedores
SELECT * FROM categorias
SELECT * FROM produtos
