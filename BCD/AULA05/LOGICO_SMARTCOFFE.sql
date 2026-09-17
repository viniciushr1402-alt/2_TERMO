CREATE TABLE ITEM_PEDIDO (
    ID_item_pedido INT AUTO_INCREMENT PRIMARY KEY,
    quantidade INT,
    adcionais VARCHAR(100),
    id_do_produto INT
);

CREATE TABLE PRODUTO (
    ID_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco_unitario DECIMAL(10, 2),
    categoria VARCHAR(20),
    ID_item_pedido INT,
    descricao VARCHAR(100),
    FOREIGN KEY (ID_item_pedido) REFERENCES ITEM_PEDIDO(ID_item_pedido)
);

CREATE TABLE PEDIDO_DELIVERY (
    ID_pedido INT AUTO_INCREMENT,
    presencial VARCHAR(20),
    delivery VARCHAR(20),
    data_e_hora DATETIME,
    status VARCHAR(100),
    valor_total DECIMAL(10, 2),
    ID_delivery INT,
    endereco_de_entrega VARCHAR(20),
    taxa_entrega DECIMAL(10, 2),
    status_do_pedido VARCHAR(100),
    data_saida DATETIME,
    ID_item_pedido INT,
    PRIMARY KEY (ID_pedido, ID_delivery),
    FOREIGN KEY (ID_item_pedido) REFERENCES ITEM_PEDIDO(ID_item_pedido)
);

CREATE TABLE PAGAMENTO (
    ID_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    Pix VARCHAR(15),
    Debito VARCHAR(15),
    Credito VARCHAR(15),
    valor_pago DECIMAL(10, 2),
    status_pagamento VARCHAR(50),
    data_hora_pagamento DATETIME,
    ID_delivery INT,
    ID_pedido INT,
    FOREIGN KEY (ID_pedido, ID_delivery) REFERENCES PEDIDO_DELIVERY(ID_pedido, ID_delivery)
);

CREATE TABLE FUNCIONARIO (
    ID_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    cargo_funcionario VARCHAR(100),
    nome_de_funcionario VARCHAR(100),
    cpf_do_funcionario VARCHAR(14) NOT NULL,
    Salario INT,
    data_admissao DATETIME,
    ID_pedido INT,
    ID_delivery INT,
    FOREIGN KEY (ID_pedido, ID_delivery) REFERENCES PEDIDO_DELIVERY(ID_pedido, ID_delivery)
);

CREATE TABLE POGRAMA_DE_FIDELIDADE (
    ID_programa_de_fidelidade INT AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(14) NOT NULL,
    saldo_pontos INT,
    data_ultima_atualizacao DATETIME,
    beneficios VARCHAR(100),
    nome VARCHAR(100)
);

CREATE TABLE FORNECEDOR (
    ID_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    email_fornecedor VARCHAR(100),
    telefone_fornecedor VARCHAR(16),
    valor INT
);

CREATE TABLE ESTOQUE (
    ID_insumo INT AUTO_INCREMENT PRIMARY KEY,
    quantidade_atual INT,
    nome_insumo VARCHAR(100),
    unidade_medida VARCHAR(10),
    quantidade_minima INT
);

CREATE TABLE CLIENTE (
    telefone VARCHAR(16),
    nome VARCHAR(100),
    email VARCHAR(100),
    CPF VARCHAR(14) NOT NULL,
    ID_cliente INT AUTO_INCREMENT PRIMARY KEY,
    admissao DATETIME,
    ID_pedido INT,
    ID_delivery INT,
    ID_programa_de_fidelidade INT,
    FOREIGN KEY (ID_pedido, ID_delivery) REFERENCES PEDIDO_DELIVERY(ID_pedido, ID_delivery),
    FOREIGN KEY (ID_programa_de_fidelidade) REFERENCES POGRAMA_DE_FIDELIDADE(ID_programa_de_fidelidade)
);

CREATE TABLE ATRIBUI (
    ID_produto INT,
    ID_fornecedor INT,
    PRIMARY KEY (ID_produto, ID_fornecedor),
    FOREIGN KEY (ID_produto) REFERENCES PRODUTO(ID_produto),
    FOREIGN KEY (ID_fornecedor) REFERENCES FORNECEDOR(ID_fornecedor)
);

CREATE TABLE TEM (
    ID_produto INT,
    ID_insumo INT,
    PRIMARY KEY (ID_produto, ID_insumo),
    FOREIGN KEY (ID_produto) REFERENCES PRODUTO(ID_produto),
    FOREIGN KEY (ID_insumo) REFERENCES ESTOQUE(ID_insumo)
);