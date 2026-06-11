-- 1. CATEGORIAS DE QUARTO
INSERT INTO categoria_quarto (id_categoria, nome, metragem, qtd_camas, capacidade_maxima, preco_base_diaria) VALUES
(1, 'Standard', 25.0, 2, 2, 150.00),
(2, 'Luxo', 40.0, 2, 3, 300.00),
(3, 'Premium', 60.0, 3, 4, 500.00),
(4, 'Suíte Master', 100.0, 1, 2, 1200.00);

-- 2. COMODIDADES
INSERT INTO comodidade (id_comodidade, descricao) VALUES
(1, 'Ar-condicionado'),
(2, 'TV Inteligente 50"'),
(3, 'Frigobar'),
(4, 'Jacuzzi'),
(5, 'Varanda com Vista para o Mar');

-- 3. RELAÇÃO CATEGORIA x COMODIDADE
INSERT INTO categoria_comodidade (id_categoria_comodidade, id_categoria, id_comodidade) VALUES
(1, 1, 1), (2, 1, 2), (3, 1, 3),                     
(4, 2, 1), (5, 2, 2), (6, 2, 3), (7, 2, 5),          
(8, 4, 1), (9, 4, 2), (10, 4, 3), (11, 4, 4), (12, 4, 5); 

-- 4. QUARTOS
INSERT INTO quarto (id_quarto, id_categoria, numero_quarto, andar, status) VALUES
(1, 1, '101', '1º Andar', 'disponível'),
(2, 1, '102', '1º Andar', 'ocupado'),
(3, 2, '201', '2º Andar', 'disponível'),
(4, 2, '202', '2º Andar', 'manutenção'),
(5, 3, '301', '3º Andar', 'disponível'),
(6, 4, '401', '4º Andar', 'disponível');

-- 5. HÓSPEDES
INSERT INTO hospede (id_hospede, nome_completo, cpf_passaporte, telefone, email, logradouro, numero, bairro, cidade, estado, pais, cep, nacionalidade) VALUES
(1, 'João da Silva', '111.111.111-11', '11999999999', 'joao@email.com', 'Rua A', '10', 'Centro', 'São Paulo', 'SP', 'Brasil', '01000', 'Brasileira'),
(2, 'Maria Oliveira', '222.222.222-22', '21988888888', 'maria@email.com', 'Rua B', '20', 'Botafogo', 'Rio de Janeiro', 'RJ', 'Brasil', '22000', 'Brasileira'),
(3, 'Pedro Santos', '333.333.333-33', '31977777777', 'pedro@email.com', 'Rua C', '30', 'Savassi', 'Belo Horizonte', 'MG', 'Brasil', '30000', 'Brasileira'),
(4, 'Anna Schmidt', 'AB123456', '+491511234567', 'anna@email.de', 'Musterstr', '40', 'Mitte', 'Berlim', 'B', 'Alemanha', '10115', 'Alemã'),
(5, 'John Smith', 'US987654', '+12025550123', 'john@email.com', 'Main St', '50', 'Downtown', 'Nova York', 'NY', 'EUA', '10001', 'Americana');

-- 6. FUNCIONÁRIOS
INSERT INTO funcionario (id_funcionario, nome_completo, funcao, escala_trabalho) VALUES
(1, 'Carlos Mendes', 'Recepcionista', '6x1 - Manhã'),
(2, 'Marta Rocha', 'Camareira', '6x1 - Tarde'),
(3, 'José Lima', 'Manutenção', '5x2 - Comercial'),
(4, 'Ana Beatriz', 'Cozinheira', '6x1 - Noite'),
(5, 'Paulo Freitas', 'Gerente', '5x2 - Comercial');

-- 7. CATÁLOGO DE SERVIÇOS ADICIONAIS
INSERT INTO servico_adicional (id_servico, nome_servico, valor_padrao) VALUES
(1, 'Restaurante', 50.00),
(2, 'Lavanderia', 30.00),
(3, 'Frigobar', 15.00),
(4, 'Spa - Massagem', 150.00),
(5, 'Passeio Turístico', 200.00),
(6, 'Transporte - Transfer', 100.00);

-- 8. RESERVAS 
INSERT INTO reserva (id_reserva, id_hospede, id_quarto, data_checkin, data_checkout, qtd_hospedes, valor_total, forma_pagamento, status, solicitacoes_especiais) VALUES
(1, 1, 1, '2026-01-10', '2026-01-15', 2, 750.00, 'Cartão de Crédito', 'concluída', 'Cama de casal'), 
(2, 2, 3, '2026-01-20', '2026-01-22', 2, 600.00, 'PIX', 'concluída', NULL),                            
(3, 5, 5, '2026-01-05', '2026-01-10', 3, 2500.00, 'Cartão de Crédito', 'concluída', 'Berço no quarto'),
(4, 3, 6, '2026-02-10', '2026-02-15', 2, 6000.00, 'Cartão de Crédito', 'concluída', 'Champanhe'),      
(5, 4, 2, '2026-02-20', '2026-02-25', 1, 750.00, 'PIX', 'concluída', NULL),                            
(6, 1, 4, '2026-02-01', '2026-02-05', 2, 1200.00, 'Dinheiro', 'concluída', 'Vista mar');               

-- 9. CONSUMO DE SERVIÇOS
INSERT INTO consumo_servico (id_consumo, id_reserva, id_servico, id_funcionario, data_hora, valor_cobrado, tipo_cobranca) VALUES
(1, 1, 1, 4, '2026-01-11 20:00:00', 120.00, 'no checkout'), 
(2, 1, 3, 2, '2026-01-12 10:00:00', 30.00, 'no checkout'),  
(3, 2, 4, 1, '2026-01-21 15:00:00', 150.00, 'imediata'),    
(4, 2, 6, 1, '2026-01-22 08:00:00', 100.00, 'imediata'),    
(5, 3, 5, 5, '2026-01-06 09:00:00', 600.00, 'no checkout'), 
(6, 4, 1, 4, '2026-02-12 21:00:00', 300.00, 'no checkout'), 
(7, 4, 4, 1, '2026-02-14 16:00:00', 300.00, 'imediata'),    
(8, 5, 2, 2, '2026-02-22 09:00:00', 30.00, 'no checkout'),  
(9, 5, 3, 2, '2026-02-23 22:00:00', 45.00, 'no checkout');  

-- 10. MANUTENÇÃO
INSERT INTO manutencao (id_manutencao, id_quarto, id_funcionario, tipo_manutencao, data_inicio, data_fim, previsao_liberacao, custo, descricao) VALUES
(1, 1, 3, 'preventiva', '2026-01-16 10:00:00', '2026-01-16 18:00:00', '2026-01-16 18:00:00', 50.00, 'Limpeza de filtro do AC (Após Res.1)'),
(2, 4, 3, 'corretiva', '2026-02-06 08:00:00', '2026-02-08 18:00:00', '2026-02-08 18:00:00', 300.00, 'Reparo de vazamento (Após Res.6)'),
(3, 6, 3, 'preventiva', '2026-02-16 09:00:00', '2026-02-17 18:00:00', '2026-02-17 18:00:00', 150.00, 'Troca de ralo da Jacuzzi (Após Res.4)'),
(4, 5, 3, 'preventiva', '2026-01-11 08:00:00', '2026-01-11 14:00:00', '2026-01-11 14:00:00', 0.00, 'Revisão elétrica (Após Res.3)');
