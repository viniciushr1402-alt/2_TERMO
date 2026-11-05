-- -- Active: 1788435082238@@127.0.0.1@3306@smartcoffe_dml_vini
-- Views e visões - transformar determinadas consultas em visoes retulizave

-- Como posso disponibilizar uma consulta como se ela fosse uma tabela?
-- reposta: VIEW

-- Ex 1: View - como consultar uma visão logíca

CREATE VIEW ww_produtos_ativos AS SELECT id_produto, nome, preco
FROM produto
Where ativo = TRUE;

-- VISUALIZAR A CONSULTA ATRAVES DA VIEW
SELECT * FROM ww_produtos_ativos;

-- OBS: A View guarda a definição da consulta. Em uma view comunm os dados continuam pertencendo as tabelas de origem.

-- TABELA : ARMAZENA REGISTROS
-- VIEW : RERESENTA A LOGICA E O RESULTADO DA CONSULTA.

-- POR QUE UTILIZAR?
-- POR QUE O DESEJO SIMPLIFICAR A MINHA CONSULTA
-- REUTILIZAR LOGICA ONDE A CONSULTA GANHA UM NOME
-- PADRONIZAÇÃO DE RELATORIOS 
-- RESTRIÇÃO DE EXPOSICÃO LOGÍCA

-- RESUMO 1: 
-- UMA CONSULTA ORIGINAL OU INICIAL

SELECT id_produto, nome, preco
FROM produto
WHERE ativo = TRUE;

-- TRANSFORMAR EM UMA VIEW
CREATE VIEW ww_produtos_ativos AS SELECT id_produto, nome, preco
FROM produto
Where ativo = TRUE;

-- COMO UTILIZAR:
SELECT * FROM ww_produtos_ativos;

-- EX 2 : UTILIZAR FILTROS NAS VIEWS
SELECT id_produto, nome, preco  
From produto
WHERE preco >= 10.00
ORDER BY preco DESC;

SELECT * FROM ww_produtos_ativos
WHERE preco >= 10.00
ORDER BY preco DESC;
-- obs: VIEW NÃO ELIMINA A POSSIBILIDADE DE USAR WHERE, ORDER BY E OURAS CLAÚSULAS

-- EX 3: VIEW COM JOINS - MOSTRAR PRODUTOS E CATEGORIAS

SELECT p.id_produto, p.nome AS produto, ca.nome AS categorias, p.preco 
FROM  produto AS p  
INNER JOIN categoria as ca  
ON ca.id_categoria = p.id_categoria;

-- CRIANDO VIEW
CREATE VIEW ww_produtos_categoria AS 
SELECT p.id_produto, p.nome AS produto, ca.nome AS categorias, p.preco 
FROM  produto AS p  
INNER JOIN categoria as ca  
ON ca.id_categoria = p.id_categoria;

-- RESULTADO VISULA POR VIEW

SELECT * FROM ww_produtos_categoria
ORDER BY categorias, produto;

-- EX 4: VIEW com varias abelas - Relatorio 

CREATE VIEW ww_pedidos_clientes AS
SELECT p.id_pedido, p.data_pedido, p.status_pedido , c.id_cliente, c.nome AS cliente
FROM pedido AS p  
INNER JOIN cliente AS c
ON c.id_cliente = p.id_cliente;


-- APAGAR VIEW
DROP VIEW ww_pedidos_clientes;

-- RESULTADO 
SELECT * FROM ww_
WHERE status = 'ABERTO';

-- EX 5: VIEW para um relatório completo de itens do pedido
CREATE VIEW ww_itens_pedidos AS
SELECT 
    pe.id_pedido, 
    pe.data_pedido, 
    c.nome AS Cliente, 
    pr.nome AS Produto, 
    ip.quantidade, 
    ip.preco_unitario, 
    (ip.quantidade * ip.preco_unitario) AS Subtotal
