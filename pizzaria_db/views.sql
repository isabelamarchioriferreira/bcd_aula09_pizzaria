SELECT *
FROM Pedidos;

SELECT p.*, c.nome
FROM Pedidos p
INNER JOIN Clientes c
ON p.cliente_id = c.cliente_id;

CREATE VIEW vw_pedidos1 AS
SELECT p.*, c.nome
FROM Pedidos p
INNER JOIN Clientes c
ON p.cliente_id = c.cliente_id;

SELECT *
FROM vw_pedidos1;