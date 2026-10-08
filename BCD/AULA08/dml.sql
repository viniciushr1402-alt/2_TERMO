-- Active: 1788435082238@@127.0.0.1@3306@smartcoffe_dml_vini

-- DQL - DATA QUERY LANGUAGE

-- ANTES DE INICIAR

INSERT INTO cliente (nome, email, telefone, cidade, ativo) VALUES ('Ana Flavia', 'anaf@gmail.com','199984512456','Campinas',TRUE);

-- EX 1: SELECT SIMPLES OU CONSULTA SIMPLES
-- ESTRUTURA SELECT COMO EXEMPLO
-- SELECT FROM tabela;

SELECT * 
FROM cliente;


-- CONSULTAR TODAS AS COLUNAS

SELECT nome, telefone
FROM cliente;

-- consultar colunas ou campos

-- Ex 2: AS COM AS COMO APELIDO AS COLUNAS

SELECT nome AS Nome_Cliente
FRom cliente;

SELECT email AS Email_Cliente, telefone AS Zap
FROM cliente;

-- Ex 3: DISTINC - 

SELECT DISTINCT cidade
FROM cliente;

-- SEM DISTINCT O RESULTADO IRA SE REPETIR VARIAS VEZES E COM SO UMA VEZ

-- EX 4: WHERE - FILTRO POR REGISTROS
-- IREMOS DEFINIR CONDIÇOES
-- = IGUAL
-- <> ou != DIFERENTE
-- > MAIOR QUE
-- >= MAIOR OU IGUAL
-- < MENOR QUE
-- <= MENOR IGUAL

SELECT nome, preco
FROM produto
WHERE preco > 10.00;
-- CONSULTA PARA VALORES ACIMA DE 10.00 REAIS

SELECT nome, ativo
FROM cliente
WHERE ativo = TRUE;
-- CONSULTA STATUS DE CLIENTES SE ESTÁ ATIVO OU INATIVO

SELECT id_pedido, data_pedido, valor_total
FROM pedido
WHERE valor_total > 25.00;
-- CONSULTA PEDIDOS ACIMA DE DETERMINADO VALOR

-- EX 5: USO DO AND, OR E NOT

-- AND TODAS AS CONDIÇOES VERDADEIRAS

SELECT nome, preco
FROM produto
WHERE preco >= 8.00 AND preco <=25.00;
-- OR PELO MENOS UMA CONDIÇÃO VERDADEIRA
SELECT nome, cidade 
FROM cliente
WHERE cidade = 'Limeira' OR cidade = 'Piracicaba'

-- not nao ira buscar ou consultar o valor desejado
SELECT nome, cidade
FROM cliente
WHERE NOT cidade = 'Limeira';

-- EXTRA - UTILIZANDO AND E OR JUNTOOS SEPARAR POR ()

SELECT nome, cidade, ativo
FROM cliente
WHERE ativo = TRUE
AND (cidade = 'Limeira' OR cidade = 'Piracicaba');

-- ex 6: BETWEEN - ENTRE DOIS VALORES
-- LIMITE INICIAL E FINAL

SELECT nome, preco
From produto 
WHERE preco BETWEEN 8.00 AND 15.00;

-- VALORES ENTRE 8 E 15

SELECT id_pedido, data_pedido, valor_total
FROM pedido
WHERE data_pedido BETWEEN '2036-09-01 00:00:00' AND '2026-09-30 23:59:00'
-- CONSULTA POR DATAS

-- EX 7: IN VARIAS POSSIBILIDADES
SELECT nome, cidade
FROM cliente
WHERE cidade IN ('Limeira','Campinas','Americana','Piracicaba')
-- CONSULTA COM VARIAS CONDIÇOES E DIMINUINDO O USO DO OR

SELECT nome, cidade
FROM cliente
WHERE cidade NOT IN ('Limeira','Piracicaba');

-- CONSULTA COM EXESSÃO DOS VALORES ESPECIFICADOS

-- EX 8; LIKE - PESQUISAR POR TEXTOS
-- CORINGAS 
-- % VÁRIOS CARACTERES
-- _ EXATAMENTE UM CHARACTER

SELECT nome
FROM produto
WHERE nome LIKE 'Café%'

-- CONSULTA COM TODOS OS PRODUTOS QUE TENHAM A MESMA PALAVRA

SELECT nome 
FROM produto
WHERE nome LIKE '%chocolate%'
-- CONSULTA TODOS OS PRODUTOS QUE POSSUAM A PALAVRA DESEJADA

SELECT nome  
FROM cliente   
WHERE nome LIKE '%Silva'
-- CONSULTA CLIENTES QUE TERMINAM COM A PALAVRA DESEJADA

SELECT nome
FROM cliente  
WHERE nome LIKE '%Si_va';

-- CONSULTA ESPECIFICAMENTE O CARACTER QUE NÃO SE LEMBRA

-- NULL -- AUSENCIA DE VALORES


-- EX 9: NULL - AUSENCIA DE VALORES
SELECT nome, telefone
FROM cliente 
WHERE telefone IS NULL;
-- CONSULTA CAMPOS QUE POSSUEM O NULL
SELECT nome, telefone
FROM cliente
WHERE telefone IS NOT NULL;
-- CONSULTA CAMPOS QUE NAO SAO MAIS NULL

-- EX 10: ORDER BY - ORDENANDO RESULTADOS
-- ASC CRESCENTE 
-- DESC DECRESCENTE

SELECT nome, preco   
FROM produto
ORDER BY preco ASC;

-- FORMA CRESCENTE


SELECT nome, preco   
FROM produto
ORDER BY preco DESC;

-- FORMA DECRESCENTE

SELECT cidade, nome 
FROM cliente
ORDER BY cidade ASC, nome DESC;

-- CONSULTA POR MAIS DE UMA COLUNA


-- EX 11: LIMIT - LIMITAR QUANTIDADE DE LINHAS

SELECT nome, preco     
FROM produto
ORDER BY preco DESC
LIMIT 10;

-- CONSULTAR APENAS UMA QUANTIDADE ESPECIFICA DE LINHAS

SELECT nome, preco    
FROM produto
ORDER BY nome
LIMIT 5 OFFSET 5;

-- CONSULTAR COM LIMITE DE VALORWS E LINHAS 

-- EX 12; CALCULO DE COLUNAS
 SELECT nome, preco, preco * 1.10 AS preco_ajustado
FROM produto;

SELECT id_item, quantidade, preco_unitario, quantidade * preco_unitario AS Sub_total
FROM item_pedido;

-- EX 13: FUNÇÕES PARA CONSULTAS
-- TEXTOS

SELECT UPPER(nome) AS Nome_Cliente, LOWER(email) AS Email_Cliente
FROM cliente;

SELECT CONCAT(nome, '---', cidade) AS Cidade_Clientes
FROM cliente;
-- CONCAT concatenação de valores

-- NUMEROS
SELECT nome, preco, ROUND(preco * 0.90, 2) AS Preco_Desconto
FROM produto;

-- DATAS 
SELECT id_pedido, data_pedido, DATE(data_pedido) AS Datas, MONTH (data_pedido) AS Mês, YEAR(data_pedido) AS Ano, DAY (data_pedido) as dia, TIME(data_pedido) as horario 
FROM pedido;

-- COALESCE - SUBSTITUIR A INFORMAÇÃO QUE DEIXAMOS EM NULL OU NÃO DEIXAMOS
SELECT nome, COALESCE(telefone, 'Não Informado') AS telefone
FROM cliente;