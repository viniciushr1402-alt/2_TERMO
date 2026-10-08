-- ====================================================
-- Parte A — Aquecimento[cite: 1]
-- ====================================================

-- 1. Liste todos os clientes cadastrados.[cite: 1]
SELECT * FROM clientes;

-- 2. Exiba apenas nome, cidade e e-mail dos clientes.[cite: 1]
SELECT nome, cidade, email FROM clientes;

-- 3. Liste os nomes das cidades sem repetir valores.[cite: 1]
SELECT DISTINCT cidade FROM clientes;

-- 4. Liste todos os produtos em ordem crescente de preço.[cite: 1]
SELECT * FROM produtos ORDER BY preco ASC;

-- 5. Mostre apenas os 5 produtos mais caros.[cite: 1]
SELECT * FROM produtos ORDER BY preco DESC LIMIT 5;


-- ====================================================
-- Parte B — Filtros[cite: 1]
-- ====================================================

-- 6. Liste os produtos com preço entre R$ 8,00 e R$ 15,00.[cite: 1]
SELECT * FROM produtos WHERE preco BETWEEN 8.00 AND 15.00;

-- 7. Liste os clientes das cidades Limeira ou Americana.[cite: 1]
SELECT * FROM clientes WHERE cidade IN ('Limeira', 'Americana');

-- 8. Localize os produtos cujo nome contém a palavra “Café”.[cite: 1]
SELECT * FROM produtos WHERE nome LIKE '%Café%';

-- 9. Liste os clientes que não informaram telefone.[cite: 1]
SELECT * FROM clientes WHERE telefone IS NULL;

-- 10. Mostre os pedidos com status FINALIZADO e valor total acima de R$ 20,00, do maior para o menor valor.[cite: 1]
SELECT * FROM pedidos WHERE status = 'FINALIZADO' AND valor_total > 20.00 ORDER BY valor_total DESC;


-- ====================================================
-- Parte C — Cálculos e agrupamentos[cite: 1]
-- ====================================================

-- 11. Informe quantos produtos estão cadastrados.[cite: 1]
SELECT COUNT(*) AS total_produtos FROM produtos;

-- 12. Mostre menor preço, maior preço e preço médio dos produtos.[cite: 1]
SELECT MIN(preco) AS menor_preco, MAX(preco) AS maior_preco, AVG(preco) AS preco_medio FROM produtos;

-- 13. Informe quantos clientes existem em cada cidade.[cite: 1]
SELECT cidade, COUNT(*) AS total_clientes FROM clientes GROUP BY cidade;

-- 14. Mostre somente as cidades que possuem dois ou mais clientes.[cite: 1]
SELECT cidade, COUNT(*) AS total_clientes FROM clientes GROUP BY cidade HAVING COUNT(*) >= 2;

-- 15. Calcule o faturamento total considerando apenas pedidos FINALIZADOS.[cite: 1]
SELECT SUM(valor_total) AS faturamento_total FROM pedidos WHERE status = 'FINALIZADO';