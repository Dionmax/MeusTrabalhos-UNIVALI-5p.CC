CREATE TABLE categoria
(
    id INTEGER NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE marca
(
    id INTEGER NOT NULL,
    nome VARCHAR(255) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE unidade
(
    id INTEGER NOT NULL,
    descricao VARCHAR(255)
);

CREATE TABLE produto
(
    id INTEGER NOT NULL,
    descricao VARCHAR(255),
    preco_custo DECIMAL(10,2) NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,
    qtd_estoque INTEGER NOT NULL,
    qtd_estoque_mimino INTEGER NOT NULL,
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