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

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (1,'Agumon', '2020-02-03', '0' , TRUE, '10.23' );

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (2,' Gabumon', '2018-11-15', '2' , TRUE, '8' );

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (3,' Pikachu', '2021-01-07', '1' , FALSE, '15.04');

INSERT INTO animals (id, names, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (4,'Devimon', '2017-05-12', '5' , TRUE, '11');

