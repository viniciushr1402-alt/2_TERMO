-- 01. Consulte produto 2 e seu preço.
SELECT * FROM produto WHERE id_produto = 2;

-- 02. START TRANSACTION e aumente produto 2 em R$3,00.
START TRANSACTION;
UPDATE produto 
SET preco = preco + 3.00 
WHERE id_produto = 2;

-- 03. Consulte dentro da transação.
SELECT * FROM produto WHERE id_produto = 2;

-- 04. ROLLBACK.
ROLLBACK;

-- 05. Consulte e comprove retorno.
SELECT * FROM produto WHERE id_produto = 2;

-- 06. Repita a alteração e finalize com COMMIT.
START TRANSACTION;
UPDATE produto 
SET preco = preco + 3.00 
WHERE id_produto = 2;
COMMIT;

-- 07. START TRANSACTION e aumente produto 3 em 10%.
START TRANSACTION;
UPDATE produto 
SET preco = preco * 1.10 
WHERE id_produto = 3;

-- 08. SAVEPOINT ajuste_produto3.
SAVEPOINT ajuste_produto3;

-- 09. Aumente produto 4 em 50%.
UPDATE produto 
SET preco = preco * 1.50 
WHERE id_produto = 4;

-- 10. Consulte os dois.
SELECT * FROM produto WHERE id_produto IN (3, 4);

-- 11. ROLLBACK TO SAVEPOINT ajuste_produto3.
ROLLBACK TO SAVEPOINT ajuste_produto3;

-- 12. COMMIT e explique em comentário qual alteração permaneceu.
COMMIT;
-- 13. START TRANSACTION.
START TRANSACTION;

-- 14. Crie pedido para cliente 1 e salve o id em @novo_pedido.
INSERT INTO pedido (id_cliente, data_pedido, status_pedido) 
VALUES (1, NOW(), 'ABERTO');

SET @novo_pedido = LAST_INSERT_ID();
-- 15. Insira dois itens válidos.
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES 
(@novo_pedido, 1, 2, 7.50),
(@novo_pedido, 2, 1, 9.00);
-- 16. Registre pagamento válido.
INSERT INTO pagamento (id_pedido, valor, id_forma_pagamento) 
VALUES (@novo_pedido, 24.00, 2);
-- 17. Consulte pedido, itens e pagamento.
SELECT * FROM pedido WHERE id_pedido = @novo_pedido;
SELECT * FROM item_pedido WHERE id_pedido = @novo_pedido;
SELECT * FROM pagamento WHERE id_pedido = @novo_pedido;
-- 18. COMMIT.
COMMIT

-- 19. START TRANSACTION e crie pedido para cliente 2.
START TRANSACTION;

INSERT INTO pedido (id_cliente, status_pedido, data_pedido) 
VALUES (2, 'ABERTO', NOW());
-- 20. Salve o id em @pedido_com_erro.
SET @pedido_com_erro = LAST_INSERT_ID();
-- 21. Tente inserir item com id_produto inexistente.
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario) 
VALUES (@pedido_com_erro, 9999, 1, 10.00);
-- 22. Após observar a FK, ROLLBACK.
ROLLBACK;
-- 23. Consulte @pedido_com_erro e comprove que não permaneceu.
SELECT * FROM pedido WHERE id_pedido = @pedido_com_erro;
-- 24. Tente excluir uma categoria que possui produtos.
-- Explique em comentário por que foi bloqueado.

-- DELETE FROM categoria WHERE id_categoria = 1;
-- Explicação em comentário: Foi bloqueado pela regra de integridade referencial (RESTRICT/NO ACTION) da chave estrangeira E impedindo a exclusão de registros pais que possuem dependentes para preservar o histórico.

-- 25. Crie em uma transação um pedido temporário com dois itens,
-- exclua o pedido e observe ON DELETE CASCADE.
-- Finalize com ROLLBACK para preservar a base.





-- DESAFIO EXTRA - CAIXA DO SMARTCOFFEE
-- Em UMA transação:
-- a) pedido; b) 3 itens; c) baixa de estoque;
-- d) SAVEPOINT; e) pagamento; f) status FINALIZADO;
-- g) consultas; h) COMMIT.

CREATE VIEW vw_produtos_ativos AS
SELECT id_produto, nome, preco
FROM produto
WHERE ativo = TRUE;

SELECT *
FROM vw_produtos_ativos
WHERE preco > 10.00;

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SELECT TABLE_NAME
FROM information_schema.VIEWS
WHERE TABLE_SCHEMA = DATABASE();



