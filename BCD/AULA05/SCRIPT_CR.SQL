-- Active: 1788435082238@@127.0.0.1@3306@sesi_cr_tb
CREATE DATABASE SESI_CR_TB;

USE SESI_CR_TB;

CREATE TABLE CLIENTE(
ID_CLIENTE int AUTO_INCREMENT PRIMARY KEY,
NOME_CLIENTE VARCHAR(60) NOT NULL
);

CREATE TABLE PEDIDO(
ID_PEDIDO int AUTO_INCREMENT PRIMARY KEY,
DATA_PEDIDO DATETIME NOT NULL,
ID_CLIENTE INT NOT NULL,
FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE (ID_CLIENTE)
);

CREATE TABLE FORNECEDOR (
ID_FORNECEDOR INT AUTO_INCREMENT PRIMARY KEY,
RAZAO_SOCIAL VARCHAR(50) NOT NULL
);

CREATE TABLE PRODUTO (
ID_PRODUTO INT AUTO_INCREMENT PRIMARY KEY,
NOME_PRODUTO VARCHAR(60) NOT NULL,
ID_FORNECEDOR INT NOT NULL,
FOREIGN KEY (ID_FORNECEDOR) REFERENCES FORNECEDOR (ID_FORNECEDOR)
);

-- 1 - QUESTÃO
-- CATEGORIA ----> PRODUTOS
-- Uma categoria pode possuir vários produtos. Cada produto pertence a apenas uma categoria.
-- 1,N                         1,1

-- 2 - QUESTÃO
-- FUNCIONÁRIO ----> PEDIDOS
-- Um funcionário pode registrar vários pedidos. Cada pedido é registrado por um funcionário.
-- 1,N                         1,1

-- 3 - QUESTÃO
-- FORNECEDOR ----> PRODUTOS
-- Um fornecedor comercializa vários produtos, e o mesmo produto pode ser comprado de vários fornecedores.
-- 1,N                         1,N

-- 4 - QUESTÃO
-- MESA ----> RESERVA
-- Uma mesa pode existir sem nenhuma reserva futura. Uma reserva deve estar vinculada a uma mesa.
-- 0,N                         1,1

-- 5 - QUESTÃO
-- PEDIDO ----> ITENS
-- Um pedido possui vários itens. Um item de pedido pertence a um único pedido.
-- 1,N                         1,1


SELECT * FROM CLIENTE;

SELECT * FROM PEDIDO;

INSERT INTO CLIENTE (NOME_CLIENTE) VALUES
('BRUNO'),
('MARIA'),
('JOSÉ');
