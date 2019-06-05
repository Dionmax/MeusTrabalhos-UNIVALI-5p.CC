CREATE TABLE projeto
(
    id int primary key,
    nome varchar(255) NOT NULL,
    data_inicio timestamp NOT NULL,
    id_colaborador_gerente int
);

CREATE TABLE colaborador
(
    id int primary key,
    id_cargo int NOT NULL,
    nome varchar(255) NOT NULL,
    ano_contratacao int NOT NULL CHECK (ano_contratacao > 2000)
);

CREATE TABLE tarefa
(
    id int primary key,
    id_colaborador_responsavel int NOT NULL,
    id_projeto int NOT NULL,
    descricao text NOT NULL,
    duracao_hora decimal(10,2) NOT NULL CHECK(duracao_hora > 0 AND duracao_hora <= 60),
    concluida boolean NOT NULL
);

CREATE TABLE cargo
(
    id int primary key NOT NULL,
    nome varchar(255) NOT NULL,
    salario_hora decimal (10,2) NOT NULL CHECK (salario_hora > 10.0)
);

ALTER TABLE projeto ADD FOREIGN KEY (id_colaborador_gerente) REFERENCES colaborador(id);
ALTER TABLE colaborador ADD FOREIGN KEY (id_cargo) REFERENCES cargo(id);
ALTER TABLE tarefa ADD FOREIGN KEY (id_colaborador_responsavel) REFERENCES
colaborador(id);
ALTER TABLE tarefa ADD FOREIGN KEY (id_projeto) REFERENCES projeto(id);

-- Inserção dos valores

-- 2
INSERT INTO projeto
    ( id, nome,data_inicio )
VALUES
    ( 1, 'Desenvolvimento do site Coca-Cola', '13-11-2018' ),
    ( 2, 'Desenvolvimento Sistema UNIVALI', '01-10-2018' ),
    ( 3, 'Analize do Sistema Rede Globo', '23-05-2019' ),
    ( 4, 'Desenvolvimento do Sistema Block Buster', '20-03-2019' );

-- 3
INSERT INTO cargo
    (id, nome, salario_hora)
VALUES
    (1, 'Programador Junior', 18.00),
    (2, 'Programador Pleno', 30.00),
    (3, 'Programador Senior', 42.00),
    (4, 'Analista de Sistemas Pleno', 32.00),
    (5, 'Analista de Sistemas Senior', 44.00),
    (6, 'Administrador de DB Pleno', 31.00),
    (7, 'Administrador de DB Senior', 43.00);


-- 4
INSERT INTO colaborador
    (id, id_cargo,nome,ano_contratacao)
VALUES
    (1, 2, 'Joao', '2017'),
    (2, 1, 'Pedro', '2015'),
    (3, 3, 'Ana', '2014'),
    (4, 1, 'Fernanda', '2010'),
    (5, 2, 'Julia', '2015'),
    (6, 5, 'Sergio', '2014'),
    (7, 6, 'Alan', '2011'),
    (8, 3, 'Bruna', '2009');

-- 5
INSERT INTO tarefa
    (id,id_projeto,id_colaborador_responsavel,descricao,concluida,duracao_hora)
VALUES
    (1, 1, 6, 'Modelagem do sistema', true , 35),
    (2, 1, 2, 'Criacao de interfaces', false  , 20  ),
    (3, 1, 1, 'Modulo administrativo', false , 40 ),
    (4, 2, 7, 'Criacao do banco de dados', true , 30  ),
    (5, 2, 3, 'Modulo administrativo', true , 60 ),
    (6, 2, 4, 'Criacao de interfaces', true , 40 ),
    (7, 2, 6, 'Treinamento dos usuarios', false , 20  ),
    (8, 3, 4, 'Modelagem do sistema', true , 40  ),
    (9, 3, 4, 'Modulo administrativo', true  , 30  ),
    (10, 3, 4, 'Criacao de interfaces', false , 40  ),
    (11, 3, 7, 'Criacao das views', true , 16  ),
    (12, 3, 4, 'Publicacao do sistema', false , 8  );

-- 6
UPDATE projeto
SET
    id_colaborador_gerente = 3
WHERE id = 1;

UPDATE projeto
SET
    id_colaborador_gerente = 6
WHERE id = 2;

UPDATE projeto
SET
    id_colaborador_gerente = 6
WHERE id = 3;

UPDATE projeto
SET
    id_colaborador_gerente = 8
WHERE id = 4;

-- 7
UPDATE cargo
SET
    salario_hora = salario_hora * 1.1
WHERE id < 4;

-- 8
SELECT nome, (2019 - ano_contratacao) as "Anos de empresa"
FROM colaborador;

-- 9
SELECT descricao, round(duracao_hora * 60, 0) as "Duração em minutos",
    round((duracao_hora * 60) * 1.5 , 0) as "Duração em minutos + 50%"
FROM tarefa
WHERE concluida = true;

-- 10
SELECT colaborador.nome, cargo.salario_hora * (44 * 4)
FROM colaborador
    INNER JOIN cargo on (cargo.id = colaborador.id_cargo);

-- 11
SELECT projeto.nome, tarefa.descricao, tarefa.duracao_hora
FROM projeto
    INNER JOIN tarefa ON (tarefa.id_projeto = projeto.id);

-- 12
SELECT colaborador.nome, projeto.nome
FROM colaborador
    INNER JOIN projeto ON (projeto.id_colaborador_gerente = colaborador.id);

-- 13
SELECT projeto.nome, count(tarefa) as "Numero de Tarefas"
FROM projeto
    FULL OUTER JOIN tarefa ON (tarefa.id_projeto = projeto.id)
GROUP BY nome;

-- 14
SELECT projeto.nome, sum(tarefa.duracao_hora) as "Duraçao em Horas"
FROM projeto
    FULL OUTER JOIN tarefa ON (tarefa.id_projeto = projeto.id)
GROUP BY nome;

-- 15
SELECT projeto.nome, sum(tarefa.duracao_hora * cargo.salario_hora) as "Custo do projeto"
FROM projeto
    INNER JOIN tarefa ON (tarefa.id_projeto = projeto.id)
    INNER JOIN colaborador ON (colaborador.id = tarefa.id_colaborador_responsavel)
    INNER JOIN cargo ON (cargo.id = colaborador.id_cargo)
GROUP BY projeto.nome;