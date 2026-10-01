CREATE DATABASE IF NOT EXISTS SMARTCOFFE_DML_VINI;
USE SMARTCOFFE_DML_VINI;

-- ==========================================
-- PARTE A — INSERT
-- ==========================================

-- Exercício 1
INSERT IGNORE INTO cliente (nome, email, telefone, cidade, ativo) VALUES 
('Carlos Silva', 'carlos.vini@email.com', '19988887777', 'Limeira', TRUE),
('Ana Souza', 'ana.vini@email.com', '19977776666', 'Campinas', TRUE);

-- Exercício 2
INSERT IGNORE INTO categoria (nome) VALUES 
('House Specials');

-- Busca o ID da categoria de forma segura (evita o erro de Foreign Key)
SET @id_cat_especiais = (SELECT id_categoria FROM categoria WHERE nome = 'House Specials');

-- Exercício 3
INSERT INTO produto (nome, preco, ativo, id_categoria) VALUES 
('Special Nutella Coffee', 15.00, TRUE, @id_cat_especiais),
('Cappuccino Doce de Leite', 16.50, TRUE, @id_cat_especiais),
('Torta de Maçã da Casa', 18.00, TRUE, @id_cat_especiais);

SET @id_prod1 = (SELECT id_produto FROM produto WHERE nome = 'Special Nutella Coffee' ORDER BY id_produto DESC LIMIT 1);
SET @id_prod2 = (SELECT id_produto FROM produto WHERE nome = 'Cappuccino Doce de Leite' ORDER BY id_produto DESC LIMIT 1);

-- Exercício 4
INSERT IGNORE INTO cliente (nome, email, telefone, cidade, ativo) VALUES 
('Fernanda Lima', 'fernanda.vini@email.com', NULL, 'Limeira', TRUE);

-- Exercício 5
SET @id_carlos = (SELECT id_cliente FROM cliente WHERE email = 'carlos.vini@email.com');

INSERT INTO pedido (data_pedido, status_pedido, valor_total, id_cliente) VALUES 
(NOW(), 'ABERTO', 0.00, @id_carlos);

SET @id_novo_pedido = LAST_INSERT_ID();

-- Exercício 6
INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario, observacao) VALUES 
(@id_novo_pedido, @id_prod1, 1, 15.00, 'Sem açúcar'),
(@id_novo_pedido, @id_prod2, 2, 16.50, 'Extra quente');


-- ==========================================
-- PARTE B — UPDATE
-- ==========================================

-- Exercício 7
UPDATE cliente 
SET telefone = '19988889999' 
WHERE email = 'carlos.vini@email.com';

-- Exercício 8
UPDATE cliente 
SET cidade = 'Piracicaba', telefone = '19977770000' 
WHERE email = 'ana.vini@email.com';

-- Exercício 9
UPDATE produto 
SET preco = preco * 1.08 
WHERE id_categoria = @id_cat_especiais;

-- Exercício 10
UPDATE pedido 
SET status_pedido = 'PREPARANDO' 
WHERE id_pedido = @id_novo_pedido;

-- Exercício 11
UPDATE pedido 
SET valor_total = (
    SELECT SUM(quantidade * preco_unitario) 
    FROM item_pedido 
    WHERE id_pedido = @id_novo_pedido
) 
WHERE id_pedido = @id_novo_pedido;

-- Exercício 12
UPDATE produto 
SET ativo = FALSE 
WHERE id_produto = @id_prod1;


-- ==========================================
-- PARTE C — DELETE
-- ==========================================

-- Exercício 13
INSERT IGNORE INTO cliente (nome, email, telefone, cidade, ativo) VALUES 
('Cliente Teste', 'cliente.teste@email.com', '19900000000', 'Limeira', TRUE);

DELETE FROM cliente 
WHERE email = 'cliente.teste@email.com';

-- Exercício 14
-- DELETE FROM cliente WHERE id_cliente = @id_carlos;
-- Resultado: Erro de FK (Cannot delete or update a parent row).

-- Exercício 15
-- Explicação: A FK impede a exclusão de clientes com pedidos vinculados, mantendo a integridade do banco.

-- Exercício 16
INSERT IGNORE INTO categoria (nome) VALUES 
('Categoria Temp Teste');

DELETE FROM categoria 
WHERE nome = 'Categoria Temp Teste';



-- 12. Escolha um dos produtos criados e faça uma exclusão lógica (ativo = FALSE).

-- SELECT * FROM produto WHERE nome='Croissant Especial';

-- UPDATE produto SET ativo=FALSE WHERE nome='Croissant Especial';

-- SELECT * FROM produto WHERE nome='Croissant Especial';


-- -- PARTE C - DELETE

-- -- 13. Crie um cliente de teste sem pedidos.
-- --     Depois localize e exclua apenas esse cliente.

-- INSERT INTO cliente (nome,email,cidade)
-- VALUES ('Cliente Temporário','temporario.a09@email.com','Limeira');

-- SELECT * FROM cliente WHERE email='temporario.a09@email.com';

-- DELETE FROM cliente WHERE email='temporario.a09@email.com';

-- SELECT * FROM cliente WHERE email='temporario.a09@email.com';