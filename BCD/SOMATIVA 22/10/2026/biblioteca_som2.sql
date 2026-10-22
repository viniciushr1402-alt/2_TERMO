
-- 1. Criação do banco —
CREATE DATABASE IF NOT EXISTS biblioteca_som2;

DROP DATABASE IF EXISTS biblioteca_som2;


CREATE DATABASE biblioteca_som2;
USE biblioteca_som2;

USE biblioteca_som2;

-- 2. Tabela USUARIO —
CREATE TABLE IF NOT EXISTS USUARIO (
    id_usuario INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL,
    telefone VARCHAR(20) NULL,
    ativo BOOLEAN DEFAULT TRUE,
    CONSTRAINT PK_USUARIO PRIMARY KEY (id_usuario),
    CONSTRAINT UN_USUARIO_EMAIL UNIQUE (email)
);

-- 3. Tabela LIVRO
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

-- 4. Tabela EMPRESTIMO
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

-- Tabela PAGAMENTO adcional
CREATE TABLE IF NOT EXISTS PAGAMENTO (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME
);

-- Tabela forma_pagamento adcional
CREATE TABLE IF NOT EXISTS forma_pagamento (
    id_forma_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(40) NOT NULL UNIQUE
);

-- 5. ALTER TABLE
ALTER TABLE LIVRO ADD COLUMN editora VARCHAR(100) NULL;

-- 6. INSERT de usuários
INSERT INTO USUARIO (nome, email, telefone) VALUES 
('Samuel DEV', 'samuel.dev@email.com', '99999-1111'),
('Bruno DEV', 'bruno.dev@email.com', NULL),
('Celso DEV', 'celso.dev@email.com', '99999-2222');

-- 7. INSERT de livros
INSERT INTO LIVRO (titulo, autor, isbn, ano_publicado, quantidade_disponivel, editora) VALUES
('O Domínio do SQL', 'Alan Beaulieu', '9788575227091', 2021, 5, 'Novatec'),
('Bancos de Dados Relacionais', 'Carlos A. Heuser', '9788577805822', 2019, 3, 'Sagra'),
('Clean Code', 'Robert C. Martin', '9788576082675', 2009, 2, 'Alta Books'),
('Introdução ao HTML5 e CSS3', 'Maurício Samy', '9788575223369', 2015, 4, 'Novatec'),
('Algoritmos Estruturados', 'Harry Farrer', '9788521611837', 2018, 1, 'LTC'),
('Design Patterns', 'Erich Gamma', '9788573076103', 2022, 6, 'Bookman');

-- 8. INSERT de empréstimos
INSERT INTO EMPRESTIMO (data_prevista, id_usuario, id_livro) VALUES
('2026-11-05', 1, 1),
('2026-11-05', 2, 2),
('2026-11-10', 3, 3);

-- 9. UPDATE
UPDATE USUARIO
SET telefone = '1998888-4444' 
WHERE email = 'bruno.dev@email.com';

-- 10. Atualização em lote
UPDATE LIVRO 
SET quantidade_disponivel = quantidade_disponivel + 2 
WHERE ano_publicacao >= 2020;

-- 11. DELETE e integridade
INSERT INTO USUARIO (nome, email, telefone, ativo) VALUES ('User Teste', 'teste@email.com', NULL, TRUE);

--  O comando acima falha e resulta no erro "Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails...". 
-- Isso ocorre porque definimos a FK com a regra implícita ON DELETE  O sistema impede a exclusão do usuário para não deixar registros órfãos na tabela EMPRESTIMO, mantendo a integridade referencial 

DELETE FROM USUARIO WHERE email = 'teste@email.com';

-- 12. SELECT básico
SELECT titulo, autor, quantidade_disponivel 
FROM LIVRO;
 
-- 13. WHERE + ORDER BY
SELECT id_livro, titulo, quantidade_disponivel 
FROM LIVRO 
WHERE quantidade_disponivel > 2 
ORDER BY quantidade_disponivel DESC;

-- 14. LIKE
SELECT id_livro, titulo, autor 
FROM LIVRO 
WHERE titulo LIKE '%Dados%';

-- 15. BETWEEN

SELECT id_livro, titulo, quantidade_disponivel 
FROM LIVRO 
WHERE ano_publicacao BETWEEN 2015 AND 2025;


-- 16. Funções agregadas
SELECT 
    COUNT(*) AS total_titulos,
    SUM(quantidade_disponivel) AS total_exemplares_estoque,
    AVG(quantidade_disponivel) AS media_exemplares,
    MIN(quantidade_disponivel) AS menor_estoque,
    MAX(quantidade_disponivel) AS maior_estoque
FROM LIVRO;

