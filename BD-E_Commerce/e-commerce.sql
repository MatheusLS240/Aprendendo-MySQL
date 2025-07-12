CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- TABELA USUARIO
CREATE TABLE IF NOT EXISTS usuario (
    cod_cpf INT NOT NULL PRIMARY KEY,
    nome_usuario VARCHAR(80) NOT NULL,
    email VARCHAR(60) NOT NULL,
    senha VARCHAR(20) NOT NULL,
    genero ENUM("Masculino", "Feminino") NOT NULL
);

-- TABELA FORNECEDOR
CREATE TABLE IF NOT EXISTS fornecedor (
    cod_fornecedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_fornecedor VARCHAR(80) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    ativo BOOLEAN DEFAULT TRUE,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- TABELA TELEFONE
CREATE TABLE telefone (
    cod_telefone INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    telefone VARCHAR(20) NOT NULL,
    tipo_entidade ENUM('usuario','fornecedor') NOT NULL,
    cod_cpf INT,
    cod_fornecedor INT,
    CHECK (
        (tipo_entidade = 'usuario' AND cod_cpf IS NOT NULL AND cod_fornecedor IS NULL) 
        OR
        (tipo_entidade = 'fornecedor' AND cod_fornecedor IS NOT NULL AND cod_cpf IS NULL)
    ),
    CONSTRAINT fk_cpf_tel FOREIGN KEY (cod_cpf) REFERENCES usuario(cod_cpf),
    CONSTRAINT fk_fornecedor_tel FOREIGN KEY (cod_fornecedor) REFERENCES fornecedor(cod_fornecedor)
);

-- TABELA ENDERECO
CREATE TABLE endereco (
    cod_endereco INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(9) NOT NULL,
    rua VARCHAR(100) NOT NULL,
    bairro VARCHAR(50) NOT NULL,
    numero SMALLINT UNSIGNED,
    tipo_entidade ENUM('usuario','fornecedor') NOT NULL,
    cod_cpf INT,
    cod_fornecedor INT,
    CHECK (
        (tipo_entidade = 'usuario' AND cod_cpf IS NOT NULL AND cod_fornecedor IS NULL) 
        OR
        (tipo_entidade = 'fornecedor' AND cod_fornecedor IS NOT NULL AND cod_cpf IS NULL)
    ),
    CONSTRAINT fk_cpf_end FOREIGN KEY (cod_cpf) REFERENCES usuario(cod_cpf),
    CONSTRAINT fk_fornecedor_end FOREIGN KEY (cod_fornecedor) REFERENCES fornecedor(cod_fornecedor)
);

-- TABELA CATEGORIA
CREATE TABLE categoria (
    cod_categoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_categoria VARCHAR(100) NOT NULL,
    descricao TEXT NULL
);

-- TABELA PRODUTO
CREATE TABLE produto (
    cod_produto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_produto VARCHAR(75) NOT NULL,
    descricao TEXT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    imagem_url VARCHAR(255) NOT NULL,
    peso DOUBLE(10, 2) NOT NULL,
    comprimento DECIMAL(10, 2) NOT NULL,
    altura DECIMAL(10, 2) NOT NULL,
    largura DECIMAL(10, 2) NOT NULL,
    cod_categoria INT,
    cod_fornecedor INT,
    CONSTRAINT fk_categoria FOREIGN KEY (cod_categoria) REFERENCES categoria(cod_categoria),
    CONSTRAINT fk_fornecedor_prod FOREIGN KEY (cod_fornecedor) REFERENCES fornecedor(cod_fornecedor)
);

-- TABELA AVALIACAO
CREATE TABLE avaliacao (
    cod_avaliacao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    texto_avaliacao TEXT NOT NULL,
    cod_produto INT,
    cod_cpf INT,
    CONSTRAINT fk_produto_ava FOREIGN KEY (cod_produto) REFERENCES produto(cod_produto),
    CONSTRAINT fk_cpf_ava FOREIGN KEY (cod_cpf) REFERENCES usuario(cod_cpf)
);

-- TABELA ESTOQUE
CREATE TABLE estoque (
    cod_estoque INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    quantidade_disponivel SMALLINT NOT NULL,
    quantidade_minima SMALLINT NOT NULL,
    data_renovacao DATE NOT NULL,
    localizacao VARCHAR(30) NOT NULL,
    cod_produto INT,
    CONSTRAINT fk_produto_est FOREIGN KEY (cod_produto) REFERENCES produto(cod_produto)
);

-- TABELA PRODUTO_PEDIDO
CREATE TABLE produto_pedido (
    cod_produtoPedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    quantidade_produto INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    desconto DECIMAL(10, 2) NULL,
    total_item DECIMAL(10, 2) GENERATED ALWAYS AS (quantidade_produto * (preco_unitario - IFNULL(desconto, 0))) STORED,
    cod_produto INT,
    CONSTRAINT fk_produto_ped FOREIGN KEY (cod_produto) REFERENCES produto(cod_produto)
);

-- TABELA PAGAMENTO
CREATE TABLE pagamento (
    cod_pagamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tipo_pagamento VARCHAR(100) NOT NULL,
    data_pagamento DATETIME NOT NULL,
    status_pagamento ENUM('pago', 'pendente') NOT NULL
);

-- TABELA TRANSPORTE
CREATE TABLE transporte(
    cod_transporte INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_transportadora VARCHAR(100) NOT NULL
);

-- TABELA PEDIDO
CREATE TABLE pedido (
    cod_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    data_solicitacao DATE NOT NULL,
    data_entrega DATE NULL,
    cod_produtoPedido INT,
    cod_transportadora INT UNIQUE,
    cod_cpf INT,
    cod_pagamento INT,
    CONSTRAINT fk_produtoPedido FOREIGN KEY (cod_produtoPedido) REFERENCES produto_pedido(cod_produtoPedido),
    CONSTRAINT fk_transportadora FOREIGN KEY (cod_transportadora) REFERENCES transporte(cod_transporte),
    CONSTRAINT fk_cpf_ped FOREIGN KEY (cod_cpf) REFERENCES usuario(cod_cpf),
    CONSTRAINT fk_pagamento_ped FOREIGN KEY (cod_pagamento) REFERENCES pagamento(cod_pagamento)
);

-- TABELA PAGAMENTO_BOLETO
CREATE TABLE Pagamento_boleto (
    cod_pagamento INT PRIMARY KEY,
    codigo_barras VARCHAR(100) NOT NULL UNIQUE,
    data_vencimento DATE NOT NULL,
    FOREIGN KEY (cod_pagamento) REFERENCES pagamento(cod_pagamento)
);

-- TABELA PAGAMENTO_PIX
CREATE TABLE Pagamento_pix (
    cod_pagamento INT PRIMARY KEY, 
    chave_pix VARCHAR(100) NOT NULL, 
    FOREIGN KEY (cod_pagamento) REFERENCES pagamento(cod_pagamento)
);

-- TABELA PAGAMENTO_CARTAO
CREATE TABLE Pagamento_cartao (
    cod_pagamento INT PRIMARY KEY, 
    numero_cartao VARCHAR(20) NOT NULL, 
    nome_titular VARCHAR(100) NOT NULL,
    bandeira VARCHAR(20) NOT NULL,
    FOREIGN KEY (cod_pagamento) REFERENCES pagamento(cod_pagamento)
);