SHOW CREATE VIEW vw_produtos_ativos;

CREATE VIEW vw_produtos_categorias AS
SELECT
    p.id_produto,
    p.nome AS produto,
    c.nome AS categoria,
    p.preco
FROM produto AS p


**6. Crie `vw_pedidos_clientes`.**
```sql
CREATE VIEW vw_pedidos_clientes AS
SELECT
    p.id_pedido,
    p.data_pedido,
    c.id_cliente,
    c.nome AS cliente,
    p.status_pedido
FROM pedido AS p
INNER JOIN cliente AS c
    ON c.id_cliente = p.id_cliente;
```[cite: 6, 18]

**7. Consulte somente pedidos FINALIZADOS pela view.**
```sql
SELECT *
FROM vw_pedidos_clientes
WHERE status_pedido = 'FINALIZADO';
```[cite: 6]

**8. Crie uma view com pedido, produto, quantidade, preço unitário e subtotal.**
```sql
CREATE VIEW vw_itens_pedidos AS
SELECT
    pe.id_pedido,
    pe.data_pedido,
    c.nome AS cliente,
    pr.nome AS produto,
    ip.quantidade,
    ip.preco_unitario,
    (ip.quantidade * ip.preco_unitario) AS subtotal
FROM pedido AS pe
INNER JOIN cliente AS c
    ON c.id_cliente = pe.id_cliente
INNER JOIN item_pedido AS ip
    ON ip.id_pedido = pe.id_pedido
INNER JOIN produto AS pr
    ON pr.id_produto = ip.id_produto;
```[cite: 7]

---

### **Parte C: Relatórios (Intermediário / Avançado)**

**9. Crie `vw_vendas_por_produto` com `SUM` e `GROUP BY`.**
```sql
CREATE VIEW vw_vendas_por_produto AS
SELECT
    pr.id_produto,
    pr.nome AS produto,
    SUM(ip.quantidade) AS unidades_vendidas,
    SUM(ip.quantidade * ip.preco_unitario) AS faturamento
FROM produto AS pr
INNER JOIN item_pedido AS ip
    ON ip.id_produto = pr.id_produto
INNER JOIN pedido AS pe
    ON pe.id_pedido = ip.id_pedido
WHERE pe.status_pedido = 'FINALIZADO'
GROUP BY pr.id_produto, pr.nome;
```[cite: 8]

**10. Liste os produtos pelo maior faturamento.**
```sql
SELECT *
FROM vw_vendas_por_produto
ORDER BY faturamento DESC;
```[cite: 8]

**11. Crie uma view que apresente todos os clientes e a quantidade de pedidos, inclusive zero.**
```sql
CREATE VIEW vw_clientes_resumo AS
SELECT
    c.id_cliente,
    c.nome AS cliente,
    COUNT(p.id_pedido) AS quantidade_pedidos
FROM cliente AS c
LEFT JOIN pedido AS p
    ON p.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome;
```[cite: 8, 9]

**12. Descubra, pela view anterior, clientes que nunca compraram.**
```sql
SELECT *
FROM vw_clientes_resumo
WHERE quantidade_pedidos = 0;
```[cite: 9]

---

### **Parte D: Manutenção**

**13. Use `CREATE OR REPLACE` para acrescentar `id_categoria` em uma view.**
```sql
CREATE OR REPLACE VIEW vw_produtos_ativos AS
SELECT
    id_produto,
    nome,
    preco,
    id_categoria
FROM produto
WHERE ativo = TRUE;
```[cite: 10]

**14. Crie uma view simples e teste uma atualização permitida pelo SGBD.**
```sql
-- Criação da view simples
CREATE VIEW vw_clientes_ativos AS
SELECT id_cliente, nome, email, ativo
FROM cliente
WHERE ativo = TRUE;

-- Teste de UPDATE (permitido por ser uma view sem agregações complexas)
UPDATE vw_clientes_ativos
SET nome = 'Ana Lima Silva'
WHERE id_cliente = 1;
```[cite: 12]

**15. Crie uma view de produtos ativos com `WITH CHECK OPTION` e analise seu efeito.**
```sql
CREATE OR REPLACE VIEW vw_produtos_ativos AS
SELECT
    id_produto,
    nome,
    preco,
    ativo,
    id_categoria
FROM produto
WHERE ativo = TRUE
WITH CHECK OPTION;