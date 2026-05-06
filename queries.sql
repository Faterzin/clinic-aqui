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

--3. Quais pacientes nunca realizaram nenhuma consulta na clínica? Mostre o nome completo e a data de cadastro
SELECT nome, data_consulta
FROM pacientes 
LEFT JOIN consultas  ON consultas = pacientes
WHERE id_paciente IS NULL;

--4. Qual o medicamento mais prescrito nos últimos 90 dias? Mostre o nome do medicamento e a contagem de prescrições.
SELECT m.nome_comercial AS medicamento,
       COUNT(*) AS total_prescricao
FROM prescricoes p  
JOIN medicamentos m  ON  m.id = p.id_medicamento
WHERE p.criada_em >= p.criada_em - INTERVAL '90 DAY'
GROUP BY m.nome_comercial
ORDER BY total_prescricao DESC
LIMIT 2;

/* ================(QUESTÃO 5)====================
Quais médicos tiveram mais de 20% de taxa de ausência nos últimos 30 dias? 
Considere ausência agendamentos com status "faltou" ou "cancelado" pelo paciente. 
Mostre o nome do médico e o percentual calculado.

Desenvolvimento de uma consulta SQL com o objetivo de identificar médicos que apresentam taxa de ausência superior a 20% no período dos últimos 30 dias.

A consulta realiza:

* Junção entre as tabelas de agendamentos (ou consultas) e médicos;
* Filtro de registros dos últimos 30 dias;
* Identificação de ausências com status "faltou" ou "cancelado";
* Cálculo do percentual de ausência com base no total de atendimentos;
* Aplicação de cláusula HAVING para selecionar apenas médicos com taxa superior a 20%.

O resultado apresenta o nome do médico e o percentual de ausências calculado.
*/

-- NOME: Giovanna Menezes

SELECT 
    m.nome,
    ROUND(
        100.0 * SUM(
            CASE 
                WHEN c.status IN ('faltou', 'cancelado') THEN 1 
                ELSE 0 
            END
        ) / COUNT(*),
    2) AS percentual_ausencia

FROM agendamentos c

JOIN medicos m 
    ON c.id_medico = m.id_medico

WHERE 
    c.data >= CURRENT_DATE - INTERVAL '30 days'

GROUP BY 
    m.nome

HAVING 
    SUM(
        CASE 
            WHEN c.status IN ('faltou', 'cancelado') THEN 1 
            ELSE 0 
        END
    ) * 1.0 / COUNT(*) > 0.2

ORDER BY 
    percentual_ausencia DESC;

select * from agendamentos



/*=================================================================================
Quais pacientes foram atendidos por mais de um médico diferente nos últimos 6 meses?
 Mostre o nome do paciente e a contagem de médicos distintos.

Desenvolvimento de uma consulta SQL com o objetivo de identificar pacientes que foram atendidos por mais de um médico 
distinto no período dos últimos 6 meses.

A consulta realiza:

* Junção entre as tabelas de agendamentos e pacientes;
* Filtro de registros com status "realizada";
* Restrição temporal considerando os últimos 6 meses;
* Contagem de médicos distintos por paciente utilizando COUNT(DISTINCT);
* Aplicação de cláusula HAVING para selecionar apenas pacientes com mais de um médico.

O resultado apresenta o nome do paciente e a quantidade de médicos distintos que o atenderam.

 ==================================================================================*/

 -- NOME: Giovanna Menezes

SELECT 
    p.nome,
    COUNT(DISTINCT c.id_medico) AS qtd_medicos
FROM agendamentos c
JOIN paciente p 
    ON c.id_paciente = p.id_paciente
WHERE 
    c.data >= CURRENT_DATE - INTERVAL '6 months'
    AND c.status = 'realizada'
GROUP BY 
    p.nome
HAVING 
    COUNT(DISTINCT c.id_medico) > 1;
    select * from pacientes

-- 7. Qual a duração média das consultas por especialidade? Mostre apenas especialidades com pelo menos 5 consultas realizadas. Ordene da maior duração média para a menor.

SELECT
    e.nome AS especialidade,
    AVG(a.fim_em - a.inicio_em) AS duracao_media
FROM consultas c
JOIN agendamentos a ON c.id_agendamento = a.id
JOIN medicos m ON c.id_medico = m.id
JOIN especialidades e ON m.id_especialidade = e.id
WHERE c.status = 'REALIZADA'
  AND a.fim_em IS NOT NULL
GROUP BY e.nome
HAVING COUNT(*) >= 5
ORDER BY duracao_media DESC;

-- 8. Quais pacientes receberam prescrição de medicamento controlado nos últimos 30 dias? Mostre o nome do paciente, o medicamento e o médico que prescreveu.
 
SELECT
    p.nome AS paciente,
    med.nome_comercial AS medicamento,
    m.nome AS medico
FROM prescricoes pr
JOIN consultas c ON pr.id_consulta = c.id
JOIN pacientes p ON c.id_paciente = p.id
JOIN medicos m ON c.id_medico = m.id
JOIN medicamentos med ON pr.id_medicamento = med.id
WHERE pr.criada_em >= NOW() - INTERVAL '30 days'
  AND med.categoria = 'CONTROLADO'
ORDER BY pr.criada_em DESC;
