-- Active: 1788435082238@@127.0.0.1@3306@smartcoffe_dml_vini
-- ============================================================
-- AULA 09 - ATIVIDADE PRÁTICA DE DQL
-- Nome: _______________________________________________
-- Turma: ______________________ Data: _________________
-- Base: smartcoffee_dql
-- ============================================================
USE smartcoffe_dml_vini;

-- PARTE A - AQUECIMENTO

-- 1. Liste todos os clientes cadastrados.


-- 2. Exiba apenas nome, cidade e e-mail dos clientes.


-- 3. Liste os nomes das cidades sem repetir valores.


-- 4. Liste todos os produtos em ordem crescente de preço.


-- 5. Mostre apenas os 5 produtos mais caros.


-- PARTE B - FILTROS

-- 6. Liste os produtos com preço entre R$ 8,00 e R$ 15,00.


-- 7. Liste os clientes das cidades Limeira ou Americana.


-- 8. Localize os produtos cujo nome contém a palavra “Café”.


-- 9. Liste os clientes que não informaram telefone.


-- 10. Mostre os pedidos FINALIZADOS com valor acima de R$ 20,00,
--     do maior para o menor valor.


-- PARTE C - CÁLCULOS E AGRUPAMENTOS

-- 11. Informe quantos produtos estão cadastrados.


-- 12. Mostre menor preço, maior preço e preço médio dos produtos.


-- 13. Informe quantos clientes existem em cada cidade.


-- 14. Mostre somente as cidades que possuem dois ou mais clientes.


-- 15. Calcule o faturamento total considerando apenas pedidos FINALIZADOS.



------------------------- EX1 --------------------------------------
SELECT * FROM cliente;
------------------------- EX2 ----------------------------------------

SELECT nome, cidade, email FROM cliente;

------------------------ EX3 ------------------------------------------

SELECT DISTINCT cidade FROM cliente;

------------------------- EX4 -----------------------------------

SELECT * FROM produto ORDER BY preco ASC;

----------------------------- EX5 ---------------------------------

SELECT * FROM produto ORDER BY preco DESC LIMIT 5;

------------------------- EX6 ---------------------------------------

SELECT * FROM produto WHERE preco BETWEEN 8.00 AND 15.00;

----------------------- EX7 ------------------------------------------

SELECT * FROM cliente WHERE cidade IN ('Limeira', 'Americana');

------------------------------- EX8 ------------------------------------------

SELECT * FROM produto WHERE nome LIKE '%Café%';

---------------------------------- EX9 ------------------------------------

SELECT nome, telefone
FROM cliente 
WHERE telefone IS NULL;

--------------------------------- EX10 ----------------------------

SELECT * FROM pedido WHERE status_pedido = 'preparando' AND valor_total > 20.00 ORDER BY valor_total DESC;

------------------------------- EX11 --------------------------------------------------------------------
SELECT COUNT(*) AS total_produtos FROM produto;

------------------------------ EX12 -----------------------------------------------

SELECT MIN(preco) AS menor_preco, MAX(preco) AS maior_preco, AVG(preco) AS preco_medio FROM produto;
----------------------------------- EX13 --------------------------------------------------
SELECT cidade, COUNT(*) AS total_cliente FROM cliente GROUP BY cidade;
------------------------------------- EX14 -------------------------------------------------
SELECT cidade, total_clientes
FROM (SELECT cidade, COUNT(*) AS total_clientes
    FROM cliente
    GROUP BY cidade
) AS resumo
WHERE total_clientes >= 2;

--------------------------------------------------- EX15 ---------------------------------------------
SELECT SUM(valor_total) AS faturamento_total FROM pedido WHERE status_pedido = 'FINALIZADO';



-- =============================================================================
-- ESCOLA SENAI "LUIZ VARGA" - BANCO DE DADOS
-- ATIVIDADE SOMATIVA: BIBLIOTECA
-- ALUNO: [Seu Nome]
-- =============================================================================

