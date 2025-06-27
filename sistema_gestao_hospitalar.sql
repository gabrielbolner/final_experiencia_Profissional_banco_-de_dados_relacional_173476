
-- Criação do banco de dados (opcional dependendo do SGBD)
CREATE DATABASE IF NOT EXISTS sistema_gestao_hospitalar;
USE sistema_gestao_hospitalar;

-- Tabela de Pacientes
CREATE TABLE paciente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100)
);

-- Tabela de Médicos
CREATE TABLE medico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    crm VARCHAR(20) UNIQUE NOT NULL,
    especialidade_id INT,
    FOREIGN KEY (especialidade_id) REFERENCES especialidade(id)
);

-- Tabela de Especialidades
CREATE TABLE especialidade (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- Tabela de Usuários (sistema)
CREATE TABLE usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    tipo ENUM('ADMIN', 'MEDICO', 'RECEPCIONISTA') NOT NULL
);

-- Tabela de Consultas
CREATE TABLE consulta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    medico_id INT NOT NULL,
    data_hora DATETIME NOT NULL,
    status ENUM('AGENDADA', 'REALIZADA', 'CANCELADA') DEFAULT 'AGENDADA',
    observacoes TEXT,
    FOREIGN KEY (paciente_id) REFERENCES paciente(id),
    FOREIGN KEY (medico_id) REFERENCES medico(id)
);

-- Tabela de Exames
CREATE TABLE exame (
    id INT AUTO_INCREMENT PRIMARY KEY,
    consulta_id INT NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    resultado TEXT,
    data_exame DATE,
    FOREIGN KEY (consulta_id) REFERENCES consulta(id)
);

-- Tabela de Prescrições
CREATE TABLE prescricao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    consulta_id INT NOT NULL,
    medicamento VARCHAR(100) NOT NULL,
    dosagem VARCHAR(50),
    frequencia VARCHAR(50),
    duracao VARCHAR(50),
    FOREIGN KEY (consulta_id) REFERENCES consulta(id)
);

-- Tabela de Internações
CREATE TABLE internacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT NOT NULL,
    data_entrada DATETIME NOT NULL,
    data_saida DATETIME,
    motivo TEXT,
    quarto VARCHAR(20),
    FOREIGN KEY (paciente_id) REFERENCES paciente(id)
);
