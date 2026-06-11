-- =========================================================================================
-- PROJETO FINAL: SISTEMA DE GESTÃO DE HOTELARIA E RESERVAS
-- Este script resolve o erro de duplicidade (Drop/Create), recria a estrutura, 
-- insere os dados e, por fim, gera os 4 relatórios solicitados com comentários explicativos.
-- Compatível com MySQL / MariaDB
-- =========================================================================================

-- =========================================================================================
-- PARTE 0: LIMPEZA DO BANCO DE DADOS (Resolve o Erro 1062 - Duplicate Entry)
-- Executar essas rotinas dropa as tabelas se já existirem, garantindo que o 
-- script rode sempre "do zero" sem dar erro de Chave Primária Duplicada.
-- =========================================================================================
DROP TABLE IF EXISTS manutencao;
DROP TABLE IF EXISTS consumo_servico;
DROP TABLE IF EXISTS reserva;
DROP TABLE IF EXISTS servico_adicional;
DROP TABLE IF EXISTS funcionario;
DROP TABLE IF EXISTS hospede;
DROP TABLE IF EXISTS quarto;
DROP TABLE IF EXISTS categoria_comodidade;
DROP TABLE IF EXISTS comodidade;
DROP TABLE IF EXISTS categoria_quarto;

-- =========================================================================================
-- PARTE 1: CRIAÇÃO DAS TABELAS (DDL)
-- =========================================================================================
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

-- =========================================================================================
-- PARTE 2: CRIAÇÃO DAS CHAVES ESTRANGEIRAS E ÍNDICES (DDL)
-- =========================================================================================
ALTER TABLE categoria_comodidade ADD CONSTRAINT fk_cat_comod_categoria FOREIGN KEY (id_categoria) REFERENCES categoria_quarto(id_categoria);
ALTER TABLE categoria_comodidade ADD CONSTRAINT fk_cat_comod_comodidade FOREIGN KEY (id_comodidade) REFERENCES comodidade(id_comodidade);
ALTER TABLE quarto ADD CONSTRAINT fk_quarto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria_quarto(id_categoria);
ALTER TABLE reserva ADD CONSTRAINT fk_reserva_hospede FOREIGN KEY (id_hospede) REFERENCES hospede(id_hospede);
ALTER TABLE reserva ADD CONSTRAINT fk_reserva_quarto FOREIGN KEY (id_quarto) REFERENCES quarto(id_quarto);
ALTER TABLE consumo_servico ADD CONSTRAINT fk_consumo_reserva FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva);
ALTER TABLE consumo_servico ADD CONSTRAINT fk_consumo_servico FOREIGN KEY (id_servico) REFERENCES servico_adicional(id_servico);
ALTER TABLE consumo_servico ADD CONSTRAINT fk_consumo_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario);
ALTER TABLE manutencao ADD CONSTRAINT fk_manutencao_quarto FOREIGN KEY (id_quarto) REFERENCES quarto(id_quarto);
ALTER TABLE manutencao ADD CONSTRAINT fk_manutencao_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario);

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

-- =========================================================================================
-- PARTE 3: CARGA DE DADOS MOCKADOS (DML)
-- =========================================================================================
INSERT INTO categoria_quarto (id_categoria, nome, metragem, qtd_camas, capacidade_maxima, preco_base_diaria) VALUES
(1, 'Standard', 25.0, 2, 2, 150.00), (2, 'Luxo', 40.0, 2, 3, 300.00), (3, 'Premium', 60.0, 3, 4, 500.00), (4, 'Suíte Master', 100.0, 1, 2, 1200.00), (5, 'Presidencial', 150.0, 2, 4, 3500.00);

INSERT INTO comodidade (id_comodidade, descricao) VALUES
(1, 'Ar-condicionado'), (2, 'TV Inteligente 50"'), (3, 'Frigobar'), (4, 'Jacuzzi'), (5, 'Varanda com Vista para o Mar'), (6, 'Wi-Fi de Alta Velocidade'), (7, 'Máquina de Café Espresso'), (8, 'Cofre Digital'), (9, 'Roupão e Pantufas'), (10, 'Serviço de Mordomo');

