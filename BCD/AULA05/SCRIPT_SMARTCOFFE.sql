-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE PEDIDO+DELIVERY (
ID_pedido Texto(1),
presencial varchar (20),
delivery varchar (20),
data_e_hora datetime,
status varchar (100),
valor_total int,
ID_delivery Texto(1),
endereco_de_entrega varchar (20),
taxa_entrega decimal (10, 2),
status_do_pedido varchar(100),
data_saida datetime,
ID_item_pedido Texto(1),
PRIMARY KEY(ID_pedido,ID_delivery)
)

CREATE TABLE PRODUTO  (
ID_produto Texto(1) PRIMARY KEY,
nome varchar (100),
preco_unitario decimal (10, 2),
categoria varchar (20),
descricao varchar (100),
ID_item_pedido Texto(1)
)

CREATE TABLE PAGAMENTO (
ID_pagamento Texto(1) PRIMARY KEY,
Pix varchar(15),
Debito varchar (15),
Credito varchar (15),
valor_pago Texto(1),
status_pagamento Texto(1),
data_hora_pagamento datetime,
ID_pedido Texto(1),
ID_delivery Texto(1),
CREATE TABLE FORNECEDOR (
    ID_fornecedor VARCHAR(10) PRIMARY KEY,
    email_fornecedor VARCHAR(100),
    telefone_fornecedor VARCHAR(16),
    valor DECIMAL(10,2)
);

CREATE TABLE ESTOQUE (
    ID_insumo VARCHAR(10) PRIMARY KEY,
    quantidade_atual INT,
    nome_insumo VARCHAR(100),
    unidade_medida VARCHAR(10),
    quantidade_minima INT
);

CREATE TABLE ITEM_PEDIDO (
    ID_item_pedido VARCHAR(10) PRIMARY KEY,
    quantidade INT,
    adicionais VARCHAR(100),
    id_do_produto VARCHAR(10)
);

CREATE TABLE PROGRAMA_DE_FIDELIDADE (
    ID_programa_de_fidelidade VARCHAR(10) PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(14),
    saldo_pontos INT,
    beneficios TEXT,
    data_ultima_atualizacao DATE
);

CREATE TABLE CLIENTE (
    ID_cliente VARCHAR(10) PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    CPF VARCHAR(14) NOT NULL,
    telefone VARCHAR(16),
    admissao DATETIME,
    ID_programa_de_fidelidade VARCHAR(10),
    FOREIGN KEY (ID_programa_de_fidelidade) REFERENCES PROGRAMA_DE_FIDELIDADE(ID_programa_de_fidelidade)
);

CREATE TABLE PRODUTO (
    ID_produto VARCHAR(10) PRIMARY KEY,
    nome VARCHAR(100),
    preco_unitario DECIMAL(10,2),
    categoria VARCHAR(50),
    descricao TEXT
);

CREATE TABLE ATRIBUI (
    ID_produto VARCHAR(10),
    ID_fornecedor VARCHAR(10),
    PRIMARY KEY (ID_produto, ID_fornecedor),
    FOREIGN KEY (ID_produto) REFERENCES PRODUTO(ID_produto),
    FOREIGN KEY (ID_fornecedor) REFERENCES FORNECEDOR(ID_fornecedor)
);

CREATE TABLE TEM (
    ID_produto VARCHAR(10),
    ID_insumo VARCHAR(10),
    PRIMARY KEY (ID_produto, ID_insumo),
    FOREIGN KEY (ID_produto) REFERENCES PRODUTO(ID_produto),
    FOREIGN KEY (ID_insumo) REFERENCES ESTOQUE(ID_insumo)
);