-- =============================================================================
-- FASE 1 — DDL: CRIAÇÃO E ESTRUTURA (25 pontos)
-- =============================================================================

-- 1. Criação do banco — 3 pts
CREATE DATABASE IF NOT EXISTS biblioteca_som2;
USE biblioteca_som2;

-- 2. Tabela USUARIO — 6 pts
-- Respeita RN01 (NOT NULL), RN02 (UNIQUE) e RN03 (DEFAULT TRUE)
CREATE TABLE IF NOT EXISTS USUARIO (
    id_usuario INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL,
    telefone VARCHAR(20) NULL,
    ativo BOOLEAN DEFAULT TRUE,
    CONSTRAINT PK_USUARIO PRIMARY KEY (id_usuario),
    CONSTRAINT UN_USUARIO_EMAIL UNIQUE (email)
);

-- 3. Tabela LIVRO — 6 pts
-- Respeita RN04 (NOT NULL), RN05 (UNIQUE) e RN06 (CHECK quantidade_disponivel >= 0)
CREATE TABLE IF NOT EXISTS LIVRO (
    id_livro INT AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(120) NOT NULL,
    isbn CHAR(13) NOT NULL,
    ano_publicacao INT NULL,
    quantidade_disponivel INT DEFAULT 0,
    CONSTRAINT PK_LIVRO PRIMARY KEY (id_livro),
    CONSTRAINT UN_LIVRO_ISBN UNIQUE (isbn),
    CONSTRAINT CK_LIVRO_QUANTIDADE CHECK (quantidade_disponivel >= 0)
);

-- 4. Tabela EMPRESTIMO — 7 pts
-- Respeita RN07 a RN12. As chaves estrangeiras usam ON DELETE RESTRICT 
-- para garantir a integridade referencial exigida pelas regras RN16 e RN17.
CREATE TABLE IF NOT EXISTS EMPRESTIMO (
    id_emprestimo INT AUTO_INCREMENT,
    data_emprestimo DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_prevista DATE NOT NULL,
    data_devolucao DATE NULL,
    status_emprestimo VARCHAR(20) DEFAULT 'ABERTO',
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    CONSTRAINT PK_EMPRESTIMO PRIMARY KEY (id_emprestimo),
    CONSTRAINT CK_STATUS_EMPRESTIMO CHECK (status_emprestimo IN ('ABERTO', 'DEVOLVIDO', 'ATRASADO')),
    CONSTRAINT FK_EMPRESTIMO_USUARIO FOREIGN KEY (id_usuario) REFERENCES USUARIO (id_usuario) ON DELETE RESTRICT,
    CONSTRAINT FK_EMPRESTIMO_LIVRO FOREIGN KEY (id_livro) REFERENCES LIVRO (id_livro) ON DELETE RESTRICT
);

-- 5. ALTER TABLE — 3 pts
ALTER TABLE LIVRO ADD COLUMN editora VARCHAR(100) NULL;


-- =============================================================================
-- FASE 2 — DML: MANIPULAÇÃO DE DADOS (25 pontos)
-- =============================================================================

-- 6. INSERT de usuários — 4 pts
INSERT INTO USUARIO (nome, email, telefone) VALUES 
('Ana Silva', 'ana.silva@email.com', '(19) 99999-1111'),
('Bruno Costa', 'bruno.costa@email.com', NULL), -- Usuário com telefone NULL
('Carlos Souza', 'carlos.souza@email.com', '(19) 99999-2222'),
('Daniela Lima', 'daniela.lima@email.com', '(19) 99999-3333');

-- 7. INSERT de livros — 5 pts
INSERT INTO LIVRO (titulo, autor, isbn, ano_publicacao, quantidade_disponivel, editora) VALUES
('O Domínio do SQL', 'Alan Beaulieu', '9788575227091', 2021, 5, 'Novatec'),
('Bancos de Dados Relacionais', 'Carlos A. Heuser', '9788577805822', 2019, 3, 'Sagra'),
('Clean Code', 'Robert C. Martin', '9788576082675', 2009, 2, 'Alta Books'),
('Introdução ao HTML5 e CSS3', 'Maurício Samy', '9788575223369', 2015, 4, 'Novatec'),
('Algoritmos Estruturados', 'Harry Farrer', '9788521611837', 2018, 1, 'LTC'),
('Design Patterns', 'Erich Gamma', '9788573076103', 2022, 6, 'Bookman');