INSERT INTO categoria_comodidade (id_categoria_comodidade, id_categoria, id_comodidade) VALUES
(1,1,1),(2,1,2),(3,1,3),(4,1,6),(5,1,8), (6,2,1),(7,2,2),(8,2,3),(9,2,5),(10,2,6),(11,2,7),(12,2,8),
(13,3,1),(14,3,2),(15,3,3),(16,3,4),(17,3,5),(18,3,6),(19,3,7),(20,3,8),(21,3,9),
(22,4,1),(23,4,2),(24,4,3),(25,4,4),(26,4,5),(27,4,6),(28,4,7),(29,4,8),(30,4,9),
(31,5,1),(32,5,2),(33,5,3),(34,5,4),(35,5,5),(36,5,6),(37,5,7),(38,5,8),(39,5,9),(40,5,10);

INSERT INTO quarto (id_quarto, id_categoria, numero_quarto, andar, status) VALUES
(1,1,'101','1º Andar','disponível'), (2,1,'102','1º Andar','disponível'), (3,1,'103','1º Andar','ocupado'), 
(4,1,'104','1º Andar','disponível'), (5,1,'105','1º Andar','disponível'), (6,1,'106','1º Andar','disponível'), 
(7,1,'107','1º Andar','manutenção'), (8,1,'108','1º Andar','disponível'), (9,1,'109','1º Andar','ocupado'), (10,1,'110','1º Andar','disponível'),
(11,2,'201','2º Andar','disponível'), (12,2,'202','2º Andar','ocupado'), (13,2,'203','2º Andar','disponível'),
(14,2,'204','2º Andar','disponível'), (15,2,'205','2º Andar','disponível'), (16,2,'206','2º Andar','manutenção'), (17,2,'207','2º Andar','ocupado'), (18,2,'208','2º Andar','disponível'),
(19,3,'301','3º Andar','disponível'), (20,3,'302','3º Andar','ocupado'), (21,3,'303','3º Andar','disponível'),
(22,3,'304','3º Andar','disponível'), (23,3,'305','3º Andar','ocupado'), (24,3,'306','3º Andar','disponível'),
(25,4,'401','4º Andar','ocupado'), (26,4,'402','4º Andar','disponível'), (27,4,'403','4º Andar','disponível'), (28,4,'404','4º Andar','manutenção'),
(29,5,'501','5º Andar','disponível'), (30,5,'502','5º Andar','ocupado');

INSERT INTO hospede (id_hospede, nome_completo, cpf_passaporte, telefone, email, logradouro, numero, bairro, cidade, estado, pais, cep, nacionalidade) VALUES
(1,'João da Silva','111.111.111-11','11999999991','joao1@email.com','Rua A','10','Centro','São Paulo','SP','Brasil','01000','Brasileira'),
(2,'Maria Oliveira','222.222.222-22','21988888882','maria2@email.com','Rua B','20','Botafogo','Rio de Janeiro','RJ','Brasil','22000','Brasileira'),
(3,'Pedro Santos','333.333.333-33','31977777773','pedro3@email.com','Rua C','30','Savassi','Belo Horizonte','MG','Brasil','30000','Brasileira'),
(4,'Anna Schmidt','AB123456','+4915112345674','anna4@email.de','Musterstr','40','Mitte','Berlim','B','Alemanha','10115','Alemã'),
(5,'John Smith','US987654','+12025550125','john5@email.com','Main St','50','Downtown','Nova York','NY','EUA','10001','Americana'),
(6,'Carlos Eduardo','666.666.666-66','41966666666','carlos6@email.com','Rua D','60','Batel','Curitiba','PR','Brasil','80000','Brasileira'),
(7,'Lucia Mello','777.777.777-77','81955555555','lucia7@email.com','Rua E','70','Boa Viagem','Recife','PE','Brasil','51000','Brasileira'),
(8,'Fernando Dias','888.888.888-88','51944444444','fernando8@email.com','Rua F','80','Moinhos','Porto Alegre','RS','Brasil','90000','Brasileira'),
(9,'Emma Watson','UK123987','+447911123456','emma9@email.uk','Baker St','221B','Marylebone','Londres','ENG','Reino Unido','NW16XE','Britânica'),
(10,'Kenji Sato','JP456123','+819012345678','kenji10@email.jp','Shibuya','101','Shibuya','Tóquio','TKY','Japão','1500002','Japonesa');

