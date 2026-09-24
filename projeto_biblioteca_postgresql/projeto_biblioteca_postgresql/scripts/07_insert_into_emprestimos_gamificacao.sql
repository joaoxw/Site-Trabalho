-- Empréstimos adicionais de demonstração, no mesmo padrão idempotente do
-- script 02_insert_into_emprestimos.sql, apenas para dar volume suficiente
-- de histórico e permitir demonstrar pontos, níveis, conquistas e ranking
-- com leitores e livros que já existem no projeto (nenhum leitor/livro novo).

-- João Silva: devolução no prazo (1984)
INSERT INTO emprestimos (id_livro, id_leitor, data_emprestimo, data_prevista, data_devolucao)
SELECT l.id_livro, le.id_leitor, '2026-08-01', '2026-08-11', '2026-08-10'
FROM livros l, leitores le
WHERE l.isbn = '9780000000003' AND le.email = 'joao.silva@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM emprestimos e
      WHERE e.id_livro = l.id_livro AND e.id_leitor = le.id_leitor AND e.data_emprestimo = '2026-08-01'
  );

-- João Silva: devolução atrasada (Harry Potter)
INSERT INTO emprestimos (id_livro, id_leitor, data_emprestimo, data_prevista, data_devolucao)
SELECT l.id_livro, le.id_leitor, '2026-08-15', '2026-08-25', '2026-08-28'
FROM livros l, leitores le
WHERE l.isbn = '9780000000002' AND le.email = 'joao.silva@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM emprestimos e
      WHERE e.id_livro = l.id_livro AND e.id_leitor = le.id_leitor AND e.data_emprestimo = '2026-08-15'
  );

-- João Silva: devolução no prazo (A Hora da Estrela)
INSERT INTO emprestimos (id_livro, id_leitor, data_emprestimo, data_prevista, data_devolucao)
SELECT l.id_livro, le.id_leitor, '2026-09-01', '2026-09-08', '2026-09-07'
FROM livros l, leitores le
WHERE l.isbn = '9780000000004' AND le.email = 'joao.silva@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM emprestimos e
      WHERE e.id_livro = l.id_livro AND e.id_leitor = le.id_leitor AND e.data_emprestimo = '2026-09-01'
  );

-- Maria Souza: devolução no prazo (Dom Casmurro)
INSERT INTO emprestimos (id_livro, id_leitor, data_emprestimo, data_prevista, data_devolucao)
SELECT l.id_livro, le.id_leitor, '2026-08-05', '2026-08-15', '2026-08-14'
FROM livros l, leitores le
WHERE l.isbn = '9780000000001' AND le.email = 'maria.souza@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM emprestimos e
      WHERE e.id_livro = l.id_livro AND e.id_leitor = le.id_leitor AND e.data_emprestimo = '2026-08-05'
  );

-- Maria Souza: devolução no prazo (1984)
INSERT INTO emprestimos (id_livro, id_leitor, data_emprestimo, data_prevista, data_devolucao)
SELECT l.id_livro, le.id_leitor, '2026-08-20', '2026-08-30', '2026-08-29'
FROM livros l, leitores le
WHERE l.isbn = '9780000000003' AND le.email = 'maria.souza@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM emprestimos e
      WHERE e.id_livro = l.id_livro AND e.id_leitor = le.id_leitor AND e.data_emprestimo = '2026-08-20'
  );

-- Maria Souza: devolução no prazo (A Hora da Estrela)
INSERT INTO emprestimos (id_livro, id_leitor, data_emprestimo, data_prevista, data_devolucao)
SELECT l.id_livro, le.id_leitor, '2026-09-02', '2026-09-09', '2026-09-09'
FROM livros l, leitores le
WHERE l.isbn = '9780000000004' AND le.email = 'maria.souza@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM emprestimos e
      WHERE e.id_livro = l.id_livro AND e.id_leitor = le.id_leitor AND e.data_emprestimo = '2026-09-02'
  );

-- Maria Souza: devolução no prazo (Dom Casmurro, segunda leitura)
INSERT INTO emprestimos (id_livro, id_leitor, data_emprestimo, data_prevista, data_devolucao)
SELECT l.id_livro, le.id_leitor, '2026-09-10', '2026-09-20', '2026-09-18'
FROM livros l, leitores le
WHERE l.isbn = '9780000000001' AND le.email = 'maria.souza@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM emprestimos e
      WHERE e.id_livro = l.id_livro AND e.id_leitor = le.id_leitor AND e.data_emprestimo = '2026-09-10'
  );

-- Ana Oliveira: empréstimo em andamento, ainda não devolvido (A Hora da Estrela)
INSERT INTO emprestimos (id_livro, id_leitor, data_emprestimo, data_prevista, data_devolucao)
SELECT l.id_livro, le.id_leitor, '2026-09-01', '2026-09-08', NULL
FROM livros l, leitores le
WHERE l.isbn = '9780000000004' AND le.email = 'ana.oliveira@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM emprestimos e
      WHERE e.id_livro = l.id_livro AND e.id_leitor = le.id_leitor AND e.data_emprestimo = '2026-09-01'
  );

-- Ana Oliveira: devolução no prazo (Harry Potter)
INSERT INTO emprestimos (id_livro, id_leitor, data_emprestimo, data_prevista, data_devolucao)
SELECT l.id_livro, le.id_leitor, '2026-09-10', '2026-09-20', '2026-09-19'
FROM livros l, leitores le
WHERE l.isbn = '9780000000002' AND le.email = 'ana.oliveira@example.com'
  AND NOT EXISTS (
      SELECT 1 FROM emprestimos e
      WHERE e.id_livro = l.id_livro AND e.id_leitor = le.id_leitor AND e.data_emprestimo = '2026-09-10'
  );