-- 8. INSERT de empréstimos — 4 pts
INSERT INTO EMPRESTIMO (data_prevista, id_usuario, id_livro) VALUES
('2026-11-05', 1, 1),
('2026-11-05', 2, 2),
('2026-11-10', 3, 3);

-- 9. UPDATE — 4 pts
-- Localizando o usuário 'Bruno Costa' via SELECT mental e alterando seu telefone
UPDATE USUARIO 
SET telefone = '(19) 98888-4444' 
WHERE email = 'bruno.costa@email.com';

-- 10. Atualização em lote — 4 pts
-- Acrescenta 2 exemplares a todos os livros com ano_publicacao >= 2020
UPDATE LIVRO 
SET quantidade_disponivel = quantidade_disponivel + 2 
WHERE ano_publicacao >= 2020;

-- 11. DELETE e integridade — 4 pts
-- Criando usuário temporário sem empréstimos
INSERT INTO USUARIO (nome, email, telefone) VALUES ('User Teste', 'teste@email.com', NULL);
-- Excluindo o usuário sem empréstimo (Funciona perfeitamente)
DELETE FROM USUARIO WHERE email = 'teste@email.com';

-- Tentativa de exclusão de usuário com histórico (Gera erro de restrição de FK)
-- DELETE FROM USUARIO WHERE id_usuario = 1;
-- [EXPLICAÇÃO DO RESULTADO]: O comando acima falha e resulta no erro "Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails...". 
-- Isso ocorre porque definimos a FK com a regra implícita ON DELETE RESTRICT (ou NO ACTION). O sistema impede a exclusão do usuário para não deixar registros órfãos na tabela EMPRESTIMO, mantendo a integridade referencial (RN16).


-- =============================================================================
-- FASE 3 — DQL: CONSULTAS E ANÁLISE (30 pontos)
-- =============================================================================

-- 12. SELECT básico — 2 pts
SELECT titulo, autor, quantidade_disponivel 
FROM LIVRO;

-- 13. WHERE + ORDER BY — 3 pts
SELECT id_livro, titulo, quantidade_disponivel 
FROM LIVRO 
WHERE quantidade_disponivel > 2 
ORDER BY quantidade_disponivel DESC;

-- 14. LIKE — 3 pts
SELECT id_livro, titulo, autor 
FROM LIVRO 
WHERE titulo LIKE '%Dados%';

-- 15. BETWEEN — 3 pts
SELECT id_livro, titulo, ano_publicacao 
FROM LIVRO 
WHERE ano_publicacao BETWEEN 2015 AND 2025;

-- 16. Funções agregadas — 4 pts
SELECT 
    COUNT(*) AS total_titulos,
    SUM(quantidade_disponivel) AS total_exemplares_estoque,
    AVG(quantidade_disponivel) AS media_exemplares,
    MIN(quantidade_disponivel) AS menor_estoque,
    MAX(quantidade_disponivel) AS maior_estoque
FROM LIVRO;

-- 17. INNER JOIN — 4 pts
SELECT 
    E.id_emprestimo,
    U.nome AS nome_usuario,
    L.titulo AS titulo_livro,
    E.data_emprestimo,
    E.status_emprestimo
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.id_usuario = U.id_usuario
INNER JOIN LIVRO L ON E.id_livro = L.id_livro;

-- 18. JOIN + WHERE — 3 pts
SELECT 
    E.id_emprestimo,
    U.nome AS nome_usuario,
    L.titulo AS titulo_livro,
    E.status_emprestimo
FROM EMPRESTIMO E
INNER JOIN USUARIO U ON E.id_usuario = U.id_usuario
INNER JOIN LIVRO L ON E.id_livro = L.id_livro
WHERE E.status_emprestimo = 'ABERTO';

