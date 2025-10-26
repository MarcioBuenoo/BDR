SELECT * FROM parametro;

-- Subconsulta do passo 1
SELECT DISTINCT st.id_reservatorio
FROM serie_temporal st
JOIN parametro p ON st.id_parametro = p.id_parametro
WHERE p.nome_parametro = 'Oxigênio Dissolvido';

 -- Subconsulta do passo 2
SELECT nome
FROM reservatorio
WHERE id_reservatorio IN (
  SELECT DISTINCT st.id_reservatorio
  FROM serie_temporal st
  JOIN parametro p ON st.id_parametro = p.id_parametro
  WHERE p.nome_parametro = 'Oxigênio Dissolvido'
);

SELECT r.nome
FROM reservatorio r
WHERE EXISTS (
  -- Esta é uma subconsulta correlacionada
  SELECT 1 
  FROM serie_temporal st
  JOIN parametro p ON st.id_parametro = p.id_parametro
  WHERE st.id_reservatorio = r.id_reservatorio -- A "correlação" acontece aqui
    AND p.nome_parametro = 'Oxigênio Dissolvido'
);

-- Subconsulta do passo 3
EXPLAIN ANALYZE
SELECT nome
FROM reservatorio
WHERE id_reservatorio IN ( ... ); 

-- Subconsulta do passo 4
EXPLAIN ANALYZE
SELECT r.nome
FROM reservatorio r
WHERE EXISTS ( ... ); 

-- Subconsulta do passo 5
-- Plano 1 (com IN)
EXPLAIN ANALYZE
SELECT nome
FROM reservatorio
WHERE id_reservatorio IN (
  SELECT st.id_reservatorio
  FROM serie_temporal st
  JOIN parametro p ON st.id_parametro = p.id_parametro
  WHERE p.nome_parametro = 'Oxigênio Dissolvido'
);

-- Plano 2 (com EXISTS)
EXPLAIN ANALYZE
SELECT r.nome
FROM reservatorio r
WHERE EXISTS (
  SELECT 1 
  FROM serie_temporal st
  JOIN parametro p ON st.id_parametro = p.id_parametro
  WHERE st.id_reservatorio = r.id_reservatorio 
    AND p.nome_parametro = 'Oxigênio Dissolvido'
);