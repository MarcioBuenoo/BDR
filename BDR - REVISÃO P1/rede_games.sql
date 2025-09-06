-- Criação do BD e das tabelas

CREATE DATABASE rede_games;

CREATE TABLE loja (id_loja SERIAL PRIMARY KEY, nome VARCHAR(50),  cidade VARCHAR(50));

CREATE TABLE jogo (id_jogo SERIAL PRIMARY KEY, titulo VARCHAR(50),
                     ano_lancamento DATE, genero VARCHAR(50));

CREATE TABLE cliente (id_cliente SERIAL PRIMARY KEY, nome VARCHAR(50),
                         email VARCHAR(50) UNIQUE, cidade VARCHAR(50));

CREATE TABLE compra (id_compra SERIAL PRIMARY KEY, data_compra DATE, 
                        id_cliente SERIAL REFERENCES cliente(id_cliente),
                        id_loja SERIAL REFERENCES loja(id_loja));

CREATE TABLE compra_jogo (id_compra SERIAL REFERENCES compra(id_compra),
                            id_jogo SERIAL REFERENCES jogo(id_jogo),
                            quantidade INT);

-- Inserção de dados

INSERT INTO loja (id_loja, nome, cidade) VALUES 
(1, 'Games', 'Jacareí'),
(2, 'Flow Games', 'Indaiatuba'),
(3, 'Terabyte', 'Guaraparí');

INSERT INTO cliente (id_cliente, nome, email, cidade) VALUES
(1, 'Cristiano', 'cris@gmail.com', 'São José dos Campos'),
(2, 'Roger', 'rogersilva@gmail.com', 'Santa Branca'),
(3, 'Carlos', 'doutorSUS@gmail.com', 'Itu');

INSERT INTO jogo (id_jogo, titulo, ano_lancamento, genero) VALUES
(1, 'Hollow Knight', '2017-02-24', 'MetroidVania'),
(2, 'Hollow Knight: Silksong', '2025-09-04', 'MetroidVanis'),
(3, 'For Honor', '2016-09-15', 'Medieval');

INSERT INTO compra (id_compra, data_compra, id_cliente, id_loja) VALUES
(1, '2025-08-23', 2, 1),
(2, '2025-09-05', 1, 3);

INSERT INTO compra_jogo (id_compra, id_jogo, quantidade) VALUES
(1, 3, 2),
(2, 2, 1);

-- Consultas

SELECT * FROM cliente;

SELECT titulo, ano_lancamento FROM jogo WHERE ano_lancamento > '2020-12-31';

SELECT SUM(quantidade) AS total_jogos_comprados
FROM compra_jogo;