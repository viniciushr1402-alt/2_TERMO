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
SELECT SUM(valor_total) AS faturamento_total FROM pedido WHERE status_pedido = 'FINALIZADO';1