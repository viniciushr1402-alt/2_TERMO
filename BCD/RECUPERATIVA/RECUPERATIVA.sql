-- Active: 1788435082238@@127.0.0.1@3306@retrogame_recuperacao


-- FASE 1 - DDL: ESTRUTURA E RESTRIÇÕES (25 pontos)

-- 1. CRIAR E SELECIONAR BANCO DE DADOS
CREATE DATABASE IF NOT EXISTS retrogame_recuperacao;
USE retrogame_recuperacao;


DROP TABLE IF EXISTS LOCACAO;
DROP TABLE IF EXISTS JOGO;
DROP TABLE IF EXISTS CLIENTE;
DROP TABLE IF EXISTS PLATAFORMA;
DROP TABLE IF EXISTS CATEGORIA;

-- 2. TABELA CLIENTE
CREATE TABLE CLIENTE (
    id_cliente INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL,
    telefone VARCHAR(20) NULL,
    ativo BOOLEAN DEFAULT TRUE,
    CONSTRAINT PK_CLIENTE PRIMARY KEY (id_cliente),
    CONSTRAINT UQ_CLIENTE_EMAIL UNIQUE (email)
);

-- 3.0 - PLATAFORMA
CREATE TABLE PLATAFORMA (
    id_plataforma INT AUTO_INCREMENT,
    NOME VARCHAR(80) NOT NULL,
    CONSTRAINT PK_PLATAFORMA PRIMARY KEY (id_plataforma),
    CONSTRAINT UQ_PLATAFORMA_NOME UNIQUE (NOME)
);

-- 3.1 - CATEGORIA
CREATE TABLE CATEGORIA (
    id_categoria INT AUTO_INCREMENT,
    DESCRICAO VARCHAR(80) NOT NULL,
    CONSTRAINT PK_CATEGORIA PRIMARY KEY (id_categoria),
    CONSTRAINT UQ_CATEGORIA_DESCRICAO UNIQUE (DESCRICAO)
);

-- 4. TABELA JOGO
CREATE TABLE JOGO (
    id_jogo INT AUTO_INCREMENT,
    TITULO VARCHAR(150) NOT NULL,
    CODIGO VARCHAR(15) NOT NULL,
    ANO_LANCAMENTO INT NOT NULL,
    QUANTIDADE_DISPONIVEL INT DEFAULT 0,
    id_plataforma INT NOT NULL,
    id_categoria INT NOT NULL,
    CONSTRAINT PK_JOGO PRIMARY KEY (id_jogo),
    CONSTRAINT UQ_JOGO_CODIGO UNIQUE (CODIGO),
    CONSTRAINT CK_JOGO_QTD CHECK (QUANTIDADE_DISPONIVEL >= 0),
    CONSTRAINT FK_JOGO_PLATAFORMA FOREIGN KEY (id_plataforma) REFERENCES PLATAFORMA(id_plataforma) ON DELETE RESTRICT,
    CONSTRAINT FK_JOGO_CATEGORIA FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria) ON DELETE RESTRICT
);

-- 5. TABELA LOCACAO 
CREATE TABLE LOCACAO (
    id_locacao INT AUTO_INCREMENT,
    data_retirada DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE NULL,
    status_locacao VARCHAR(20) DEFAULT 'ABERTA',
    id_cliente INT NOT NULL,
    id_jogo INT NOT NULL,
    CONSTRAINT PK_LOCACAO PRIMARY KEY (id_locacao),
    CONSTRAINT CK_STATUS_LOCACAO CHECK (status_locacao IN ('ABERTA', 'DEVOLVIDA', 'ATRASADA')),
    CONSTRAINT FK_LOCACAO_CLIENTE FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente) ON DELETE RESTRICT,
    CONSTRAINT FK_LOCACAO_JOGO FOREIGN KEY (id_jogo) REFERENCES JOGO(id_jogo) ON DELETE RESTRICT
);


-- 6. ALTER TABLE
ALTER TABLE JOGO ADD COLUMN DESENVOLVEDORA VARCHAR(100) NULL;

-- FASE 2 - DML: MANIPULAÇÃO DE DADOS (25 pontos)

-- 7. INSERIR CLIENTE
INSERT INTO CLIENTE (nome, email, telefone) VALUES 
('Samuel DEV', 'samuel.dev@email.com', '99999-1111'),
('Bruno DEV', 'bruno.dev@email.com', NULL),
('Celso DEV', 'celso.dev@email.com', '99999-2222'),
('Vini DEV', 'vini.dev@email.com', '91995-2267');


-- 8. INSERIR PLATAFORMAS, CATEGORIAS E JOGOS
INSERT INTO PLATAFORMA (nome) VALUES ('Nintendo'), ('XBOX'), ('PlayStation 5');
INSERT INTO CATEGORIA (descricao) VALUES ('Escolha'), ('RPG'), ('Terror');

INSERT INTO JOGO (titulo, codigo, ano_lancamento, quantidade_disponivel, id_plataforma, id_categoria, desenvolvedora)
VALUES 
('Sillent Hill 2', '45378', 2022, 5, 1, 1, 'KONAMI'),
('Detroid: Become Human', '73292', 2018, 3, 1, 1, 'Quantic Dream'),
('Expedition 33', '893722', 2025, 4, 2, 1, 'Sandfall Interactive'),
('Overwatch', '129522', 2016, 2, 1, 2, 'Blizard'),
('Outlast 2', '39382', 2017, 6, 1, 3, 'Red Barrels'),
('Silksong', '391022', 2025, 1, 3, 2, 'Team Cherry'),
('Super Mario World', '438S001', 1990, 5, 1, 1, 'Nintendo'),
('Donkey Kong Country', '342S002', 1994, 3, 1, 1, 'Rare'),
('Sonic the Hedgehog', '234001', 1991, 4, 2, 1, 'SEGA'),
('Chrono Trigger', '332003', 1995, 2, 1, 2, 'Square'),
('Street Fighter II', '2312004', 1992, 6, 1, 3, 'Capcom'),
('Final Fantasy VII', '233001', 1997, 1, 3, 2, 'Square');

