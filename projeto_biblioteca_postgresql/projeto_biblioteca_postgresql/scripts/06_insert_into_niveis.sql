-- Faixas de pontuação coerentes com o volume de dados de demonstração do projeto
-- (poucos leitores/empréstimos). Ajuste os valores se o volume real de dados crescer.
INSERT INTO niveis (nome, pontos_minimos) VALUES
('Leitor Iniciante', 0),
('Leitor Frequente', 30),
('Leitor Assíduo', 60),
('Leitor Dedicado', 90),
('Leitor Expert', 120)
ON CONFLICT (nome) DO NOTHING;
