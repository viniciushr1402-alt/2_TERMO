-- TCL - TRANSAÇÕES E INTEGRIDADE
-- SEM TRANSAÇÃO: PARTE DO PROCESSO IRÁ PERMANECER GRAVADO
-- COM TRANSAÇÃO: PODEMOS CONFIRMAR OU DESFAZER O PROCESSO INTEIRO

-- ESTRUTURA DE TRANSAÇÃO
BEGIN TRANSACTION;
-- COMANDOS SQL

COMMIT; -- CONFIRMA A TRANSAÇÃO
-- OU
ROLLBACK; -- DESFAZ A TRANSAÇÃO

INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES ('C Ronaldo', 'cronaldo@email.com', '1993452703703', 'Funchal', TRUE);

SELECT nome FROM cliente;

-- EX 1: COMMIT
-- CONFIRA AS ALTERAÇÕES DENTRO DA TRANSAÇÃO

START TRANSACTION;
UPDATE produto
SET preco = 8.50
WHERE id_produto = 1;
COMMIT;

-- EX 2: ROLLBACK
-- DESFAZ AS ALTERAÇÕES NAO CONFIRMADAS
START TRANSACTION;
UPDATE produto
SET preco = 50000.00
WHERE id_produto = 1;

SELECT * FROM produto WHERE id_produto = 1;
ROLLBACK;

-- EX 3: SAVEPOINT
-- CRIAR UM PONTO DENTRO DE UMA TRANSAÇÃO

START TRANSACTION;
UPDATE produto
SET preco = PRECO * 1.50
WHERE id_produto = 1;

SAVEPOINT reajuste_cafes;

UPDATE produto
SET preco = preco * 2.00
WHERE id_categoria = 4

ROLLBACK TO SAVEPOINT reajuste_cafes;

COMMIT;

--EX4: RELEASE SAVEPOINT
-- REMOVE O SAV POINT DA TRANSAÇÃO

RELEASE SAVEPOINT reajuste_cafes;
COMMIT;

-- EX 5: AUTOCOMMIT
SELECT @@autocommit;
-- ATIVO POR PADRÃO NO MYSQL

START TRANSACTION;
-- DMLS RELACIONADAS
COMMIT;



-- EX 6: TRANSAÇÕES NÃO SUBSTITUI CONSTRAINT

-- CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria) ON DELETE CASCADE ON UPDATE CASCADE;

-- CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente); ON DELETE CASCADE ON UPDATE CASCADE;


-- CREATE TABLE cliente (
--     id_cliente INT PRIMARY KEY,
--     nome VARCHAR(60),
--     telefone VARCHAR(15),
--     cidade VARCHAR(60),
--     ativo BOOLEAN DEFAULT TRUE,
--     CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente) 
--     ON DELETE CASCADE 
--     ON UPDATE CASCADE
-- );

-- SEMPRE CHECAR A QUANTIDADE E SE ABAIXO DE 0 OU IGUAL QUE 0 SINALIZAR

CONSTRAINT ck_estoque_quantidade CHECK (quantidade >= 0);

-- EXEMPLO COM UTILIZAÇÃO

CREATE TABLE estoque (
    id_estoque INT AUTO_INCREMENT,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 0,
    -- restriçoes
    -- chave primaria
    CONSTRAINT pk_estoque PRIMARY KEY (id_estoque),
    -- chave unique ou unica
    CONSTRAINT uq_estoque_produto UNIQUE (id_produto),
    -- checar ou validar uma operação de quantidade
    CONSTRAINT ck_estoque_quantidade CHECK (quantidade >= 0),
    -- Chave estrangeira
    CONSTRAINT fk_estoque_produto FOREIGN KEY (id_produto)
    REFERENCES produto (id_produto) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO estoque (id_produto, quantidade) VALUES (1,50),(2,40),(3,30);

SELECT * FROM estoque;

-- EX 7; FLUXO SEGURO PARA UPDATE E DELETE0
-- exclusaõ fissica
DELETE FROM produto
WHERE id_produto = 11;

-- EXCLUSÃO LOGICA

UPDATE produto
SET ativo = FALSE
WHERE id_produto = 10;

SELECT * FROM produto WHERE id_produto = 3;

START TRANSACTION;

UPDATE produto
SET preco = 15.50
WHERE id_produto = 3;

SELECT * FROM produto WHERE id_produto = 3;

COMMIT;

START TRANSACTION;

INSERT INTO pedido (data_pedido, status_pedido, valor_total, id_cliente) 
VALUES (NOW(), 'ABERTO', 0.00, 1); 

SET @pedido = LAST_INSERT_ID();

INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES (@pedido, 1, 2, 7.50), (@pedido, 1, 2, 8.50);

INSERT INTO pagamento (id_pedido, valor, id_forma_pagamento) 
VALUES (@pedido, 23.00, 2);

COMMIT;

SELECT * FROM item_pedido;


-- EX 9: PEDIDO COMPLETO COM TRANSAÇÃO E ROLLBACK
START TRANSACTION;

INSERT INTO pedido (data_pedido, status, valor_total, id_cliente)
VALUES (NOW(), 'ABERTO', 0.00, 23);

SET @pedido = LAST_INSERT_ID();

-- PRODUTO INEXISTENTE
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES (@pedido, 1999, 9.00), (@pedido, 1999, 11.00);

ROLLBACK;