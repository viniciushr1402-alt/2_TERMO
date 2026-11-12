-- =====================================================================
-- SITUAÇÃO DE APRENDIZAGEM - RECUPERAÇÃO: RETROGAME
-- ESCOLA SENAI "LUIZ VARGA" - TURMA DEVIS-26-SESI
-- =====================================================================

CREATE DATABASE IF NOT EXISTS retrogame_recuperacao;
USE retrogame_recuperacao;

-- --- REMOÇÃO SEGURA DE TABELAS (Ordem inversa de dependência) ---
DROP TABLE IF EXISTS LOCACAO;
DROP TABLE IF EXISTS JOGO;
DROP TABLE IF EXISTS CLIENTE;
DROP TABLE IF EXISTS CATEGORIA;
DROP TABLE IF EXISTS PLATAFORMA;

-- =====================================================================
-- FASE 1 - DDL: ESTRUTURA E RESTRIÇÕES (25 pontos)
-- =====================================================================

-- 2. Tabela CLIENTE
CREATE TABLE CLIENTE (
    id_cliente INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL,
    telefone VARCHAR(20) NULL,
    ativo BOOLEAN DEFAULT TRUE,
    CONSTRAINT PK_CLIENTE PRIMARY KEY (id_cliente),
    CONSTRAINT UQ_CLIENTE_EMAIL UNIQUE (email)
);

-- 3. Tabelas Auxiliares: PLATAFORMA e CATEGORIA
CREATE TABLE PLATAFORMA (
    id_plataforma INT AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    CONSTRAINT PK_PLATAFORMA PRIMARY KEY (id_plataforma),
    CONSTRAINT UQ_PLATAFORMA_NOME UNIQUE (nome)
);

CREATE TABLE CATEGORIA (
    id_categoria INT AUTO_INCREMENT,
    descricao VARCHAR(80) NOT NULL,
    CONSTRAINT PK_CATEGORIA PRIMARY KEY (id_categoria),
    CONSTRAINT UQ_CATEGORIA_DESCRICAO UNIQUE (descricao)
);

-- 4. Tabela JOGO
CREATE TABLE JOGO (
    id_jogo INT AUTO_INCREMENT,
    titulo VARCHAR(150) NOT NULL,
    codigo VARCHAR(15) NOT NULL,
    ano_lancamento INT NOT NULL,
    quantidade_disponivel INT DEFAULT 0,
    id_plataforma INT NOT NULL,
    id_categoria INT NOT NULL,
    CONSTRAINT PK_JOGO PRIMARY KEY (id_jogo),
    CONSTRAINT UQ_JOGO_CODIGO UNIQUE (codigo),
    CONSTRAINT CK_JOGO_QTD CHECK (quantidade_disponivel >= 0),
    CONSTRAINT FK_JOGO_PLATAFORMA FOREIGN KEY (id_plataforma) REFERENCES PLATAFORMA(id_plataforma) ON DELETE RESTRICT,
    CONSTRAINT FK_JOGO_CATEGORIA FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria) ON DELETE RESTRICT
);

-- 5. Tabela LOCACAO (Protegendo históricos contra exclusões com ON DELETE RESTRICT)
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

-- 6. ALTER TABLE: Acrescentar a coluna 'desenvolvedora' na tabela JOGO
ALTER TABLE JOGO ADD desenvolvedora VARCHAR(100);


-- =====================================================================
-- FASE 2 - DML: MANIPULAÇÃO DE DADOS (25 pontos)
-- =====================================================================

-- 7. Inserir Clientes (Pelo menos 4, um com telefone NULL)
INSERT INTO CLIENTE (nome, email, telefone, ativo) VALUES 
('Carlos Silva', 'carlos.silva@email.com', '19988776655', TRUE),
('Mariana Souza', 'mariana.souza@email.com', '19977665544', TRUE),
('Lucas Oliveira', 'lucas.oliveira@email.com', NULL, TRUE),
('Beatriz Lima', 'beatriz.lima@email.com', '19955443322', TRUE);

