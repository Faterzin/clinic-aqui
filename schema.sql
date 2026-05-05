CREATE TABLE pacientes (
    
);

CREATE TABLE medicos (
    
);

CREATE TABLE especialidades (
    
);

CREATE TABLE agendamentos (
    
);

CREATE TABLE consultas (
    
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
    
);

CREATE TABLE convenios (
    
);