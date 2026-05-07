/*
View: agenda_do_dia
Descrição: Exibe a agenda de consultas agendadas para o dia atual.
Inclui nome do paciente, médico, especialidade e hora marcada.
Filtra apenas agendamentos com status 'AGENDADA' e data atual.
Ordena por hora de início.
*/
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


/*
View: historico_paciente
Descrição: Fornece um histórico resumido de pacientes ativos.
Inclui ID e nome do paciente, total de consultas realizadas,
data e médico da última consulta, e se possui prescrição ativa (últimos 30 dias).
Usa CTEs para calcular métricas: ultima_consulta, total_consultas e prescricao_ativa.
Ordena por nome do paciente.
*/

CREATE OR REPLACE VIEW historico_paciente AS
WITH ultima_consulta AS (
    SELECT
        c.id_paciente,
        c.data_consulta,
        m.nome AS medico_ultimo_atendimento,
        ROW_NUMBER() OVER (
            PARTITION BY c.id_paciente
            ORDER BY c.data_consulta DESC
        ) AS ordem
    FROM consultas c
    INNER JOIN medicos m
        ON m.id = c.id_medico
    WHERE c.status = 'REALIZADA'
),
total_consultas AS (
    SELECT
        id_paciente,
        COUNT(*) AS quantidade_consultas
    FROM consultas
    WHERE status = 'REALIZADA'
    GROUP BY id_paciente
),
prescricao_ativa AS (
    SELECT DISTINCT
        c.id_paciente
    FROM consultas c
    INNER JOIN prescricoes pr
        ON pr.id_consulta = c.id
    WHERE pr.criada_em >= CURRENT_DATE - INTERVAL '30 days'
)
SELECT
    p.id AS id_paciente,
    p.nome AS nome_paciente,
    COALESCE(tc.quantidade_consultas, 0) AS quantidade_consultas_realizadas,
    uc.data_consulta AS data_ultima_consulta,
    uc.medico_ultimo_atendimento,
    CASE
        WHEN pa.id_paciente IS NOT NULL THEN TRUE
        ELSE FALSE
    END AS possui_prescricao_ativa
FROM pacientes p
LEFT JOIN total_consultas tc
    ON tc.id_paciente = p.id
LEFT JOIN ultima_consulta uc
    ON uc.id_paciente = p.id
    AND uc.ordem = 1
LEFT JOIN prescricao_ativa pa
    ON pa.id_paciente = p.id
WHERE p.status = 'ATIVO'
ORDER BY p.nome;
