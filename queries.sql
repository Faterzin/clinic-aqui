--1. Quantas consultas cada médico realizou nos últimos 60 dias? Mostre o nome do médico, a especialidade e a contagem. Ordene do médico com mais consultas para o com menos.

SELECT
    m.nome AS medico,
    e.nome AS especialidade,
    COUNT(c.id) AS total_consultas
FROM
    consultas c
JOIN
    medicos m ON c.id_medico = m.id
JOIN
    especialidades e ON m.id_especialidade = e.id
WHERE
    c.data_consulta >= NOW() - INTERVAL '60 days'
    AND c.status = 'REALIZADA'
GROUP BY
    m.nome, e.nome
ORDER BY
    total_consultas DESC;

--2. Quais pacientes têm agendamento nos próximos 7 dias? Mostre o nome do paciente, o médico, a especialidade e a data e hora do agendamento.

    SELECT 
    p.nome AS paciente,
    m.nome AS medico,
    e.nome AS especialidade,
    a.inicio_em AS data_hora
FROM agendamentos a
inner JOIN pacientes p ON a.id_paciente = p.id
inner JOIN medicos m ON a.id_medico = m.id
inner JOIN especialidades e ON m.id_especialidade = e.id
WHERE a.inicio_em BETWEEN NOW() AND NOW() + INTERVAL '7 days'
  AND a.status = 'AGENDADA'
ORDER BY a.inicio_em ASC;