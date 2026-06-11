-- =======================================================================
-- CARGA MASSIVA DE DADOS MOCKADOS (DML) - Compatível com MySQL / MariaDB
-- Banco de Dados: Hotelaria - Carga Extensa para Relatórios Dinâmicos
-- =======================================================================

-- 1. CATEGORIAS DE QUARTO (Expandido)
INSERT INTO categoria_quarto (id_categoria, nome, metragem, qtd_camas, capacidade_maxima, preco_base_diaria) VALUES
(1, 'Standard', 25.0, 2, 2, 150.00),
(2, 'Luxo', 40.0, 2, 3, 300.00),
(3, 'Premium', 60.0, 3, 4, 500.00),
(4, 'Suíte Master', 100.0, 1, 2, 1200.00),
(5, 'Presidencial', 150.0, 2, 4, 3500.00);

-- 2. COMODIDADES (Expandido)
INSERT INTO comodidade (id_comodidade, descricao) VALUES
(1, 'Ar-condicionado'), (2, 'TV Inteligente 50"'), (3, 'Frigobar'),
(4, 'Jacuzzi'), (5, 'Varanda com Vista para o Mar'),
(6, 'Wi-Fi de Alta Velocidade'), (7, 'Máquina de Café Espresso'),
(8, 'Cofre Digital'), (9, 'Roupão e Pantufas'), (10, 'Serviço de Mordomo');

-- 3. CATEGORIA_COMODIDADE (Amarrando amenidades)
INSERT INTO categoria_comodidade (id_categoria_comodidade, id_categoria, id_comodidade) VALUES
(1,1,1),(2,1,2),(3,1,3),(4,1,6),(5,1,8),
(6,2,1),(7,2,2),(8,2,3),(9,2,5),(10,2,6),(11,2,7),(12,2,8),
(13,3,1),(14,3,2),(15,3,3),(16,3,4),(17,3,5),(18,3,6),(19,3,7),(20,3,8),(21,3,9),
(22,4,1),(23,4,2),(24,4,3),(25,4,4),(26,4,5),(27,4,6),(28,4,7),(29,4,8),(30,4,9),
(31,5,1),(32,5,2),(33,5,3),(34,5,4),(35,5,5),(36,5,6),(37,5,7),(38,5,8),(39,5,9),(40,5,10);

-- 4. QUARTOS (30 quartos simulando andares de um hotel grande)
INSERT INTO quarto (id_quarto, id_categoria, numero_quarto, andar, status) VALUES
(1,1,'101','1º Andar','disponível'), (2,1,'102','1º Andar','disponível'), (3,1,'103','1º Andar','ocupado'), 
(4,1,'104','1º Andar','disponível'), (5,1,'105','1º Andar','disponível'), (6,1,'106','1º Andar','disponível'), 
(7,1,'107','1º Andar','manutenção'), (8,1,'108','1º Andar','disponível'), (9,1,'109','1º Andar','ocupado'), 
(10,1,'110','1º Andar','disponível'),
(11,2,'201','2º Andar','disponível'), (12,2,'202','2º Andar','ocupado'), (13,2,'203','2º Andar','disponível'),
(14,2,'204','2º Andar','disponível'), (15,2,'205','2º Andar','disponível'), (16,2,'206','2º Andar','manutenção'),
(17,2,'207','2º Andar','ocupado'), (18,2,'208','2º Andar','disponível'),
(19,3,'301','3º Andar','disponível'), (20,3,'302','3º Andar','ocupado'), (21,3,'303','3º Andar','disponível'),
(22,3,'304','3º Andar','disponível'), (23,3,'305','3º Andar','ocupado'), (24,3,'306','3º Andar','disponível'),
(25,4,'401','4º Andar','ocupado'), (26,4,'402','4º Andar','disponível'), (27,4,'403','4º Andar','disponível'), 
(28,4,'404','4º Andar','manutenção'),
(29,5,'501','5º Andar','disponível'), (30,5,'502','5º Andar','ocupado');