SELECT * FROM JOGO;
-- 9. INSERIR LOCAÇÕES
INSERT INTO LOCACAO (data_prevista, status_locacao, id_cliente, id_jogo) VALUES 
('2026-11-20', 'ABERTA', 1, 1),
('2026-11-22', 'ABERTA', 2, 3),
('2026-11-25', 'ABERTA', 4, 4);

SELECT * FROM LOCACAO;

-- 10. SELECT + UPDATE
SELECT * FROM CLIENTE WHERE id_cliente = 3;
UPDATE CLIENTE SET telefone = '19911223344' WHERE id_cliente = 3;

SELECT * FROM CLIENTE;

-- 11. UPDATE EM LOTE
INSERT INTO JOGO (titulo, codigo, ano_lancamento, quantidade_disponivel, id_plataforma, id_categoria, desenvolvedora) 
VALUES ('Mega Man ', '589403', 1987, 2, 3, 1, 'Capcom');

UPDATE JOGO SET quantidade_disponivel = quantidade_disponivel + 2 WHERE ano_lancamento >= 2000;

-- 12. DELETE E PROTEÇÃO DO HISTORICO
SELECT titulo, autor, quantidade_disponivel 
FROM LIVRO;

-- FASE 3 - DQL: CONSULTAS E ANÁLISE (30 pontos)

-- 13. SELECT BASICO
SELECT titulo, ano_lancamento, quantidade_disponivel FROM JOGO;

-- 14. WHERE + ORDER BY
SELECT * FROM JOGO WHERE quantidade_disponivel > 2 ORDER BY quantidade_disponivel DESC;

-- 15. LIKE
SELECT * FROM JOGO WHERE titulo LIKE '%Super%';

-- 16. BETWEEN
SELECT * FROM JOGO WHERE ano_lancamento BETWEEN 1990 AND 2005;

-- 17. FUNCOES AGREGADAS
SELECT 
    COUNT(*) AS total_jogos,
    SUM(quantidade_disponivel) AS estoque_total,
    AVG(quantidade_disponivel) AS media_estoque,
    MIN(quantidade_disponivel) AS menor_estoque,
    MAX(quantidade_disponivel) AS maior_estoque
FROM JOGO;

-- 18. INNER JOIN
SELECT l.id_locacao, c.nome AS cliente, j.titulo AS jogo, l.data_retirada, l.status_locacao
FROM LOCACAO l
INNER JOIN CLIENTE c ON l.id_cliente = c.id_cliente
INNER JOIN JOGO j ON l.id_jogo = j.id_jogo;

-- 19. JOIN + WHERE

SELECT l.id_locacao, c.nome AS cliente, j.titulo AS jogo, l.status_locacao
FROM LOCACAO l
INNER JOIN CLIENTE c ON l.id_cliente = c.id_cliente
INNER JOIN JOGO j ON l.id_jogo = j.id_jogo
WHERE l.status_locacao = 'ABERTA';

-- 20. GROUP BY 
SELECT c.nome, COUNT(l.id_locacao) AS total_locacoes
FROM CLIENTE c
INNER JOIN LOCACAO l ON c.id_cliente = l.id_cliente
GROUP BY c.id_cliente, c.nome
ORDER BY total_locacoes DESC;

-- 21. LEFT JOIN
SELECT c.nome, COUNT(l.id_locacao) AS total_locacoes
FROM CLIENTE c
LEFT JOIN LOCACAO l ON c.id_cliente = l.id_cliente
GROUP BY c.id_cliente, c.nome;

-- FASE 4 - TCL: TRANSAÇÕES E INTEGRIDADE (20 pontos)

-- 22. TRANSACAO DE LOCACAO
START TRANSACTION;
SELECT quantidade_disponivel FROM JOGO WHERE id_jogo = 2 FOR UPDATE;
INSERT INTO LOCACAO (data_prevista, status_locacao, id_cliente, id_jogo) 
VALUES ('2026-12-01', 'ABERTA', 3, 2);
UPDATE JOGO SET quantidade_disponivel = quantidade_disponivel - 1 WHERE id_jogo = 2 AND quantidade_disponivel > 0;
COMMIT;

-- 23. ROLLBACK 
START TRANSACTION;
SELECT quantidade_disponivel FROM JOGO WHERE id_jogo = 2;
UPDATE JOGO SET quantidade_disponivel = 99 WHERE id_jogo = 2;
SELECT quantidade_disponivel FROM JOGO WHERE id_jogo = 2;
ROLLBACK;
SELECT quantidade_disponivel FROM JOGO WHERE id_jogo = 2;


-- 24. SAVEPOINT
 START TRANSACTION;
UPDATE JOGO SET quantidade_disponivel = 10 WHERE id_jogo = 1;
SAVEPOINT meu_savepoint;
UPDATE JOGO SET quantidade_disponivel = 20 WHERE id_jogo = 2;
ROLLBACK TO meu_savepoint;
COMMIT;

-- 25. TRANSACAO DE DEVOLUCAO
START TRANSACTION
UPDATE LOCACAO SET status_locacao = 'DEVOLVIDA', data_devolucao = CURRENT_DATE() WHERE id_locacao = 1 AND status_locacao = 'ABERTA';
UPDATE JOGO SET quantidade_disponivel = quantidade_disponivel + 1 WHERE id_jogo = (SELECT id_jogo FROM LOCACAO WHERE id_locacao = 1);
COMMIT;