INSERT INTO funcionario (id_funcionario, nome_completo, funcao, escala_trabalho) VALUES
(1,'Carlos Mendes','Recepcionista','6x1 - Manhã'), (2,'Marta Rocha','Camareira','6x1 - Tarde'), (3,'José Lima','Manutenção','5x2 - Comercial'),
(4,'Ana Beatriz','Cozinheira','6x1 - Noite'), (5,'Paulo Freitas','Gerente','5x2 - Comercial'), (6,'Roberta Diniz','Recepcionista','6x1 - Noite'),
(7,'Ricardo Nunes','Camareiro','6x1 - Manhã'), (8,'Felipe Souza','Manutenção','12x36 - Noturno'), (9,'Juliana Pires','Massagista SPA','5x2 - Tarde'), (10,'Rafael Gomes','Motorista','6x1 - Manhã');

INSERT INTO servico_adicional (id_servico, nome_servico, valor_padrao) VALUES
(1,'Restaurante - Almoço/Jantar', 80.00), (2,'Lavanderia - Peça Avulsa', 15.00), (3,'Frigobar - Bebidas', 15.00),
(4,'Spa - Massagem Relaxante', 150.00), (5,'Passeio Turístico - City Tour', 200.00), (6,'Transporte - Transfer Aeroporto', 100.00),
(7,'Restaurante - Café no Quarto', 45.00), (8,'Frigobar - Snacks', 20.00), (9,'Aluguel de Veículo (Diária)', 180.00), (10,'Lavanderia - Passadoria', 10.00);

INSERT INTO reserva (id_reserva, id_hospede, id_quarto, data_checkin, data_checkout, qtd_hospedes, valor_total, forma_pagamento, status, solicitacoes_especiais) VALUES
(1, 1, 1, '2026-01-10', '2026-01-15', 2, 750.00, 'Cartão de Crédito', 'concluída', 'Cama de casal'),
(2, 2, 11, '2026-01-20', '2026-01-22', 2, 600.00, 'PIX', 'concluída', NULL),
(3, 5, 19, '2026-01-05', '2026-01-10', 3, 2500.00, 'Cartão de Crédito', 'concluída', 'Berço'),
(4, 3, 25, '2026-02-10', '2026-02-15', 2, 6000.00, 'Cartão de Crédito', 'concluída', 'Champanhe'),
(5, 4, 2, '2026-02-20', '2026-02-25', 1, 750.00, 'PIX', 'concluída', NULL),
(6, 1, 12, '2026-02-01', '2026-02-05', 2, 1200.00, 'Dinheiro', 'concluída', 'Vista mar'),
(7, 6, 3, '2026-03-01', '2026-03-05', 1, 600.00, 'Cartão de Crédito', 'pendente', NULL),
(8, 7, 29, '2026-03-10', '2026-03-12', 2, 7000.00, 'Transferência', 'pendente', 'Flores no quarto');

