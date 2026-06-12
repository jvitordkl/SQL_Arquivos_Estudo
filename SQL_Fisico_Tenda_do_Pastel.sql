-- =============================================================================
--  TENDA DO PASTEL
-- =============================================================================

CREATE DATABASE tenda_do_pastel;
-- DROP DATABASE tenda_do_pastel;
USE tenda_do_pastel;

-- ─────────────────────────────────────────────────────────────────────────────
-- 1. USUARIOS
-- ─────────────────────────────────────────────────────────────────────────────
CREATE TABLE USUARIO (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  email VARCHAR(320),
  senha VARCHAR(50) NOT NULL,
  funcao ENUM('user','admin') NOT NULL DEFAULT 'user',
  criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  ultimo_login TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

  -- EXPLICAR O ENUM
  -- EXPLICAR OS ATRIBUTOS CRIADO, ATUALIZADO E ULTIMO_LOGIN
);

-- COMO INSERIR DADOS NAS TABELAS CRIADAS?
-- INSERT INTO nome_da_tabela (coluna1, coluna2, coluna3, ...)
-- VALUES (valor1, valor2, valor3, ...);

-- INSIRA DADOS NA TABELA USUARIO
INSERT INTO usuario(nome,email,senha,funcao)
VALUES ('Alice','alice@gmail.com','alice12345','admin');

INSERT INTO usuario(nome,email,senha)
VALUES('Bob','bob@gmail.com','bob12345');

INSERT INTO usuario(nome,senha)
VALUES('danilo','danilo12345');
-- ALTERAR ATRIBUTO DO NOME DO USUÁRIO AQUI E COLOCAR COMO ÚNICO
ALTER TABLE usuario CHANGE nome nome VARCHAR(100) NOT NULL UNIQUE;
-- ACRESCENTAR PERFIL NO ENUM DE FUNÇÃO
ALTER TABLE usuario CHANGE funcao funcao ENUM('user','admin','gerente') NOT NULL DEFAULT 'user';
DESC usuario;
-- ─────────────────────────────────────────────────────────────────────────────
-- 2. PRODUTOS
-- ─────────────────────────────────────────────────────────────────────────────
CREATE TABLE PRODUTO (
  id_produto INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(150) NOT NULL,
  valor DECIMAL(6,2) NOT NULL,
  categoria ENUM('pastel','caldo_de_cana') NOT NULL,
  volume_ml SMALLINT UNSIGNED

  -- EXPLICAR UNSIGNED
);

-- INSIRA DADOS NA TABELA PRODUTOS
INSERT INTO produto(nome,valor,categoria)
VALUES ('Pastel de frango',10.50,'pastel');
INSERT INTO produto(nome,valor,categoria)
VALUES ('Pastel de carne',11.50,'pastel');
INSERT INTO produto(nome,valor,categoria)
VALUES ('Pastel de queijo',9.00,'pastel');
INSERT INTO produto(nome,valor,categoria,volume_ml)
VALUES ('Caldo de cana',10.50,'caldo_de_cana',100);
INSERT INTO produto(nome,valor,categoria,volume_ml)
VALUES ('Caldo de cana',18.00,'caldo_de_cana',300);
-- ─────────────────────────────────────────────────────────────────────────────
-- 3. CAIXAS
-- ─────────────────────────────────────────────────────────────────────────────
CREATE TABLE CAIXA (
  id_caixa INT PRIMARY KEY AUTO_INCREMENT,
  id_usuario_fk INT,
  data_hora_abertura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  data_hora_fechamento DATETIME,
  valor_inicial DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  valor_final DECIMAL(10,2),
  FOREIGN KEY (id_usuario_fk) REFERENCES USUARIO(id_usuario)
);

ALTER TABLE usuario RENAME COLUMN nome TO nome_usuario;
INSERT INTO usuario(nome_usuario,email,senha,funcao) VALUES
('admin','admin@tenda.com','admin','admin'),
('carlos_vendedor','calos@tenda.com','carlos123','user');
-- ─────────────────────────────────────────────────────────────────────────────
-- 4. PEDIDOS
-- ─────────────────────────────────────────────────────────────────────────────
CREATE TABLE PEDIDO (
  id_pedido INT PRIMARY KEY AUTO_INCREMENT,
  id_caixa_fk INT NOT NULL,
  data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  data_hora_finalizacao DATETIME,
  status_pedido ENUM('pendente','em_preparo','finalizado') NOT NULL DEFAULT 'pendente',
  forma_pagamento ENUM('dinheiro','pix','cartao') NOT NULL DEFAULT 'pix',
  observacao TEXT,
  FOREIGN KEY (id_caixa_fk) REFERENCES CAIXA(id_caixa)
);

-- ─────────────────────────────────────────────────────────────────────────────
-- 5. PEDIDO_ITENS
-- ─────────────────────────────────────────────────────────────────────────────
CREATE TABLE PEDIDO_ITEM (
  id_pedido_item INT PRIMARY KEY AUTO_INCREMENT,
  id_pedido_fk INT NOT NULL,
  id_produto_fk INT NOT NULL,
  quantidade TINYINT UNSIGNED NOT NULL DEFAULT 1,
  valor_unit DECIMAL(5,2) NOT NULL,
  observacao VARCHAR(255),
  FOREIGN KEY (id_pedido_fk) REFERENCES PEDIDO(id_pedido),
  FOREIGN KEY (id_produto_fk) REFERENCES PRODUTO(id_produto)
);

-- FAÇA UM ALTER TABLE PARA RENOMEAR O ATRIBUTO nome PARA nome_usuario

INSERT INTO USUARIO(id_usuario, nome, email, senha, funcao) VALUES
  (5, 'admin', 'admin@tenda.com', 'admin123', 'admin'),
  (4, 'carlos_vendedor', 'carlos@tenda.com', 'carlos123', 'user');

INSERT INTO USUARIO(id_usuario, nome, senha, funcao) VALUES
  (10, 'danilo', 'danilo123', 'admin');

INSERT INTO USUARIO(nome, senha) VALUES
  ('teste', 'teste');

-- QUAL SERÁ O ID DO USUÁRIO teste?

-- Caixa 1 (Fechado)
INSERT INTO CAIXA (id_usuario_fk, data_hora_abertura, data_hora_fechamento, valor_inicial, valor_final) VALUES
  (4, '2026-05-20 08:00:00', '2026-05-20 18:00:00', 100.00, 350.50);

-- Caixa 2 (Aberto)
-- FAÇA O INSERT AQUI
INSERT INTO caixa (id_usuario_fk,data_hora_abertura,valor_inicial) VALUES
(4,'2026-06-11 21:40:00',100.00);
-- PEDIDO
-- FAÇA 5 INSERTS DE PEDIDOS

-- PEDIDO_ITEM
-- FAÇA 8 INSERTS DE  PEDIDO_ITEM

-- COMO APAGAR DADOS DE UMA TABELA?
-- DELETE FROM nome_tabela WHERE condição;

-- APAGUE O USUÁRIO `teste` DA TABELA DE USUÁRIOS
-- APAGUE OS PRODUTOS COM PREÇOS MAIORES QUE 500

-- Faça um select apenas no nome dos usuários e apenas os usuários que começam com a letra d


-- COMO MODIFICAR DADOS DE UMA TABELA?
-- UPDATE nome_tabela
-- SET coluna1 = valor1, coluna2 = valor2 WHERE condicao
-- Observação: caso o comando seja utilizado sem a cláusula WHERE, todos os registros serão atualizados.

-- Altere o nome do usuario carlos_vendedor para carlos.
-- Insira uma data e hora de fechamento para o caixa que está aberto