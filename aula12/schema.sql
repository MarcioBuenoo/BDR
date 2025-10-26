CREATE TABLE reservatorio (
  id_reservatorio SERIAL PRIMARY KEY,
  nome VARCHAR(100) NOT NULL
);

CREATE TABLE parametro (
  id_parametro SERIAL PRIMARY KEY,
  nome_parametro VARCHAR(50) NOT NULL
);

CREATE TABLE serie_temporal (
  id_serie SERIAL PRIMARY KEY,
  id_reservatorio INT NOT NULL,
  id_parametro INT NOT NULL,
  valor NUMERIC(5,2) NOT NULL,
  data_hora TIMESTAMP NOT NULL,
  FOREIGN KEY (id_reservatorio) REFERENCES reservatorio(id_reservatorio),
  FOREIGN KEY (id_parametro) REFERENCES parametro(id_parametro)
);


INSERT INTO reservatorio (id_reservatorio, nome) VALUES
(1, 'Reservatório A'),
(2, 'Reservatório B'),
(3, 'Reservatório C');

INSERT INTO parametro (id_parametro, nome_parametro) VALUES
(1, 'pH'),
(2, 'Temperatura'),
(3, 'Turbidez');

INSERT INTO serie_temporal (id_serie, id_reservatorio, id_parametro, valor, data_hora) VALUES
(1, 1, 1, 7.0, '2024-10-20 08:00:00'),
(2, 1, 1, 6.8, '2024-10-20 12:00:00'),
(3, 1, 1, 7.2, '2024-10-20 16:00:00'),
(4, 2, 1, 6.5, '2024-10-20 08:00:00'),
(5, 2, 1, 6.7, '2024-10-20 12:00:00'),
(6, 3, 1, 7.5, '2024-10-20 09:00:00'),
(7, 3, 1, 7.3, '2024-10-20 15:00:00');

SELECT 
  r.nome AS reservatorio,
  
  -- Subconsulta para calcular a média do pH
  (
    SELECT AVG(st.valor)
    FROM serie_temporal st
    JOIN parametro p ON st.id_parametro = p.id_parametro
    WHERE st.id_reservatorio = r.id_reservatorio
      AND p.nome_parametro = 'pH'
  ) AS media_ph,
  
  -- Subconsulta para calcular o menor valor de pH
  (
    SELECT MIN(st.valor)
    FROM serie_temporal st
    JOIN parametro p ON st.id_parametro = p.id_parametro
    WHERE st.id_reservatorio = r.id_reservatorio
      AND p.nome_parametro = 'pH'
  ) AS minimo_ph,
  
  -- Subconsulta para calcular o maior valor de pH
  (
    SELECT MAX(st.valor)
    FROM serie_temporal st
    JOIN parametro p ON st.id_parametro = p.id_parametro
    WHERE st.id_reservatorio = r.id_reservatorio
      AND p.nome_parametro = 'pH'
  ) AS maximo_ph

FROM reservatorio r;