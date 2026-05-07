-- Seed para clinic-aqui
-- Data de referência: 2026-05-06
-- Janela "últimos 2 meses": 2026-03-06 → 2026-05-06

TRUNCATE TABLE prescricoes, consultas, agendamentos, medicamentos,
               pacientes, medicos, especialidades, status_vinculo, convenios
RESTART IDENTITY CASCADE;

-- =============================================================
-- Convênios (4)
-- =============================================================
INSERT INTO convenios (nome, codigo_operadora, procedimentos) VALUES
    ('Unimed',         'UNI001', 'Consultas, exames laboratoriais, internação'),
    ('Bradesco Saúde', 'BRA002', 'Consultas, exames de imagem, cirurgias eletivas'),
    ('Amil',           'AMI003', 'Consultas, exames laboratoriais e de imagem'),
    ('SulAmérica',     'SUL004', 'Consultas e exames de rotina');

-- =============================================================
-- Status de vínculo (2)
-- =============================================================
INSERT INTO status_vinculo (nome) VALUES ('ATIVO'), ('INATIVO');

-- =============================================================
-- Especialidades (6)
-- =============================================================
INSERT INTO especialidades (nome, descricao) VALUES
    ('Cardiologia',    'Diagnóstico e tratamento de doenças do coração'),
    ('Pediatria',      'Saúde de crianças e adolescentes'),
    ('Dermatologia',   'Pele, cabelo e unhas'),
    ('Ortopedia',      'Sistema musculoesquelético'),
    ('Ginecologia',    'Saúde da mulher'),
    ('Clínica Geral',  'Atendimento médico geral');

-- =============================================================
-- Médicos (9 — 8 ativos + 1 inativo, especialidades variadas)
-- =============================================================
INSERT INTO medicos (nome, crm, id_especialidade, telefone, email, id_status_vinculo) VALUES
    ('Dr. Ricardo Silva',     'CRM-SP-12001', 1, '11999000001', 'ricardo.silva@clinic.com',     1),
    ('Dra. Ana Costa',        'CRM-SP-12002', 2, '11999000002', 'ana.costa@clinic.com',         1),
    ('Dr. Bruno Lima',        'CRM-SP-12003', 3, '11999000003', 'bruno.lima@clinic.com',        1),
    ('Dra. Carla Rocha',      'CRM-SP-12004', 4, '11999000004', 'carla.rocha@clinic.com',       1),
    ('Dr. Daniel Souza',      'CRM-SP-12005', 5, '11999000005', 'daniel.souza@clinic.com',      1),
    ('Dra. Eliane Martins',   'CRM-SP-12006', 6, '11999000006', 'eliane.martins@clinic.com',    1),
    ('Dr. Felipe Alves',      'CRM-SP-12007', 1, '11999000007', 'felipe.alves@clinic.com',      1),
    ('Dra. Gabriela Pinto',   'CRM-SP-12008', 2, '11999000008', 'gabriela.pinto@clinic.com',    1),
    ('Dr. Henrique Dias',     'CRM-SP-12009', 4, '11999000009', 'henrique.dias@clinic.com',     2);

