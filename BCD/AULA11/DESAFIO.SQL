-- Active: 1788435082238@@127.0.0.1@3308@smartcoffee_procedures_vini


-- 1. listar_clientes_ativos()

USE smartcoffee_procedures_vini;

DELIMITER $$
CREATE PROCEDURE listar_clientes_ativos()
BEGIN
    SELECT id_cliente, nome, email, telefone
    FROM cliente
    WHERE ativo = TRUE
    ORDER BY nome;
END $$
DELIMITER ;


CALL listar_clientes_ativos();

-- 2. buscar_produto_por_nome(IN p_busca VARCHAR(100))

DROP PROCEDURE IF EXISTS buscar_produto_por_nome;

DELIMITER $$
CREATE PROCEDURE buscar_produto_por_nome(IN p_busca VARCHAR(100))
BEGIN
    SELECT id_produto, nome, preco
    FROM produto
    WHERE nome LIKE CONCAT('%', p_busca, '%')
      AND ativo = TRUE
    ORDER BY nome;
END $$
DELIMITER ;

CALL buscar_produto_por_nome('Café');

-- 3. produtos_por_categoria(IN p_id_categoria INT)

DROP PROCEDURE IF EXISTS produtos_por_categoria;

DELIMITER $$
CREATE PROCEDURE produtos_por_categoria(
    IN p_id_categoria INT
)
BEGIN
    SELECT id_produto, nome, preco
    FROM produto
    WHERE id_categoria = p_id_categoria
      AND ativo = TRUE
      ORDER BY nome;


      END $$

      DELIMITER;

CALL produtos_por_categoria(1);

-- 4. total_clientes(OUT p_total INT)

DELIMITER $$
CREATE PROCEDURE total_clientes(
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*)
    INTO p_total
    FROM cliente
    WHERE ativo = TRUE;
END $$
DELIMITER ;

CALL total_clientes(@total_clientes);
SELECT @total_clientes AS total_clientes_ativos;


-- 5. consultar_estoque(IN p_id_produto INT) usando variável local

DELIMITER $$
CREATE PROCEDURE consultar_estoque(
    IN p_id_produto INT
)
BEGIN
    DECLARE v_quantidade INT;

    SELECT quantidade
    INTO v_quantidade
    FROM estoque
    WHERE id_produto = p_id_produto;

    SELECT p_id_produto AS id_produto, v_quantidade AS quantidade_estoque;
END $$
DELIMITER ;

-- 6. classificar estoque: 0 SEM ESTOQUE / <=5 BAIXO / >5 NORMAL

DROP PROCEDURE IF EXISTS classificar_estoque;

DELIMITER $$
CREATE PROCEDURE classificar_estoque(
    IN p_id_produto INT
)
BEGIN
    DECLARE v_quantidade INT;

    SELECT quantidade
    INTO v_quantidade
    FROM estoque
    WHERE id_produto = p_id_produto;

    IF v_quantidade = 0 THEN
        SELECT 'SEM ESTOQUE' AS situacao;
    ELSEIF v_quantidade <= 5 THEN
        SELECT 'BAIXO' AS situacao;
    ELSE
        SELECT 'NORMAL' AS situacao;
    END IF;
END $$
DELIMITER ;

CALL classificar_estoque(1);


-- 7. cadastrar_cliente(...) com três parâmetros IN

DROP PROCEDURE IF EXISTS cadastrar_cliente;

DELIMITER $$
CREATE PROCEDURE cadastrar_cliente(
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(120),
    IN p_telefone VARCHAR(20)
)
BEGIN
    INSERT INTO cliente (nome, email, telefone, ativo)
    VALUES (p_nome, p_email, p_telefone, TRUE);
END $$
DELIMITER ;


CALL cadastrar_cliente('Carlos Lima', 'carlos.lima@email.com', '19988887777');


-- 8. alterar_preco(...) impedindo valor <= 0

DROP PROCEDURE IF EXISTS alterar_preco;

DELIMITER $$
CREATE PROCEDURE alterar_preco(
    IN p_id_produto INT,
    IN p_novo_preco DECIMAL(10,2)
)
BEGIN
    IF p_novo_preco > 0 THEN
        UPDATE produto
        SET preco = p_novo_preco
        WHERE id_produto = p_id_produto;

        SELECT 'PREÇO ATUALIZADO COM SUCESSO' AS mensagem;
    ELSE
        SELECT 'ERRO: O PREÇO DEVE SER MAIOR QUE ZERO' AS mensagem;
    END IF;

    END $$

    -- 9. criar_pedido(IN p_id_cliente INT, OUT p_id_pedido INT)

DROP PROCEDURE IF EXISTS criar_pedido;

DELIMITER $$
CREATE PROCEDURE criar_pedido(
    IN p_id_cliente INT,
    OUT p_id_pedido INT
)
BEGIN
    START TRANSACTION;

    INSERT INTO pedido (id_cliente, data_pedido, status_pedido)
    VALUES (p_id_cliente, NOW(), 'ABERTO');

    SET p_id_pedido = LAST_INSERT_ID();

    COMMIT;
END $$
DELIMITER ;

CALL criar_pedido(1, @novo_pedido);
SELECT @novo_pedido AS id_pedido_criado;

-- 11. adicionar_item_pedido(...) buscando o preço atual

DROP PROCEDURE IF EXISTS adicionar_item_pedido;

DELIMITER $$
CREATE PROCEDURE adicionar_item_pedido(
    IN p_id_pedido INT,
    IN p_id_produto INT,
    IN p_quantidade INT
)
BEGIN
    DECLARE v_preco DECIMAL(10,2);

    IF p_quantidade <= 0 THEN
        SELECT 'QUANTIDADE INVÁLIDA' AS mensagem;
    ELSE
        SELECT preco
        INTO v_preco
        FROM produto
        WHERE id_produto = p_id_produto
          AND ativo = TRUE;

        IF v_preco IS NULL THEN
            SELECT 'PRODUTO INEXISTENTE OU INATIVO' AS mensagem;
        ELSE
            INSERT INTO item_pedido (id_pedido, id_produto, quantidade, preco_unitario)
            VALUES (p_id_pedido, p_id_produto, p_quantidade, v_preco);

            SELECT 'ITEM ADICIONADO' AS mensagem;
        END IF;
    END IF;
END $$
DELIMITER ;