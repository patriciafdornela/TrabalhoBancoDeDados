------------------------------- Criação Esquema ------------------------------- 

-- Se já existe o esquema agencia, deleta  
DROP SCHEMA IF EXISTS agencia CASCADE; 

-- Cria o esquema agencia  
CREATE SCHEMA agencia; 

-- Define o caminho para o esquema agencia 
SET search_path TO agencia; 

-- ------------------------------- Criação Das Tabelas ------------------------------- 

-- Tabela Cidade 
CREATE TABLE cidade ( 
    id_cidade CHAR(15) NOT NULL, 
    nome VARCHAR(100) NOT NULL, 
    estado VARCHAR(100) NOT NULL, 
    populacao INTEGER, 
    CONSTRAINT pk_cidade PRIMARY KEY (id_cidade) 
); 

-- Tabela Restaurante
CREATE TABLE restaurante ( 
    id_restaurante CHAR(15) NOT NULL, 
    id_cidade CHAR(15) NOT NULL,
    nome_restaurante VARCHAR(100) NOT NULL, 
	endereco VARCHAR(100) NOT NULL,
    categoria VARCHAR(100) NOT NULL, 
    valor DECIMAL(10,2) NOT NULL, 
    especialidade VARCHAR(100) NOT NULL, 
    CONSTRAINT pk_restaurante PRIMARY KEY (id_restaurante),
    CONSTRAINT fk_restaurante_cidade FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade)
);

-- Tabela Hotel 
CREATE TABLE hotel ( 
    id_hotel CHAR(15) NOT NULL,
    id_cidade CHAR(15) NOT NULL, 
    id_restaurante CHAR(15) NOT NULL, 
    nome_hotel VARCHAR(100) NOT NULL, 
    endereco VARCHAR(100) NOT NULL, 
    categoria DECIMAL(3,1) NOT NULL,
    CONSTRAINT pk_hotel PRIMARY KEY (id_hotel), 
    CONSTRAINT fk_hotel_cidade FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade), 
    CONSTRAINT fk_hotel_restaurante FOREIGN KEY (id_restaurante) REFERENCES restaurante (id_restaurante) 
);

-- Tabela Quarto 
CREATE TABLE quarto( 
    tipo_quarto VARCHAR(50) NOT NULL, 
    qtd_quartos SMALLINT NOT NULL, 
    CONSTRAINT pk_quarto PRIMARY KEY (tipo_quarto)
); 

-- Tabela Hotel_Quarto 
CREATE TABLE hotel_quarto ( 
    id_hotel CHAR(15) NOT NULL,
    tipo_quarto VARCHAR(50) NOT NULL,
    diaria DECIMAL(10,2) NOT NULL,
    CONSTRAINT pk_hotel_quarto PRIMARY KEY (id_hotel, tipo_quarto),
    CONSTRAINT fk_hotel_quarto_hotel FOREIGN KEY (id_hotel) REFERENCES hotel (id_hotel),
    CONSTRAINT fk_hotel_quarto_quarto FOREIGN KEY (tipo_quarto) REFERENCES quarto (tipo_quarto)
);

-- Tabela Ponto Turístico 
CREATE TABLE ponto_turistico (
    id_pt_turistico CHAR(15) NOT NULL,
    id_cidade CHAR(15) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    endereco VARCHAR(100) NOT NULL,
    CONSTRAINT pk_ponto_turistico PRIMARY KEY (id_pt_turistico),
    CONSTRAINT fk_pt_cidade FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade)
	);

	
-- Tabela Casa de Shows
CREATE TABLE casa_de_shows( 
    id_pt_turistico CHAR(15) NOT NULL,
	id_cidade CHAR(15) NOT NULL,
    id_restaurante CHAR(15), 
	descricao VARCHAR(100) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
    hora_inicio TIME NOT NULL, 
    fechado VARCHAR (15),
    CONSTRAINT pk_casa_de_shows PRIMARY KEY (id_pt_turistico),
    CONSTRAINT fk_cds_pt FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade),
    CONSTRAINT fk_cds_restaurante FOREIGN KEY (id_restaurante) REFERENCES restaurante (id_restaurante)
);

-- Tabela Museus 
CREATE TABLE museus( 
    id_pt_turistico CHAR(15) NOT NULL,
	id_cidade CHAR(15) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
    data_fundacao DATE NOT NULL,
    salas SMALLINT NOT NULL,
    CONSTRAINT pk_museus PRIMARY KEY (id_pt_turistico),
	CONSTRAINT fk_cds_mu FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade)
);