-- 17. INNER JOIN
SELECT E.id_emprestimo, U.id_usuario, E.id_livro, E.data_prevista, E.status_emprestimo 
FROM EMPRESTIMO as E 
INNER JOIN USUARIO AS U ON E.id_usuario = U.id_usuario;

-- 18. JOIN + WHERE
SELECT status_emprestimo, COUNT(*) AS Quantidade 
FROM EMPRESTIMO 
GROUP BY status_emprestimo;

-- 19. GROUP BY
SELECT U.id_usuario, U.nome, COUNT(E.id_emprestimo) AS Quantidade 
FROM USUARIO AS U 
INNER JOIN EMPRESTIMO AS E ON E.id_usuario = U.id_usuario 
GROUP BY U.id_usuario, U.nome 
ORDER BY Quantidade DESC;

-- 20. LEFT JOIN
SELECT U.id_usuario, U.nome, COUNT(E.id_emprestimo) AS Quantidade 
FROM USUARIO AS U 
LEFT JOIN EMPRESTIMO AS E ON E.id_usuario = U.id_usuario 
GROUP BY U.id_usuario, U.nome;

-- FASE 4 — TCL, TRANSAÇÕES E INTEGRIDADE

-- 21. Transação de empréstimo
START TRANSACTION;

INSERT INTO EMPRESTIMO
    (data_prevista, id_usuario, id_livro)
VALUES
    ('2026-11-05', 3, 4);

UPDATE LIVRO
SET quantidade_disponivel = quantidade_disponivel - 1
WHERE id_livro = 4
  AND quantidade_disponivel > 0;

SELECT *
FROM EMPRESTIMO
WHERE id_usuario = 2
  AND id_livro = 2;

SELECT *
FROM LIVRO
WHERE id_livro = 4;

COMMIT;

-- 22. ROLLBACK

UPDATE LIVRO
SET quantidade_disponivel = 99
WHERE id_livro = 1;
SELECT id_livro, quantidade_disponivel
FROM LIVRO
WHERE id_livro = 1;

ROLLBACK;

SELECT id_livro, quantidade_disponivel
FROM LIVRO
WHERE id_livro = 1;


-- 23. SAVEPOINT
START TRANSACTION;

UPDATE LIVRO
SET quantidade_disponivel = 20
WHERE id_livro = 2;

SAVEPOINT ponto_alte;

UPDATE LIVRO
SET quantidade_disponivel = 30
WHERE id_livro = 3;

ROLLBACK TO SAVEPOINT ponto_alte;

COMMIT;

SELECT id_livro, quantidade_disponivel
FROM LIVRO
WHERE id_livro IN (2, 3);


-- 24. TRANSAÇÃO DE DEVOLUÇÃO
START TRANSACTION;

UPDATE LIVRO L
INNER JOIN EMPRESTIMO E
    ON L.id_livro = E.id_livro
SET L.quantidade_disponivel = L.quantidade_disponivel + 1
WHERE E.id_emprestimo = 1
  AND E.status_emprestimo ='‘ABERTO';

UPDATE EMPRESTIMO
SET status_emprestimo = 'DEVOLVIDO',
    Data_devolucao = CURDATE()
WHERE id_emprestimo = 1
  AND status_emprestimo = 'ABERTO';

COMMIT;


-- 25. Análise técnica
-- A
-- R: Dá para resolver direto no banco de dados usando a regra UNIQUE no campo do e-mail. Isso impede que o sistema aceite dois cadastros iguais.
-- B
-- R: Não vai ser possível cadastrar. O ISBN funciona como uma identidade do livro, então também precisamos aplicar a restrição UNIQUE para bloquear duplicados.
-- C
-- R: O sistema não deve aceitar esse tipo de dado. A melhor forma de bloquear é criando uma regra de validação do tipo CHECK para garantir que a condição seja respeitada.
-- D
-- R: Não é possível realizar a operação. A tabela depende obrigatoriamente de uma Chave Estrangeira FK vinculada a um ID de usuário válido. Se o ID não existir, o banco rejeita.
-- E
-- R: A exclusão vai dar erro e será bloqueada. Como o livro está sendo referenciado em um empréstimo ativo, a restrição de integridade Constraint da FK impede que ele seja apagado.
-- F
-- R: Isso é uma transação. Como envolve várias etapas críticas, o processo precisa rodar de forma segura usando comandos como Start Transaction, Commit para salvar se tudo der certo ou Rollback para cancelar tudo se algo der errado.
-- G
-- R: O sistema deve bloquear isso por meio de uma regra de negócio na aplicação. Não faz sentido lógico permitir o empréstimo de um livro que já consta como indisponível no estoque.

