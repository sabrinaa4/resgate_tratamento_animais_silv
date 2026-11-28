CREATE DATABASE resgate_tratamento_animais_silv;

use resgate_tratamento_animais_silv;

CREATE TABLE RECINTO(
id_recinto INT PRIMARY KEY AUTO_INCREMENT,
tipo ENUM('Quarentena', 'Viveiro', 'Tanque', 'Enfermaria') NOT NULL,
capacidade INT NOT NULL, 
localizacao varchar(100) NOT NULL
);

CREATE TABLE VOLUNTARIO(
id_voluntario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(200) NOT NULL,
cpf VARCHAR(50) NOT NULL UNIQUE,
telefone VARCHAR(50) NOT NULL,
area_atuacao VARCHAR(100) 
);

CREATE TABLE ESPECIE(
id_especie INT PRIMARY KEY AUTO_INCREMENT, 
nome_popular VARCHAR(100) NOT NULL, 
nome_cientifico VARCHAR(100) NOT NULL,
grau_ameaca ENUM('Pouco preocupante', 'Quase ameaçada', 'Vulnerável', 'Em perigo', 'Criticamente em perigo', 'Dados insuficientes') NOT NULL
);

CREATE TABLE ANIMAL(
id_animal INT PRIMARY KEY AUTO_INCREMENT, 
nome VARCHAR(200) NOT NULL, 
sexo ENUM('M','F','I') NOT NULL,
status ENUM('Em tratamento','Em reabilitação','Solto','Cativeiro permanente') NOT NULL,
origem ENUM('Resgate', 'Apreensão', 'Entrega voluntária') NOT NULL, 
data_entrada DATE NOT NULL, 
id_especie_fk INT NOT NULL, 
id_recinto_fk INT, 
FOREIGN KEY (id_especie_fk) REFERENCES ESPECIE(id_especie),
FOREIGN KEY (id_recinto_fk) REFERENCES RECINTO(id_recinto)
);

CREATE TABLE VETERINARIO(
id_veterinario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(200) NOT NULL,
crmv VARCHAR(100) UNIQUE NOT NULL, 
especialidade VARCHAR(200),
telefone VARCHAR(30)
);

CREATE TABLE TRATAMENTO(
id_tratamento INT PRIMARY KEY AUTO_INCREMENT,
descricao VARCHAR(300) NOT NULL,
medicamento VARCHAR(200),
custo DECIMAL(10,2), 
data_inicio DATE,
data_fim DATE,
id_animal_fk INT NOT NULL, 
id_veterinario_fk INT NOT NULL, 
FOREIGN KEY (id_animal_fk) REFERENCES ANIMAL(id_animal),
FOREIGN KEY (id_veterinario_fk) REFERENCES VETERINARIO(id_veterinario)
);

CREATE TABLE LOCAL_SOLTURA(
id_local_soltura  INT PRIMARY KEY AUTO_INCREMENT, 
nome VARCHAR(200) NOT NULL,
bioma ENUM('Amazônia', 'Cerrado', 'Mata Atlântica', 'Caatinga', 'Pampa', 'Pantanal') DEFAULT 'Amazônia' NOT NULL,
cidade VARCHAR(100) NOT NULL,
estado VARCHAR(100)  NOT NULL
);

CREATE TABLE SOLTURA(
id_soltura INT PRIMARY KEY AUTO_INCREMENT,
observacoes VARCHAR(300),
data_soltura DATE,
id_animal_fk INT NOT NULL, 
id_veterinario_fk INT NOT NULL, 
id_local_soltura_fk INT NOT NULL, 
FOREIGN KEY (id_animal_fk) REFERENCES ANIMAL(id_animal),
FOREIGN KEY (id_veterinario_fk) REFERENCES VETERINARIO(id_veterinario),
FOREIGN KEY (id_local_soltura_fk) REFERENCES LOCAL_SOLTURA(id_local_soltura)
);

CREATE TABLE RECINTO_VOLUNTARIO(
id_recinto_voluntario INT PRIMARY KEY AUTO_INCREMENT,
id_recinto_fk INT NOT NULL, 
id_voluntario_fk INT NOT NULL, 
FOREIGN KEY (id_recinto_fk) REFERENCES RECINTO(id_recinto),
FOREIGN KEY (id_voluntario_fk) REFERENCES VOLUNTARIO(id_voluntario)
);