-- Tabela Fundador 
CREATE TABLE fundador( 
    id_fundador CHAR(15) NOT NULL, 
    nome_fundador VARCHAR(100) NOT NULL, 
    data_nascimento DATE NOT NULL, 
    data_falecimento DATE, 
    profissao VARCHAR(100) NOT NULL, 
    nacionalidade VARCHAR(100) NOT NULL, 
    CONSTRAINT pk_fundador PRIMARY KEY (id_fundador) 
);  

-- Tabela Fundador museus
CREATE TABLE fundador_museus( 
    id_pt_turistico CHAR(15) NOT NULL,
    id_fundador CHAR(15) NOT NULL,
    CONSTRAINT pk_fundador_museus PRIMARY KEY (id_pt_turistico, id_fundador),
    CONSTRAINT fk_fm_museu FOREIGN KEY (id_pt_turistico) REFERENCES museus (id_pt_turistico),
    CONSTRAINT fk_fm_fundador FOREIGN KEY (id_fundador) REFERENCES fundador (id_fundador)
);

-- Tabela Igrejas 
CREATE TABLE igreja( 
    id_pt_turistico CHAR(15) NOT NULL,
	id_cidade CHAR(15) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
    data_fundacao DATE NOT NULL, 
    estilo VARCHAR(100),
    CONSTRAINT pk_igreja PRIMARY KEY (id_pt_turistico), 
    CONSTRAINT fk_igreja_pt FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade)
);

-- ------------------------------- Povoamento das Tabelas -------------------------------

-- Povoamento da tabela cidades
INSERT INTO cidade (id_cidade, nome, estado, populacao) VALUES
('id_cid_01', 'Rio de Janeiro', 'RJ', 6729894),
('id_cid_02', 'São Paulo', 'SP', 11895578),
('id_cid_03', 'Salvador', 'BA', 2568928),
('id_cid_04', 'Belo Horizonte', 'MG', 2416339),
('id_cid_05', 'Florianópolis', 'SC', 576361),
('id_cid_06', 'Curitiba', 'PR', 1773718),
('id_cid_07', 'Fortaleza', 'CE', 2574412),
('id_cid_08', 'Manaus', 'AM', 2279686),
('id_cid_09', 'Porto Alegre', 'RS', 1389322),
('id_cid_10', 'Recife', 'PE', 1587707),
('id_cid_11', 'Ouro Preto', 'MG', 74821),
('id_cid_12', 'Brasília', 'DF', 2817381),
('id_cid_13', 'Natal', 'RN', 785368),
('id_cid_14', 'João Pessoa', 'PB', 833932),
('id_cid_15', 'Maceió', 'AL', 957916),
('id_cid_16', 'Vitória', 'ES', 322869);

