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
VALUES (2,' Gabumon', '2018-11-15', '2' , TRUE, '8' );

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


-- Updates

UPDATE animals SET escape_attempts =2 WHERE id = 2;
UPDATE animals SET names = 'Gabumon' WHERE weight_kg = 8;


-- Create column called species

ALTER TABLE animals ADD species VARCHAR(40);

-- add DATA

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (5,' Charmander', '2020-02-08', '0' , FALSE, '-11');

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (6,' Plantom', '2021-11-15', '2' , TRUE, '-5.7');

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (7,' Squirtle', '1993-04-02', '3' , FALSE, '-12.13');

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (8,' Angemon', '2005-06-12', '1' , TRUE, '-45');

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (9,' Boarmon', '2005-06-07', '7' , TRUE, '20.4');

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (10,' Blossom', '1998-10-13', '3' , TRUE, '17');

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (11,' Ditto', '2022-04-014', '4' , TRUE, '22');



--  Start the transaction for the clinic

BEGIN;
UPDATE animals SET species = 'unspecified';
ROLLBACK;




