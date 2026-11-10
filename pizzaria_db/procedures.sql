USE pizzaria;

SELECT valor
FROM pizzas
WHERE pizza_id = 5;

SELECT valor
FROM pizzas
WHERE pizza_id = 28;

INSERT INTO pedidos
VALUES
(
DEFAULT,
98,
CURDATE(),
NOW(),
NULL
);

SELECT *
FROM pedidos
ORDER BY pedido_id DESC
LIMIT 1;

SELECT LAST_INSERT_ID();

INSERT INTO itens_pedido
VALUES
(
28,
5,
1,
(SELECT valor FROM pizzas WHERE pizza_id = 5)
),
(
28,
28,
2,
(SELECT valor FROM pizzas WHERE pizza_id = 28)
);

SELECT *
FROM itens_pedido
WHERE pedido_id = 28;

SELECT SUM(valor * quantidade)
FROM itens_pedido
WHERE pedido_id = 28;

UPDATE pedidos
SET valor =
(
SELECT SUM(valor * quantidade)
FROM itens_pedido
WHERE pedido_id = 28
)
WHERE pedido_id = 28;

SELECT *
FROM pedidos
WHERE pedido_id = 28;

DROP PROCEDURE IF EXISTS atulizaValorPedido;

CREATE PROCEDURE atulizaValorPedido(id INT)
UPDATE pedidos
SET valor =
(
SELECT SUM(valor * quantidade)
FROM itens_pedido
WHERE pedido_id = id
)
WHERE pedido_id = id;

SELECT *
FROM pedidos
WHERE pedido_id = 28;

UPDATE pedidos
SET valor = NULL
WHERE pedido_id = 28;

SELECT *
FROM pedidos
WHERE pedido_id = 28;

CALL atulizaValorPedido(28);

SELECT *
FROM pedidos
WHERE pedido_id = 28;

SHOW PROCEDURE STATUS;

SELECT *
FROM clientes;

SELECT *
FROM pizzas;

INSERT INTO pedidos
VALUES
(
DEFAULT,
91,
CURDATE(),
NOW(),
NULL
);

INSERT INTO itens_pedido
VALUES
(
29,
28,
2,
(SELECT valor FROM pizzas WHERE pizza_id = 28)
);

SELECT *
FROM pedidos
WHERE pedido_id = 29;

CALL atulizaValorPedido(29);

SELECT *
FROM pedidos
WHERE pedido_id = 29;

DROP PROCEDURE IF EXISTS pedidoDeUmItem;

DELIMITER //

CREATE PROCEDURE pedidoDeUmItem(
    cli_id INT,
    piz_id INT,
    qtd INT
)
BEGIN

    INSERT INTO pedidos
    VALUES
    (
        DEFAULT,
        cli_id,
        CURDATE(),
        NOW(),
        NULL
    );

    INSERT INTO itens_pedido
    VALUES
    (
        LAST_INSERT_ID(),
        piz_id,
        qtd,
        (SELECT valor FROM pizzas WHERE pizza_id = piz_id)
    );

    CALL atulizaValorPedido(LAST_INSERT_ID());

END//

DELIMITER ;