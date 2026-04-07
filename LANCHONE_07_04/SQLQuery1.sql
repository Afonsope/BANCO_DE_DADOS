CREATE DATABASE lanchonete_07_04
GO

USE lanchonete_07_04

CREATE TABLE categorias (
	codigo	INT			NOT NULL PRIMARY KEY IDENTITY,
	nome	VARCHAR(50) NOT NULL
);
GO

CREATE TABLE lanches (
	codigo				INT				NOT NULL PRIMARY KEY IDENTITY,
	nome				VARCHAR(50)		NOT NULL,
	preco				DECIMAL(10,2)	NOT NULL,
	calorias			INT				NOT NULL,
	categoria_codigo	INT				NOT NULL REFERENCES CATEGORIAS
);
GO

CREATE TABLE bebidas (
	codigo	INT				NOT NULL PRIMARY KEY IDENTITY,
	nome	VARCHAR(50)		NOT NULL,
	preco	DECIMAL(10,2)	NOT NULL,
	estoque INT
);
GO

CREATE TABLE ufs (
	sigla	CHAR(2)			NOT NULL PRIMARY KEY,
	nome	VARCHAR(50)		NOT NULL
);
GO

CREATE TABLE cidades (
	codigo		INT				NOT NULL PRIMARY KEY IDENTITY,
	nome		VARCHAR(50)		NOT NULL,
	uf_sigla	CHAR(2)			NOT NULL REFERENCES ufs
);
GO

CREATE TABLE ceps (
	nr				VARCHAR(10)		NOT NULL PRIMARY KEY,
	cidade_codigo	INT				NOT NULL REFERENCES cidades
);
GO

CREATE TABLE pessoas (
	codigo INT NOT NULL PRIMARY KEY IDENTITY,
	nome VARCHAR(50) NOT NULL,
	cpf VARCHAR(15) NOT NULL UNIQUE,
	cep_nr VARCHAR(10) NOT NULL REFERENCES ceps,
	logadouro VARCHAR(100) NOT NULL,
	nr VARCHAR(5) NOT NULL 
);
GO

CREATE TABLE telefones (
	pessoas_codigo INT NOT NULL REFERENCES pessoas,
	nr VARCHAR(20) NOT NULL,
	PRIMARY KEY(pessoas_codigo, nr) -- chave primaria composta
);
GO

CREATE TABLE clientes (
	pessoas_codigo INT NOT NULL PRIMARY KEY REFERENCES pessoas,
	estrelas INT 
);
GO

CREATE TABLE funcionarios (
	pessoa_codigo INT NOT NULL PRIMARY KEY REFERENCES pessoas,
	salario DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE entregadores (
	pessoa_codigo INT NOT NULL PRIMARY KEY REFERENCES pessoas,
	valor_diaria DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE entregas (
	codigo INT NOT NULL PRIMARY KEY IDENTITY,
	data_hora_saida DATETIME NULL,
	status INT NULL,
	entregador_codigo INT NOT NULL REFERENCES entregadores
);
GO

CREATE TABLE pedidos (
	nr INT NOT NULL PRIMARY KEY IDENTITY,
	data DATETIME NOT NULL DEFAULT GETDATE(),
	total DECIMAL(10,2) NULL,
	status INT NULL,
	cliente_codigo INT NOT NULL REFERENCES clientes,
	funcionario_codigo INT NOT NULL REFERENCES funcionarios,
	entrega_codigo INT NULL REFERENCES entregas
);
GO

CREATE TABLE pedidos_lanches (
	pedido_nr INT NOT NULL REFERENCES pedidos,
	lanche_codigo INT NOT NULL REFERENCES lanches,
	qtd INT NOT NULL,
	preco DECIMAL(10,2) NOT NULL,
	PRIMARY KEY(pedido_nr, lanche_codigo)
);
GO

CREATE TABLE pedidos_bebidas (
	 pedido_nr INT NOT NULL REFERENCES pedidos,
	 bebida_codigo INT NOT NULL REFERENCES bebidas,
	 qtd INT NOT NULL,
	 PRIMARY KEY(pedido_nr, bebida_codigo)
);
GO