-- =============================================================
-- Pacientes (42 — 5 inativos, variação de convênios incl. sem convênio)
-- =============================================================
INSERT INTO pacientes (nome, data_nascimento, contato, endereco, email, status, id_convenio) VALUES
    ('João Pereira',         '1985-04-12', '11988000001', 'Rua A, 100, São Paulo',   'joao.pereira@mail.com',     'ATIVO',   1),
    ('Maria Oliveira',       '1990-09-23', '11988000002', 'Rua B, 200, São Paulo',   'maria.oliveira@mail.com',   'ATIVO',   2),
    ('Carlos Santos',        '1978-01-05', '11988000003', 'Rua C, 300, São Paulo',   'carlos.santos@mail.com',    'ATIVO',   1),
    ('Fernanda Almeida',     '1995-07-19', '11988000004', 'Rua D, 400, São Paulo',   'fernanda.almeida@mail.com', 'ATIVO',   3),
    ('Paulo Ribeiro',        '1982-11-30', '11988000005', 'Rua E, 500, São Paulo',   'paulo.ribeiro@mail.com',    'ATIVO',   2),
    ('Juliana Mendes',       '1992-03-14', '11988000006', 'Rua F, 600, São Paulo',   'juliana.mendes@mail.com',   'ATIVO',   4),
    ('Roberto Castro',       '1970-06-08', '11988000007', 'Rua G, 700, São Paulo',   'roberto.castro@mail.com',   'ATIVO',   1),
    ('Patrícia Gomes',       '1988-12-01', '11988000008', 'Rua H, 800, São Paulo',   'patricia.gomes@mail.com',   'ATIVO',   3),
    ('Lucas Moreira',        '2000-05-25', '11988000009', 'Rua I, 900, São Paulo',   'lucas.moreira@mail.com',    'ATIVO',   NULL),
    ('Camila Ferreira',      '1996-08-17', '11988000010', 'Rua J, 1000, São Paulo',  'camila.ferreira@mail.com',  'ATIVO',   2),
    ('André Barbosa',        '1975-02-22', '11988000011', 'Rua K, 1100, São Paulo',  'andre.barbosa@mail.com',    'ATIVO',   1),
    ('Beatriz Cardoso',      '1993-10-09', '11988000012', 'Rua L, 1200, São Paulo',  'beatriz.cardoso@mail.com',  'ATIVO',   4),
    ('Diego Nunes',          '1987-04-03', '11988000013', 'Rua M, 1300, São Paulo',  'diego.nunes@mail.com',      'ATIVO',   2),
    ('Eduarda Tavares',      '1998-11-27', '11988000014', 'Rua N, 1400, São Paulo',  'eduarda.tavares@mail.com',  'ATIVO',   3),
    ('Fábio Rezende',        '1980-07-15', '11988000015', 'Rua O, 1500, São Paulo',  'fabio.rezende@mail.com',    'ATIVO',   1),
    ('Gabriela Souto',       '1991-01-31', '11988000016', 'Rua P, 1600, São Paulo',  'gabriela.souto@mail.com',   'ATIVO',   NULL),
    ('Hugo Carvalho',        '1972-09-12', '11988000017', 'Rua Q, 1700, São Paulo',  'hugo.carvalho@mail.com',    'ATIVO',   2),
    ('Isabela Freitas',      '1999-03-08', '11988000018', 'Rua R, 1800, São Paulo',  'isabela.freitas@mail.com',  'ATIVO',   4),
    ('José Antunes',         '1965-12-20', '11988000019', 'Rua S, 1900, São Paulo',  'jose.antunes@mail.com',     'ATIVO',   1),
    ('Karina Lopes',         '1989-06-05', '11988000020', 'Rua T, 2000, São Paulo',  'karina.lopes@mail.com',     'ATIVO',   3),
    ('Leonardo Vieira',      '1994-02-18', '11988000021', 'Av A, 100, São Paulo',    'leonardo.vieira@mail.com',  'ATIVO',   2),
    ('Mariana Brito',        '1986-08-29', '11988000022', 'Av B, 200, São Paulo',    'mariana.brito@mail.com',    'ATIVO',   1),
    ('Nicolas Prado',        '2002-04-14', '11988000023', 'Av C, 300, São Paulo',    'nicolas.prado@mail.com',    'ATIVO',   NULL),
    ('Olivia Cunha',         '1997-10-02', '11988000024', 'Av D, 400, São Paulo',    'olivia.cunha@mail.com',     'ATIVO',   4),
    ('Pedro Henrique',       '1981-05-21', '11988000025', 'Av E, 500, São Paulo',    'pedro.henrique@mail.com',   'ATIVO',   2),
    ('Quésia Ramos',         '1990-12-11', '11988000026', 'Av F, 600, São Paulo',    'quesia.ramos@mail.com',     'ATIVO',   3),
    ('Rafael Teixeira',      '1984-07-07', '11988000027', 'Av G, 700, São Paulo',    'rafael.teixeira@mail.com',  'ATIVO',   1),
    ('Sabrina Macedo',       '1993-09-19', '11988000028', 'Av H, 800, São Paulo',    'sabrina.macedo@mail.com',   'ATIVO',   2),
    ('Thiago Borges',        '1979-03-26', '11988000029', 'Av I, 900, São Paulo',    'thiago.borges@mail.com',    'ATIVO',   4),
    ('Úrsula Pacheco',       '1995-11-04', '11988000030', 'Av J, 1000, São Paulo',   'ursula.pacheco@mail.com',   'ATIVO',   1),
    ('Vinícius Coelho',      '1988-01-22', '11988000031', 'Av K, 1100, São Paulo',   'vinicius.coelho@mail.com',  'ATIVO',   3),
    ('Wagner Moura',         '1973-10-15', '11988000032', 'Av L, 1200, São Paulo',   'wagner.moura@mail.com',     'ATIVO',   2),
    ('Xênia Duarte',         '2001-06-30', '11988000033', 'Av M, 1300, São Paulo',   'xenia.duarte@mail.com',     'ATIVO',   NULL),
    ('Yago Marinho',         '1992-04-09', '11988000034', 'Av N, 1400, São Paulo',   'yago.marinho@mail.com',     'ATIVO',   1),
    ('Zilda Faria',          '1968-08-13', '11988000035', 'Av O, 1500, São Paulo',   'zilda.faria@mail.com',      'ATIVO',   4),
    ('Aline Bastos',         '1991-12-25', '11988000036', 'Av P, 1600, São Paulo',   'aline.bastos@mail.com',     'ATIVO',   2),
    ('Breno Camargo',        '1985-05-17', '11988000037', 'Av Q, 1700, São Paulo',   'breno.camargo@mail.com',    'ATIVO',   3),
    -- 5 inativos
    ('Cláudia Salvador',     '1976-02-28', '11988000038', 'Av R, 1800, São Paulo',   'claudia.salvador@mail.com', 'INATIVO', 1),
    ('Davi Monteiro',        '1983-09-06', '11988000039', 'Av S, 1900, São Paulo',   'davi.monteiro@mail.com',    'INATIVO', 2),
    ('Elaine Pires',         '1990-07-23', '11988000040', 'Av T, 2000, São Paulo',   'elaine.pires@mail.com',     'INATIVO', 3),
    ('Fausto Galvão',        '1971-11-11', '11988000041', 'Av U, 2100, São Paulo',   'fausto.galvao@mail.com',    'INATIVO', NULL),
    ('Geovana Sales',        '1996-03-04', '11988000042', 'Av V, 2200, São Paulo',   'geovana.sales@mail.com',    'INATIVO', 4);

