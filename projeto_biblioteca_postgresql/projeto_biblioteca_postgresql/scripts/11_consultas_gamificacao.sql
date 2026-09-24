-- Consultas de demonstração da gamificação.
-- Todas calculadas em tempo real a partir de historico_pontos, niveis,
-- conquistas e leitor_conquistas (nada é lido de uma coluna "pontos" fixa).

-- 1) Ranking geral (RANK() do PostgreSQL, não calculado manualmente)
SELECT
    RANK() OVER (ORDER BY total.pontos DESC) AS posicao,
    le.nome AS leitor,
    total.pontos,
    n.nome AS nivel
FROM (
    SELECT id_leitor, COALESCE(SUM(pontos), 0) AS pontos
    FROM historico_pontos
    GROUP BY id_leitor
) total
JOIN leitores le ON le.id_leitor = total.id_leitor
JOIN LATERAL (
    SELECT nome
    FROM niveis
    WHERE pontos_minimos <= total.pontos
    ORDER BY pontos_minimos DESC
    LIMIT 1
) n ON true
ORDER BY posicao;

-- 2) Pontuação individual de um leitor (troque o e-mail para consultar outro)
SELECT le.nome AS leitor, COALESCE(SUM(h.pontos), 0) AS pontos
FROM leitores le
LEFT JOIN historico_pontos h ON h.id_leitor = le.id_leitor
WHERE le.email = 'joao.silva@example.com'
GROUP BY le.nome;

-- 3) Nível atual de um leitor
SELECT
    le.nome AS leitor,
    total.pontos,
    n.nome AS nivel_atual
FROM (
    SELECT id_leitor, COALESCE(SUM(pontos), 0) AS pontos
    FROM historico_pontos
    GROUP BY id_leitor
) total
JOIN leitores le ON le.id_leitor = total.id_leitor
JOIN LATERAL (
    SELECT nome
    FROM niveis
    WHERE pontos_minimos <= total.pontos
    ORDER BY pontos_minimos DESC
    LIMIT 1
) n ON true
WHERE le.email = 'joao.silva@example.com';

-- 4) Progresso até o próximo nível
SELECT
    le.nome AS leitor,
    total.pontos,
    n_atual.nome AS nivel_atual,
    COALESCE(n_prox.nome, 'Nível máximo atingido') AS proximo_nivel,
    GREATEST(COALESCE(n_prox.pontos_minimos, total.pontos) - total.pontos, 0) AS pontos_para_proximo_nivel
FROM (
    SELECT id_leitor, COALESCE(SUM(pontos), 0) AS pontos
    FROM historico_pontos
    GROUP BY id_leitor
) total
JOIN leitores le ON le.id_leitor = total.id_leitor
JOIN LATERAL (
    SELECT nome, pontos_minimos
    FROM niveis
    WHERE pontos_minimos <= total.pontos
    ORDER BY pontos_minimos DESC
    LIMIT 1
) n_atual ON true
LEFT JOIN LATERAL (
    SELECT nome, pontos_minimos
    FROM niveis
    WHERE pontos_minimos > total.pontos
    ORDER BY pontos_minimos ASC
    LIMIT 1
) n_prox ON true
ORDER BY total.pontos DESC;

-- 5) Conquistas de um leitor (desbloqueadas e bloqueadas)
SELECT
    le.nome AS leitor,
    c.nome AS conquista,
    c.descricao,
    CASE WHEN lc.id_leitor IS NOT NULL THEN 'Desbloqueada' ELSE 'Bloqueada' END AS status,
    lc.data_desbloqueio
FROM leitores le
CROSS JOIN conquistas c
LEFT JOIN leitor_conquistas lc
    ON lc.id_leitor = le.id_leitor AND lc.id_conquista = c.id_conquista
WHERE le.email = 'maria.souza@example.com'
ORDER BY status DESC, c.nome;

-- 6) Histórico de pontos de um leitor (explica de onde vieram os pontos)
SELECT
    le.nome AS leitor,
    h.pontos,
    h.motivo,
    h.data_registro
FROM historico_pontos h
JOIN leitores le ON le.id_leitor = h.id_leitor
WHERE le.email = 'joao.silva@example.com'
ORDER BY h.data_registro;
