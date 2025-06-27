
-- 1. Relatório: Pacientes por médico
SELECT m.nome AS medico, COUNT(c.id) AS total_consultas
FROM medico m
JOIN consulta c ON m.id = c.medico_id
GROUP BY m.nome;

-- 2. Relatório: Consultas agendadas por data
SELECT DATE(data_hora) AS data_consulta, COUNT(*) AS total_agendadas
FROM consulta
WHERE status = 'AGENDADA'
GROUP BY DATE(data_hora)
ORDER BY data_consulta;

-- 3. Relatório: Internações ativas
SELECT p.nome AS paciente, i.quarto, i.data_entrada
FROM internacao i
JOIN paciente p ON i.paciente_id = p.id
WHERE i.data_saida IS NULL;

-- 4. Relatório: Exames pendentes (sem resultado)
SELECT e.id, p.nome AS paciente, e.tipo, c.data_hora
FROM exame e
JOIN consulta c ON e.consulta_id = c.id
JOIN paciente p ON c.paciente_id = p.id
WHERE e.resultado IS NULL;

-- 5. Relatório: Medicamentos prescritos por paciente
SELECT p.nome AS paciente, pr.medicamento, pr.dosagem, pr.frequencia, pr.duracao
FROM prescricao pr
JOIN consulta c ON pr.consulta_id = c.id
JOIN paciente p ON c.paciente_id = p.id
ORDER BY p.nome;
