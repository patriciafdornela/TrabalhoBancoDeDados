-- Visão de Integridade
-- consistência e validade dos dados

CREATE OR REPLACE VIEW agencia.hotel_restaurante_cidade AS
SELECT
    h.nome_hotel,
    r.nome_restaurante,
    c.nome AS cidade,
    c.estado
FROM
    agencia.hotel h
INNER JOIN
    agencia.restaurante r ON h.id_restaurante = r.id_restaurante
INNER JOIN
    agencia.cidade c ON h.id_cidade = c.id_cidade;

-- Para a consulta da visão de integridade:

SELECT * FROM agencia.hotel_restaurante_cidade;


-- Resultado da consulta/visão integridade:
/*
nome_hotel				nome_restaurante	cidade			estado

"Copacabana Palace, A Belmond Hotel"	"Restaurante Colombo"	"Rio de Janeiro"	"RJ"
"Iconyc Charlie Ibirapuera Hotel"	"Sabores da Itália"	"São Paulo"		"SP"
"ibis budget Manaus"			"Casa do Hamburguer"	"Manaus"		"AM"
"Hotel Vivenzo Savassi"			"Tempero da Vovó"	"Belo Horizonte"	"MG"
"Praiano Hotel"				"Vegetalia"		"Fortaleza"		"CE"
"Hotel Arpoador"			"Restaurante Colombo"	"Rio de Janeiro"	"RJ"
*/


-- Visão de Disponibilidade
-- Recursos ou serviços que estão disponíveis para uso

CREATE OR REPLACE VIEW agencia.quartos_por_hotel AS
SELECT 
    h.nome_hotel,
    q.tipo_quarto,
    q.diaria,
    c.nome AS cidade
FROM 
    agencia.hotel h
INNER JOIN 
    agencia.hotel_quarto hq ON h.id_hotel = hq.id_hotel
INNER JOIN 
    agencia.quarto q ON hq.tipo_quarto = q.tipo_quarto
INNER JOIN 
    agencia.cidade c ON h.id_cidade = c.id_cidade
ORDER BY 
    h.nome_hotel, q.diaria;

-- Para a consulta da visão de disponibilidade:

SELECT * FROM agencia.quartos_por_hotel;


-- Resultado da consulta/visão disponibilidade:
/*
nome_hotel				tipo_quarto		diaria		cidade
		
"Copacabana Palace, A Belmond Hotel"	"Luxo"			1200.00		"Rio de Janeiro"
"Copacabana Palace, A Belmond Hotel"	"Suíte Presidencial"	5000.00		"Rio de Janeiro"
"Hotel Vivenzo Savassi"			"Standard"		350.00		"Belo Horizonte"
"ibis budget Manaus"			"Standard"		350.00		"Manaus"
"ibis budget Manaus"			"Luxo"			1200.00		"Manaus"
"Iconyc Charlie Ibirapuera Hotel"	"Standard"		350.00		"São Paulo"
"Iconyc Charlie Ibirapuera Hotel"	"Executivo"		800.00		"São Paulo"
"Iconyc Charlie Ibirapuera Hotel"	"Luxo"			1200.00		"São Paulo"
"Praiano Hotel"				"Familiar"		450.00		"Fortaleza"
"Praiano Hotel"				"Suíte Presidencial"	5000.00		"Fortaleza"
*/


-- Visão de Confidencialidade
-- Proteção de dados sensíveis

CREATE OR REPLACE VIEW agencia.cidades_publico AS
SELECT
    nome,
    estado,
    populacao
FROM
    agencia.cidade;

-- Para a consulta da visão de confidencialidade:

SELECT * FROM agencia.cidades_publico;

-- Resultado da consulta/visão confidencialidade:

/*
nome			estado		populacao

"Rio de Janeiro"	"RJ"		6729894
"São Paulo"		"SP"		11895578
"Salvador"		"BA"		2568928
"Belo Horizonte"	"MG"		2416339
"Florianópolis"		"SC"		576361
"Curitiba"		"PR"		1773718
"Fortaleza"		"CE"		2574412
"Manaus"		"AM"		2279686
"Porto Alegre"		"RS"		1389322
"Recife"		"PE"		1587707
*/