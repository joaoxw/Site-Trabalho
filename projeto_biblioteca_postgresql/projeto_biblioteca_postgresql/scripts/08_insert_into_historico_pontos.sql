-- Regra de pontuação:
--   Empréstimo realizado.......... +10 pontos
--   Devolução dentro do prazo..... +20 pontos
-- (Reserva não existe no modelo atual, então não gera pontos.)
-- Os pontos são calculados a partir da tabela emprestimos que já existe —
-- nenhum ponto é digitado manualmente. Script idempotente: pode ser
-- executado novamente sem duplicar histórico.

-- +10 por empréstimo realizado
INSERT INTO historico_pontos (id_leitor, id_emprestimo, pontos, motivo, data_registro)
SELECT e.id_leitor, e.id_emprestimo, 10, 'Empréstimo realizado', e.data_emprestimo
FROM emprestimos e
WHERE NOT EXISTS (
    SELECT 1 FROM historico_pontos h
    WHERE h.id_emprestimo = e.id_emprestimo AND h.motivo = 'Empréstimo realizado'
);

-- +20 por devolução dentro do prazo
INSERT INTO historico_pontos (id_leitor, id_emprestimo, pontos, motivo, data_registro)
SELECT e.id_leitor, e.id_emprestimo, 20, 'Devolução no prazo', e.data_devolucao
FROM emprestimos e
WHERE e.data_devolucao IS NOT NULL
  AND e.data_devolucao <= e.data_prevista
  AND NOT EXISTS (
      SELECT 1 FROM historico_pontos h
      WHERE h.id_emprestimo = e.id_emprestimo AND h.motivo = 'Devolução no prazo'
  );