-- 8. Inserir Plataformas, Categorias e Jogos (6 jogos, anos e estoques diferentes)
INSERT INTO PLATAFORMA (nome) VALUES ('Super Nintendo'), ('Mega Drive'), ('PlayStation 1');

INSERT INTO CATEGORIA (descricao) VALUES ('Plataforma'), ('RPG'), ('Luta');

INSERT INTO JOGO (titulo, codigo, ano_lancamento, quantidade_disponivel, id_plataforma, id_categoria, desenvolvedora) VALUES 
('Super Mario World', 'SNES001', 1990, 5, 1, 1, 'Nintendo'),
('Donkey Kong Country', 'SNES002', 1994, 3, 1, 1, 'Rare'),
('Sonic the Hedgehog', 'SEGA001', 1991, 4, 2, 1, 'SEGA'),
('Chrono Trigger', 'SNES003', 1995, 2, 1, 2, 'Square'),
('Street Fighter II', 'SNES004', 1992, 6, 1, 3, 'Capcom'),
('Final Fantasy VII', 'PS1001', 1997, 1, 3, 2, 'Square');

-- 9. Inserir Locações Abertas (Reduzindo o estoque correspondente)
INSERT INTO LOCACAO (data_prevista, status_locacao, id_cliente, id_jogo) VALUES 
('2026-11-20', 'ABERTA', 1, 1),
('2026-11-22', 'ABERTA', 2, 3),
('2026-11-25', 'ABERTA', 4, 4);

UPDATE JOGO SET quantidade_disponivel = quantidade_disponivel - 1 WHERE id_jogo IN (1, 3, 4);

-- 10. SELECT + UPDATE: Localizar cliente e modificar telefone
SELECT * FROM CLIENTE WHERE id_cliente = 3;
UPDATE CLIENTE SET telefone = '19911223344' WHERE id_cliente = 3;

-- 11. UPDATE em lote: Acrescentar 2 unidades ao estoque de jogos a partir de 2000
-- (Inserindo primeiro um jogo moderno para teste do lote)
INSERT INTO JOGO (titulo, codigo, ano_lancamento, quantidade_disponivel, id_plataforma, id_categoria, desenvolvedora) 
VALUES ('Mega Man 9', 'WII001', 2008, 2, 3, 1, 'Capcom');

UPDATE JOGO SET quantidade_disponivel = quantidade_disponivel + 2 WHERE ano_lancamento >= 2000;

-- 12. DELETE e proteção do histórico
-- Teste de exclusão bem-sucedida (cliente sem locações)
INSERT INTO CLIENTE (nome, email, telefone, ativo) VALUES ('Teste Exclusao', 'teste@email.com', '19000000000', TRUE);
DELETE FROM CLIENTE WHERE email = 'teste@email.com';

-- Tentativa de exclusão de cliente com histórico (gerará erro de chave estrangeira propositalmente protegido)
-- DELETE FROM CLIENTE WHERE id_cliente = 1; 
-- Justificativa técnica: Como a tabela LOCACAO possui restrição "ON DELETE RESTRICT" vinculada ao cliente, o SGBD impede a exclusão para manter a integridade referencial do histórico de locações.


-- =====================================================================
-- FASE 3 - DQL: CONSULTAS E ANÁLISE (30 pontos)
-- =====================================================================

-- 13. SELECT básico
SELECT titulo, ano_lancamento, quantidade_disponivel FROM JOGO;

-- 14. WHERE + ORDER BY
SELECT * FROM JOGO WHERE quantidade_disponivel > 2 ORDER BY quantidade_disponivel DESC;

-- 15. LIKE
SELECT * FROM JOGO WHERE titulo LIKE '%Super%';

-- 16. BETWEEN
SELECT * FROM JOGO WHERE ano_lancamento BETWEEN 1990 AND 2005;

-- 17. Funções agregadas
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