-- Povoamento da tabela restaurantes
INSERT INTO restaurante (id_restaurante, id_cidade, nome_restaurante, endereco, categoria, valor, especialidade) VALUES
('id_res_01', 'id_cid_01', 'Restaurante Colombo', 'R. Gonçalves Dias, 32 - Centro, Rio de Janeiro - RJ', 'clássico', 150.00, 'comidas portuguesas'),
('id_res_02', 'id_cid_02', 'Terraço Itália','Av. Ipiranga, 344 - 41º andar - República, São Paulo - SP', 'italiano', 120.00, 'massas artesanais'),
('id_res_03', 'id_cid_02', 'Palácio do Sushi', 'Rua Otto Pfuntzenreuter, 379 - Costa e Silva - São Paulo - SP', 'japonês', 200.00, 'sushis e sashimis'),
('id_res_04', 'id_cid_09', 'Churrascaria Freio de Ouro', 'R. José de Alencar, 460 - Menino Deus, Porto Alegre - RS', 'churrascaria', 180.00, 'carnes nobres'),
('id_res_05', 'id_cid_04', 'Paris 6 Bistrô', 'Avenida do Contorno, 6061 - Shopping Patio Savassi - Belo Horizonte - MG','francês', 220.00, 'culinária francesa contemporânea'),
('id_res_06', 'id_cid_04', 'Gero','R. São Paulo, 2320 - Lourdes, Belo Horizonte - MG', 'italiano', 160.00, 'massas e risotos'),
('id_res_07', 'id_cid_07', 'Mandir Restaurante Vegano', 'Rua Padre Francisco Pinto, 257 - Benfica, Fortaleza - CE', 'vegetariano', 110.00, 'pratos vegetarianos'),
('id_res_08', 'id_cid_08', 'Casa do Hamburguer', 'Rua Luiz Antony - Aparecida, 1072 - A, Manaus - AM', 'hamburgueria', 75.00, 'hambúrgueres artesanais'),
('id_res_10', 'id_cid_06', 'Thai', 'Al. Júlia da Costa, 870 - Bigorrilho, Curitiba - PR', 'tailandês', 130.00, 'pratos exóticos'),
('id_res_11', 'id_cid_10', 'Parraxaxá','Av. Fernando Simões Barbosa, 1200 - Boa Viagem, Recife - PE', 'regional', 47.00, 'pratos tipicos nordestinos'),
('id_res_12', 'id_cid_11', 'Oscar','R. Sen. Rocha Lagoa, 164 - Centro - Ouro Preto - MG', 'regional', 180.00, 'Comida Mineira'),
('id_res_13', 'id_cid_12',	'Dom Francisco', 'CLS 402 Bloco B, Lojas 9 a 15, Brasília - DF', 'comida variada', 90.00, 'pratos com bacalhau' ),
('id_res_14', 'id_cid_13', 'Esmeralda Praia Hotel', 'R. Francisco Gurgel, 1160 - Ponta Negra, Natal - RN', 'nordestina', 129.00, 'comidas típicas'),
('id_res_15', 'id_cid_14', 'Nau Frutos do Mar','R. Lupércio Branco, 130 - Manaíra, João Pessoa - PB', 'Frutos do mar', 95.00, 'Frutos do Mar'),
('id_res_16', 'id_cid_14', 'Mangai', ' Av. Gen. Edson Ramalho, 696 - Manaíra, João Pessoa - PB', 'nordestina', 135.00, 'comidas típicas'),
('id_res_17', 'id_cid_15', 'Bodega do Sertão', 'Av. Dr. Júlio Marques Luz, 62 - Jatiúca, Maceió - AL', 'regional', 75.00, 'comidas típicas'),
('id_res_18', 'id_cid_16', 'Restaurante Papaguth', 'Av. Nossa Sra. dos Navegantes, 700 - Enseada do Suá, Vitória - ES', 'frutos do mar', 190.00, 'comidas típicas capixaba'),
('id_res_19', 'id_cid_15', 'Divina Gula', 'Av. Eng. Paulo Brandão Nogueira, 85 - Jatiúca, Maceió - AL', 'brasileira', 70.00, 'comidas típicas'),
('id_res_20', 'id_cid_03', 'Casa de Tereza', ' R. Odilon Santos, 45 - Rio Vermelho, Salvador - BA', 'regional', 100.00, 'comidas típicas'),
('id_res_21', 'id_cid_05', 'Ostradamus', 'Rod. Baldicero Filomeno, 7640 - Ribeirão da Ilha, Florianópolis - SC', 'frutos do mar', 120.00, 'ostras'),
('id_res_22', 'id_cid_03', 'Casarão', ' R. da Fonte do Boi, 215 - Rio Vermelho, Salvador - BA', 'baiana', 150.00, 'comidas típicas'),
('id_res_23', 'id_cid_07', 'Mangostin e Mucuripe', 'Av. Beira Mar, 3980 - Loja 1 - Mucuripe, Fortaleza - CE', 'asiática', 200.00, 'comida asiática');


