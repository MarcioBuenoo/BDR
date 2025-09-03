CREATE DATABASE db_escola;

CREATE TABLE cursos (id_curso SERIAL PRIMARY KEY, nome VARCHAR(100) NOT NULL);

CREATE TABLE alunos (id_aluno SERIAL PRIMARY KEY, nome VARCHAR(100) NOT NULL, idade
INT, id_curso INT REFERENCES cursos(id_curso));

CREATE TABLE notas (id_nota SERIAL PRIMARY KEY, disciplina VARCHAR(100) NOT NULL, nota float,
id_aluno INT REFERENCES alunos(id_aluno));

INSERT INTO cursos (nome) VALUES ('Engenharia');

INSERT INTO cursos (nome) VALUES ('Análise de Sistemas'), ('Computação'), ('Matemática');

INSERT INTO alunos (nome, idade, id_curso) VALUES ('Marina Lima', 16, 3), ('Maria Souza', 20, 3),
('Carlos Lima', 25, 4), ('Lucas Pereira', 18, 3);

INSERT INTO notas (id_nota, id_aluno, disciplina, nota) VALUES (101, 1, 'Matemática', 8.5),(102, 2,
'História', 9.0);

UPDATE alunos SET idade = 16 WHERE nome = 'João Silva';

UPDATE alunos SET idade = 17, id_curso = 1 WHERE nome = 'Marina Lima';

SELECT * FROM cursos;

SELECT * FROM alunos;

SELECT alunos.nome, notas.disciplina, notas.nota FROM alunos
INNER JOIN notas on alunos.id_aluno = notas.id_aluno;

SELECT alunos.nome, notas.disciplina, notas.nota
FROM alunos
LEFT JOIN notas ON alunos.id_aluno = notas.id_aluno;

-- Desafio da Aula

INSERT INTO alunos (nome) VALUES 
('Carlos Almeida'),
('Fernanda Costa');

INSERT INTO notas (disciplina) VALUES 
('Engenharia'),
('Computação');
