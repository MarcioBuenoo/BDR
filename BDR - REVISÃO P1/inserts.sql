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