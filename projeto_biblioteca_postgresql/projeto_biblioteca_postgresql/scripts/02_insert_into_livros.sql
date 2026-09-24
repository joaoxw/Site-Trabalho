INSERT INTO livros (titulo, isbn, ano_publicacao, quantidade, id_autor, id_categoria)
SELECT 'Dom Casmurro', '9780000000001', 1899, 3, a.id_autor, c.id_categoria
FROM autores a, categorias c
WHERE a.nome = 'Machado de Assis' AND c.nome = 'Literatura Brasileira'
ON CONFLICT (isbn) DO NOTHING;

INSERT INTO livros (titulo, isbn, ano_publicacao, quantidade, id_autor, id_categoria)
SELECT 'Harry Potter e a Pedra Filosofal', '9780000000002', 1997, 4, a.id_autor, c.id_categoria
FROM autores a, categorias c
WHERE a.nome = 'J. K. Rowling' AND c.nome = 'Fantasia'
ON CONFLICT (isbn) DO NOTHING;

INSERT INTO livros (titulo, isbn, ano_publicacao, quantidade, id_autor, id_categoria)
SELECT '1984', '9780000000003', 1949, 2, a.id_autor, c.id_categoria
FROM autores a, categorias c
WHERE a.nome = 'George Orwell' AND c.nome = 'Ficção Científica'
ON CONFLICT (isbn) DO NOTHING;

INSERT INTO livros (titulo, isbn, ano_publicacao, quantidade, id_autor, id_categoria)
SELECT 'A Hora da Estrela', '9780000000004', 1977, 2, a.id_autor, c.id_categoria
FROM autores a, categorias c
WHERE a.nome = 'Clarice Lispector' AND c.nome = 'Literatura Brasileira'
ON CONFLICT (isbn) DO NOTHING;
