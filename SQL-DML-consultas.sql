-- 4. SQL/DML - Consultas

-- A) Codificar, executar e apresentar o resultado de três consultas em SQL/DML que manipulem dados de pelo menos duas tabelas; 
-- 1) 

SELECT h.nome_hotel, c.nome AS cidade
FROM hotel h
JOIN cidade c ON h.id_cidade = c.id_cidade;

-- 2)

SELECT r.nome_restaurante, h.nome_hotel
FROM restaurante r
JOIN hotel h ON r.id_restaurante = h.id_restaurante;

-- 3) 

SELECT q.tipo_quarto, h.nome_hotel
FROM hotel_quarto hq
JOIN quarto q ON hq.tipo_quarto = q.tipo_quarto
JOIN hotel h ON hq.id_hotel = h.id_hotel;

-- B) Codificar, executar e apresentar o resultado de três consultas em SQL/DML usando funções de agregação; 

-- 1) 

SELECT AVG(populacao) AS media_populacao
FROM cidade;

-- 2)

SELECT AVG(diaria) AS media_diaria
FROM quarto;

-- 3) 

SELECT tipo_quarto, SUM(qtd_quartos) AS total_quartos
FROM quarto
GROUP BY tipo_quarto;

-- C) Codificar, executar e apresentar o resultado de três consultas em SQL/DML usando funções de agregação, GROUP BY e HAVING;

-- 1) 

SELECT nome, populacao
FROM cidade
WHERE populacao > (SELECT AVG(populacao) FROM cidade);

-- 2) 

SELECT tipo_quarto, AVG(diaria) AS media_diaria
FROM quarto
GROUP BY tipo_quarto
HAVING AVG(diaria) > 300;

-- 3)

SELECT c.nome AS cidade, COUNT(h.id_hotel) AS qtd_hoteis
FROM cidade c
JOIN hotel h ON c.id_cidade = h.id_cidade
GROUP BY c.nome
HAVING COUNT(h.id_hotel) > 1;





