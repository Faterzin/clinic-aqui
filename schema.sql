CREATE TABLE pacientes (
    
);

CREATE TABLE medicos (

    CREATE TABLE medico (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) NOT NULL UNIQUE,
    especialidade VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100),
    id_status_vinculo INT NOT NULL,

    CONSTRAINT fk_status_vinculo
        FOREIGN KEY (id_status_vinculo)
        REFERENCES status_vinculo(id_status_vinculo)
);
    
);

CREATE TABLE especialidades (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    criada_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    
);

CREATE TABLE agendamentos (
    
);

CREATE TABLE consultas (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_agendamento UUID NOT NULL,
    data_inicio DATETIME NOT NULL,
    duracao_minutos INT NOT NULL default 30,
    queixa_principal TEXT NOT NULL,
    observacoes_medico TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
);

CREATE TABLE prescricoes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    id_consulta UUID NOT NULL,
    id_medicamento UUID NOT NULL,
    dosagem VARCHAR(50) NOT NULL,
    frequencia VARCHAR(100) NOT NULL,
    duracao_tratamento INT NOT NULL
    criada_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
);

CREATE TABLE medicamentos (

    CREATE TYPE categoria_medicamento AS ENUM ('CONTROLADO', 'COMUM');
    
    id SERIAL PRIMARY KEY,
    nome_comercial VARCHAR(100) NOT NULL,
    principio_ativo VARCHAR(100) NOT NULL,
    categoria categoria_medicamento NOT NULL,

    CONSTRAINT fk_prescricao
        FOREIGN KEY (id_prescricao)
        REFERENCES prescricao(id_prescricao)  
);

CREATE TABLE convenios (
    
);