-- =============================================================
-- Medicamentos (16)
-- =============================================================
INSERT INTO medicamentos (nome_comercial, principio_ativo, categoria) VALUES
    ('Losartana',     'Losartana Potássica',     'COMUM'),
    ('Atenolol',      'Atenolol',                'COMUM'),
    ('Amoxicilina',   'Amoxicilina',             'COMUM'),
    ('Dipirona',      'Dipirona Sódica',         'COMUM'),
    ('Paracetamol',   'Paracetamol',             'COMUM'),
    ('Ibuprofeno',    'Ibuprofeno',              'COMUM'),
    ('Omeprazol',     'Omeprazol',               'COMUM'),
    ('Metformina',    'Metformina',              'COMUM'),
    ('Sinvastatina',  'Sinvastatina',            'COMUM'),
    ('Loratadina',    'Loratadina',              'COMUM'),
    ('Cetoconazol',   'Cetoconazol',             'COMUM'),
    ('Azitromicina',  'Azitromicina',            'COMUM'),
    ('Rivotril',      'Clonazepam',              'CONTROLADO'),
    ('Ritalina',      'Metilfenidato',           'CONTROLADO'),
    ('Tramal',        'Cloridrato de Tramadol',  'CONTROLADO'),
    ('Prozac',        'Fluoxetina',              'CONTROLADO');