-- 5. HOSPEDES (20 hóspedes diversos)
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
(10,'Kenji Sato','JP456123','+819012345678','kenji10@email.jp','Shibuya','101','Shibuya','Tóquio','TKY','Japão','1500002','Japonesa'),
(11,'Roberto Costa','101.101.101-11','11933333333','roberto11@email.com','Rua G','110','Pinheiros','São Paulo','SP','Brasil','05400','Brasileira'),
(12,'Camila Rocha','121.121.121-22','21922222222','camila12@email.com','Rua H','120','Copacabana','Rio de Janeiro','RJ','Brasil','22070','Brasileira'),
(13,'Luis Pereira','131.131.131-33','31911111111','luis13@email.com','Rua I','130','Lourdes','Belo Horizonte','MG','Brasil','30180','Brasileira'),
(14,'Oliver Kahn','GER987123','+491701234567','oliver14@email.de','Goetheplatz','1','Altstadt','Munique','BAV','Alemanha','80331','Alemã'),
(15,'Sarah Connor','US321654','+13105550199','sarah15@email.com','Sunset Blvd','200','Hollywood','Los Angeles','CA','EUA','90028','Americana'),
(16,'Julia Alves','161.161.161-66','61988887777','julia16@email.com','Rua J','160','Asa Sul','Brasília','DF','Brasil','70200','Brasileira'),
(17,'Thiago Nogueira','171.171.171-77','85977776666','thiago17@email.com','Rua K','170','Aldeota','Fortaleza','CE','Brasil','60150','Brasileira'),
(18,'Isabella Conti','IT654321','+393311234567','isabella18@email.it','Via Roma','10','Centro','Roma','RM','Itália','00184','Italiana'),
(19,'Diego Fernandez','ES123456','+34612345678','diego19@email.es','Gran Vía','20','Sol','Madri','MD','Espanha','28013','Espanhola'),
(20,'Marcos Lima','202.202.202-00','11955554444','marcos20@email.com','Rua L','200','Vila Mariana','São Paulo','SP','Brasil','04000','Brasileira');

-- 6. FUNCIONÁRIOS (10 funcionários)
INSERT INTO funcionario (id_funcionario, nome_completo, funcao, escala_trabalho) VALUES
(1,'Carlos Mendes','Recepcionista','6x1 - Manhã'),
(2,'Marta Rocha','Camareira','6x1 - Tarde'),
(3,'José Lima','Manutenção','5x2 - Comercial'),
(4,'Ana Beatriz','Cozinheira','6x1 - Noite'),
(5,'Paulo Freitas','Gerente','5x2 - Comercial'),
(6,'Roberta Diniz','Recepcionista','6x1 - Noite'),
(7,'Ricardo Nunes','Camareiro','6x1 - Manhã'),
(8,'Felipe Souza','Manutenção','12x36 - Noturno'),
(9,'Juliana Pires','Massagista SPA','5x2 - Tarde'),
(10,'Rafael Gomes','Motorista','6x1 - Manhã');

-- 7. SERVIÇOS ADICIONAIS (10 serviços no catálogo)
INSERT INTO servico_adicional (id_servico, nome_servico, valor_padrao) VALUES
(1,'Restaurante - Almoço/Jantar', 80.00),
(2,'Lavanderia - Peça Avulsa', 15.00),
(3,'Frigobar - Bebidas', 15.00),
(4,'Spa - Massagem Relaxante', 150.00),
(5,'Passeio Turístico - City Tour', 200.00),
(6,'Transporte - Transfer Aeroporto', 100.00),
(7,'Restaurante - Café no Quarto', 45.00),
(8,'Frigobar - Snacks', 20.00),
(9,'Aluguel de Veículo (Diária)', 180.00),
(10,'Lavanderia - Passadoria', 10.00);

