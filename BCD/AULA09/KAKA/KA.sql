------------------------- EX 16 ------------------------------------
-- 16. Liste cada pedido exibindo: id do pedido, data, nome do cliente, status e valor total.
SELECT p.id_pedido, p.data_pedido, c.nome AS cliente, p.status_pedido, p.valor_total
FROM pedido AS p
INNER JOIN cliente AS c ON c.id_cliente = p.id_cliente;


------------------------- EX 17 ------------------------------------
-- 17. Liste cada produto acompanhado do nome de sua categoria.
SELECT pr.id_produto, pr.nome AS produto, pr.preco, cat.nome AS categoria
FROM produto AS pr
INNER JOIN categoria AS cat ON cat.id_categoria = pr.id_categoria;


------------------------- EX 18 ------------------------------------
-- 18. Gere um relatório dos itens vendidos exibindo: pedido, produto, quantidade, preço unitário e subtotal.
SELECT ip.id_pedido, pr.nome AS produto, ip.quantidade, ip.preco_unitario, (ip.quantidade * ip.preco_unitario) AS subtotal
FROM item_pedido AS ip
INNER JOIN produto AS pr ON pr.id_produto = ip.id_produto;


------------------------- EX 19 ------------------------------------
-- 19. Mostre todos os clientes, inclusive aqueles que nunca fizeram pedidos.
SELECT c.id_cliente, c.nome, p.id_pedido, p.data_pedido
FROM cliente AS c
LEFT JOIN pedido AS p ON p.id_cliente = c.id_cliente;


------------------------- EX 20 ------------------------------------
-- 20. Liste apenas os clientes que nunca fizeram pedidos.
SELECT c.id_cliente, c.nome
FROM cliente AS c
LEFT JOIN pedido AS p ON p.id_cliente = c.id_cliente
WHERE p.id_pedido IS NULL;


------------------------- EX 21 ------------------------------------
-- 21. Informe quantos pedidos FINALIZADOS cada cliente realizou e quanto cada cliente gastou. Ordene do maior gasto para o menor.
SELECT c.id_cliente, c.nome, COUNT(p.id_pedido) AS total_pedidos_finalizados, SUM(p.valor_total) AS total_gasto
FROM cliente AS c
INNER JOIN pedido AS p ON p.id_cliente = c.id_cliente
WHERE p.status_pedido = 'FINALIZADO'
GROUP BY c.id_cliente, c.nome
ORDER BY total_gasto DESC;


------------------------- EX 22 ------------------------------------
-- 22. Mostre a quantidade de produtos e o preço médio de cada categoria.
SELECT cat.nome AS categoria, COUNT(pr.id_produto) AS quantidade_produtos, AVG(pr.preco) AS preco_medio
FROM categoria AS cat
LEFT JOIN produto AS pr ON pr.id_categoria = cat.id_categoria
GROUP BY cat.id_categoria, cat.nome;


------------------------- EX 23 ------------------------------------
-- 23. Descubra quais produtos possuem preço superior ao preço médio de todos os produtos.
SELECT id_produto, nome, preco
FROM produto
WHERE preco > (SELECT AVG(preco) FROM produto)
ORDER BY preco ASC;


------------------------- EX 24 ------------------------------------
-- 24. Classifique os produtos como “Econômico”, “Intermediário” ou “Premium”, utilizando faixas de preço definidas por você.
SELECT nome, preco,
    CASE 
        WHEN preco < 10.00 THEN 'Econômico'
        WHEN preco BETWEEN 10.00 AND 25.00 THEN 'Intermediário'
        ELSE 'Premium'
    END AS classificacao
FROM produto
ORDER BY preco ASC;

-- 25. Crie em uma transação um pedido temporário com dois itens,
-- exclua o pedido e observe ON DELETE CASCADE.
-- Finalize com ROLLBACK para preservar a base.
START TRANSACTION;
INSERT INTO pedido (id_cliente, status_pedido) VALUES (1, 'ABERTO');
SET @pedido_temp = LAST_INSERT_ID();
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES (@pedido_temp, 1, 1, 7.50), (@pedido_temp, 2, 1, 9.00);

-- Excluir o pedido disparará o CASCADE nos itens
DELETE FROM pedido WHERE id_pedido = @pedido_temp;
SELECT * FROM item_pedido WHERE id_pedido = @pedido_temp;
ROLLBACK;

-- DESAFIO EXTRA - CAIXA DO SMARTCOFFEE
-- Em UMA transação:
-- a) pedido; b) 3 itens; c) baixa de estoque;
-- d) SAVEPOINT; e) pagamento; f) status FINALIZADO;
-- g) consultas; h) COMMIT.
START TRANSACTION;

-- a) Criar pedido
INSERT INTO pedido (id_cliente, status_pedido) VALUES (1, 'ABERTO');
SET @pedido_caixa = LAST_INSERT_ID();

-- b) Inserir 3 itens
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES 
(@pedido_caixa, 1, 1, 8.00),
(@pedido_caixa, 2, 2, 6.50),
(@pedido_caixa, 3, 1, 10.00);

-- c) Baixa de estoque
UPDATE estoque SET quantidade = quantidade - 1 WHERE id_produto = 1;
UPDATE estoque SET quantidade = quantidade - 2 WHERE id_produto = 2;
UPDATE estoque SET quantidade = quantidade - 1 WHERE id_produto = 3;

-- d) Criar SAVEPOINT
SAVEPOINT antes_pagamento;

-- e) Registrar pagamento
INSERT INTO pagamento (id_pedido, valor, forma_pagamento) VALUES (@pedido_caixa, 31.00, 'DINHEIRO');

-- f) Alterar status para FINALIZADO
UPDATE pedido SET status_pedido = 'FINALIZADO' WHERE id_pedido = @pedido_caixa;

-- g) Consultas para conferência
SELECT * FROM pedido WHERE id_pedido = @pedido_caixa;
SELECT * FROM item_pedido WHERE id_pedido = @pedido_caixa;
SELECT * FROM pagamento WHERE id_pedido = @pedido_caixa;

-- h) COMMIT final
COMMIT;