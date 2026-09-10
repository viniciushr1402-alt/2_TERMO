-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Cliente (
nome_cliente varchar(50),
Id_cliente int autoincriment primary key PRIMARY KEY
)

CREATE TABLE Pedido (
Id_pedido Texto(1) PRIMARY KEY,
Data_Pedido datetime not null,
Id_cliente int autoincriment primary key,
FOREIGN KEY(Id_cliente) REFERENCES Cliente (Id_cliente)
)

CREATE TABLE Produto+Estoque (
Id_produto int auto incriment primary key,
nome_produto varchar(50),
Id_estoque int auto incriment primary key,
quantidade int,
PRIMARY KEY(Id_produto,Id_estoque)
)

CREATE TABLE Fornecedor (
Razão_social VARCHAR(100),
Id_Fornecedor int auto increment primary key PRIMARY KEY
)

CREATE TABLE Produto (
Id_Produto int auto incriment primary  key PRIMARY KEY,
Nome_Produto VARCHAR(100)
)

)


CREATE TABLE Fornecedor+Item_Produto (
Id_Produto Int Not Null,
Int Not Null int auto increment primary key,
Id_Item int auto increment primary key PRIMARY KEY,
Valor decimal (10,2)
)

