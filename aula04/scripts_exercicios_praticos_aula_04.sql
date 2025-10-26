INSERT INTO usuario (nome, email, senha_hash) VALUES
('Carlos Pereira', 'carlos.pereira@email.com', 'hash_senha_carlos');

INSERT INTO tipo_evento (nome, descricao) VALUES
('Tempestade de Raios', 'Evento caracterizado por intensa atividade elétrica na atmosfera.');

INSERT INTO relato (texto, data_hora, id_evento, id_usuario) VALUES
('Vi a fumaça de longe, parece ser sério.', '2025-08-22 16:00:00', 1, 4);

SELECT * FROM relato WHERE id_usuario = 4;

UPDATE usuario
SET email = 'joao.silva.novo@email.com'
WHERE id_usuario = 2;

UPDATE evento
SET status = 'Resolvido'
WHERE id_evento = 2;

SELECT titulo, status FROM evento WHERE id_evento = 2;

INSERT INTO alerta (mensagem, data_hora, nivel, id_evento) VALUES
('ALERTA FALSO PARA REMOÇÃO', '2025-08-23 10:00:00', 'Baixo', 3);

DELETE FROM alerta
WHERE id_evento = 3 AND mensagem = 'ALERTA FALSO PARA REMOÇÃO';

SELECT * FROM alerta WHERE mensagem = 'ALERTA FALSO PARA REMOÇÃO';

