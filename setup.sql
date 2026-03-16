CREATE DATABASE IF NOT EXISTS bookstore_db;
USE bookstore_db;

-- Criar Tabela Usuario se não existir
CREATE TABLE IF NOT EXISTS Usuario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255),
    senha VARCHAR(255)
);

-- Criar Tabela Autor
CREATE TABLE IF NOT EXISTS Autor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255)
);

-- Criar Tabela Livro
CREATE TABLE IF NOT EXISTS Livro (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    isbn VARCHAR(255),
    preco DECIMAL(10,2),
    dataLancamento DATETIME
);

-- Tabela de ligação
CREATE TABLE IF NOT EXISTS Livro_Autor (
    Livro_id INT,
    autores_id INT
);

-- Agora sim, os INSERTS
INSERT INTO Usuario (email, senha) VALUES ('user@lab.com', '123456');
INSERT INTO Autor (id, nome) VALUES (1, 'Edgar kazu'), (2, 'Robert C. Martin');
INSERT INTO Livro (id, titulo, isbn, preco, dataLancamento) VALUES 
(1, 'Java para DevOps', '978-1-123456', 59.90, NOW()),
(2, 'Clean Code', '978-0132350884', 70.00, NOW());
INSERT INTO Livro_Autor (Livro_id, autores_id) VALUES (1, 1), (2, 2);
