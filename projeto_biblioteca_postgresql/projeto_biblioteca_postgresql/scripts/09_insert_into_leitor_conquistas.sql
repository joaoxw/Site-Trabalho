-- Desbloqueio de conquistas calculado a partir dos dados reais de
-- emprestimos/historico_pontos (nenhuma conquista é atribuída manualmente).
-- Idempotente graças à PK composta (id_leitor, id_conquista).

-- Primeiro Empréstimo
INSERT INTO leitor_conquistas (id_leitor, id_conquista, data_desbloqueio)
SELECT e.id_leitor, c.id_conquista, MIN(e.data_emprestimo)
FROM emprestimos e
JOIN conquistas c ON c.codigo = 'PRIMEIRO_EMPRESTIMO'
GROUP BY e.id_leitor, c.id_conquista
ON CONFLICT (id_leitor, id_conquista) DO NOTHING;

-- Primeira Devolução (dentro do prazo)
INSERT INTO leitor_conquistas (id_leitor, id_conquista, data_desbloqueio)
SELECT e.id_leitor, c.id_conquista, MIN(e.data_devolucao)
FROM emprestimos e
JOIN conquistas c ON c.codigo = 'PRIMEIRA_DEVOLUCAO'
WHERE e.data_devolucao IS NOT NULL AND e.data_devolucao <= e.data_prevista
GROUP BY e.id_leitor, c.id_conquista
ON CONFLICT (id_leitor, id_conquista) DO NOTHING;

-- Leitor Frequente (atingiu a pontuação mínima do nível "Leitor Frequente")
INSERT INTO leitor_conquistas (id_leitor, id_conquista, data_desbloqueio)
SELECT h.id_leitor, c.id_conquista, CURRENT_DATE
FROM historico_pontos h
JOIN conquistas c ON c.codigo = 'LEITOR_FREQUENTE'
JOIN niveis n ON n.nome = 'Leitor Frequente'
GROUP BY h.id_leitor, c.id_conquista, n.pontos_minimos
HAVING SUM(h.pontos) >= n.pontos_minimos
ON CONFLICT (id_leitor, id_conquista) DO NOTHING;

-- 5 Livros Lidos (5 empréstimos com devolução registrada)
INSERT INTO leitor_conquistas (id_leitor, id_conquista, data_desbloqueio)
SELECT e.id_leitor, c.id_conquista, CURRENT_DATE
FROM emprestimos e
JOIN conquistas c ON c.codigo = 'CINCO_LIVROS'
WHERE e.data_devolucao IS NOT NULL
GROUP BY e.id_leitor, c.id_conquista
HAVING COUNT(*) >= 5
ON CONFLICT (id_leitor, id_conquista) DO NOTHING;

-- 10 Livros Lidos (10 empréstimos com devolução registrada)
INSERT INTO leitor_conquistas (id_leitor, id_conquista, data_desbloqueio)
SELECT e.id_leitor, c.id_conquista, CURRENT_DATE
FROM emprestimos e
JOIN conquistas c ON c.codigo = 'DEZ_LIVROS'
WHERE e.data_devolucao IS NOT NULL
GROUP BY e.id_leitor, c.id_conquista
HAVING COUNT(*) >= 10
ON CONFLICT (id_leitor, id_conquista) DO NOTHING;

-- Explorador de Categorias (livros de pelo menos 3 categorias diferentes)
INSERT INTO leitor_conquistas (id_leitor, id_conquista, data_desbloqueio)
SELECT e.id_leitor, c.id_conquista, CURRENT_DATE
FROM emprestimos e
JOIN livros l ON l.id_livro = e.id_livro
JOIN conquistas c ON c.codigo = 'EXPLORADOR_CATEGORIAS'
GROUP BY e.id_leitor, c.id_conquista
HAVING COUNT(DISTINCT l.id_categoria) >= 3
ON CONFLICT (id_leitor, id_conquista) DO NOTHING;