-- =============================================================
-- Agendamentos (65)
--   30 REALIZADA  (id  1..30)  → cada uma gera uma consulta
--   15 AGENDADA   (id 31..45)  → futuras
--   10 CANCELADA  (id 46..55)
--   10 FALTOU     (id 56..65)
-- =============================================================
INSERT INTO agendamentos (id_medico, id_paciente, inicio_em, fim_em, observacoes, status) VALUES
    -- REALIZADA (30)
    (1,  1,  '2026-03-09 08:00', '2026-03-09 08:30', 'Consulta de rotina',           'REALIZADA'),
    (2,  2,  '2026-03-10 09:00', '2026-03-10 09:30', 'Acompanhamento pediátrico',    'REALIZADA'),
    (3,  3,  '2026-03-11 10:00', '2026-03-11 10:30', 'Avaliação dermatológica',      'REALIZADA'),
    (4,  4,  '2026-03-12 14:00', '2026-03-12 14:30', 'Dor lombar',                   'REALIZADA'),
    (5,  5,  '2026-03-13 15:00', '2026-03-13 15:30', 'Consulta ginecológica',        'REALIZADA'),
    (6,  6,  '2026-03-16 08:30', '2026-03-16 09:00', 'Check-up geral',               'REALIZADA'),
    (7,  7,  '2026-03-17 09:30', '2026-03-17 10:00', 'Hipertensão',                  'REALIZADA'),
    (8,  8,  '2026-03-18 10:30', '2026-03-18 11:00', 'Vacinação infantil',           'REALIZADA'),
    (1,  9,  '2026-03-19 11:00', '2026-03-19 11:30', 'Arritmia leve',                'REALIZADA'),
    (2, 10,  '2026-03-20 14:00', '2026-03-20 14:30', 'Otite recorrente',             'REALIZADA'),
    (3, 11,  '2026-03-23 15:00', '2026-03-23 15:30', 'Dermatite',                    'REALIZADA'),
    (4, 12,  '2026-03-24 08:00', '2026-03-24 08:30', 'Tendinite',                    'REALIZADA'),
    (5, 13,  '2026-03-25 09:00', '2026-03-25 09:30', 'Pré-natal',                    'REALIZADA'),
    (6, 14,  '2026-03-26 10:00', '2026-03-26 10:30', 'Gripe',                        'REALIZADA'),
    (7, 15,  '2026-03-27 11:00', '2026-03-27 11:30', 'Pressão alta',                 'REALIZADA'),
    (8, 16,  '2026-03-30 14:00', '2026-03-30 14:30', 'Asma infantil',                'REALIZADA'),
    (1, 17,  '2026-03-31 15:00', '2026-03-31 15:30', 'Colesterol',                   'REALIZADA'),
    (2, 18,  '2026-04-01 08:30', '2026-04-01 09:00', 'Resfriado',                    'REALIZADA'),
    (3, 19,  '2026-04-02 09:30', '2026-04-02 10:00', 'Acne severa',                  'REALIZADA'),
    (4, 20,  '2026-04-03 10:30', '2026-04-03 11:00', 'Lesão no joelho',              'REALIZADA'),
    (5, 21,  '2026-04-06 11:30', '2026-04-06 12:00', 'Anticoncepcional',             'REALIZADA'),
    (6, 22,  '2026-04-07 14:30', '2026-04-07 15:00', 'Dor de cabeça',                'REALIZADA'),
    (7, 23,  '2026-04-08 15:30', '2026-04-08 16:00', 'Avaliação cardíaca',           'REALIZADA'),
    (8, 24,  '2026-04-09 08:00', '2026-04-09 08:30', 'Bronquite infantil',           'REALIZADA'),
    (1, 25,  '2026-04-10 09:00', '2026-04-10 09:30', 'Insuficiência cardíaca',       'REALIZADA'),
    (2, 26,  '2026-04-13 10:00', '2026-04-13 10:30', 'Consulta pediátrica',          'REALIZADA'),
    (3, 27,  '2026-04-14 14:00', '2026-04-14 14:30', 'Manchas na pele',              'REALIZADA'),
    (4, 28,  '2026-04-15 15:00', '2026-04-15 15:30', 'Fratura no pulso',             'REALIZADA'),
    (5, 29,  '2026-04-16 08:30', '2026-04-16 09:00', 'Climatério',                   'REALIZADA'),
    (6, 30,  '2026-04-17 09:30', '2026-04-17 10:00', 'Dor estomacal',                'REALIZADA'),

    -- AGENDADA (15) — futuras
    (1, 31,  '2026-05-07 08:00', '2026-05-08 08:30', NULL, 'AGENDADA'),
    (2, 32,  '2026-05-07 09:00', '2026-05-08 09:30', NULL, 'AGENDADA'),
    (3, 33,  '2026-05-07 10:00', '2026-05-09 10:30', NULL, 'AGENDADA'),
    (4, 34,  '2026-05-07 11:00', '2026-05-09 11:30', NULL, 'AGENDADA'),
    (5, 35,  '2026-05-07 14:00', '2026-05-11 14:30', NULL, 'AGENDADA'),
    (6, 36,  '2026-05-11 15:00', '2026-05-11 15:30', NULL, 'AGENDADA'),
    (7, 37,  '2026-05-12 08:30', '2026-05-12 09:00', NULL, 'AGENDADA'),
    (8,  1,  '2026-05-12 09:30', '2026-05-12 10:00', NULL, 'AGENDADA'),
    (1,  2,  '2026-05-13 10:30', '2026-05-13 11:00', NULL, 'AGENDADA'),
    (2,  3,  '2026-05-13 11:30', '2026-05-13 12:00', NULL, 'AGENDADA'),
    (3,  4,  '2026-05-14 14:30', '2026-05-14 15:00', NULL, 'AGENDADA'),
    (4,  5,  '2026-05-14 15:30', '2026-05-14 16:00', NULL, 'AGENDADA'),
    (5,  6,  '2026-05-15 08:00', '2026-05-15 08:30', NULL, 'AGENDADA'),
    (6,  7,  '2026-05-18 09:00', '2026-05-18 09:30', NULL, 'AGENDADA'),
    (7,  8,  '2026-05-19 10:00', '2026-05-19 10:30', NULL, 'AGENDADA'),

    -- CANCELADA (10)
    (1,  9,  '2026-03-15 08:00', '2026-03-15 08:30', 'Paciente cancelou',            'CANCELADA'),
    (2, 10,  '2026-03-22 09:00', '2026-03-22 09:30', 'Reagendamento solicitado',     'CANCELADA'),
    (3, 11,  '2026-03-29 10:00', '2026-03-29 10:30', 'Médico indisponível',          'CANCELADA'),
    (4, 12,  '2026-04-05 14:00', '2026-04-05 14:30', 'Paciente cancelou',            'CANCELADA'),
    (5, 13,  '2026-04-12 15:00', '2026-04-12 15:30', 'Reagendamento solicitado',     'CANCELADA'),
    (6, 14,  '2026-04-19 08:30', '2026-04-19 09:00', 'Paciente cancelou',            'CANCELADA'),
    (7, 15,  '2026-04-21 09:30', '2026-04-21 10:00', 'Cancelado por motivo pessoal', 'CANCELADA'),
    (8, 16,  '2026-04-23 10:30', '2026-04-23 11:00', 'Paciente cancelou',            'CANCELADA'),
    (1, 38,  '2026-04-25 11:00', '2026-04-25 11:30', 'Inativação do paciente',       'CANCELADA'),
    (2, 39,  '2026-04-28 14:30', '2026-04-28 15:00', 'Inativação do paciente',       'CANCELADA'),

    -- FALTOU (10)
    (3, 17,  '2026-03-14 14:00', '2026-03-14 14:30', 'Não compareceu',               'FALTOU'),
    (4, 18,  '2026-03-21 15:00', '2026-03-21 15:30', 'Não compareceu',               'FALTOU'),
    (5, 19,  '2026-03-28 08:00', '2026-03-28 08:30', 'Não compareceu',               'FALTOU'),
    (6, 20,  '2026-04-04 09:00', '2026-04-04 09:30', 'Não compareceu',               'FALTOU'),
    (7, 21,  '2026-04-11 10:00', '2026-04-11 10:30', 'Não compareceu',               'FALTOU'),
    (8, 22,  '2026-04-18 11:00', '2026-04-18 11:30', 'Não compareceu',               'FALTOU'),
    (1, 23,  '2026-04-22 14:00', '2026-04-22 14:30', 'Não compareceu',               'FALTOU'),
    (2, 24,  '2026-04-24 15:00', '2026-04-24 15:30', 'Não compareceu',               'FALTOU'),
    (3, 40,  '2026-04-27 08:30', '2026-04-27 09:00', 'Paciente inativo, não veio',   'FALTOU'),
    (4, 41,  '2026-04-30 09:30', '2026-04-30 10:00', 'Paciente inativo, não veio',   'FALTOU');