-- 19. GROUP BY — 4 pts
SELECT 
    U.nome AS nome_usuario,
    COUNT(E.id_emprestimo) AS total_emprestimos
FROM USUARIO U
INNER JOIN EMPRESTIMO E ON U.id_usuario = E.id_usuario
GROUP BY U.id_usuario, U.nome
ORDER BY total_emprestimos DESC;

-- 20. LEFT JOIN — 4 pts
SELECT 
    U.nome AS nome_usuario,
    COUNT(E.id_emprestimo) AS total_emprestimos
FROM USUARIO U
LEFT JOIN EMPRESTIMO E ON U.id_usuario = E.id_usuario
GROUP BY U.id_usuario, U.nome
ORDER BY total_emprestimos DESC;


-- =============================================================================
-- FASE 4 — TCL, TRANSAÇÕES E INTEGRIDADE (20 pontos)
-- =============================================================================

-- 21. Transação de empréstimo — 7 pts
START TRANSACTION;
-- Passo 1: Registra o novo empréstimo (RN11)
INSERT INTO EMPRESTIMO (data_prevista, id_usuario, id_livro) VALUES ('2026-11-15', 4, 4);
-- Passo 2: Reduz o estoque do livro emprestado em 1 (RN13)
UPDATE LIVRO SET quantidade_disponivel = quantidade_disponivel - 1 WHERE id_livro = 4;
-- Passo 3: Consulta para conferência das alterações
SELECT * FROM EMPRESTIMO WHERE id_usuario = 4 AND id_livro = 4;
SELECT * FROM LIVRO WHERE id_livro = 4;
-- Passo 4: Confirma a transação atomicamente
COMMIT;

-- 22. ROLLBACK — 5 pts
START TRANSACTION;
-- Modificando temporariamente a quantidade do livro id 1
UPDATE LIVRO SET quantidade_disponivel = 99 WHERE id_livro = 1;
-- Consulta para comprovar a alteração em memória temporária
SELECT id_livro, quantidade_disponivel FROM LIVRO WHERE id_livro = 1;
-- Cancelando a operação
ROLLBACK;
-- Consulta pós-rollback comprovando o retorno ao valor original anterior
SELECT id_livro, quantidade_disponivel FROM LIVRO WHERE id_livro = 1;

-- 23. SAVEPOINT — 4 pts
START TRANSACTION;
-- Alteração 1
UPDATE LIVRO SET quantidade_disponivel = 20 WHERE id_livro = 2;
-- Criação do Savepoint após a primeira alteração
SAVEPOINT ponto_alteracao_um;
-- Alteração 2
UPDATE LIVRO SET quantidade_disponivel = 30 WHERE id_livro = 3;
-- Desfazendo apenas a segunda alteração voltando ao Savepoint
ROLLBACK TO SAVEPOINT ponto_alteracao_um;
-- Finalizando e confirmando apenas a alteração 1
COMMIT;
-- Verificação física (Livro 2 deve ser 20; Livro 3 deve manter seu valor original de inserts/updates prévios)
SELECT id_livro, quantidade_disponivel FROM LIVRO WHERE id_livro IN (2, 3);

-- 24. Transação de devolução — 4 pts
START TRANSACTION;
-- Passo 1 e 2: Marca como DEVOLVIDO e preenche a data atual (RN15)
UPDATE EMPRESTIMO 
SET status_emprestimo = 'DEVOLVIDO', data_devolucao = CURDATE() 
WHERE id_emprestimo = 1 AND status_emprestimo = 'ABERTO';
-- Passo 3: Aumenta o estoque do livro retornado em 1 (RN15)
UPDATE LIVRO 
SET quantidade_disponivel = quantidade_disponivel + 1 
WHERE id_livro = (SELECT id_livro FROM EMPRESTIMO WHERE id_emprestimo = 1);
-- Passo 4: Consolida no banco
COMMIT;