-- Povoamento da tabela hotéis
INSERT INTO hotel (id_hotel, id_cidade, id_restaurante, nome_hotel, endereco, categoria) VALUES
('id_hot_01', 'id_cid_01', 'id_res_01', 'Copacabana Palace, A Belmond Hotel', 'Av. Atlântica, 1702', 9.4),
('id_hot_02', 'id_cid_02', 'id_res_02', 'Iconyc Charlie Ibirapuera Hotel', 'Rua Loefgren, 2527', 8.8),
('id_hot_03', 'id_cid_08', 'id_res_08', 'ibis budget Manaus', 'Avenida Djalma Batista, 1151', 8.4),
('id_hot_04', 'id_cid_04', 'id_res_05', 'Hotel Vivenzo Savassi', 'Rua. Antônio de Albuquerque, 54', 8.6),
('id_hot_05', 'id_cid_07', 'id_res_07', 'Praiano Hotel', 'Av. Beira Mar, 2800', 9.2),
('id_hot_06', 'id_cid_01', 'id_res_01', 'Hotel Arpoador',  'R. Francisco Otaviano, 177 - Ipanema', 8),
('id_hot_07', 'id_cid_03', 'id_res_22', 'Hotel Mercure Salvador', 'R. da Fonte do Boi, 215 - Rio Vermelho, Salvador - BA', 9.2),
('id_hot_08', 'id_cid_07', 'id_res_23', 'Hotel Gran Marquise', 'Av. Beira Mar, 3980 - Loja 1 - Mucuripe, Fortaleza - CE', 8.9),
('id_hot_09', 'id_cid_11', 'id_res_12', 'Grande Hotel Ouro Preto', 'R. Sen. Rocha Lagoa, 164, Ouro Preto - MG', 8.0),
('id_hot_10', 'id_cid_12', 'id_res_13','Esmeralda Praia Hotel', 'R. Francisco Gurgel, 1160 - Ponta Negra, Natal - RN', 9.2),
('id_hot_11', 'id_cid_04', 'id_res_06','Hotel Fasano Belo Horizonte','R. São Paulo, 2320 - Lourdes, Belo Horizonte - MG', 9.0),
('id_hot_12', 'id_cid_05', 'id_res_21','Majestic Palace Hotel','Av. Jorn. Rubéns de Arruda Ramos, 2746 - Centro, Florianópolis - SC', 8.5),
('id_hot_13', 'id_cid_16', 'id_res_18','Go Inn Vitória', 'Av. João Batista Parra, 261 - Praia do Suá, Vitória - ES', 7.0);

-- Povoamento da tabela quartos
INSERT INTO quarto (tipo_quarto, qtd_quartos) VALUES
('Standard', 25),
('Luxo', 10),
('Suíte Presidencial', 5),
('Familiar', 20),
('Executivo', 15);

-- Povoamento da tabela hotel_quarto
INSERT INTO hotel_quarto (id_hotel, tipo_quarto, diaria) VALUES
('id_hot_02', 'Standard', 350.00),('id_hot_02', 'Luxo', 1200.00),
('id_hot_01', 'Suíte Presidencial', 5000.00),
('id_hot_04', 'Standard',300.00),
('id_hot_02', 'Executivo', 800.00),
('id_hot_03', 'Standard', 400.00),
('id_hot_05', 'Familiar', 450.00),
('id_hot_01', 'Luxo', 1000.00),
('id_hot_03', 'Luxo',1100.00),
('id_hot_05', 'Suíte Presidencial', 2000.00),
('id_hot_06', 'Luxo', 950.00),('id_hot_06', 'Standard', 250.00),
('id_hot_07', 'Standard', 350.90),('id_hot_07', 'Familiar', 420.00),('id_hot_07', 'Suíte Presidencial', 6500.00),
('id_hot_08', 'Luxo',100.00),('id_hot_08', 'Suíte Presidencial', 3000.00),('id_hot_08', 'Standard', 290.00),
('id_hot_09', 'Luxo', 850.00 ),('id_hot_09', 'Suíte Presidencial', 1500.00),
('id_hot_09', 'Standard', 300.00),('id_hot_09', 'Executivo', 950.00),
('id_hot_10', 'Standard', 900.00),('id_hot_10', 'Familiar', 500.00),('id_hot_10', 'Luxo', 1200.00),
('id_hot_11', 'Luxo', 1350.00), ('id_hot_11', 'Suíte Presidencial', 3900.00),
('id_hot_12', 'Suíte Presidencial', 4500.00),
('id_hot_12', 'Standard', 320.00),
('id_hot_12', 'Executivo', 680.00),
('id_hot_13', 'Standard', 280.00);

-- Povoamento da tabela Casa_de_Shows

