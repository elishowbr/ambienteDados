-- =================================================================================
-- ETAPA 5: RELATÓRIOS GERENCIAIS (DQL - Data Query Language)
-- =================================================================================

-- 1. Ocupação mensal por tipo de quarto (%). 
-- (Dica: relacione as reservas com o total de quartos daquela categoria no mês).
-- NOTA: Utiliza o mês de check-in e estima 30 dias para a base percentual.
SELECT 
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


-- 2. Consumo total por hóspede, detalhando os serviços consumidos durante a estadia.
SELECT 
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


-- 3. Receita mensal por categoria de serviço (restaurante, lavanderia, etc.).
SELECT 
    DATE_FORMAT(cs.data_hora, '%Y-%m') AS mes_ano,
    sa.nome_servico,
    COUNT(cs.id_consumo) AS qtd_vendas,
    SUM(cs.valor_cobrado) AS receita_total_mensal
FROM consumo_servico cs
JOIN servico_adicional sa ON cs.id_servico = sa.id_servico
GROUP BY DATE_FORMAT(cs.data_hora, '%Y-%m'), sa.nome_servico
ORDER BY mes_ano DESC, receita_total_mensal DESC;


-- 4. Quartos indisponíveis por manutenção, com datas de início/fim e funcionários responsáveis.
SELECT 
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