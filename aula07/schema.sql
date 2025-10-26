CREATE TABLE TipoEvento (
    idTipoEvento SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    descricao VARCHAR(255)
);

CREATE TABLE Localizacao (
    idLocalizacao SERIAL PRIMARY KEY,
    latitude FLOAT,
    longitude FLOAT,
    cidade VARCHAR(100),
    estado VARCHAR(2)
);

CREATE TABLE CategoriaUsuario (
    idCategoria SERIAL PRIMARY KEY,
    nome VARCHAR(50) 
);

CREATE TABLE Usuario (
    idUsuario SERIAL PRIMARY KEY,
    nome VARCHAR(150),
    email VARCHAR(150) UNIQUE,
    senhaHash VARCHAR(255),
    idCategoria INT,
    FOREIGN KEY (idCategoria) REFERENCES CategoriaUsuario(idCategoria)
);

CREATE TABLE Evento (
    idEvento SERIAL PRIMARY KEY,
    titulo VARCHAR(255),
    descricao TEXT,
    dataHora TIMESTAMP,
    status VARCHAR(50), 
    idTipoEvento INT,
    idLocalizacao INT,
    FOREIGN KEY (idTipoEvento) REFERENCES TipoEvento(idTipoEvento),
    FOREIGN KEY (idLocalizacao) REFERENCES Localizacao(idLocalizacao)
);

CREATE TABLE Relato (
    idRelato SERIAL PRIMARY KEY,
    texto TEXT,
    dataHora TIMESTAMP,
    idEvento INT,
    idUsuario INT,
    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento),
    FOREIGN KEY (idUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE Alerta (
    idAlerta SERIAL PRIMARY KEY,
    mensagem TEXT,
    dataHora TIMESTAMP,
    nivel VARCHAR(50),
    idEvento INT,
    FOREIGN KEY (idEvento) REFERENCES Evento(idEvento)
);

INSERT INTO CategoriaUsuario (nome) VALUES
('Cidadão'),
('Agente da Defesa Civil'),
('Pesquisador');

INSERT INTO TipoEvento (nome, descricao) VALUES
('Enchente', 'Acúmulo excessivo de água em uma área que normalmente é seca.'),
('Deslizamento de Terra', 'Movimento de solo ou rocha encosta abaixo.'),
('Incêndio Florestal', 'Fogo que se espalha por áreas de vegetação, como florestas e matas.');

INSERT INTO Localizacao (latitude, longitude, cidade, estado) VALUES
(-23.5505, -46.6333, 'São Paulo', 'SP'),
(-22.9068, -43.1729, 'Rio de Janeiro', 'RJ'),
(-3.1190, -60.0217, 'Manaus', 'AM');

INSERT INTO Usuario (nome, email, senhaHash, idCategoria) VALUES
('Ana Silva', 'ana.silva@email.com', 'hash_senha_123', 1),
('Bruno Costa', 'bruno.costa@defesacivil.gov', 'hash_senha_456', 2),
('Carla Dias', 'carla.dias@email.com', 'hash_senha_789', 1);

INSERT INTO Evento (titulo, descricao, dataHora, status, idTipoEvento, idLocalizacao) VALUES
('Alagamento na Zona Leste', 'Fortes chuvas causaram alagamento na região de Itaquera.', '2024-01-15 18:30:00', 'Encerrado', 1, 1),
('Risco de Deslizamento no Morro do Alemão', 'Solo encharcado apresenta risco iminente de deslizamento.', '2024-02-20 10:00:00', 'Ativo', 2, 2),
('Fumaça na Reserva Florestal', 'Focos de incêndio detectados próximos à reserva Adolpho Ducke.', '2024-08-10 14:00:00', 'Confirmado', 3, 3);

SELECT nome, email FROM Usuario;

SELECT titulo, dataHora, status FROM Evento;

SELECT titulo, descricao, cidade, estado
FROM Evento
WHERE status = 'Ativo';

SELECT Usuario.nome, Usuario.email, CategoriaUsuario.nome AS categoria
FROM Usuario
WHERE CategoriaUsuario.nome = 'Cidadão';

INSERT INTO Relato (texto, dataHora, idEvento, idUsuario) VALUES ('A água chegou até o portão da minha casa.', '2024-01-15 19:00:00', 1, 1), ('Deslizamento atingiu parte da rua principal.', '2024-02-20 10:30:00', 2, 2);

INSERT INTO Alerta (mensagem, dataHora, nivel, idEvento) VALUES ('Evitem a região de Itaquera. Alagamento severo.', '2024-01-15 18:45:00', 'Alto', 1), ('Moradores do Morro do Alemão devem evacuar imediatamente.', '2024-02-20 10:15:00', 'Crítico', 2);

SELECT titulo, dataHora
FROM Evento
ORDER BY dataHora;

SELECT titulo, dataHora
FROM Evento
ORDER BY dataHora DESC
LIMIT 3;

-- Quantidade total de usuários do banco.
SELECT COUNT(*) AS total_usuarios FROM Usuario;

-- Calcular a SOMA total da área afetada por todos os eventos.
SELECT SUM(area_afetada_km2) AS area_total_afetada_em_km2 FROM Evento;

-- Calcular a MÉDIA da área afetada por evento.
SELECT AVG(area_afetada_km2) AS media_de_area_afetada_em_km2 FROM Evento;