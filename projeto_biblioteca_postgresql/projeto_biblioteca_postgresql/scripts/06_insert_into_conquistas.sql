INSERT INTO conquistas (codigo, nome, descricao, pontos_bonus) VALUES
('PRIMEIRO_EMPRESTIMO', 'Primeiro Empréstimo', 'Realizou o primeiro empréstimo na biblioteca.', 0),
('PRIMEIRA_DEVOLUCAO', 'Primeira Devolução', 'Devolveu um livro dentro do prazo pela primeira vez.', 0),
('LEITOR_FREQUENTE', 'Leitor Frequente', 'Atingiu o nível Leitor Frequente.', 0),
('CINCO_LIVROS', '5 Livros Lidos', 'Concluiu 5 empréstimos com devolução registrada.', 25),
('DEZ_LIVROS', '10 Livros Lidos', 'Concluiu 10 empréstimos com devolução registrada.', 50),
('EXPLORADOR_CATEGORIAS', 'Explorador de Categorias', 'Pegou livros emprestados de pelo menos 3 categorias diferentes.', 15)
ON CONFLICT (codigo) DO NOTHING;
