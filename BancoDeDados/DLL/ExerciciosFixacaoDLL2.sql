CREATE TABLE cargo
(
    id INTEGER NOT NULL,
    nome VARCHAR(255) NOT NULL,
    salario_hora DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE colaborador
(
    id INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    ano_contratacao INTEGER NOT NULL,
    id_cargo int NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE projeto
(
    id INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    data_inicio TIMESTAMP NOT NULL,
    id_colaborador_gerente int NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE tarefa
(
    id INTEGER NOT NULL,
    descricao VARCHAR(255) NULL,
    duracao_hora DECIMAL(10,2) NULL CHECK(duracao_hora > 0 AND duracao_hora <= 23.59),
    concluida boolean DEFAULT FALSE,
    id_colaborador_responsavel int NOT NULL,
    id_projeto int NOT NULL,
    PRIMARY KEY(id)
);

ALTER TABLE colaborador ADD FOREIGN KEY (id_cargo)
    REFERENCES cargo(id);

ALTER TABLE projeto ADD FOREIGN KEY (id_colaborador_gerente)
    REFERENCES colaborador(id);

ALTER TABLE tarefa ADD FOREIGN KEY (id_colaborador_responsavel)
    REFERENCES colaborador(id);

ALTER TABLE tarefa ADD FOREIGN KEY (id_projeto)
    REFERENCES projeto(id);