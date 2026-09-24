INSERT INTO leitores (nome, email, data_cadastro) VALUES
('Joao Silva', 'joao.silva@example.com', '2026-09-01'),
('Maria Souza', 'maria.souza@example.com', '2026-09-02'),
('Pedro Santos', 'pedro.santos@example.com', '2026-09-03'),
('Ana Oliveira', 'ana.oliveira@example.com', '2026-09-04')
ON CONFLICT (email) DO NOTHING;
