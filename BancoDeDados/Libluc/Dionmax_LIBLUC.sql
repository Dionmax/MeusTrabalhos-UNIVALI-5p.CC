-- 1
SELECT *
FROM projeto
WHERE nome
ILIKE '%a%';

-- 2
SELECT *
FROM projeto
WHERE nome
ILIKE '%a';

-- 3
SELECT *
FROM projeto
WHERE nome
ILIKE '%a%';

-- 4
SELECT *
FROM projeto
WHERE nome
ILIKE '___a%';

-- 5
SELECT *
FROM tarefa
ORDER BY descricao
LIMIT 5 offset
0 * 5

-- 6
SELECT descricao
FROM tarefa
ORDER BY descricao
LIMIT 5 offset
0 * 5

-- 7
SELECT descricao
FROM tarefa
ORDER BY descricao
LIMIT 5 offset
1 * 5

-- 8
SELECT projeto.nome, tarefa.descricao,
    CASE WHEN tarefa.concluida = TRUE
THEN 'Finalizada'
WHEN tarefa.concluida = FALSE OR tarefa.tempo_reportado != NULL
THEN 'Em desenvolvimento'
WHEN tarefa.tempo_reportado = NULL
THEN 'Não Iniciada'
END
FROM projeto
    INNER JOIN tarefa ON (tarefa.projeto_id = projeto.id)
ORDER BY nome
LIMIT 5 offset
0 * 5

-- 9
SELECT colaborador.nome,
    CASE WHEN to_char(colaborador.data_nascimento, 'dd/mm/yyyy') like ('%01%')
 THEN 'Janeiro'
 WHEN to_char(colaborador.data_nascimento, 'dd/mm/yyyy') like ('%02%')
 THEN 'Fevereiro'
 WHEN to_char(colaborador.data_nascimento, 'dd/mm/yyyy') like ('%03%')
 THEN 'Março'
 WHEN to_char(colaborador.data_nascimento, 'dd/mm/yyyy') like ('%04%')
 THEN 'Abril'
 WHEN to_char(colaborador.data_nascimento, 'dd/mm/yyyy') like ('%05%')
 THEN 'Maio'
 WHEN to_char(colaborador.data_nascimento, 'dd/mm/yyyy') like ('%06%')
 THEN 'Junho'
 WHEN to_char(colaborador.data_nascimento, 'dd/mm/yyyy') like ('%07%')
 THEN 'Julho'
 WHEN to_char(colaborador.data_nascimento, 'dd/mm/yyyy') like ('%08%')
 THEN 'Agosto'
 WHEN to_char(colaborador.data_nascimento, 'dd/mm/yyyy') like ('%09%')
 THEN 'Setembro'
 WHEN to_char(colaborador.data_nascimento, 'dd/mm/yyyy') like ('%10%')
 THEN 'Outubro'
 WHEN to_char(colaborador.data_nascimento, 'dd/mm/yyyy') like ('%11%')
 THEN 'Novembro'
 WHEN to_char(colaborador.data_nascimento, 'dd/mm/yyyy') like ('%12%')
 THEN 'Dezembro'
END  as "Mês Nascimento"
FROM colaborador

-- 10
SELECT projeto.nome, tarefa.descricao,
    CASE WHEN tarefa.concluida = TRUE
THEN 'Finalizada'
WHEN tarefa.concluida = FALSE OR tarefa.tempo_reportado != NULL
THEN 'Em desenvolvimento'
WHEN tarefa.tempo_reportado = NULL
THEN 'Não Iniciada'
END
FROM projeto
    INNER JOIN tarefa ON (tarefa.projeto_id = projeto.id)
ORDER BY nome
LIMIT 5 offset
0 * 5