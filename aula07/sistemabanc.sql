CREATE DATABASE banco_sim;

CREATE TYPE transaction_type AS ENUM ('deposit', 'withdrawal', 'transfer');

CREATE TABLE clientes (
    cliente_id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome               VARCHAR(150)        NOT NULL,
    cpf                VARCHAR(14) UNIQUE  NOT NULL,
    email              VARCHAR(200),
    telefone           VARCHAR(30),
    data_nascimento    DATE,
    criado_em          TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE contas (
    conta_id           BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cliente_id         BIGINT NOT NULL REFERENCES clientes(cliente_id) ON DELETE CASCADE,
    agencia            VARCHAR(10) NOT NULL,
    numero             VARCHAR(20) NOT NULL,
    tipo_conta         VARCHAR(20) NOT NULL,
    saldo              NUMERIC(14,2) NOT NULL DEFAULT 0.00,
    moeda              CHAR(3) DEFAULT 'BRL',
    aberta_em          TIMESTAMPTZ DEFAULT now(),
    UNIQUE (agencia, numero)
);

CREATE TABLE transacoes (
    transacao_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    conta_id           BIGINT NOT NULL REFERENCES contas(conta_id) ON DELETE CASCADE,
    tipo               transaction_type NOT NULL,
    valor              NUMERIC(14,2) NOT NULL CHECK (valor > 0),
    data_hora          TIMESTAMPTZ DEFAULT now(),
    descricao          TEXT,
    conta_destino_id   BIGINT NULL, 
    saldo_posterior    NUMERIC(14,2) NULL, 
    CHECK ( (tipo = 'transfer' AND conta_destino_id IS NOT NULL) OR (tipo <> 'transfer') )
);

CREATE INDEX idx_transacoes_conta ON transacoes(conta_id);
CREATE INDEX idx_transacoes_tipo ON transacoes(tipo);

INSERT INTO clientes (nome, cpf, email, telefone, data_nascimento)
VALUES
('Ana Silva', '123.456.789-00', 'ana.silva@email.com', '(11) 91234-0001', '1985-04-12'),
('Bruno Costa', '234.567.890-11', 'bruno.costa@email.com', '(11) 91234-0002', '1990-09-30'),
('Carla Souza', '345.678.901-22', 'carla.souza@email.com', '(11) 91234-0003', '1978-02-05'),
('Diego Martins', '456.789.012-33', 'diego.martins@email.com', '(11) 91234-0004', '2000-12-10'),
('Eduarda Rocha', '567.890.123-44', 'eduarda.rocha@email.com', '(11) 91234-0005', '1995-06-25');

INSERT INTO contas (cliente_id, agencia, numero, tipo_conta, saldo)
VALUES
(1, '0001', '10001-0', 'corrente', 3500.00),   
(2, '0001', '10002-8', 'corrente', 1250.50),   
(3, '0002', '20001-5', 'poupanca', 9876.75),   
(4, '0003', '30001-2', 'corrente', 50.00),     
(5, '0001', '10003-6', 'poupanca', 0.00),     
(1, '0002', '20002-3', 'poupanca', 500.00);    

INSERT INTO transacoes (conta_id, tipo, valor, data_hora, descricao, saldo_posterior)
VALUES
(1, 'deposit',    2000.00, '2025-08-20 10:15:00-03', 'Depósito inicial', 3500.00),
(1, 'withdrawal', 150.00,  '2025-08-21 09:30:00-03', 'Saque caixa eletrônico', 3350.00),
(1, 'withdrawal', 50.00,   '2025-08-22 12:00:00-03', 'Saque cartão débito', 3300.00);

INSERT INTO transacoes (conta_id, tipo, valor, data_hora, descricao, saldo_posterior)
VALUES
(2, 'deposit',    1000.00, '2025-08-10 08:00:00-03', 'Depósito salário', 1250.50),
(2, 'withdrawal', 100.00,  '2025-08-15 17:45:00-03', 'Saque caixa', 1150.50);

INSERT INTO transacoes (conta_id, tipo, valor, data_hora, descricao, saldo_posterior)
VALUES
(3, 'deposit',    5000.00, '2025-07-30 11:20:00-03', 'Transferência recebida', 9876.75),
(3, 'withdrawal', 300.00,  '2025-08-05 14:10:00-03', 'Saque', 9576.75);

INSERT INTO transacoes (conta_id, tipo, valor, data_hora, descricao, saldo_posterior)
VALUES
(4, 'deposit',     200.00, '2025-08-01 09:00:00-03', 'Depósito inicial', 50.00),
(4, 'withdrawal',  150.00, '2025-08-02 18:30:00-03', 'Saque', -100.00); 

INSERT INTO transacoes (conta_id, tipo, valor, data_hora, descricao, saldo_posterior)
VALUES
(5, 'deposit',     500.00, '2025-06-20 10:10:00-03', 'Depósito', 0.00);

INSERT INTO transacoes (conta_id, tipo, valor, data_hora, descricao, conta_destino_id, saldo_posterior)
VALUES
(1, 'transfer', 300.00, '2025-08-25 15:00:00-03', 'Transferência para poupança', 6, 3000.00),
(6, 'deposit',  300.00, '2025-08-25 15:00:01-03', 'Transferência recebida de conta 1', NULL, 800.00);

INSERT INTO clientes (nome, cpf, email) VALUES ('Felipe Ramos', '678.901.234-55', 'felipe@email.com');
INSERT INTO contas (cliente_id, agencia, numero, tipo_conta, saldo) VALUES (6, '0004', '40001-7', 'corrente', 250.00);
INSERT INTO transacoes (conta_id, tipo, valor, data_hora, descricao, saldo_posterior) VALUES (7, 'deposit', 250.00, '2025-08-27 10:00:00-03', 'Depósito', 250.00);

SELECT COUNT(*) AS total_clientes FROM clientes;

SELECT SUM(saldo) AS saldo_total FROM contas;

SELECT AVG(valor) AS media_saques FROM transacoes WHERE tipo = 'withdrawal';

select * from contas;

