-- 1. Deleta o banco de dados caso já exista
DROP DATABASE IF EXISTS Escola;
CREATE DATABASE Escola;

-- 2. Seleciona o banco de dados para uso
USE Escola;

-- 3. Tabela para a Direção (administradores)
CREATE TABLE Adm (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL -- Senha deve ser armazenada de forma segura (hashed)
);

-- 4. Tabela para os Usuários (alunos, professores e direção)
CREATE TABLE Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL, -- Senha deve ser armazenada de forma segura
    cargo ENUM('aluno', 'professor', 'direcao') NOT NULL,
    token_direcao VARCHAR(255), -- Referência ao token da direção (se for professor)
    data_nascimento DATE, -- Apenas para alunos
    FOREIGN KEY (token_direcao) REFERENCES adm(token) ON DELETE SET NULL
);

-- 5. Tabela para as Notas dos Alunos
CREATE TABLE Notas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_professor INT NOT NULL,
    id_aluno INT NOT NULL,
    nota DECIMAL(5,2) NOT NULL,
    materia VARCHAR(255) NOT NULL,
    data DATE NOT NULL,
    FOREIGN KEY (id_professor) REFERENCES Usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (id_aluno) REFERENCES Usuarios(id) ON DELETE CASCADE
);

-- 6. Inserir dados de exemplo para a Direção
INSERT INTO adm (nome, token, email, senha)
VALUES 
('Direção Escolar', 'direcao_123456', 'direcao@escola.com', 'senha_direcao');

-- 7. Inserir dados de exemplo para um Professor
INSERT INTO Usuarios (nome, email, senha, cargo, token_direcao)
VALUES 
('Professor João', 'joao@escola.com', 'senha123', 'professor', 'direcao_123456');

-- 8. Inserir dados de exemplo para um Aluno
INSERT INTO Usuarios (nome, email, senha, cargo, data_nascimento)
VALUES 
('Carlos Silva', 'carlos@escola.com', '123', 'aluno', '2005-02-15');

-- 9. Inserir dados de exemplo para as Notas
INSERT INTO Notas (id_professor, id_aluno, nota, materia, data)
VALUES 
(2, 1, 8.5, 'Matemática', '2024-11-07');

-- 10. Consultar todos os usuários (alunos, professores, direção)
SELECT * FROM Usuarios;

-- 11. Consultar todas as notas
SELECT * FROM Notas;
