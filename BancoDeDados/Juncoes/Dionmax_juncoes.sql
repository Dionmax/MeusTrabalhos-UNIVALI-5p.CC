-- tables
-- Table: cargo
CREATE TABLE cargo
(
    id int NOT NULL,
    nome varchar(50) NOT NULL,
    salario_por_hora numeric NOT NULL,
    PRIMARY KEY (id)
);
-- Table: colaborador
CREATE TABLE colaborador
(
    id int NOT NULL,
    nome varchar(255) NOT NULL,
    data_nascimento date NOT NULL,
    cargo_id int NOT NULL,
    PRIMARY KEY (id)
);
-- Table: projeto
CREATE TABLE projeto
(
    id int NOT NULL,
    nome varchar(255) NOT NULL,
    concluido boolean NOT NULL,
    PRIMARY KEY (id)
);
-- Table: tarefa
CREATE TABLE tarefa
(
    id int NOT NULL,
    descricao text NOT NULL,
    tempo_estimado numeric NOT NULL,
    tempo_reportado numeric NULL,
    concluida boolean NOT NULL,
    projeto_id int NOT NULL,
    colaborador_id int NOT NULL,
    PRIMARY KEY (id)
);
-- foreign keys
-- Reference: colaborador_cargo (table: colaborador)
ALTER TABLE colaborador ADD FOREIGN KEY (cargo_id)
REFERENCES cargo (id)
;
-- Reference: tarefa_colaborador (table: tarefa)
ALTER TABLE tarefa ADD FOREIGN KEY (colaborador_id)
REFERENCES colaborador (id)
;
-- Reference: tarefa_projeto (table: tarefa)
ALTER TABLE tarefa ADD FOREIGN KEY (projeto_id)
REFERENCES projeto (id)
;
-- End of file.
-- Valores Ficticios 

INSERT INTO cargo
    (id, nome, salario_por_hora)
VALUES
    ( 1, 'Estagiario', 5.3),
    ( 2, 'Analista', 18),
    ( 3, 'Desenvolvedor', 25),
    ( 4, 'Design', 16),
    ( 5, 'Secretaria', 10);

INSERT INTO colaborador
    (id, nome, data_nascimento, cargo_id)
VALUES
    ( 1, 'Donald Trump', '2000-03-22', 1),
    ( 2, 'Nilin', '1988-06-19' , 2),
    ( 3, 'Schade', '1990-11-12', 3),
    ( 4, 'Julius', '1968-07-30', 4),
    ( 5, 'Amanda', '1998-06-09', 5);

INSERT INTO projeto
    (id, nome, concluido)
VALUES
    ( 1, 'Malas-Aeroporto', FALSE),
    ( 2, 'Estacionamento', TRUE),
    ( 3, 'Caixa-Padaria', TRUE),
    ( 4, 'Estoque-Americanas', TRUE );

INSERT INTO tarefa
    (id, descricao, tempo_estimado, tempo_reportado, concluida, projeto_id, colaborador_id)
VALUES
    ( 1, 'Logica_Cadastro', 8, 6, TRUE, 1, 3),
    ( 2, 'Tela_Inicial', 10, 11, FALSE, 1, 4),
    ( 3, 'Listar_Compras', 2, 1, TRUE, 3, 1),
    ( 4, 'Ligar_Central', 1, 1, TRUE, 2, 5),
    ( 5, 'Analizar_disposicao', 4, 5, FALSE, 4, 2);

-- Começo Exercicios

-- 1
SELECT count(id)
FROM projeto;

-- 2
SELECT count(concluido)
FROM projeto
WHERE concluido = true;

-- 3
SELECT count(id), sum(tempo_reportado)
FROM tarefa
WHERE concluida = true;

-- 4
SELECT descricao, (tempo_estimado - tempo_reportado) as "Diferença_tempo"
FROM tarefa
WHERE concluida = true;

-- 5
SELECT max(tempo_reportado)
FROM tarefa
WHERE concluida = true;

-- 6
SELECT round(avg(tempo_estimado), 2)
FROM tarefa;

-- 7
SELECT projeto.nome, tarefa.descricao
FROM projeto
    INNER JOIN tarefa ON (tarefa.projeto_id = projeto.id);

-- 8
SELECT projeto.nome, tarefa.descricao, colaborador.nome
FROM projeto
    INNER JOIN tarefa ON (tarefa.projeto_id = projeto.id)
    INNER JOIN colaborador ON (tarefa.colaborador_id = colaborador.id);