-- 19. JOIN + WHERE (Status ABERTA)
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

-- 21. LEFT JOIN (Todos os clientes, inclusive os que nunca locaram)
SELECT c.nome, COUNT(l.id_locacao) AS total_locacoes
FROM CLIENTE c
LEFT JOIN LOCACAO l ON c.id_cliente = l.id_cliente
GROUP BY c.id_cliente, c.nome;


-- =====================================================================
-- FASE 4 - TCL: TRANSAÇÕES E INTEGRIDADE (20 pontos)
-- =====================================================================

-- 22. Transação de locação segura com verificação de estoque
START TRANSACTION;
-- Verificando se há estoque antes de locar (Ex: Jogo ID 2 possui estoque)
SELECT quantidade_disponivel FROM JOGO WHERE id_jogo = 2 FOR UPDATE;

INSERT INTO LOCACAO (data_prevista, status_locacao, id_cliente, id_jogo) 
VALUES ('2026-12-01', 'ABERTA', 3, 2);

UPDATE JOGO SET quantidade_disponivel = quantidade_disponivel - 1 WHERE id_jogo = 2 AND quantidade_disponivel > 0;

COMMIT;
-- Para evitar locar sem estoque, utiliza-se a validação condicional no UPDATE (quantidade > 0) aliada ao bloqueio de linha (FOR UPDATE) ou regras lógicas na camada de aplicação.

-- 23. ROLLBACK
START TRANSACTION;
SELECT quantidade_disponivel FROM JOGO WHERE id_jogo = 5;
UPDATE JOGO SET quantidade_disponivel = 99 WHERE id_jogo = 5;
SELECT quantidade_disponivel FROM JOGO WHERE id_jogo = 5;
ROLLBACK;
-- Conferindo retorno ao valor original após o rollback:
SELECT quantidade_disponivel FROM JOGO WHERE id_jogo = 5;

-- 24. SAVEPOINT
START TRANSACTION;
UPDATE JOGO SET quantidade_disponivel = 10 WHERE id_jogo = 1;
SAVEPOINT meu_savepoint;
UPDATE JOGO SET quantidade_disponivel = 20 WHERE id_jogo = 2;
-- Desfazendo apenas a segunda alteração:
ROLLBACK TO meu_savepoint;
COMMIT;

-- 25. Transação de devolução
START TRANSACTION;
UPDATE LOCACAO SET status_locacao = 'DEVOLVIDA', data_devolucao = CURRENT_DATE() WHERE id_locacao = 1 AND status_locacao = 'ABERTA';
UPDATE JOGO SET quantidade_disponivel = quantidade_disponivel + 1 WHERE id_jogo = (SELECT id_jogo FROM LOCACAO WHERE id_locacao = 1);
COMMIT;


-- =====================================================================
-- 8. ANÁLISE TÉCNICA (Explicação exigida na especificação)
-- =====================================================================
-- (a) E-mail repetido: Evitado pela restrição UNIQUE (CONSTRAINT UQ_CLIENTE_EMAIL).
-- (b) Código de jogo repetido: Evitado pela restrição UNIQUE (CONSTRAINT UQ_JOGO_CODIGO).
-- (c) Estoque negativo: Evitado pela restrição CHECK (quantidade_disponivel >= 0).
-- (d) Locação de cliente inexistente: Evitado pela Chave Estrangeira (FK_LOCACAO_CLIENTE).
-- (e) Exclusão de jogo com histórico: Evitado pela regra de comportamento referencial ON DELETE RESTRICT na FK.
-- (f) Locação gravada sem baixa de estoque: Garantido pelo controle transacional (DML associado na mesma transação).
-- (g) Locação quando não há unidades disponíveis: Prevenido por validação lógica de estoque > 0 combinada com restrição CHECK e transações seguras.
-- Diferenciação: Restrições do banco garantem integridade estrutural (DDL/Constraints), transações asseguram atomicidade e consistência (TCL), e validações de aplicação tratam regras de negócio interativas.