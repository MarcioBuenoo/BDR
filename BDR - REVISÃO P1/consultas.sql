-- Consultas

SELECT * FROM cliente;

SELECT titulo, ano_lancamento FROM jogo WHERE ano_lancamento > '2020-12-31';

SELECT SUM(quantidade) AS total_jogos_comprados
FROM compra_jogo;