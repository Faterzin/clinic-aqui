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

-- Enum para categoria
CREATE TYPE categoria_medicamento AS ENUM ('CONTROLADO', 'COMUM');

-- Tabela Medicamento (item prescrito)
CREATE TABLE medicamento (
    id SERIAL PRIMARY KEY,
    nome_comercial VARCHAR(100) NOT NULL,
    principio_ativo VARCHAR(100) NOT NULL,
    categoria categoria_medicamento NOT NULL,

    CONSTRAINT fk_prescricao
        FOREIGN KEY (id_prescricao)
        REFERENCES prescricao(id_prescricao)
);