INSERT INTO casa_de_shows (id_pt_turistico, id_cidade, id_restaurante, descricao, endereco, hora_inicio, fechado) VALUES
('id_pt_01', 'id_cid_01',  'id_res_01', 'Corcovado - Cristo Redentor', 'Parque Nacional da Tijuca, - Alto da Boa vista Rio de Janeiro - RJ', '12:00:00', null),
('id_pt_02', 'id_cid_01', null, 'Circo Voador', 'R. dos Arcos, s/n - Lapa, Rio de Janeiro - RJ', '20:00:00', 'Quarta-Feira'),
('id_pt_03', 'id_cid_01', 'id_res_02', 'Bondinho Pão de Açúcar', 'Estação II - Morro da Urca / Praia Vermelha', '19:30:00', null),
('id_pt_04', 'id_cid_02', null, 'Villa Country', 'Av. Francisco Matarazzo, 774 - Água Branca, São Paulo - SP', '20:00:00', 'Segunda-Feira'),
('id_pt_08', 'id_cid_02', 'id_res_03', 'Tokio Marine Hall', 'R. Bragança Paulista, 1281 - Varzea de Baixo, São Paulo - SP', '12:00:00', null),
('id_pt_09', 'id_cid_03', null,'Largo Tereza Batista', 'R. Gregório de Matos, 6 - Pelourinho, Salvador - BA', '12:00:00', null),
('id_pt_16', 'id_cid_03', null,'Concha Acústica', 'Av. Alberto Pinto, 11 - Campo Grande, Salvador - BA', '19:30:00', 'Segunda-Feira'),
('id_pt_17', 'id_cid_10', 'id_res_11','Clubre Metrópole', 'R. das Ninfas, 125 - Boa Vista, Recife - PE', '20:00:00', 'Quarta-Feira'),
('id_pt_18', 'id_cid_09', 'id_res_04', 'Opiniao','R. José do Patrocínio, 834 - Cidade Baixa, Porto Alegre - RS', '19:00:00', null),
('id_pt_13', 'id_cid_13', null, 'Rastapé Casa de Forró','R. Aristides Porpino Filho', '22:00:00', 'Quinta-Feira'),
('id_pt_14', 'id_cid_14', null, 'Lovina Seixas', 'R. dos Pescadores, 426 - Seixas - João Pessoa- PB', '10:00:00', null),
('id_pt_15', 'id_cid_15', 'id_res_17', 'Orákulo Chopperia', 'R. Barão de Jaraguá, 718 - Jaraguá, Maceio - AL', '21:00:00', 'Segunda-Feira');


-- Povoamento da tabela museus
INSERT INTO museus (id_pt_turistico, id_cidade, descricao, endereco, data_fundacao, salas) VALUES
('id_pt_05', 'id_cid_02', 'MASP', 'Avenida Paulista, no bairro da Bela Vista, 1578, São Paulo - SP','1947-10-07', 10),
('id_pt_06', 'id_cid_03', 'Museu Afro-Brasileiro da UFBA', 'Largo do Terreiro de Jesus, s/n, Salvador - BA', '1982-01-07', 27 ),
('id_pt_19', 'id_cid_16', 'Museu de Arte do Espirito Santo', 'Avenida Jerônimo Monteiro, 631, Centro, Vitória - ES','1998-12-18', 5),
('id_pt_20', 'id_cid_11', 'Museu da Inconfidência', 'Praça Tiradentes, 139, Centro Histórico, Ouro Preto - MG', '1944-08-11', 16);


-- Povoamento da tabela fundador								
INSERT INTO fundador (id_fundador, nome_fundador, data_nascimento, data_falecimento, profissao, nacionalidade) VALUES
('id_fun_01', 'Assis Chateaubriand', '1892-10-04', '1968-04-04', 'Empresário', 'Brasileira'),
('id_fun_02', 'Pierre Verger', '1902-11-04', '1996-02-11', 'Antropólogo', 'Francês'),
('id_fun_03', 'Yeda Pessoa de Castro', '1937-03-10', null, 'Etnolinguista', 'Brasileira'),
('id_fun_04', 'Paulo Herkenhoff', '1949-10-05', null, 'Curador de Arte', 'Brasileiro'),
('id_fun_05', 'Raimundo Trindade', '1983-11-20', '1962-04-02', 'Historiador', 'Brasileiro');


-- Povoamento da tabela fundador_museus
INSERT INTO fundador_museus (id_pt_turistico, id_fundador) VALUES
('id_pt_05', 'id_fun_01'),
('id_pt_06', 'id_fun_02'),
('id_pt_06', 'id_fun_03'),
('id_pt_19', 'id_fun_04'),
('id_pt_20', 'id_fun_05');

