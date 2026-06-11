-- ==========================================
-- 1. CRIAÇÃO DAS TABELAS (SEM FKs)
-- ==========================================

CREATE TABLE categoria_quarto (
    id_categoria INT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    metragem DECIMAL(5,2),
    qtd_camas INT,
    capacidade_maxima INT,
    preco_base_diaria DECIMAL(10,2) NOT NULL
);

CREATE TABLE comodidade (
    id_comodidade INT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

CREATE TABLE categoria_comodidade (
    id_categoria_comodidade INT PRIMARY KEY,
    id_categoria INT NOT NULL,
    id_comodidade INT NOT NULL
);

CREATE TABLE quarto (
    id_quarto INT PRIMARY KEY,
    id_categoria INT NOT NULL,
    numero_quarto VARCHAR(10) NOT NULL,
    andar VARCHAR(10),
    status VARCHAR(20) NOT NULL
);

CREATE TABLE hospede (
    id_hospede INT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    cpf_passaporte VARCHAR(50) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    logradouro VARCHAR(150),
    numero VARCHAR(20),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    estado VARCHAR(50),
    pais VARCHAR(50),
    cep VARCHAR(20),
    nacionalidade VARCHAR(50)
);

CREATE TABLE reserva (
    id_reserva INT PRIMARY KEY,
    id_hospede INT NOT NULL,
    id_quarto INT NOT NULL,
    data_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    qtd_hospedes INT NOT NULL,
    valor_total DECIMAL(10,2),
    forma_pagamento VARCHAR(50),
    status VARCHAR(30) NOT NULL,
    solicitacoes_especiais TEXT
);

CREATE TABLE funcionario (
    id_funcionario INT PRIMARY KEY,
    nome_completo VARCHAR(150) NOT NULL,
    funcao VARCHAR(50) NOT NULL,
    escala_trabalho VARCHAR(50)
);

CREATE TABLE servico_adicional (
    id_servico INT PRIMARY KEY,
    nome_servico VARCHAR(100) NOT NULL,
    valor_padrao DECIMAL(10,2) NOT NULL
);

CREATE TABLE consumo_servico (
    id_consumo INT PRIMARY KEY,
    id_reserva INT NOT NULL,
    id_servico INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_hora TIMESTAMP NOT NULL,
    valor_cobrado DECIMAL(10,2) NOT NULL,
    tipo_cobranca VARCHAR(30) NOT NULL
);

CREATE TABLE manutencao (
    id_manutencao INT PRIMARY KEY,
    id_quarto INT NOT NULL,
    id_funcionario INT NOT NULL,
    tipo_manutencao VARCHAR(50) NOT NULL,
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP,
    previsao_liberacao TIMESTAMP,
    custo DECIMAL(10,2),
    descricao TEXT
);

-- ==========================================
-- 2. CRIAÇÃO DAS CHAVES ESTRANGEIRAS (FKs)
-- ==========================================

ALTER TABLE categoria_comodidade 
    ADD CONSTRAINT fk_cat_comod_categoria FOREIGN KEY (id_categoria) REFERENCES categoria_quarto(id_categoria);
ALTER TABLE categoria_comodidade 
    ADD CONSTRAINT fk_cat_comod_comodidade FOREIGN KEY (id_comodidade) REFERENCES comodidade(id_comodidade);

ALTER TABLE quarto 
    ADD CONSTRAINT fk_quarto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria_quarto(id_categoria);

ALTER TABLE reserva 
    ADD CONSTRAINT fk_reserva_hospede FOREIGN KEY (id_hospede) REFERENCES hospede(id_hospede);
ALTER TABLE reserva 
    ADD CONSTRAINT fk_reserva_quarto FOREIGN KEY (id_quarto) REFERENCES quarto(id_quarto);

ALTER TABLE consumo_servico 
    ADD CONSTRAINT fk_consumo_reserva FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva);
ALTER TABLE consumo_servico 
    ADD CONSTRAINT fk_consumo_servico FOREIGN KEY (id_servico) REFERENCES servico_adicional(id_servico);
ALTER TABLE consumo_servico 
    ADD CONSTRAINT fk_consumo_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario);

ALTER TABLE manutencao 
    ADD CONSTRAINT fk_manutencao_quarto FOREIGN KEY (id_quarto) REFERENCES quarto(id_quarto);
ALTER TABLE manutencao 
    ADD CONSTRAINT fk_manutencao_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario);

-- ==========================================
-- 3. CRIAÇÃO DE ÍNDICES (OTIMIZAÇÃO)
-- ==========================================

CREATE INDEX idx_categoria_comod_categoria ON categoria_comodidade(id_categoria);
CREATE INDEX idx_categoria_comod_comodidade ON categoria_comodidade(id_comodidade);

CREATE INDEX idx_quarto_categoria ON quarto(id_categoria);

CREATE INDEX idx_reserva_hospede ON reserva(id_hospede);
CREATE INDEX idx_reserva_quarto ON reserva(id_quarto);

CREATE INDEX idx_consumo_reserva ON consumo_servico(id_reserva);
CREATE INDEX idx_consumo_servico ON consumo_servico(id_servico);
CREATE INDEX idx_consumo_funcionario ON consumo_servico(id_funcionario);

CREATE INDEX idx_manutencao_quarto ON manutencao(id_quarto);
CREATE INDEX idx_manutencao_funcionario ON manutencao(id_funcionario);
