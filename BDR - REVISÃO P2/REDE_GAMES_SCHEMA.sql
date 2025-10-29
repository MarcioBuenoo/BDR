-- Ex 01 - Criação do Banco --
CREATE DATABASE rede_games;

-- Ex 02 - Criação das tabelas --
CREATE TABLE fabricante (
 id_fabricante SERIAL PRIMARY KEY,
 nome_fabricante VARCHAR(100) NOT NULL,
 pais VARCHAR(50)
);

CREATE TABLE produto (
 id_produto SERIAL PRIMARY KEY,
 nome VARCHAR(120) NOT NULL,
 preco NUMERIC(10,2) NOT NULL CHECK (preco > 0),
 id_fabricante INT,
 FOREIGN KEY (id_fabricante) REFERENCES fabricante(id_fabricante)
);

CREATE TABLE loja (
 id_loja SERIAL PRIMARY KEY,
 nome_loja VARCHAR(120) NOT NULL,
 cidade VARCHAR(80) NOT NULL
);

CREATE TABLE venda (
 id_venda SERIAL PRIMARY KEY,
 id_produto INT NOT NULL,
 id_loja INT NOT NULL,
 quantidade INT NOT NULL CHECK (quantidade > 0),
 data_venda DATE NOT NULL,
 FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
 FOREIGN KEY (id_loja) REFERENCES loja(id_loja)
);

-- Ex 03 - Inserção fabricantes
INSERT INTO fabricante (nome_fabricante, pais) VALUES
('Nintendo', 'Japão'),
('Sony', 'Japão'),
('Microsoft', 'Estados Unidos'),
('Razer', 'Estados Unidos'),
('HyperX', 'Estados Unidos'),
('Logitech', 'Suíça'),
('Capcom', 'Japão');

-- Ex 04 - Inserção produtos

INSERT INTO produto (nome, preco, id_fabricante) VALUES
('Nintendo Switch OLED', 2499.90, 1),
('Joy-Con Pair', 499.90, 1),
('PlayStation 5', 4399.00, 2),
('DualSense Controller', 399.90, 2),
('Xbox Series X', 4599.90, 3),
('Xbox Wireless Controller', 349.90, 3),
('Razer Kraken Headset', 499.90, 4),
('HyperX Cloud II Headset', 649.90, 5),
('Logitech G Pro Mouse', 399.90, 6),
('Resident Evil 4 Remake', 299.90, 7),
('Street Fighter 6', 349.90, 7);

-- Ex 05 - Inserção lojas

INSERT INTO loja (nome_loja, cidade) VALUES
('Rede Games SP - Paulista', 'São Paulo'),
('Rede Games RJ - Barra', 'Rio de Janeiro'),
('Rede Games MG - BH Shopping', 'Belo Horizonte'),
('Rede Games PR - Curitiba', 'Curitiba');

-- Ex 06 - Inserção vendas

INSERT INTO venda (id_produto, id_loja, quantidade, data_venda) VALUES
(1, 1, 20, '2025-09-20'),
(2, 1, 35, '2025-09-21'),
(3, 2, 15, '2025-09-22'),
(4, 2, 40, '2025-10-01'),
(5, 3, 10, '2025-10-02')
(6, 3, 5, '2025-10-02'),
(7, 4, 12, '2025-10-05'),
(8, 4, 18, '2025-10-05'),
(9, 1, 20, '2025-10-06'),
(10, 2, 25, '2025-10-06'),
(11, 3, 30, '2025-10-07');

-- Ex 07 - JOIN
SELECT
  p.nome,
  l.nome_loja,
  v.quantidade
FROM
  venda AS v
JOIN
  produto AS p ON v.id_produto = p.id_produto
JOIN
  loja AS l ON v.id_loja = l.id_loja;

-- Ex 08 - GROUP BY

SELECT
  l.nome_loja,
  SUM(v.quantidade) AS total_vendido
FROM
  venda AS v
JOIN
  loja AS l ON v.id_loja = l.id_loja
GROUP BY
  l.nome_loja
ORDER BY
  total_vendido DESC;

-- Ex 09 - HAVING

SELECT
  l.nome_loja,
  SUM(v.quantidade) AS total_vendido
FROM
  venda AS v
JOIN
  loja AS l ON v.id_loja = l.id_loja
GROUP BY
  l.nome_loja
HAVING
  SUM(v.quantidade) > 30 
ORDER BY
  total_vendido DESC;

-- Ex 10 - Subconsultas

SELECT DISTINCT
  f.nome_fabricante
FROM
  fabricante AS f
WHERE
  EXISTS (
    SELECT 1 
    FROM
      produto AS p
    JOIN
      venda AS v ON p.id_produto = v.id_produto
    WHERE
      p.id_fabricante = f.id_fabricante
  );