-- Povoamento da tabela igrejas
INSERT INTO igreja (id_pt_turistico, id_cidade, descricao, endereco, data_fundacao, estilo) VALUES
('id_pt_07', 'id_cid_04', 'Santuário São José', 'Rua Tupis, 164 - Centro  - Belo Horizonte - MG', '1900-01-27', 'neogótico'),
('id_pt_08', 'id_cid_02', 'Catedral da Sé', 'Praça da Sé - Centro - São Paulo - SP', '1913-08-25', 'neogótico/renascentista'),
('id_pt_09', 'id_cid_01', 'Catedral de São Sebastião', 'Av. República do Chile, 245 - Centro, Rio de Janeiro - RJ', '1964-01-20', 'modernista');

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

SELECT ROUND (AVG(populacao) ,2) AS media_populacao
FROM cidade;

-- 2)

SELECT ROUND (AVG(diaria) ,2) AS media_diaria
FROM hotel_quarto;

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

--SELECT tipo_quarto, ROUND (AVG(diaria) ,2) AS media_diaria
--FROM quarto
--GROUP BY tipo_quarto
--HAVING AVG(diaria) > 300;

SELECT q.tipo_quarto, ROUND(AVG(hq.diaria),2) AS media_diaria
FROM quarto q INNER JOIN hotel_quarto hq ON q.tipo_quarto = hq.tipo_quarto
GROUP BY q.tipo_quarto
HAVING AVG (hq.diaria) > 300;

-- 3)

SELECT c.nome AS cidade, COUNT(h.id_hotel) AS qtd_hoteis
FROM cidade c
JOIN hotel h ON c.id_cidade = h.id_cidade
GROUP BY c.nome
HAVING COUNT(h.id_hotel) > 1;


--  5. SQL/DML- Atualizações
--  Apresentar um Script SQL com o objetivo de implementar as seguintes operações de atualização do Banco de Dados:

--  (a) Uma inserção que envolva integridade referencial.

INSERT INTO hotel (id_hotel, id_cidade, id_restaurante, nome_hotel, endereco, categoria) VALUES
('id_hot_14', 'id_cid_10', 'id_res_10', 'Hotel Atlante Plaza', 'Av. Boa Viagem, 5426', 8.4);

-- 	(b) Uma insersção que envolva cláusula CHECK.

ALTER TABLE hotel_quarto ADD CHECK(diaria > 99.9);

INSERT INTO hotel_quarto (id_hotel, tipo_quarto, diaria) VALUES
('id_hot_12', 'Luxo', 50.00);

--  (c) Uma inserção de dados em uma tabela à partir de dados em outra tabela, ou seja,
--  uso do SELECT em INSERT.

INSERT INTO ponto_turistico (id_pt_turistico, id_cidade, descricao, endereco)
SELECT id_pt_turistico, id_cidade, descricao, endereco
FROM casa_de_shows;

--  (d) Uma remoção que envolva integridade referencial usando CASCADE.

--ALTER TABLE restaurante DROP CONSTRAINT fk_restaurante_cidade;

ALTER TABLE restaurante
ADD CONSTRAINT fk_res_cidade FOREIGN KEY (id_cidade) REFERENCES cidade (id_cidade)
ON UPDATE NO ACTION
ON DELETE CASCADE;

DELETE FROM hotel WHERE id_restaurante = 'id_res_04';

--  (e) Uma remoção que envolva integridade referencial usando SET NULL.

--ALTER TABLE fundador_museus DROP CONSTRAINT pk_fundador_museus;

--ALTER TABLE fundador_museus 
--ALTER COLUMN id_fundador DROP NOT NULL;

--ALTER TABLE fundador_museus DROP CONSTRAINT fk_fm_fundador;

ALTER TABLE fundador_museus
ADD CONSTRAINT fk_fm_fund FOREIGN KEY (id_fundador) REFERENCES fundador (id_fundador)
ON UPDATE NO ACTION
ON DELETE SET NULL;

DELETE FROM fundador WHERE id_fundador = 'id_fun_02';

--  (f) Uma atualização que envolVa dados obtidos de consultas a outras tabelas

UPDATE hotel_quarto hq
SET diaria = diaria + (diaria * 0.15)
FROM hotel h
JOIN cidade c ON h.id_cidade = c.id_cidade
WHERE hq.id_hotel = h.id_hotel
  AND c.id_cidade = 'id_cid_01';
