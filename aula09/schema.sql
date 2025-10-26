-- Criação das tabelas
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

CREATE TABLE notas (
	id_nota SERIAL PRIMARY KEY,
	disciplina VARCHAR(100) NOT NULL,
	nota FLOAT,
	id_aluno INT REFERENCES alunos(id_aluno)
);

-- Inserção de dados nas tabelas
INSERT INTO cursos (nome) VALUES ('Engenharia');
INSERT INTO cursos (nome) VALUES ('Análise de Sistemas'),('Computação'),('Matemática');

INSERT INTO alunos (nome, idade, id_curso) VALUES 
('João', 22, 1),
('Marina Lima', 16, 3),
('Maria Souza', 20, 3),
('Carlos Lima', 25, 4),
('Lucas Pereira', 18, 3);

INSERT INTO notas (id_nota, id_aluno, disciplina, nota) VALUES 
(101, 1, 'Matemática', 8.5),
(102, 2, 'História', 9.0);

-- Atualizações nos dados
UPDATE alunos SET idade = 16 WHERE nome = 'João Silva';
UPDATE alunos SET idade = 17, id_curso = 1 WHERE nome = 'Marina Lima';

-- Verificação dos dados
SELECT * FROM cursos;
SELECT * FROM alunos;

-- INNER JOIN entre alunos e notas
-- Retorna apenas os alunos que têm notas registradas
SELECT alunos.nome, notas.disciplina, notas.nota
FROM alunos
INNER JOIN notas ON alunos.id_aluno = notas.id_aluno;

-- LEFT JOIN entre alunos e notas
-- Retorna todos os alunos, com notas se houver (NULL se não houver)
SELECT alunos.nome, notas.disciplina, notas.nota
FROM alunos
LEFT JOIN notas ON alunos.id_aluno = notas.id_aluno;

-- INNER JOIN entre alunos e cursos
-- Retorna apenas alunos que estão matriculados em algum curso
SELECT alunos.nome, cursos.nome AS curso
FROM alunos
INNER JOIN cursos ON alunos.id_curso = cursos.id_curso;

- Consulta A: Título do evento e nome do tipo de evento
SELECT e.titulo AS evento, te.nome AS tipo_evento
FROM evento e
INNER JOIN tipo_evento te ON e.id_tipo_evento = te.id_tipo_evento;

-- Consulta B: Título do evento, cidade e sigla do estado
SELECT e.titulo AS evento, l.cidade, l.sigla_estado
FROM evento e
INNER JOIN localizacao l ON e.id_localizacao = l.id_localizacao;

-- Consulta C: Inclui eventos que podem não ter localização (LEFT JOIN)
SELECT e.titulo AS evento, te.nome AS tipo_evento, l.cidade
FROM evento e
INNER JOIN tipo_evento te ON e.id_tipo_evento = te.id_tipo_evento
LEFT JOIN localizacao l ON e.id_localizacao = l.id_localizacao;
-- LEFT JOIN usado com localizacao para incluir eventos sem localização definida.

-- Consulta D: Mesma da B, mas com RIGHT JOIN (inverte a ordem)
SELECT e.titulo AS evento, l.cidade, l.sigla_estado
FROM localizacao l
RIGHT JOIN evento e ON e.id_localizacao = l.id_localizacao;


-- Consulta E: Quantidade de eventos por cidade
SELECT l.cidade, COUNT(e.id_evento) AS qtd_eventos
FROM localizacao l
LEFT JOIN evento e ON l.id_localizacao = e.id_localizacao
GROUP BY l.cidade;