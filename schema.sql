CREATE TABLE IF NOT EXISTS convenios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    codigo_operadora VARCHAR(20),
    procedimentos TEXT
);

CREATE TABLE IF NOT EXISTS status_vinculo (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS especialidades (
    id BIGSERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    criada_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pacientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    contato VARCHAR(20),
    endereco VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'ATIVO' CHECK (status IN ('ATIVO', 'INATIVO')),
    id_convenio INT REFERENCES convenios(id)
);

CREATE TABLE IF NOT EXISTS medicos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE,
    id_especialidade BIGINT NOT NULL REFERENCES especialidades(id),
    telefone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    id_status_vinculo INT NOT NULL REFERENCES status_vinculo(id)
);

CREATE TABLE IF NOT EXISTS agendamentos (
    id BIGSERIAL PRIMARY KEY,
    id_medico INT NOT NULL REFERENCES medicos(id),
    id_paciente INT NOT NULL REFERENCES pacientes(id),
    inicio_em TIMESTAMP NOT NULL,
    fim_em TIMESTAMP,
    observacoes TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'AGENDADA' CHECK (status IN ('AGENDADA', 'REALIZADA', 'CANCELADA', 'FALTOU')),
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (fim_em IS NULL OR fim_em > inicio_em)
);

CREATE TABLE IF NOT EXISTS consultas (
    id BIGSERIAL PRIMARY KEY,
    id_agendamento BIGINT UNIQUE REFERENCES agendamentos(id),
    id_medico INT NOT NULL REFERENCES medicos(id),
    id_paciente INT NOT NULL REFERENCES pacientes(id),
    data_consulta TIMESTAMP NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'REALIZADA' CHECK (status IN ('AGENDADA', 'REALIZADA', 'CANCELADA', 'FALTOU')),
    observacoes TEXT
);

CREATE TABLE IF NOT EXISTS medicamentos (
    id BIGSERIAL PRIMARY KEY,
    nome_comercial VARCHAR(100) NOT NULL,
    principio_ativo VARCHAR(100) NOT NULL,
    categoria VARCHAR(20) NOT NULL CHECK (categoria IN ('CONTROLADO', 'COMUM'))
);

CREATE TABLE IF NOT EXISTS prescricoes (
    id BIGSERIAL PRIMARY KEY,
    id_consulta BIGINT NOT NULL REFERENCES consultas(id) ON DELETE CASCADE,
    id_medicamento BIGINT NOT NULL REFERENCES medicamentos(id),
    dosagem VARCHAR(50) NOT NULL,
    frequencia VARCHAR(100) NOT NULL,
    duracao_tratamento INT NOT NULL CHECK (duracao_tratamento > 0),
    criada_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_agendamentos_medico_inicio
    ON agendamentos (id_medico, inicio_em);

CREATE INDEX IF NOT EXISTS idx_agendamentos_paciente_inicio
    ON agendamentos (id_paciente, inicio_em);

CREATE INDEX IF NOT EXISTS idx_consultas_data
    ON consultas (data_consulta);