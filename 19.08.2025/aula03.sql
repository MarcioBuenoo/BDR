CREATE DATABASE ds_escola;

CREATE TABLE cursos (
	id_curso SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL
);

CREATE TABLE alunos (
	id_aluno SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	idade INT,
	id_curso INT REFERENCES cursos(id_curso)
);

INSERT INTO cursos (id_curso,nome) 
VALUES (1,'Engenharia');

INSERT INTO alunos (nome, idade, id_curso)
VALUES ('João Silva', 22, 1);

INSERT INTO cursos (nome) VALUES
('Análise de Sistemas'),
('Computação'),
('Matemática');

INSERT INTO alunos (nome, idade, id_curso) VALUES
('Maria Souza', 20, 3),
('Carlos Lima', 25, 4);

UPDATE alunos
SET idade = 23
WHERE nome = 'João Silva';

UPDATE alunos
SET idade = 21, id_curso = 1
WHERE nome = 'Maria Souza';

DELETE FROM alunos
WHERE nome = 'Carlos Lima';

TRUNCATE TABLE alunos;