-- 9
SELECT projeto.nome, tarefa.descricao, colaborador.nome, cargo.nome
FROM projeto
    INNER JOIN tarefa ON (tarefa.projeto_id = projeto.id)
    INNER JOIN colaborador ON (tarefa.colaborador_id = colaborador.id)
    INNER JOIN cargo ON (colaborador.cargo_id = cargo.id);

-- 10
SELECT projeto.nome, tarefa.descricao,
    (tarefa.tempo_reportado * cargo.salario_por_hora) as "Custo da Tarefa"
FROM projeto
    INNER JOIN tarefa ON (tarefa.projeto_id = projeto.id)
    INNER JOIN colaborador ON (tarefa.colaborador_id = colaborador.id)
    INNER JOIN cargo ON (colaborador.cargo_id = cargo.id)
WHERE tarefa.concluida = true;

-- 11
SELECT projeto.nome, tarefa.descricao,
    (tarefa.tempo_estimado * cargo.salario_por_hora) as "Custo Estimado",
    (tarefa.tempo_reportado * cargo.salario_por_hora) as "Custo da Tarefa"
FROM projeto
    INNER JOIN tarefa ON (tarefa.projeto_id = projeto.id)
    INNER JOIN colaborador ON (tarefa.colaborador_id = colaborador.id)
    INNER JOIN cargo ON (colaborador.cargo_id = cargo.id)
WHERE tarefa.concluida = true;

-- 12
SELECT projeto.nome, tarefa.descricao,
    (tarefa.tempo_estimado * cargo.salario_por_hora) as "Custo Estimado",
    (tarefa.tempo_reportado * cargo.salario_por_hora) as "Custo da Tarefa",
    (tarefa.tempo_estimado - tarefa.tempo_reportado ) * cargo.salario_por_hora as "Diferença de Custo"
FROM projeto
    INNER JOIN tarefa ON (tarefa.projeto_id = projeto.id)
    INNER JOIN colaborador ON (tarefa.colaborador_id = colaborador.id)
    INNER JOIN cargo ON (colaborador.cargo_id = cargo.id)
WHERE tarefa.concluida = true;

-- 13
SELECT projeto.nome, count(tarefa.id)
from projeto
    FULL OUTER JOIN tarefa ON (tarefa.projeto_id = projeto.id)
GROUP BY projeto.nome;

-- 14
SELECT cargo.nome, colaborador.nome
FROM cargo
    INNER JOIN colaborador ON (colaborador.cargo_id = cargo.id);

-- 15
SELECT projeto.nome, sum(tarefa.tempo_reportado)
FROM projeto
    INNER JOIN tarefa on (tarefa.projeto_id = projeto.id)
GROUP BY nome;

-- 16
SELECT colaborador.nome, count(tarefa.concluida) as "Numero de tarefas concluidas"
FROM colaborador
    INNER JOIN tarefa ON (tarefa.colaborador_id = colaborador.id)
WHERE tarefa.concluida = true
GROUP BY nome;

-- 17
SELECT colaborador.nome, count(tarefa.concluida) as "Numero de tarefas restantes"
FROM colaborador
    INNER JOIN tarefa ON (tarefa.colaborador_id = colaborador.id)
WHERE tarefa.concluida = FALSE
GROUP BY nome;

-- 18
SELECT colaborador.nome, sum(tarefa.tempo_reportado) as "Tempo trabalhado"
FROM colaborador
    INNER JOIN tarefa ON (tarefa.colaborador_id = colaborador.id)
GROUP BY nome

-- 19
SELECT projeto.nome, sum(tarefa.tempo_estimado)
FROM projeto
    INNER JOIN tarefa ON (tarefa.projeto_id = projeto.id)
WHERE tarefa.concluida = false
GROUP BY nome;

-- 20
SELECT projeto.nome, colaborador.nome,
    (sum(tarefa.tempo_estimado)* cargo.salario_por_hora) as "Salario colaborador"
FROM projeto
    INNER JOIN tarefa ON (tarefa.projeto_id = projeto.id)
    INNER JOIN colaborador ON (tarefa.colaborador_id = colaborador.id)
    INNER JOIN cargo ON (colaborador.cargo_id = cargo.id)
GROUP BY projeto.nome, colaborador.nome, cargo.salario_por_hora