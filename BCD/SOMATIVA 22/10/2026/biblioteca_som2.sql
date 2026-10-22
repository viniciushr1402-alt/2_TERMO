-- Active: 1788435082238@@127.0.0.1@3306@biblioteca_som2

-- 1. Criação do banco —
CREATE DATABASE IF NOT EXISTS biblioteca_som2;
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
-- 2.1 Tabela USUARIO 
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
-- 2.2 Tabela USUARIO 
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
    -- 5. ALTER TABLE
);
-- 2.3 Tabela USUARIO 
CREATE TABLE PAGAMENTO (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT NOT NULL,
    id_forma_pagamento INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATETIME
);
-- 2.4 Tabela USUARIO 
CREATE TABLE forma_pagamento (
    id_forma_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(40) NOT NULL UNIQUE
);
-- 5. ALTER TABLE
ALTER TABLE LIVRO ADD COLUMN editora VARCHAR(100) NULL;

--6. INSERT de usuários
INSERT INTO USUARIO (nome, email, telefone) VALUES 
('Samuel DEV', 'samuel.dev@email.com', '99999-1111'),
('Bruno DEV', 'bruno.dev@email.com', NULL),
('Celso DEV', 'celso.dev@email.com', '99999-2222'),

-- 7. INSERT de livros
INSERT INTO LIVRO (titulo, autor, isbn, ano_publicado, quantidade_disponivel, editora) VALUES
('O Domínio do SQL', 'Alan Beaulieu', '9788575227091', 2021, 5, 'Novatec'),
('Bancos de Dados Relacionais', 'Carlos A. Heuser', '9788577805822', 2019, 3, 'Sagra'),
('Clean Code', 'Robert C. Martin', '9788576082675', 2009, 2, 'Alta Books'),
('Introdução ao HTML5 e CSS3', 'Maurício Samy', '9788575223369', 2015, 4, 'Novatec'),
('Algoritmos Estruturados', 'Harry Farrer', '9788521611837', 2018, 1, 'LTC'),
('Design Patterns', 'Erich Gamma', '9788573076103', 2022, 6, 'Bookman');

-- 8. INSERT de empréstimos
INSERT (data_prevista, id_usuario, id_livro) VALUES
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
WHERE ano_publicado >= 2020;

-- 11. DELETE e integridade
INSERT INTO USUARIO (nome, email, telefone, ativo) VALUES ('User Teste', 'teste@email.com', NULL, TRUE);

DELETE FROM USUARIO WHERE email = 'teste@email.com';
-- 12. SELECT básico
SELECT titulo, autor, quantidade_disponivel 
FROM LIVRO;
 
--  13. WHERE + ORDER BY
