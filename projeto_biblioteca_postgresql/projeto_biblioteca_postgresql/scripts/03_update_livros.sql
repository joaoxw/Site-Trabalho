-- Validação de UPDATE:
-- aumenta em 1 a quantidade de exemplares de "1984".
UPDATE livros
SET quantidade = quantidade + 1
WHERE isbn = '9780000000003';

-- Consulta para conferir o resultado.
SELECT id_livro, titulo, quantidade
FROM livros
WHERE isbn = '9780000000003';