INSERT INTO consumo_servico (id_consumo, id_reserva, id_servico, id_funcionario, data_hora, valor_cobrado, tipo_cobranca) VALUES
(1,1,1,4,'2026-01-11 20:00:00',120.00,'no checkout'), (2,1,3,2,'2026-01-12 10:00:00',30.00,'no checkout'),
(3,2,4,9,'2026-01-21 15:00:00',150.00,'imediata'), (4,2,6,10,'2026-01-22 08:00:00',100.00,'imediata'),
(5,3,5,1,'2026-01-06 09:00:00',600.00,'no checkout'), (6,4,1,4,'2026-02-12 21:00:00',300.00,'no checkout'),
(7,4,4,9,'2026-02-14 16:00:00',300.00,'imediata'), (8,5,2,2,'2026-02-22 09:00:00',30.00,'no checkout');

INSERT INTO manutencao (id_manutencao, id_quarto, id_funcionario, tipo_manutencao, data_inicio, data_fim, previsao_liberacao, custo, descricao) VALUES
(1, 7, 3, 'preventiva', '2026-01-05 10:00:00', '2026-01-05 18:00:00', '2026-01-05 18:00:00', 50.00, 'Limpeza de filtro do AC'),
(2, 16, 8, 'corretiva', '2026-01-12 02:00:00', '2026-01-13 18:00:00', '2026-01-13 18:00:00', 450.00, 'Vazamento grave no banheiro'),
(3, 28, 3, 'preventiva', '2026-02-16 09:00:00', '2026-02-17 18:00:00', '2026-02-17 18:00:00', 150.00, 'Troca de ralo da Jacuzzi');

-- =========================================================================================
-- PARTE 4: RELATÓRIOS GERENCIAIS (DQL) - COMENTADOS E DIFERENCIADOS
-- =========================================================================================

-- -----------------------------------------------------------------------------------------
-- RELATÓRIO 1: Ocupação mensal por tipo de quarto (%)
-- Objetivo: Demonstrar o quão cheios estão os quartos de cada categoria em um dado mês.
-- -----------------------------------------------------------------------------------------
-- EXPLICAÇÃO DA LÓGICA: 
-- 1. Usa DATE_FORMAT na data_checkin para agrupar por mês/ano.
-- 2. Calcula DATEDIFF(checkout, checkin) para saber quantos dias o quarto foi ocupado.
-- 3. Usa uma subquery (SELECT COUNT(*)...) para descobrir quantos quartos daquela categoria existem.
-- 4. Multiplica o total de quartos da categoria por 30 (dias num mês comercial) para achar a capacidade máxima mensal de ocupação.
-- 5. Divide os dias ocupados pela capacidade máxima e multiplica por 100 para achar a porcentagem (%).
-- -----------------------------------------------------------------------------------------
SELECT 
    '1. OCUPAÇÃO POR QUARTO' AS nome_do_relatorio,  -- <--- TRUQUE AQUI
    DATE_FORMAT(r.data_checkin, '%Y-%m') AS mes_ano,
    cq.nome AS categoria_quarto,
    (SELECT COUNT(*) FROM quarto q2 WHERE q2.id_categoria = cq.id_categoria) AS qtd_quartos_existentes,
    SUM(DATEDIFF(r.data_checkout, r.data_checkin)) AS total_dias_ocupados,
    ROUND((SUM(DATEDIFF(r.data_checkout, r.data_checkin)) * 100.0) / 
          ((SELECT COUNT(*) FROM quarto q2 WHERE q2.id_categoria = cq.id_categoria) * 30), 2) AS taxa_ocupacao_percentual
FROM reserva r
JOIN quarto q ON r.id_quarto = q.id_quarto
JOIN categoria_quarto cq ON q.id_categoria = cq.id_categoria
GROUP BY DATE_FORMAT(r.data_checkin, '%Y-%m'), cq.id_categoria, cq.nome
ORDER BY mes_ano DESC, taxa_ocupacao_percentual DESC;


