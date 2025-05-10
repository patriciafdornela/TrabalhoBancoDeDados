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
nome_hotel				nome_restaurante		cidade			estado

"Copacabana Palace, A Belmond Hotel"	"Restaurante Colombo"		"Rio de Janeiro"	"RJ"
"Iconyc Charlie Ibirapuera Hotel"	"Terraço Itália"		"São Paulo"		"SP"
"ibis budget Manaus"			"Casa do Hamburguer"		"Manaus"		"AM"
"Hotel Vivenzo Savassi"			"Paris 6 Bistrô"		"Belo Horizonte"	"MG"
"Praiano Hotel"				"Mandir Restaurante Vegano"	"Fortaleza"		"CE"
"Hotel Arpoador"			"Restaurante Colombo"		"Rio de Janeiro"	"RJ"
"Hotel Mercure Salvador"		"Casarão"			"Salvador"		"BA"
"Hotel Gran Marquise"			"Mangostin e Mucuripe"		"Fortaleza"		"CE"
"Grande Hotel Ouro Preto"		"Oscar"				"Ouro Preto"		"MG"
"Esmeralda Praia Hotel"			"Dom Francisco"			"Brasília"		"DF"
"Hotel Fasano Belo Horizonte"		"Gero"				"Belo Horizonte"	"MG"
"Majestic Palace Hotel"			"Ostradamus"			"Florianópolis"		"SC"
"Go Inn Vitória"			"Restaurante Papaguth"		"Vitória"		"ES"
*/


-- Visão de Disponibilidade
-- Recursos ou serviços que estão disponíveis para uso

CREATE OR REPLACE VIEW agencia.quartos_por_hotel AS
SELECT 
    h.nome_hotel,
    q.tipo_quarto,
    hq.diaria,
    c.nome AS cidade
FROM 
    agencia.hotel h
INNER JOIN 
    agencia.hotel_quarto hq ON h.id_hotel = hq.id_hotel
INNER JOIN 
    agencia.quarto q ON hq.tipo_quarto = q.tipo_quarto  -- Correção aqui
INNER JOIN 
    agencia.cidade c ON h.id_cidade = c.id_cidade
ORDER BY 
    h.nome_hotel, hq.diaria;

-- Para a consulta da visão de disponibilidade:

SELECT * FROM agencia.quartos_por_hotel;


-- Resultado da consulta/visão disponibilidade:
/*
nome_hotel				tipo_quarto		diaria		cidade
		
"Copacabana Palace, A Belmond Hotel"	"Luxo"			1000.00		"Rio de Janeiro"
"Copacabana Palace, A Belmond Hotel"	"Suíte Presidencial"	5000.00		"Rio de Janeiro"
"Esmeralda Praia Hotel"			"Familiar"		500.00		"Brasília"
"Esmeralda Praia Hotel"			"Standard"		900.00		"Brasília"
"Esmeralda Praia Hotel"			"Luxo"			1200.00		"Brasília"
"Go Inn Vitória"			"Standard"		280.00		"Vitória"
"Grande Hotel Ouro Preto"		"Standard"		300.00		"Ouro Preto"
"Grande Hotel Ouro Preto"		"Luxo"			850.00		"Ouro Preto"
"Grande Hotel Ouro Preto"		"Executivo"		950.00		"Ouro Preto"
"Grande Hotel Ouro Preto"		"Suíte Presidencial"	1500.00		"Ouro Preto"
"Hotel Arpoador"			"Standard"		250.00		"Rio de Janeiro"
"Hotel Arpoador"			"Luxo"			950.00		"Rio de Janeiro"
"Hotel Fasano Belo Horizonte"		"Luxo"			1350.00		"Belo Horizonte"
"Hotel Fasano Belo Horizonte"		"Suíte Presidencial"	3900.00		"Belo Horizonte"
"Hotel Gran Marquise"			"Luxo"			100.00		"Fortaleza"
"Hotel Gran Marquise"			"Standard"		290.00		"Fortaleza"
"Hotel Gran Marquise"			"Suíte Presidencial"	3000.00		"Fortaleza"
"Hotel Mercure Salvador"		"Standard"		350.90		"Salvador"
"Hotel Mercure Salvador"		"Familiar"		420.00		"Salvador"
"Hotel Mercure Salvador"		"Suíte Presidencial"	6500.00		"Salvador"
"Hotel Vivenzo Savassi"			"Standard"		300.00		"Belo Horizonte"
"ibis budget Manaus"			"Standard"		400.00		"Manaus"
"ibis budget Manaus"			"Luxo"			1100.00		"Manaus"
"Iconyc Charlie Ibirapuera Hotel"	"Standard"		350.00		"São Paulo"
"Iconyc Charlie Ibirapuera Hotel"	"Executivo"		800.00		"São Paulo"
"Iconyc Charlie Ibirapuera Hotel"	"Luxo"			1200.00		"São Paulo"
"Majestic Palace Hotel"			"Standard"		320.00		"Florianópolis"
"Majestic Palace Hotel"			"Executivo"		680.00		"Florianópolis"
"Majestic Palace Hotel"			"Suíte Presidencial"	4500.00		"Florianópolis"
"Praiano Hotel"				"Familiar"		450.00		"Fortaleza"
"Praiano Hotel"				"Suíte Presidencial"	2000.00		"Fortaleza"
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
"Ouro Preto"		"MG"		74821
"Brasília"		"DF"		2817381
"Natal"			"RN"		785368
"João Pessoa"		"PB"		833932
"Maceió"		"AL"		957916
"Vitória"		"ES"		322869
*/