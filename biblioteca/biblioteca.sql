CREATE DATABASE IF NOT EXISTS `biblioteca`;

USE `biblioteca`;

CREATE TABLE IF NOT EXISTS `autor` (
    `cod_autor` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome` VARCHAR(80) NOT NULL,
    `nacionalidade` VARCHAR(30) NOT NULL,
    `data_nascimento` DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS `livro` (
    `cod_livro` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `titulo` VARCHAR(255) NOT NULL,
    `editora` VARCHAR(255) NOT NULL,
    `ano` INT NOT NULL,
    `cod_autor` INT, FOREIGN KEY (`cod_autor`) REFERENCES autor(`cod_autor`)
);

CREATE TABLE IF NOT EXISTS `cliente` (
    `cod_cliente` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `nome` VARCHAR(40) NOT NULL,
    `sobrenome` VARCHAR(60) NOT NULL,
    `email` VARCHAR(60) NOT NULL UNIQUE,
    `cod_endereco` INT, FOREIGN KEY (`cod_endereco`) REFERENCES endereco(`cod_endereco`)
);

CREATE TABLE IF NOT EXISTS `endereco` (
    `cod_endereco` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `estado` VARCHAR(30) NOT NULL,
    `cidade` VARCHAR(30) NOT NULL,
    `bairro` VARCHAR(30) NOT NULL,
    `cep` CHAR(9) NOT NULL,
    `rua` VARCHAR(60) NOT NULL,
    `complemento` VARCHAR(60) NULL
);

CREATE TABLE IF NOT EXISTS `emprestimo` (
    `cod_emprestimo` INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    `data_emprestimo` DATE NOT NULL,
    `data_dev_prevista` DATE NOT NULL,
    `data_devolucao` DATE NULL,
    `cod_livro` INT, FOREIGN KEY (`cod_livro`) REFERENCES livro(`cod_livro`),
    `cod_cliente` INT, FOREIGN KEY (`cod_cliente`) REFERENCES cliente(`cod_cliente`)
);


