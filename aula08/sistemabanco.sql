CREATE TABLE clientes (
id_cliente SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
cpf VARCHAR(11) UNIQUE NOT NULL,
endereco TEXT,
telefone VARCHAR(15)
);

CREATE TABLE contas (
id_conta SERIAL PRIMARY KEY,
numero_conta VARCHAR(10) UNIQUE NOT NULL,
saldo DECIMAL(10,2) DEFAULT 0,
id_cliente INT REFERENCES clientes(id_cliente) ON DELETE CASCADE
);

CREATE TABLE transacoes (
id_transacao SERIAL PRIMARY KEY,
id_conta INT REFERENCES contas(id_conta) ON DELETE CASCADE,
tipo VARCHAR(15) CHECK (tipo IN ('Depósito', 'Saque', 'Transferência')),
valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
data_transacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
destino_transferencia INT REFERENCES contas(id_conta)
);

INSERT INTO contas (numero_conta, saldo, id_cliente) VALUES
('000123', 1500.00, 1),
('000456', 2300.00, 2);

INSERT INTO transacoes (id_conta, tipo, valor) VALUES
(1, 'Depósito', 500.00),
(2, 'Saque', 200.00),
(1, 'Transferência', 300.00);

SELECT * FROM contas;

SELECT contas.numero_conta, clientes.nome, contas.saldo
FROM contas
INNER JOIN clientes ON contas.id_cliente = clientes.id_cliente;

SELECT transacoes.tipo, transacoes.valor, transacoes.data_transacao,
contas.numero_conta AS origem,
c2.numero_conta AS destino
FROM transacoes
INNER JOIN contas ON transacoes.id_conta = contas.id_conta
LEFT JOIN contas c2 ON transacoes.destino_transferencia = c2.id_conta;

UPDATE contas
SET saldo = saldo + 500.00
WHERE id_conta = 1;

DELETE FROM clientes WHERE id_cliente = 2;

INSERT INTO clientes (nome, cpf, endereco, telefone) VALUES
('Lula da Silva', '18765432100', 'Rua B, 456', '12988887777');

INSERT INTO contas (numero_conta, saldo, id_cliente) VALUES
('000789', 2.300, 5);

SELECT * FROM clientes;

SELECT * FROM contas;

-- Atualizar os saldos
UPDATE contas SET saldo = saldo - 100.00 WHERE numero_conta = '000123';
UPDATE contas SET saldo = saldo + 100.00 WHERE numero_conta = '000789';

-- Listar todas as contas do banco, mostrando os saldos atualizados
SELECT contas.numero_conta, clientes.nome, contas.saldo
FROM contas
INNER JOIN clientes ON contas.id_cliente = clientes.id_cliente;