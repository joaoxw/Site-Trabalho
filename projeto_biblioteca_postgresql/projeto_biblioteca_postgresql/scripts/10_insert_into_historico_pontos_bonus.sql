-- Aplica ao histórico de pontos o pontos_bonus das conquistas já
-- desbloqueadas em 09_insert_into_leitor_conquistas.sql (algumas conquistas,
-- como "Primeiro Empréstimo", têm pontos_bonus = 0 e não geram linha aqui).
INSERT INTO historico_pontos (id_leitor, id_emprestimo, pontos, motivo, data_registro)
SELECT lc.id_leitor, NULL, c.pontos_bonus, 'Bônus conquista: ' || c.nome, lc.data_desbloqueio
FROM leitor_conquistas lc
JOIN conquistas c ON c.id_conquista = lc.id_conquista
WHERE c.pontos_bonus > 0
  AND NOT EXISTS (
      SELECT 1 FROM historico_pontos h
      WHERE h.id_leitor = lc.id_leitor AND h.motivo = 'Bônus conquista: ' || c.nome
  );