-- =============================================================
-- Consultas (30) — uma para cada agendamento REALIZADA (id 1..30)
-- =============================================================
INSERT INTO consultas (id_agendamento, id_medico, id_paciente, data_consulta, status, observacoes) VALUES
    (1,  1,  1,  '2026-03-09 08:05', 'REALIZADA', 'PA 130/85 — orientado dieta'),
    (2,  2,  2,  '2026-03-10 09:05', 'REALIZADA', 'Crescimento adequado'),
    (3,  3,  3,  '2026-03-11 10:05', 'REALIZADA', 'Eczema em braços'),
    (4,  4,  4,  '2026-03-12 14:05', 'REALIZADA', 'Lombalgia mecânica'),
    (5,  5,  5,  '2026-03-13 15:05', 'REALIZADA', 'Exames de rotina solicitados'),
    (6,  6,  6,  '2026-03-16 08:35', 'REALIZADA', 'Hemograma normal'),
    (7,  7,  7,  '2026-03-17 09:35', 'REALIZADA', 'Hipertensão estágio 1'),
    (8,  8,  8,  '2026-03-18 10:35', 'REALIZADA', 'Vacinas em dia'),
    (9,  1,  9,  '2026-03-19 11:05', 'REALIZADA', 'Holter solicitado'),
    (10, 2, 10,  '2026-03-20 14:05', 'REALIZADA', 'Otite média aguda'),
    (11, 3, 11,  '2026-03-23 15:05', 'REALIZADA', 'Dermatite atópica'),
    (12, 4, 12,  '2026-03-24 08:05', 'REALIZADA', 'Tendinite no ombro'),
    (13, 5, 13,  '2026-03-25 09:05', 'REALIZADA', 'Gestação 12 semanas'),
    (14, 6, 14,  '2026-03-26 10:05', 'REALIZADA', 'Síndrome gripal'),
    (15, 7, 15,  '2026-03-27 11:05', 'REALIZADA', 'Ajuste de medicação'),
    (16, 8, 16,  '2026-03-30 14:05', 'REALIZADA', 'Asma controlada'),
    (17, 1, 17,  '2026-03-31 15:05', 'REALIZADA', 'Dislipidemia'),
    (18, 2, 18,  '2026-04-01 08:35', 'REALIZADA', 'Resfriado comum'),
    (19, 3, 19,  '2026-04-02 09:35', 'REALIZADA', 'Acne grau III'),
    (20, 4, 20,  '2026-04-03 10:35', 'REALIZADA', 'Entorse de joelho'),
    (21, 5, 21,  '2026-04-06 11:35', 'REALIZADA', 'Prescrição renovada'),
    (22, 6, 22,  '2026-04-07 14:35', 'REALIZADA', 'Cefaleia tensional'),
    (23, 7, 23,  '2026-04-08 15:35', 'REALIZADA', 'Eletro normal'),
    (24, 8, 24,  '2026-04-09 08:05', 'REALIZADA', 'Bronquite viral'),
    (25, 1, 25,  '2026-04-10 09:05', 'REALIZADA', 'IC classe II — ajuste'),
    (26, 2, 26,  '2026-04-13 10:05', 'REALIZADA', 'Avaliação geral OK'),
    (27, 3, 27,  '2026-04-14 14:05', 'REALIZADA', 'Hipercromia pós-inflamatória'),
    (28, 4, 28,  '2026-04-15 15:05', 'REALIZADA', 'Fratura distal do rádio'),
    (29, 5, 29,  '2026-04-16 08:35', 'REALIZADA', 'Sintomas vasomotores'),
    (30, 6, 30,  '2026-04-17 09:35', 'REALIZADA', 'Gastrite leve');

