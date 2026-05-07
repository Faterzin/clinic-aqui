CREATE OR REPLACE VIEW agenda_do_dia AS
SELECT
    p.nome AS nome_paciente,
    m.nome AS medico,
    e.nome AS especialidade,
    a.inicio_em::time AS hora_marcada
FROM agendamentos a
INNER JOIN pacientes p
    ON p.id = a.id_paciente
LEFT JOIN convenios c
    ON c.id = p.id_convenio
INNER JOIN medicos m
    ON m.id = a.id_medico
INNER JOIN especialidades e
    ON e.id = m.id_especialidade
WHERE DATE(a.inicio_em) = CURRENT_DATE
    AND a.status = 'AGENDADA'
ORDER BY a.inicio_em;