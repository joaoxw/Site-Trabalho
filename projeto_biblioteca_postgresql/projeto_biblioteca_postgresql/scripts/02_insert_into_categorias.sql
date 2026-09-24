INSERT INTO categorias (nome) VALUES
('Romance'),
('Fantasia'),
('Ficção Científica'),
('Literatura Brasileira')
ON CONFLICT (nome) DO NOTHING;
