-- Active: 1788435082238@@127.0.0.1@3306@smartcoffe_dml_vini
-- DQL - DATA QUERY LANGUAGE
-- BANCO: smartcoffe_dml_vini

-- ANTES DE INICIAR
INSERT INTO cliente (nome, email, telefone, cidade, ativo)
VALUES ('Ana Flavia', 'anaf@gmail.com', '199984512456', 'Campinas', TRUE);


-- EX 1: SELECT SIMPLES
SELECT *
FROM cliente;

SELECT nome, telefone
FROM cliente;


-- EX 2: AS - APELIDOS DE COLUNAS
SELECT nome AS Nome_Cliente
FROM cliente;

SELECT email AS Email_Cliente, telefone AS Zap
FROM cliente;


-- EX 3: DISTINCT
SELECT DISTINCT cidade
FROM cliente;


-- EX 4: WHERE - FILTRO DE REGISTROS
SELECT nome, preco
FROM produto
WHERE preco > 10.00;

SELECT nome, ativo
FROM cliente
WHERE ativo = TRUE;

SELECT id_pedido, data_pedido, valor_total
FROM pedido
WHERE valor_total > 25.00;


-- EX 5: AND, OR E NOT
SELECT nome, preco
FROM produto
WHERE preco >= 8.00 AND preco <= 25.00;

SELECT nome, cidade
FROM cliente
WHERE cidade = 'Limeira' OR cidade = 'Piracicaba';

SELECT nome, cidade
FROM cliente
WHERE NOT cidade = 'Limeira';

SELECT nome, cidade, ativo
FROM cliente
WHERE ativo = TRUE
AND (cidade = 'Limeira' OR cidade = 'Piracicaba');


-- EX 6: BETWEEN
SELECT nome, preco
FROM produto
WHERE preco BETWEEN 8.00 AND 15.00;

SELECT id_pedido, data_pedido, valor_total
FROM pedido
WHERE data_pedido BETWEEN '2026-09-01 00:00:00'
AND '2026-09-30 23:59:59';


-- EX 7: IN E NOT IN
SELECT nome, cidade
FROM cliente
WHERE cidade IN ('Limeira', 'Campinas', 'Americana', 'Piracicaba');

SELECT nome, cidade
FROM cliente
WHERE cidade NOT IN ('Limeira', 'Piracicaba');


-- EX 8: LIKE
SELECT nome
FROM produto
WHERE nome LIKE 'Café%';

SELECT nome
FROM produto
WHERE nome LIKE '%chocolate%';

SELECT nome
FROM cliente
WHERE nome LIKE '%Silva';

SELECT nome
FROM cliente
WHERE nome LIKE '%Si_va';


-- EX 9: NULL
SELECT nome, telefone
FROM cliente
WHERE telefone IS NULL;

SELECT nome, telefone
FROM cliente
WHERE telefone IS NOT NULL;


-- EX 10: ORDER BY
SELECT nome, preco
FROM produto
ORDER BY preco ASC;

SELECT nome, preco
FROM produto
ORDER BY preco DESC;

SELECT cidade, nome
FROM cliente
ORDER BY cidade ASC, nome DESC;


-- EX 11: LIMIT
SELECT nome, preco
FROM produto
ORDER BY preco DESC
LIMIT 10;

SELECT nome, preco
FROM produto
ORDER BY nome
LIMIT 5 OFFSET 5;


-- EX 12: CÁLCULO DE COLUNAS
SELECT nome, preco, preco * 1.10 AS preco_ajustado
FROM produto;

SELECT id_item, quantidade, preco_unitario,
       quantidade * preco_unitario AS Sub_total
FROM item_pedido;


-- EX 13: FUNÇÕES
-- TEXTOS
SELECT UPPER(nome) AS Nome_Cliente,
       LOWER(email) AS Email_Cliente
FROM cliente;

SELECT CONCAT(nome, ' --- ', cidade) AS Cidade_Clientes
FROM cliente;

-- NÚMEROS
SELECT nome, preco,
       ROUND(preco * 0.90, 2) AS Preco_Desconto
FROM produto;

-- DATAS
SELECT id_pedido, data_pedido,
       DATE(data_pedido) AS Data,
       MONTH(data_pedido) AS Mes,
       YEAR(data_pedido) AS Ano,
       DAY(data_pedido) AS Dia,
       TIME(data_pedido) AS Horario
FROM pedido;

-- COALESCE
SELECT nome,
       COALESCE(telefone, 'Não Informado') AS telefone
FROM cliente;


-- EX 14: FUNÇÕES DE AGRUPAMENTO
SELECT COUNT(*) AS TOTAL_CLIENTES
FROM cliente;

SELECT AVG(preco) AS MEDIA_PRECOS
FROM produto;

SELECT MIN(preco) AS MENOR_PRECO,
       MAX(preco) AS MAIOR_PRECO
FROM produto;

SELECT SUM(valor_total) AS Faturamento_Total
FROM pedido
WHERE status_pedido = 'FINALIZADO';


-- EX 15: GROUP BY
SELECT cidade, COUNT(*) AS Quantidade_Clientes
FROM cliente
GROUP BY cidade;

