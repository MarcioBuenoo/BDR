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