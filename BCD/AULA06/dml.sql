-- Active: 1788435082238@@127.0.0.1@3306@smartcoffe_dml_vini

DROP DATABASE IF EXISTS SMARTCOFFE_DML_VINI;

CREATE DATABASE IF NOT EXISTS SMARTCOFFE_DML_VINI;

USE SMARTCOFFE_DML_VINI;

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE,
    telefone VARCHAR(15),
    cidade VARCHAR(60) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    id_categoria INT NOT NULL,
    CONSTRAINT fk_profutos_categoria FOREIGN KEY (id_categoria)
    REFERENCES categoria (id_categoria)
);

CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    data_pedido DATETIME NOT NULL,
    status_pedido ENUM('ABERTO', 'PREPARANDO', 'FINALIZADO', 'CANCELADO') NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    id_cliente INT NOT NULL,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) 
    REFERENCES cliente (id_cliente)
);

CREATE TABLE item_pedido (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    observacao VARCHAR(150),
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido) 
    REFERENCES pedido (id_pedido),
    CONSTRAINT fk_item_produto FOREIGN KEY (id_produto) 
    REFERENCES produto (id_produto)
);

CREATE TABLE forma_pagamento (
    id_forma_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE pagamento (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME,
    CONSTRAINT fk_pagamento_pedido FOREIGN KEY (id_pedido)
    REFERENCES pedido (id_pedido),
    CONSTRAINT fk_pagamento_forma_pagamento FOREIGN KEY (id_forma_pagamento)
    REFERENCES forma_pagamento (id_forma_pagamento)
);

INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES
('Luis Felipe', 'luis@email.com', '1999999901', 'Limeira', TRUE),
('Maria Eduarda', 'maria@email.com', '1999999902', 'Limeira', TRUE),
('Mateus Silva', 'mateus@email.com', '1999999903', 'Limeira', TRUE),
('Matheus Oricolli', 'matheusc@email.com', '1999999904', 'Limeira', TRUE),
('Nicolas Filipe', 'nicolas@email.com', '1999999906', 'Limeira', TRUE),
('Otavio Correia', 'otavio@email.com', '1999999905', 'Conchal', TRUE),
('Pedro Miranda', 'pedro@email.com', '1999999907', 'Limeira', TRUE),
('Rafael Viera', 'rafael@email.com', '1999999908', 'Limeira', TRUE),
('Rebecca', 'rebecca@email.com', NULL, 'Limeira', TRUE),
('Rennan Campos', 'rennan@email.com', '1999999909', 'Americana', TRUE),
('Samira Emily Dalosto', 'samira@email.com', NULL, 'Ourinhos', FALSE),
('Sophia Carolina', 'sophia@email.com', '1999999911', 'Taubaté', TRUE),
('Vanessa Queiroz', 'vanessa@email.com', '1999999912', 'Limeira', TRUE),
('Vinicius Henrique', 'vinicius@email.com', '1999999913', 'Limeira', TRUE),
('Vinicius Oliveira', 'viniciuso@email.com', '1999999914', 'Chicago', TRUE);

INSERT INTO categoria (nome) VALUES 
('Café'),
('Bebidas Quentes'),
('Bebidas Geladas'),
('Doces'),
('Salgados'),
('Combo');

INSERT INTO produto (nome, preco, ativo, id_categoria) VALUES
('Café Expresso', 6.00, TRUE, 1),
('Café Americano', 7.00, TRUE, 1),
('Café Coado Especial', 8.50, TRUE, 1),
('Ristretto', 6.50, TRUE, 1),
('Café Duplo', 9.00, TRUE, 1);

INSERT INTO produto (nome, preco, ativo, id_categoria) VALUES
('Cappuccino Tradicional', 12.00, TRUE, 2),
('Mocaccino', 14.00, TRUE, 2),
('Chá Latte', 11.00, TRUE, 2),
('Chocolate Quente Cremoso', 13.50, TRUE, 2),
('Macchiato', 10.00, TRUE, 2);

INSERT INTO produto (nome, preco, ativo, id_categoria) VALUES
('Iced Coffee', 12.50, TRUE, 3),
('Frappuccino de Caramel', 18.00, TRUE, 3),
('Soda Italiana de Maçã Verde', 14.00, TRUE, 3),
('Smoothie de Morango', 16.50, TRUE, 3),
('Chá Gelado de Limão', 9.00, TRUE, 3);

INSERT INTO produto (nome, preco, ativo, id_categoria) VALUES
('Fatia de Torta de Holandesa', 15.00, TRUE, 4),
('Brownie com Sorvete', 17.50, TRUE, 4),
('Croissant de Nutella', 14.00, TRUE, 4),
('Cheesecake de Frutas Vermelhas', 16.00, TRUE, 4),
('Cookie de Chocolate', 8.00, TRUE, 4);

INSERT INTO produto (nome, preco, ativo, id_categoria) VALUES
('Pão de Queijo Recheado', 7.50, TRUE, 5),
('Coxinha de Frango com Catupiry', 9.00, TRUE, 5),
('Croissant de Presunto e Queijo', 12.00, TRUE, 5),
('Empada de Palmito', 8.50, TRUE, 5),
('Quiche de Alho Poró', 13.00, TRUE, 5);

INSERT INTO pedido (data_pedido, status_pedido, valor_total, id_cliente) VALUES
('2024-03-20 08:30:00', 'FINALIZADO', 0.00, 1),
('2024-03-20 09:15:00', 'FINALIZADO', 0.00, 2),
('2024-03-20 10:00:00', 'FINALIZADO', 0.00, 3),
('2024-03-20 11:45:00', 'FINALIZADO', 0.00, 4),
('2024-03-20 14:20:00', 'FINALIZADO', 0.00, 5),
('2024-03-21 08:00:00', 'FINALIZADO', 0.00, 6),
('2024-03-21 09:30:00', 'PREPARANDO', 0.00, 7),
('2024-03-21 10:10:00', 'ABERTO', 0.00, 8),
('2024-03-21 11:00:00', 'FINALIZADO', 0.00, 10),
('2024-03-21 11:30:00', 'CANCELADO', 0.00, 12);

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, observacao) VALUES
(1, 1, 2, 6.00, 'Sem açúcar'),
(1, 16, 1, 7.50, NULL),
(2, 6, 1, 12.00, 'Leite de aveia'),
(2, 18, 1, 14.00, NULL),
(3, 11, 1, 12.50, 'Pouco gelo'),
(3, 20, 1, 8.00, NULL),
(4, 25, 1, 12.00, NULL),
(5, 9, 2, 13.50, 'Bem quente'),
(5, 17, 1, 17.50, NULL),
(6, 22, 1, 27.00, NULL),
(7, 3, 1, 8.50, NULL),
(7, 19, 1, 12.00, 'Aquecer o croissant'),
(8, 12, 1, 18.00, 'Bastante calda de chantilly'),
(9, 2, 1, 7.00, NULL),
(9, 16, 2, 7.50, NULL),
(10, 24, 1, 24.00, NULL);

