-- Active: 1788435082238@@127.0.0.1@3308@biblioteca_senai_vini
-- A escola Biblioteca Conecta deseja substituir planilhas e registros manuais por um banco de dados relacional capaz de controlar usuários, livros e empréstimos. Sua missão é desenvolver a primeira versão do banco, desde sua criação até operações de consulta, manipulação e controle transacional. A atividade já inicia com 3 tabelas e você deverá criar e adaptar mais 2 tabelas.

-- Criar tabelas - Usuario, Livro, Emprestimo,

CREATE DATABASE IF NOT EXISTS BIBLIOTECA_SENAI_VINI;

USE BIBLIOTECA_SENAI-VINI;

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