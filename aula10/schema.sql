
-- 1. Listar quantos livros cada autor possui (BD Biblioteca)
SELECT a.nome AS autor, COUNT(l.id_livro) AS total_livros
FROM autor a
INNER JOIN livro l ON a.id_autor = l.id_autor
GROUP BY a.nome;

-- 2. Mostrar a média de páginas dos livros por editora (BD Biblioteca)
SELECT e.nome AS editora, AVG(l.numero_paginas) AS media_paginas
FROM editora e
INNER JOIN livro l ON l.id_editora = e.id_editora
GROUP BY e.nome;

-- 3. Listar o total de campanhas por reservatório (limnologia_db)
SELECT r.nome AS reservatorio, COUNT(c.id_campanha) AS total_campanhas
FROM reservatorio r
INNER JOIN campanha c ON r.id_reservatorio = c.id_reservatorio
GROUP BY r.nome;


-- 4. Mostrar a média de valores de cada parâmetro em séries temporais (limnologia_db)
SELECT p.nome AS parametro, AVG(s.valor) AS media_valor
FROM parametro p
INNER JOIN serie_temporal s ON p.id_parametro = s.id_parametro
GROUP BY p.nome;


-- 5. Exibir apenas as instituições que realizaram mais de 3 campanhas (limnologia_db)
SELECT i.nome AS instituicao, COUNT(c.id_campanha) AS total_campanhas
FROM instituicao i
INNER JOIN campanha c ON i.id_instituicao = c.id_instituicao
GROUP BY i.nome
HAVING COUNT(c.id_campanha) > 3;
