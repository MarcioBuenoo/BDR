CREATE DATABASE queimadas_db;

CREATE TABLE focos_calor (
	id SERIAL PRIMARY KEY,
	estado VARCHAR(50),
	bioma VARCHAR(50),
	data_ocorrencia DATE
);

INSERT INTO focos_calor (estado, bioma, data_ocorrencia)
VALUES ('São Paulo', 'Mata Atlântica', '2025-02-10');

SELECT * FROM focos_calor;