-- -----------------------------------------------------------------------------------------
-- RELATÓRIO 2: Consumo total por hóspede, detalhando serviços consumidos
-- Objetivo: Mostrar quanto cada hóspede gastou com serviços extras, discriminando os itens.
-- -----------------------------------------------------------------------------------------
-- EXPLICAÇÃO DA LÓGICA:
-- 1. Faz o JOIN entre Hóspede -> Reserva -> Consumo_Servico -> Servico_Adicional.
-- 2. Agrupa (GROUP BY) pelo nome do hóspede, pela reserva e pelo nome do serviço.
-- 3. Conta quantas vezes aquele serviço foi consumido (COUNT) e soma o valor total gasto (SUM).
-- -----------------------------------------------------------------------------------------
SELECT 
    '2. CONSUMO POR HÓSPEDE' AS nome_do_relatorio, -- <--- TRUQUE AQUI
    h.nome_completo AS hospede,
    r.id_reserva,
    sa.nome_servico AS servico_consumido,
    COUNT(cs.id_consumo) AS quantidade_vezes_consumido,
    SUM(cs.valor_cobrado) AS valor_total_gasto
FROM hospede h
JOIN reserva r ON h.id_hospede = r.id_hospede
JOIN consumo_servico cs ON r.id_reserva = cs.id_reserva
JOIN servico_adicional sa ON cs.id_servico = sa.id_servico
GROUP BY h.nome_completo, r.id_reserva, sa.nome_servico
ORDER BY h.nome_completo, valor_total_gasto DESC;


-- -----------------------------------------------------------------------------------------
-- RELATÓRIO 3: Receita mensal por categoria de serviço
-- Objetivo: Identificar quais serviços adicionais geram mais lucro para o hotel a cada mês.
-- -----------------------------------------------------------------------------------------
-- EXPLICAÇÃO DA LÓGICA:
-- 1. Usa DATE_FORMAT na data do consumo para obter o fechamento do mês.
-- 2. Agrupa pelo mês gerado e pelo nome do serviço.
-- 3. Soma os valores cobrados, permitindo comparar a lucratividade (ex: Spa vs Restaurante).
-- -----------------------------------------------------------------------------------------
SELECT 
    '3. RECEITA POR SERVIÇO' AS nome_do_relatorio, -- <--- TRUQUE AQUI
    DATE_FORMAT(cs.data_hora, '%Y-%m') AS mes_ano,
    sa.nome_servico,
    COUNT(cs.id_consumo) AS qtd_vendas,
    SUM(cs.valor_cobrado) AS receita_total_mensal
FROM consumo_servico cs
JOIN servico_adicional sa ON cs.id_servico = sa.id_servico
GROUP BY DATE_FORMAT(cs.data_hora, '%Y-%m'), sa.nome_servico
ORDER BY mes_ano DESC, receita_total_mensal DESC;


-- -----------------------------------------------------------------------------------------
-- RELATÓRIO 4: Quartos indisponíveis por manutenção, com datas e responsáveis
-- Objetivo: Listar todos os quartos interditados, o motivo e quem do time técnico é o responsável.
-- -----------------------------------------------------------------------------------------
-- EXPLICAÇÃO DA LÓGICA:
-- 1. Une as tabelas Manutencao, Quarto, Categoria_Quarto e Funcionario usando JOIN.
-- 2. Traz a categoria do quarto, o tipo do defeito/reparo, as datas de interdição e o nome do técnico.
-- 3. Ordena pela data de início (DESC) para deixar as interdições mais recentes no topo.
-- -----------------------------------------------------------------------------------------
SELECT 
    '4. STATUS DE MANUTENÇÃO' AS nome_do_relatorio, -- <--- TRUQUE AQUI
    q.numero_quarto,
    cq.nome AS categoria,
    m.tipo_manutencao,
    m.data_inicio,
    m.data_fim,
    m.descricao AS motivo_manutencao,
    f.nome_completo AS funcionario_responsavel
FROM manutencao m
JOIN quarto q ON m.id_quarto = q.id_quarto
JOIN categoria_quarto cq ON q.id_categoria = cq.id_categoria
JOIN funcionario f ON m.id_funcionario = f.id_funcionario
ORDER BY m.data_inicio DESC;