-- 8. RESERVAS (30 reservas simulando fluxo intenso entre Janeiro e Março)
INSERT INTO reserva (id_reserva, id_hospede, id_quarto, data_checkin, data_checkout, qtd_hospedes, valor_total, forma_pagamento, status, solicitacoes_especiais) VALUES
(1, 1, 1, '2026-01-10', '2026-01-15', 2, 750.00, 'Cartão de Crédito', 'concluída', 'Cama de casal'),
(2, 2, 11, '2026-01-20', '2026-01-22', 2, 600.00, 'PIX', 'concluída', NULL),
(3, 5, 19, '2026-01-05', '2026-01-10', 3, 2500.00, 'Cartão de Crédito', 'concluída', 'Berço'),
(4, 3, 25, '2026-02-10', '2026-02-15', 2, 6000.00, 'Cartão de Crédito', 'concluída', 'Champanhe'),
(5, 4, 2, '2026-02-20', '2026-02-25', 1, 750.00, 'PIX', 'concluída', NULL),
(6, 1, 12, '2026-02-01', '2026-02-05', 2, 1200.00, 'Dinheiro', 'concluída', 'Vista mar'),
(7, 6, 3, '2026-03-01', '2026-03-05', 1, 600.00, 'Cartão de Crédito', 'pendente', NULL),
(8, 7, 29, '2026-03-10', '2026-03-12', 2, 7000.00, 'Transferência', 'pendente', 'Flores no quarto'),
(9, 8, 20, '2026-01-12', '2026-01-16', 2, 2000.00, 'Cartão de Débito', 'concluída', NULL),
(10, 9, 4, '2026-01-15', '2026-01-25', 1, 1500.00, 'Cartão de Crédito', 'concluída', 'Andar alto'),
(11, 10, 26, '2026-02-18', '2026-02-20', 2, 2400.00, 'Dinheiro', 'concluída', NULL),
(12, 11, 5, '2026-02-05', '2026-02-08', 2, 450.00, 'PIX', 'concluída', NULL),
(13, 12, 13, '2026-03-05', '2026-03-15', 3, 3000.00, 'Cartão de Crédito', 'confirmada', 'Cama extra'),
(14, 13, 21, '2026-01-28', '2026-02-02', 2, 2500.00, 'PIX', 'concluída', NULL),
(15, 14, 6, '2026-03-20', '2026-03-25', 1, 750.00, 'Cartão de Crédito', 'confirmada', NULL),
(16, 15, 27, '2026-01-10', '2026-01-12', 2, 2400.00, 'Dinheiro', 'concluída', 'Saída tardia'),
(17, 16, 30, '2026-02-14', '2026-02-16', 2, 7000.00, 'Cartão de Crédito', 'concluída', 'Decoração romântica'),
(18, 17, 7, '2026-03-01', '2026-03-08', 2, 1050.00, 'PIX', 'pendente', NULL),
(19, 18, 14, '2026-02-25', '2026-03-02', 2, 1500.00, 'Cartão de Crédito', 'concluída', NULL),
(20, 19, 22, '2026-01-02', '2026-01-08', 4, 3000.00, 'Dinheiro', 'concluída', NULL),
(21, 20, 8, '2026-03-15', '2026-03-20', 1, 750.00, 'PIX', 'confirmada', NULL),
(22, 1, 15, '2026-03-25', '2026-03-30', 2, 1500.00, 'Cartão de Crédito', 'confirmada', NULL),
(23, 2, 23, '2026-02-10', '2026-02-12', 2, 1000.00, 'Cartão de Crédito', 'concluída', NULL),
(24, 3, 28, '2026-01-20', '2026-01-25', 1, 6000.00, 'PIX', 'concluída', NULL),
(25, 4, 9, '2026-03-05', '2026-03-06', 1, 150.00, 'Dinheiro', 'concluída', NULL),
(26, 5, 16, '2026-02-05', '2026-02-10', 2, 1500.00, 'Cartão de Crédito', 'concluída', NULL),
(27, 6, 24, '2026-01-15', '2026-01-18', 3, 1500.00, 'PIX', 'concluída', NULL),
(28, 7, 10, '2026-02-28', '2026-03-03', 2, 450.00, 'Cartão de Crédito', 'concluída', NULL),
(29, 8, 17, '2026-03-12', '2026-03-15', 2, 900.00, 'Dinheiro', 'confirmada', NULL),
(30, 9, 18, '2026-02-22', '2026-02-28', 1, 1800.00, 'Cartão de Crédito', 'concluída', NULL);