-- CORRIGIDO: CONTAGEM DE CLIENTES POR CIDADE
SELECT cidade, COUNT(*) AS QTDE_CLIENTES
FROM cliente
GROUP BY cidade
HAVING COUNT(*) >= 2;


-- EX 16: HAVING
SELECT cidade, COUNT(*) AS QTDE_CLIENTES
FROM cliente
GROUP BY cidade
HAVING COUNT(*) >= 2;


-- EX 17: ORDEM DE UMA CONSULTA COMPLETA
-- Exemplo de estrutura:
-- SELECT coluna
-- FROM tabela
-- WHERE condicao
-- GROUP BY coluna
-- HAVING condicao
-- ORDER BY coluna
-- LIMIT quantidade;


-- PARTE II: JOINS

-- EX 1: INNER JOIN
-- PEDIDOS COM O NOME DO CLIENTE
SELECT P.ID_PEDIDO,
       P.DATA_PEDIDO,
       C.NOME AS CLIENTE,
       P.VALOR_TOTAL
FROM PEDIDO AS P
INNER JOIN CLIENTE AS C
    ON C.ID_CLIENTE = P.ID_CLIENTE;


-- EX 2: LEFT JOIN
-- TODOS OS CLIENTES, INCLUSIVE QUEM NUNCA COMPROU
SELECT C.NOME,
       P.ID_PEDIDO,
       P.DATA_PEDIDO
FROM CLIENTE AS C
LEFT JOIN PEDIDO AS P
    ON P.ID_CLIENTE = C.ID_CLIENTE
ORDER BY C.NOME;


-- DESCOBRINDO CLIENTES SEM PEDIDOS
-- DESCOBRINDO CLIENTES SEM PEDIDOS
SELECT C.ID_CLIENTE, C.NOME
FROM CLIENTE AS C
LEFT JOIN PEDIDO AS P
ON P.ID_CLIENTE = C.ID_CLIENTE
WHERE P.ID_PEDIDO IS NULL;


-- EX 3: JOIN COM TRÊS TABELAS
-- ITENS DE PEDIDO COM NOME DO PRODUTO
SELECT P.ID_PEDIDO,
       PR.NOME AS PRODUTO,
       IP.QUANTIDADE,
       IP.PRECO_UNITARIO,
       IP.QUANTIDADE * IP.PRECO_UNITARIO AS SUBTOTAL
FROM PEDIDO AS P
INNER JOIN ITEM_PEDIDO AS IP
    ON IP.ID_PEDIDO = P.ID_PEDIDO
INNER JOIN PRODUTO AS PR
    ON PR.ID_PRODUTO = IP.ID_PRODUTO
ORDER BY P.ID_PEDIDO;

-- EX 4: JOIN COM CATEGORIA
-- PRODUTO E NOME DE SUA CATEGORIA
SELECT PR.NOME AS PRODUTO, C.NOME AS CATEGORIA, PR.PRECO
FROM PRODUTO AS PR
INNER JOIN CATEGORIA AS C
ON C.ID_CATEGORIA = PR.ID_CATEGORIA
ORDER BY C.NOME, PR.NOME;

-- EX 5: AGREGAÇÃO + JOIN
-- QUANTIDADE DE PRODUTOS POR CATEGORIA
SELECT C.NOME AS CATEGORIA, COUNT(PR.ID_produto) AS QTDE_PRODUTOS
FROM CATEGORIA AS C
LEFT JOIN PRODUTO AS PR
ON PR.ID_CATEGORIA = C.ID_CATEGORIA
GROUP BY C.NOME;

-- TOTAL COMPRADO POR CLIENTE
SELECT C.NOME AS CLIENTE, 
       COUNT(P.ID_PEDIDO) AS QTDE_PEDIDOS,
       SUM(P.VALOR_TOTAL) AS TOTAL_COMPRADO
FROM CLIENTE AS C
LEFT JOIN PEDIDO AS P 
    ON P.ID_CLIENTE = C.ID_CLIENTE AND P.STATUS_pedido = 'ABERTO'
GROUP BY C.ID_CLIENTE, C.NOME
ORDER BY TOTAL_COMPRADO DESC;

-- EX 6: RELATÓRIO COMPLETO DO PEDIDO
SELECT P.ID_PEDIDO, 
       DATE_FORMAT(P.DATA_PEDIDO, '%d %m %Y %H:%i') AS DATA, 
       C.NOME AS CLIENTE, 
       PR.NOME AS PRODUTO, 
       IP.QUANTIDADE, 
       IP.PRECO_UNITARIO, 
       IP.QUANTIDADE * IP.PRECO_UNITARIO AS SUBTOTAL
FROM PEDIDO AS P
INNER JOIN CLIENTE AS C
    ON C.ID_CLIENTE = P.ID_CLIENTE
INNER JOIN ITEM_PEDIDO AS IP
    ON IP.ID_PEDIDO = P.ID_PEDIDO
INNER JOIN PRODUTO AS PR
    ON PR.ID_PRODUTO = IP.ID_PRODUTO
ORDER BY P.ID_PEDIDO, PR.NOME;

