-- CRIAR E USAR O BANCO DE DADOS
CREATE DATABASE smartcoffee;
USE smartcoffee;


CREATE TABLE FORNECEDOR (
    ID_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    email_fornecedor VARCHAR(100),
    telefone_fornecedor VARCHAR(20),
    metodo_de_transporte VARCHAR(50),
    valor DECIMAL(10,2),
    localizacao VARCHAR(255),
    cnpj_fornecedor VARCHAR(20)
);
CREATE TABLE CLIENTE (
    ID_cliente INT AUTO_INCREMENT PRIMARY KEY,
    telefone VARCHAR(20),
    nome VARCHAR(100),
    email VARCHAR(100),
    CPF VARCHAR(14)
);
CREATE TABLE POGRAMA_DE_FIDELIDADE (
    ID_programa_de_fidelidade INT AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(14),
    nome VARCHAR(100),
    beneficios VARCHAR(255)
);
CREATE TABLE FUNCIONARIO (
    ID_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    cargo_funcionario VARCHAR(50),
    cpf_do_funcionario VARCHAR(14),
    nome_de_funcionario VARCHAR(100),
    Salario DECIMAL(10,2)
);
CREATE TABLE PRODUTO (
    ID_produto INT AUTO_INCREMENT PRIMARY KEY,
    validade DATE,
    quantidade INT,
    preco DECIMAL(10,2),
    desconto DECIMAL(10,2),
    codigo_do_produto VARCHAR(50),
    qr_code VARCHAR(255),
    itens VARCHAR(255)
);
CREATE TABLE ESTOQUE (
    ID_estoque INT AUTO_INCREMENT PRIMARY KEY,
    quantidade INT,
    fiscalizacao VARCHAR(100),
    localizacao VARCHAR(255)
);
CREATE TABLE PEDIDO (
    ID_pedido INT AUTO_INCREMENT PRIMARY KEY,
    data_e_hora VARCHAR(50),
    status VARCHAR(50),
    valor_total DECIMAL(10,2),
    tipo VARCHAR(50)
);
CREATE TABLE ITEM_PEDIDO (
    ID_item_pedido INT AUTO_INCREMENT PRIMARY KEY,
    quantidade INT,
    adicionais VARCHAR(255),
    id_do_produto INT,
    qrcode_do_produto VARCHAR(255)
);
CREATE TABLE PAGAMENTO (
    ID_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    recebimento VARCHAR(20),
    forma_pagamento VARCHAR(50)
);
CREATE TABLE DELIVERY (
    ID_delivery INT AUTO_INCREMENT PRIMARY KEY,
    endereco_de_entrega VARCHAR(255),
    entregador VARCHAR(100),
    status_do_pedido VARCHAR(50),
    data_saida VARCHAR(50)
);

SHOW TABLES;


INSERT INTO FORNECEDOR (email_fornecedor, telefone_fornecedor, metodo_de_transporte, valor, localizacao, cnpj_fornecedor) 
VALUES 
('contato@graosnobres.com', '19998887766', 'Caminhão', 1200.00, 'Fazenda Minas', '12.345.678/0001-90'),
('vendas@embalagensexpress.com', '19987654321', 'Van', 450.00, 'São Paulo - SP', '98.765.432/0001-10');
INSERT INTO CLIENTE (nome, telefone, email, CPF) 
VALUES 
('Ana Souza', '19971112233', 'ana.souza@email.com', '111.222.333-44'),
('Lucas Pereira', '19972223344', 'lucas.p@email.com', '555.666.777-88');
INSERT INTO POGRAMA_DE_FIDELIDADE (cpf, nome, beneficios) 
VALUES 
('111.222.333-44', 'Ana Souza', 'Desconto de 10% no café expresso'),
('555.666.777-88', 'Lucas Pereira', 'Ganha 1 pão de queijo a cada 5 compras');