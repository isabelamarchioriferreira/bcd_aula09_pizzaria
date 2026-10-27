-- A) Quantas tabelas o banco de dados possui?
SHOW TABLES;

-- B) Quantos clientes cadastrados?
SELECT COUNT(*) AS total_clientes
FROM Clientes;

-- C) Quantas pizzas cadastradas?
SELECT COUNT(*) AS total_pizzas
FROM Pizzas;

-- D) Quantas pizzas o pedido nº 3 possui?
SELECT SUM(quantidade) AS total_pizzas
FROM Itens_Pedido
WHERE pedido_id = 3;

-- E) Qual o nome do cliente que fez o pedido nº 3?
SELECT c.nome
FROM Clientes c
INNER JOIN Pedidos p
ON c.cliente_id = p.cliente_id
WHERE p.pedido_id = 3;

-- F) Quais os nomes das pizzas do pedido nº 3?
SELECT pz.nome
FROM Pizzas pz
INNER JOIN Itens_Pedido ip
ON pz.pizza_id = ip.pizza_id
WHERE ip.pedido_id = 3;

-- DML - MANIPULAÇÃO DOS DADOS
-- Inserindo o cliente
INSERT INTO Clientes
(nome, logradouro, numero, bairro, referencia)
VALUES
('Gaspar Oliveira', 'Rua Lizandro Silva', 21, 'São Dimas', 'Ao lado da igrejinha');

-- Inserindo o telefone
INSERT INTO Telefones(cliente_id, telefone)
VALUES
(
    (SELECT cliente_id
     FROM Clientes
     WHERE nome = 'Gaspar Oliveira'),
    '19 99898-1141'
);

-- Primeiro pedido
INSERT INTO Pedidos(cliente_id, data, hora)
VALUES
(
    (SELECT cliente_id
     FROM Clientes
     WHERE nome = 'Gaspar Oliveira'),
    CURDATE(),
    CURTIME()
);

-- Pizza Margherita
INSERT INTO Itens_Pedido
(pedido_id, pizza_id, quantidade, valor)
VALUES
(
    (SELECT MAX(pedido_id) FROM Pedidos),
    (SELECT pizza_id FROM Pizzas WHERE nome='Margherita'),
    1,
    (SELECT valor FROM Pizzas WHERE nome='Margherita')
);

-- Pizza Napolitana
INSERT INTO Itens_Pedido
(pedido_id, pizza_id, quantidade, valor)
VALUES
(
    (SELECT MAX(pedido_id) FROM Pedidos),
    (SELECT pizza_id FROM Pizzas WHERE nome='Napolitana'),
    2,
    (SELECT valor FROM Pizzas WHERE nome='Napolitana')
);

-- Inserindo nova pizza no cardápio
INSERT INTO Pizzas
(nome, descricao, valor)
VALUES
(
    'A moda do chef',
    'Molho de tomate, palmito macio em rodelas, coberto com catupiry, frango desfiado, ovos, carne seca, oregano e azeitonas',
    41.90
);

-- Novo pedido de Gaspar
INSERT INTO Pedidos(cliente_id, data, hora)
VALUES
(
    (SELECT cliente_id
     FROM Clientes
     WHERE nome='Gaspar Oliveira'),
    CURDATE(),
    CURTIME()
);

-- Duas pizzas A moda do chef
INSERT INTO Itens_Pedido
(pedido_id, pizza_id, quantidade, valor)
VALUES
(
    (SELECT MAX(pedido_id) FROM Pedidos),
    (SELECT pizza_id FROM Pizzas WHERE nome='A moda do chef'),
    2,
    (SELECT valor FROM Pizzas WHERE nome='A moda do chef')
);

-- Alterando para 3 pizzas
UPDATE Itens_Pedido
SET quantidade = 3
WHERE pedido_id = (SELECT MAX(pedido_id) FROM Pedidos)
AND pizza_id = (
    SELECT pizza_id
    FROM Pizzas
    WHERE nome='A moda do chef'
);

-- Acrescentando uma Margherita
INSERT INTO Itens_Pedido
(pedido_id, pizza_id, quantidade, valor)
VALUES
(
    (SELECT MAX(pedido_id) FROM Pedidos),
    (SELECT pizza_id FROM Pizzas WHERE nome='Margherita'),
    1,
    (SELECT valor FROM Pizzas WHERE nome='Margherita')
);