-- =============================================================
-- Prescrições — 22 consultas com prescrições (1..3 medicamentos cada)
-- =============================================================
INSERT INTO prescricoes (id_consulta, id_medicamento, dosagem, frequencia, duracao_tratamento) VALUES
    -- Consulta 1 (Cardio — hipertensão)
    (1,  1, '50mg',  '1x ao dia',     30),
    (1,  9, '20mg',  '1x ao dia à noite', 30),
    -- Consulta 3 (Dermato)
    (3, 11, 'Tópico', '2x ao dia',    14),
    -- Consulta 4 (Ortopedia)
    (4,  6, '600mg', '8/8h',          7),
    (4,  4, '500mg', 'Se dor',        5),
    -- Consulta 7 (Cardio — hipertensão)
    (7,  1, '50mg',  '1x ao dia',     60),
    (7,  2, '25mg',  '1x ao dia',     60),
    -- Consulta 9 (Cardio)
    (9,  1, '100mg', '1x ao dia',     30),
    -- Consulta 10 (Pediatria — otite)
    (10, 3, '500mg', '8/8h',          7),
    (10, 4, '500mg', 'Se febre',      3),
    -- Consulta 11 (Dermato)
    (11, 10, '10mg', '1x ao dia',     20),
    -- Consulta 12 (Ortopedia)
    (12, 6, '600mg', '12/12h',        10),
    -- Consulta 14 (Clínica — gripe)
    (14, 5, '750mg', '8/8h',          5),
    (14, 4, '500mg', '6/6h se dor',   3),
    -- Consulta 15 (Cardio)
    (15, 1, '50mg',  '1x ao dia',     90),
    (15, 9, '40mg',  '1x ao dia',     90),
    -- Consulta 16 (Pediatria — asma)
    (16, 6, '200mg', '8/8h',          5),
    -- Consulta 17 (Cardio — colesterol)
    (17, 9, '20mg',  '1x ao dia',     60),
    -- Consulta 18 (Pediatria — resfriado)
    (18, 5, '500mg', '6/6h se febre', 5),
    -- Consulta 19 (Dermato — acne)
    (19, 12, '500mg', '1x ao dia',    10),
    -- Consulta 20 (Ortopedia — entorse)
    (20, 6, '600mg', '8/8h',          7),
    (20, 15, '50mg', 'Se dor',        5),
    -- Consulta 22 (Clínica — cefaleia)
    (22, 4, '1g',    'Se dor',        7),
    (22, 13, '0,5mg', '1x à noite',   30),
    -- Consulta 24 (Pediatria — bronquite)
    (24, 12, '200mg', '1x ao dia',    5),
    -- Consulta 25 (Cardio — IC)
    (25, 1, '50mg',  '1x ao dia',     90),
    (25, 2, '25mg',  '1x ao dia',     90),
    (25, 9, '20mg',  '1x ao dia',     90),
    -- Consulta 27 (Dermato)
    (27, 11, 'Tópico', '1x à noite',  30),
    -- Consulta 28 (Ortopedia — fratura)
    (28, 15, '50mg', '8/8h',          7),
    (28, 4, '1g',    'Se dor',        7),
    -- Consulta 29 (Ginecologia — climatério)
    (29, 16, '20mg', '1x ao dia',     60),
    -- Consulta 30 (Clínica — gastrite)
    (30, 7,  '20mg', '1x ao dia em jejum', 30);
