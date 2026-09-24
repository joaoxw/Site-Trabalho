INSERT INTO emprestimos
    (id_livro, id_leitor, data_emprestimo, data_prevista, data_devolucao)
SELECT l.id_livro, le.id_leitor, '2026-09-05', '2026-09-15', NULL
FROM livros l, leitores le
WHERE l.isbn = '9780000000001'
  AND le.email = 'joao.silva@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM emprestimos e
      WHERE e.id_livro = l.id_livro
        AND e.id_leitor = le.id_leitor
        AND e.data_emprestimo = '2026-09-05'
  );

INSERT INTO emprestimos
    (id_livro, id_leitor, data_emprestimo, data_prevista, data_devolucao)
SELECT l.id_livro, le.id_leitor, '2026-09-06', '2026-09-16', '2026-09-10'
FROM livros l, leitores le
WHERE l.isbn = '9780000000002'
  AND le.email = 'maria.souza@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM emprestimos e
      WHERE e.id_livro = l.id_livro
        AND e.id_leitor = le.id_leitor
        AND e.data_emprestimo = '2026-09-06'
  );
