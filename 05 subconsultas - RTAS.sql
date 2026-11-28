use resgate_tratamento_animais_silv;

SELECT e.nome_popular, COUNT(a.id_animal) AS total_animais
FROM especie AS e
INNER JOIN animal AS a
ON a.id_especie_fk = e.id_especie
GROUP BY e.id_especie, e.nome_popular
HAVING COUNT(a.id_animal) > 2;

SELECT v.nome, SUM(t.custo) AS custo_total
FROM veterinario AS v
INNER JOIN tratamento AS t 
ON t.id_veterinario_fk = v.id_veterinario
GROUP BY v.id_veterinario, v.nome
HAVING SUM(t.custo) > 2000
ORDER BY custo_total DESC;

SELECT l.nome, l.estado, COUNT(s.id_soltura) AS total_solturas
FROM local_soltura AS l
INNER JOIN soltura AS s 
ON s.id_local_soltura_fk = l.id_local_soltura
GROUP BY l.id_local_soltura, l.nome, l.estado
HAVING COUNT(s.id_soltura) > 4;

SELECT status, COUNT(*) AS total_animais
FROM animal GROUP BY status
ORDER BY total_animais DESC;

SELECT tipo, COUNT(*) AS total_recintos, SUM(capacidade) AS capacidade_total, AVG(capacidade) AS capacidade_media
FROM recinto GROUP BY tipo;

SELECT id_animal, nome, status
FROM animal WHERE id_animal NOT IN (SELECT id_animal_fk FROM soltura);

SELECT id_tratamento, descricao, custo
FROM tratamento WHERE custo > (SELECT AVG(custo) FROM tratamento)
ORDER BY custo DESC;

SELECT id_recinto, tipo, localizacao
FROM recinto WHERE id_recinto NOT IN (SELECT id_recinto_fk FROM recinto_voluntario);

SELECT a.id_animal, a.nome, a.status
FROM animal AS a WHERE NOT EXISTS (SELECT * FROM tratamento AS t WHERE t.id_animal_fk = a.id_animal);

SELECT nome_popular, nome_cientifico, grau_ameaca
FROM especie WHERE id_especie IN (SELECT id_especie_fk FROM animal WHERE status = 'Cativeiro permanente');

SELECT a.nome AS animal, e.nome_popular AS especie, a.status, r.tipo AS recinto, r.localizacao
FROM animal AS a
INNER JOIN especie AS e 
ON e.id_especie = a.id_especie_fk
LEFT JOIN recinto AS r 
ON r.id_recinto = a.id_recinto_fk;


SELECT t.id_tratamento, a.nome AS animal, v.nome AS veterinario, t.descricao, t.custo, t.data_inicio, t.data_fim
FROM tratamento AS t
INNER JOIN animal AS a 
ON a.id_animal = t.id_animal_fk
INNER JOIN veterinario AS v 
ON v.id_veterinario = t.id_veterinario_fk;


SELECT s.data_soltura, a.nome AS animal, l.nome AS local_soltura, l.bioma, v.nome AS veterinario
FROM soltura AS s
INNER JOIN animal AS a 
ON a.id_animal = s.id_animal_fk
INNER JOIN local_soltura AS l 
ON l.id_local_soltura = s.id_local_soltura_fk
INNER JOIN veterinario AS v 
ON v.id_veterinario = s.id_veterinario_fk
ORDER BY s.data_soltura;


SELECT vo.nome AS voluntario, vo.area_atuacao, r.tipo AS recinto, r.localizacao
FROM recinto_voluntario AS rv
INNER JOIN voluntario AS vo 
ON vo.id_voluntario = rv.id_voluntario_fk
INNER JOIN recinto AS r 
ON r.id_recinto = rv.id_recinto_fk
ORDER BY vo.nome;


SELECT r.id_recinto, r.tipo, r.capacidade, COUNT(a.id_animal) AS animais_atuais
FROM recinto AS r
LEFT JOIN animal AS a 
ON a.id_recinto_fk = r.id_recinto
GROUP BY r.id_recinto, r.tipo, r.capacidade
ORDER BY animais_atuais DESC;