-- 9. CONSUMO DE SERVIÇOS (50 itens variados para alimentar relatórios OLAP/BI)
INSERT INTO consumo_servico (id_consumo, id_reserva, id_servico, id_funcionario, data_hora, valor_cobrado, tipo_cobranca) VALUES
(1,1,1,4,'2026-01-11 20:00:00',120.00,'no checkout'),
(2,1,3,2,'2026-01-12 10:00:00',30.00,'no checkout'),
(3,2,4,9,'2026-01-21 15:00:00',150.00,'imediata'),
(4,2,6,10,'2026-01-22 08:00:00',100.00,'imediata'),
(5,3,5,1,'2026-01-06 09:00:00',600.00,'no checkout'),
(6,4,1,4,'2026-02-12 21:00:00',300.00,'no checkout'),
(7,4,4,9,'2026-02-14 16:00:00',300.00,'imediata'),
(8,5,2,2,'2026-02-22 09:00:00',30.00,'no checkout'),
(9,5,3,2,'2026-02-23 22:00:00',45.00,'no checkout'),
(10,6,7,2,'2026-02-02 08:00:00',90.00,'no checkout'),
(11,6,1,4,'2026-02-03 19:30:00',160.00,'no checkout'),
(12,8,4,9,'2026-03-11 14:00:00',300.00,'no checkout'),
(13,8,7,2,'2026-03-12 09:00:00',90.00,'no checkout'),
(14,9,1,4,'2026-01-13 12:30:00',150.00,'imediata'),
(15,10,2,7,'2026-01-20 10:00:00',45.00,'no checkout'),
(16,10,10,7,'2026-01-21 11:00:00',20.00,'no checkout'),
(17,11,6,10,'2026-02-18 10:00:00',100.00,'imediata'),
(18,11,3,2,'2026-02-19 22:00:00',60.00,'no checkout'),
(19,12,8,2,'2026-02-06 15:00:00',40.00,'no checkout'),
(20,13,1,4,'2026-03-06 20:00:00',250.00,'no checkout'),
(21,13,5,1,'2026-03-08 09:00:00',600.00,'imediata'),
(22,14,4,9,'2026-01-30 16:00:00',300.00,'no checkout'),
(23,16,1,4,'2026-01-11 21:00:00',320.00,'no checkout'),
(24,16,7,2,'2026-01-12 08:30:00',150.00,'imediata'),
(25,17,4,9,'2026-02-15 15:00:00',300.00,'no checkout'),
(26,17,6,10,'2026-02-16 12:00:00',100.00,'imediata'),
(27,19,2,7,'2026-02-28 09:00:00',60.00,'no checkout'),
(28,20,1,4,'2026-01-04 19:00:00',400.00,'imediata'),
(29,20,5,1,'2026-01-05 08:00:00',800.00,'no checkout'),
(30,22,3,2,'2026-03-26 23:00:00',30.00,'no checkout'),
(31,23,7,2,'2026-02-11 07:30:00',90.00,'no checkout'),
(32,24,9,1,'2026-01-21 10:00:00',360.00,'no checkout'),
(33,26,1,4,'2026-02-06 13:00:00',180.00,'imediata'),
(34,26,4,9,'2026-02-07 14:00:00',150.00,'no checkout'),
(35,27,8,2,'2026-01-16 16:00:00',60.00,'no checkout'),
(36,28,3,2,'2026-03-01 22:00:00',45.00,'no checkout'),
(37,29,1,4,'2026-03-13 20:00:00',160.00,'imediata'),
(38,30,5,1,'2026-02-25 09:00:00',200.00,'no checkout'),
(39,30,2,7,'2026-02-26 10:00:00',45.00,'no checkout'),
(40,1,6,10,'2026-01-15 12:00:00',100.00,'imediata'),
(41,3,7,2,'2026-01-08 08:00:00',135.00,'no checkout'),
(42,6,4,9,'2026-02-04 17:00:00',150.00,'no checkout'),
(43,14,3,2,'2026-01-31 21:00:00',45.00,'no checkout'),
(44,19,1,4,'2026-03-01 19:00:00',180.00,'imediata'),
(45,20,3,2,'2026-01-07 23:00:00',90.00,'no checkout'),
(46,24,6,10,'2026-01-25 11:00:00',100.00,'imediata'),
(47,26,7,2,'2026-02-08 08:00:00',90.00,'no checkout'),
(48,27,1,4,'2026-01-17 20:30:00',240.00,'no checkout'),
(49,29,4,9,'2026-03-14 16:00:00',300.00,'imediata'),
(50,30,6,10,'2026-02-28 09:00:00',100.00,'imediata');

-- 10. MANUTENÇÃO (Histórico extenso para cruzamento de dados)
INSERT INTO manutencao (id_manutencao, id_quarto, id_funcionario, tipo_manutencao, data_inicio, data_fim, previsao_liberacao, custo, descricao) VALUES
(1, 7, 3, 'preventiva', '2026-01-05 10:00:00', '2026-01-05 18:00:00', '2026-01-05 18:00:00', 50.00, 'Limpeza de filtro do AC'),
(2, 16, 8, 'corretiva', '2026-01-12 02:00:00', '2026-01-13 18:00:00', '2026-01-13 18:00:00', 450.00, 'Vazamento grave no banheiro'),
(3, 28, 3, 'preventiva', '2026-02-16 09:00:00', '2026-02-17 18:00:00', '2026-02-17 18:00:00', 150.00, 'Troca de ralo da Jacuzzi'),
(4, 5, 8, 'preventiva', '2026-01-11 08:00:00', '2026-01-11 14:00:00', '2026-01-11 14:00:00', 0.00, 'Revisão elétrica'),
(5, 1, 3, 'corretiva', '2026-01-16 09:00:00', '2026-01-16 15:00:00', '2026-01-16 14:00:00', 120.00, 'Conserto da fechadura eletrônica'),
(6, 11, 8, 'preventiva', '2026-02-23 10:00:00', '2026-02-23 12:00:00', '2026-02-23 12:00:00', 0.00, 'Dedetização periódica'),
(7, 30, 3, 'corretiva', '2026-02-17 10:00:00', '2026-02-18 16:00:00', '2026-02-18 18:00:00', 800.00, 'Reparo no aquecedor central da Presidencial'),
(8, 20, 8, 'preventiva', '2026-01-17 08:00:00', '2026-01-17 17:00:00', '2026-01-17 17:00:00', 100.00, 'Pintura da varanda'),
(9, 2, 3, 'corretiva', '2026-02-26 09:00:00', '2026-02-26 14:00:00', '2026-02-26 14:00:00', 60.00, 'Troca do chuveiro queimado'),
(10, 19, 8, 'preventiva', '2026-01-11 10:00:00', '2026-01-11 18:00:00', '2026-01-11 18:00:00', 200.00, 'Limpeza profunda de estofados');
