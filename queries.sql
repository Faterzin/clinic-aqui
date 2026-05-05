CREATE TABLE Especialidade (
    id INT PRIMARY KEY AUTO_INCREMENT,  
    nome VARCHAR(100) NOT NULL UNIQUE,               
    descricao TEXT,                                   
    criada_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP   
);

CREATE TABLE Consulta (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_agendamento INT NOT NULL,
    data_inicio DATETIME NOT NULL,
    duracao_minutos INT NOT NULL,
    queixa_principal TEXT NOT NULL,
    observacoes_medico TEXT,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_agendamento) REFERENCES Agendamento(id_agendamento) ON DELETE CASCADE
);
