CREATE TABLE categoria
(
    id SERIAL NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE marca
(
    id SERIAL NOT NULL,
    nome VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE unidade
(
    id SERIAL NOT NULL,
    descricao VARCHAR(255)
);

CREATE TABLE produto
(
    id SERIAL NOT NULL,
    descricao VARCHAR(255),
    preco_custo DECIMAL(10,2) NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,
    qtd_estoque INTEGER NOT NULL,
    qtd_estoque_minimo INTEGER NOT NULL,
    categoria_id INTEGER NOT NULL,
    marca_id INTEGER NOT NULL,
    unidade_id INTEGER NOT NULL
);

ALTER TABLE produto ADD FOREIGN KEY (categoria_id)
    REFERENCES categoria(id);

ALTER TABLE produto ADD FOREIGN KEY (marca_id)
    REFERENCES marca(id);

ALTER TABLE produto ADD FOREIGN KEY (unidade_id)
    REFERENCES unidade(id);

-- Inserção de valores na tabela

INSERT INTO marca
    (nome)
VALUES
    ('Nike'),
    ('Adidas'),
    ('Reebok'),
    ('Wilson'),
    ('Speedy'),
    ('Butterfy');

INSERT INTO categoria
    (descricao)
VALUES
    ('Confeccao'),
    ('Calcados'),
    ('Bolas'),
    ('Natacao'),
    ('Tenis'),
    ('Tenis de mesa');

INSERT INTO unidade
    (descricao)
VALUES
    ('Peca'),
    ('Par'),
    ('Gramas'),
    ('Litro'),
    ('Caixa'),
    ('Cartela');

INSERT INTO produto
    (descricao,preco_custo,preco_venda,qtd_estoque,qtd_estoque_minimo, categoria_id, marca_id, unidade_id)
VALUES
    ('Camisa Brasil 1', '100', '160', '18', '6', '1', '1', '1'),
    ('Bola Adidas Copa 2010', '150', '240', '2', '3', '3', '2', '1'),
    ('Camisa Franca 2', '110', '170', '1', '2', '1', '2', '1'),
    ('Bola Tenis de Mesa Professional al c/6', '20', '32', '12', '6', '6', '6', '6'),
    ('Bola de Tenis c/ 3', '11', '18', '4', '6', '5', '4', '5'),
    ('Raquete Tenis Profissional al', '280', '460', '2', '2', '5', '4', '1'),
    ('Camisa Esportiva', '20', '32', '12', '3', '1', '3', '1'),
    ('Chuteira Campo de Couro', '90', '170', '8', '6', '2', '1', '2'),
    ('Chuteira de Futsal de Couro Sintetico', '40', '65', '12', '6', '2', '3', '2'),
    ('Oculos Natacao Expert', '35', '60', '3', '6', '4', '5', '1'),
    ('Maio de Natacao Sublime', '70', '125', '3', '3', '4', '5', '1');

-- Inserção dos comandos

-- Questão 6
UPDATE unidade 
    SET descricao = 'kilos'
    WHERE id  =  3;

-- Questão 7
UPDATE marca
   SET nome='Speed'
   WHERE id = 5;

-- Questão 8
UPDATE produto
    SET descricao='Camisa Lazer Poliester'
    WHERE id = 7;

-- Questão 9
UPDATE produto
    SET preco_venda='155'
    WHERE id = 8;

-- Questão 10
UPDATE produto
    SET qtd_estoque = (qtd_estoque + '6')
    WHERE id = 9;

-- Questão 11
UPDATE produto
    SET preco_venda = (preco_venda + (preco_venda * 0.1))
    WHERE id % 2 != 0;

-- Questão 12
UPDATE produto
    SET descricao = 'Maio de Natacao Sublime Especial',
        preco_custo = '64',
        preco_venda = '155',
        qtd_estoque = '9',
        qtd_estoque_minimo = '6'
    WHERE id = 11;

-- Questão 13
DELETE FROM unidade WHERE id = 4

-- Questão 14
DELETE FROM produto WHERE id = 7

-- Questão 15
SELECT *
FROM marca

-- Questão 16
SELECT *
FROM categoria
ORDER BY descricao

-- Questão 17
SELECT *
FROM unidade
ORDER BY id DESC

-- Questão 18
SELECT descricao, preco_venda
FROM produto
ORDER BY preco_venda

-- Questão 19
SELECT descricao, preco_custo, preco_venda
FROM produto
ORDER BY preco_custo DESC

-- Questão 20
SELECT descricao, preco_custo, preco_venda, qtd_estoque, qtd_estoque_minimo
FROM produto
ORDER BY descricao DESC

-- Questão 21
SELECT *
FROM produto
WHERE preco_venda > 100

-- Questão 22
SELECT *
FROM produto
WHERE preco_venda > 100 AND preco_venda < 200
ORDER BY descricao, preco_custo

-- Questão 23
SELECT descricao, qtd_estoque
FROM produto
WHERE qtd_estoque > 8 AND qtd_estoque < 20
ORDER BY descricao

-- Questão 24
SELECT *
FROM produto
WHERE qtd_estoque < qtd_estoque_minimo

-- Questão 25
SELECT descricao, ROUND((qtd_estoque_minimo + (qtd_estoque_minimo * 0.5) - qtd_estoque), 0)
FROM dion_server.produto
WHERE qtd_estoque < qtd_estoque_minimo

-- Questão 26
SELECT descricao, qtd_estoque * preco_venda
FROM produto

-- Questão 27
SELECT descricao, (qtd_estoque * preco_venda) - (qtd_estoque * preco_custo) 'Lucro'
FROM produto

-- Questão 28
SELECT descricao, ROUND((((qtd_estoque * preco_venda - qtd_estoque * preco_custo) / preco_custo) * 100), 0) '%'
FROM produto

-- Questão 29
SELECT descricao, (qtd_estoque * preco_venda - qtd_estoque * preco_custo) * 0.35 'Imposto'
FROM produto