FROM pedido AS pe
INNER JOIN cliente AS c ON c.id_cliente = pe.id_cliente
INNER JOIN item_pedido AS ip ON ip.id_pedido = pe.id_pedido
INNER JOIN produto AS pr ON pr.id_produto = ip.id_produto;

-- RESULTADO 
 SELECT * FROM ww_itens_pedidos
where id_pedido = 3;

-- EX 6: VIEW COM FUNÇÕES DE AGREGAÇÃO
CREATE VIEW ww_vendas_por_produto AS
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
-- SUM() é uma função de agregação utilizada para calcular a soma total dos valores de uma coluna numérica.

-- RESULTADO : CONSULTA GERENCIAL

SELECT * FROM ww_vendas_por_produto
ORDER BY faturamento DESC;

-- EX 7 : VIEW COM LEFT JOIN - QUEREMOS TODOS OS CLIENTES INCLUISVE QUEM NUNCA REALIZOU PEDIDOS

CREATE VIEW ww_clientes_resumo AS
SELECT
    c.id_cliente,
    c.nome AS cliente,
    COUNT(p.id_pedido) AS quantidade_pedidos
FROM cliente AS c
LEFT JOIN pedido AS p
    ON p.id_cliente = c.id_cliente
GROUP BY c.id_cliente, c.nome;

-- RESULTADO 
SELECT * FROM ww_clientes_resumo
WHERE quantidade_pedidos = 0;

-- EX 8 : NOMENADO VIEWS
-- ALIASES TORNAM AS VIEWS MAIS CLARAS

CREATE VIEW ww_preco_produtos AS
SELECT id_produto, nome AS produto, preco AS preco_atual
FROM produto;

SELECT * FROM ww_preco_produtos;

-- EX 9: VISUALIZAR AS VIEWS EXISTENTES
-- VISUALIZAR O RESULTADO DE TODAS AS VIEWS CRIADAS 

SHOW FULL TABLES WHERE TABLE_TYPE = 'VIEW';

-- PODEMOS CONSULTAR O CATALOGO 
-- QUER DIZER TODO O BD MYSQL

SELECT TABLE_NAME FROM information_schema.VIEWS
WHERE `TABLE_SCHEMA` = DATABASE();

-- EX 10: VISUALIZANDO DEFINIÇÕES 

SHOW CREATE VIEW ww_produtos_categoria;

-- EX 11: CREATE OR REPLACE VIEW
CREATE OR REPLACE VIEW ww_produto_ativos AS
SELECT id_produto, nome, preco, id_categoria
FROM produto
WHERE ativo = TRUE;
-- Obs: Irá substituir ou alterar uma view ja criada com suas informações

-- EX 12: VIEW ATUALIZÁVEL
CREATE VIEW vw_clientes_ativos AS
SELECT id_cliente, nome, email, ativo
FROM cliente
WHERE ativo = TRUE;

-- Atualizar a tabela Cliente
UPDATE vw_clientes_ativos
SET nome = 'Ana Francis'
WHERE id_cliente = 2;

-- EX 13: VIEW NÃO ATUALIZÁVEL
UPDATE ww_vendas_por_produto
SET Faturamento = 1000
WHERE id_produto = 1;

-- Obs: O campo é calculado. Simplesmente não é possível receber 1000.

-- EX 14: WITH CHECK OPTION - VIEW QUE MOSTRA APENAS PRODUTOS ATIVOS
CREATE OR REPLACE VIEW ww_produtos_ativos AS
SELECT id_produto, nome, preco, ativo, id_categoria
FROM produto
WHERE ativo = TRUE
WITH CHECK OPTION;

SELECT * FROM ww_produtos_ativos
-- Obs: O With Check Option ajuda a impedir alterações incorretas

-- EX 15: PADRÃO DEFINIÇÃO DE NOMENCLATURA
-- vw - views
-- nome - complementar a tabela ou consultar que deseja realizar.
-- vw_nome_desejo
-- vw_nome_da_finalidade
-- vw_produtos_ativos

-- APAGAR VIEWS
