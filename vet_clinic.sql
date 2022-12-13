-- vet database with a table of animal and id as a PRIMARY KEY

DROP TABLE IF EXISTS vet_clinic;

CREATE TABLE animals (
    id INT,
    names VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY (id)
);

-- insert data into the table

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (1,'Agumon', '2020-02-03', '0' , TRUE, '10.23' );

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (2,' Gabumon', '2018-11-15', '3' , TRUE, '8' );

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (3,' Pikachu', '2021-01-07', '1' , FALSE, '15.04');

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (4,'Devimon', '2017-05-12', '5' , TRUE, '11');

-- Quest Querries,

SELECT * from animals where names LIKE '%mon';
SELECT names from animals where date_of_birth  BETWEEN '2016-01-01' AND '2019-12-31';
SELECT names from animals where escape_attempts < 3 AND neutered =true;
SELECT date_of_birth from animals where names='Agumon' OR names='Pikachu';
SELECT names,escape_attempts from animals where weight_kg > 10.5;
SELECT * from animals where neutered =true;
SELECT * from animals where names!='Gabumon.' ;
SELECT * from animals where weight_kg>=10.4 AND weight_kg<=17.3;
