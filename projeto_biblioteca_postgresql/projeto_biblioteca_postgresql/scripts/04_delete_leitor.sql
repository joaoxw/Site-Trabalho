-- Validação de DELETE:
-- Pedro Santos não possui empréstimos nos dados de exemplo,
-- portanto pode ser excluído sem quebrar uma chave estrangeira.
DELETE FROM leitores
WHERE email = 'pedro.santos@example.com';

-- Consulta para conferir o resultado.
SELECT * FROM leitores ORDER BY id_leitor;