INSERT INTO forma_pagamento (descricao) VALUES
('Dinheiro'),
('Cartão de Crédito'),
('Cartão de Débito'),
('PIX');

INSERT INTO pagamento (id_pedido, id_forma_pagamento, valor, data_pagamento) VALUES
(1, 4, 19.50, '2026-03-20 08:32:00'),
(2, 2, 26.00, '2026-03-20 09:17:00'), 
(3, 1, 20.50, '2026-03-20 10:02:00'), 
(4, 3, 12.00, '2026-03-20 11:46:00'), 
(5, 4, 44.50, '2026-03-20 14:22:00'), 
(6, 2, 27.00, '2026-03-21 08:02:00'); 

INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES 
('Carlos Silva', 'carlos@email.com', '19988887777', 'Limeira', TRUE),
('Ana Souza', 'ana@email.com', '19977776666', 'Campinas', TRUE);

SET @id_carlos = (SELECT id_cliente FROM cliente WHERE email = 'carlos@email.com');

INSERT INTO categoria (nome) VALUES 
('Especiais da Casa');

SET @id_cat_especiais = LAST_INSERT_ID();

INSERT INTO produto (nome, preco, ativo, id_categoria) VALUES 
('Café Nutella Especial', 15.00, TRUE, @id_cat_especiais),
('Cappuccino Doce de Leite', 16.50, TRUE, @id_cat_especiais),
('Torta de Maçã da Casa', 18.00, TRUE, @id_cat_especiais);

SET @id_prod1 = (SELECT id_produto FROM produto WHERE nome = 'Café Nutella Especial');
SET @id_prod2 = (SELECT id_produto FROM produto WHERE nome = 'Cappuccino Doce de Leite');

INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES 
('Fernanda Lima', 'fernanda@email.com', NULL, 'Limeira', TRUE);

INSERT INTO pedido (data_pedido, status_pedido, valor_total, id_cliente) VALUES 
(NOW(), 'ABERTO', 0.00, @id_carlos);

SET @id_novo_pedido = LAST_INSERT_ID();

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, observacao) VALUES 
(@id_novo_pedido, @id_prod1, 1, 15.00, 'Sem açúcar'),
(@id_novo_pedido, @id_prod2, 2, 16.50, 'Extra quente');

UPDATE cliente 
SET telefone = '19988889999' 
WHERE email = 'carlos@email.com';

UPDATE cliente 
SET cidade = 'Piracicaba', telefone = '19977770000' 
WHERE email = 'ana@email.com';

UPDATE produto 
SET preco = preco * 1.08 
WHERE id_categoria = @id_cat_especiais;

UPDATE pedido 
SET status_pedido = 'PREPARANDO' 
WHERE id_pedido = @id_novo_pedido;

UPDATE pedido 
SET valor_total = (
    SELECT SUM(quantidade * preco_unitario) 
    FROM item_pedido 
    WHERE id_pedido = @id_novo_pedido
) 
WHERE id_pedido = @id_novo_pedido;

UPDATE produto 
SET ativo = FALSE 
WHERE id_produto = @id_prod1;
