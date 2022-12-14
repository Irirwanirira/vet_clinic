-- -- vet database with a table of animal and id as a PRIMARY KEY

-- DROP TABLE IF EXISTS animals;

-- CREATE TABLE animals (
--     id INT GENERATED ALWAYS AS IDENTITY,
--     names VARCHAR(100) NOT NULL,
--     date_of_birth DATE,
--     escape_attempts INTEGER,
--     neutered BOOLEAN,
--     weight_kg DECIMAL,
--     PRIMARY KEY (id)
-- );

-- -- insert data into the table

-- INSERT INTO animals (names, date_of_birth, escape_attempts, neutered, weight_kg)
-- VALUES ('Agumon', '2020-02-03', '0' , TRUE, '10.23' );

-- INSERT INTO animals (names, date_of_birth, escape_attempts, neutered, weight_kg)
-- VALUES (' Gabumon', '2018-11-15', '2' , TRUE, '8' );

-- INSERT INTO animals (names, date_of_birth, escape_attempts, neutered, weight_kg)
-- VALUES (' Pikachu', '2021-01-07', '1' , FALSE, '15.04');

-- INSERT INTO animals (names, date_of_birth, escape_attempts, neutered, weight_kg)
-- VALUES ('Devimon', '2017-05-12', '5' , TRUE, '11');

-- -- Quest Querries,

-- SELECT * from animals where names LIKE '%mon';
-- SELECT names from animals where date_of_birth  BETWEEN '2016-01-01' AND '2019-12-31';
-- SELECT names from animals where escape_attempts < 3 AND neutered =true;
-- SELECT date_of_birth from animals where names='Agumon' OR names='Pikachu';
-- SELECT names,escape_attempts from animals where weight_kg > 10.5;
-- SELECT * from animals where neutered =true;
-- SELECT * from animals where names!='Gabumon.' ;
-- SELECT * from animals where weight_kg>=10.4 AND weight_kg<=17.3;


-- -- Updates

-- -- UPDATE animals SET escape_attempts =2 WHERE id = 2;
-- -- UPDATE animals SET names = 'Gabumon' WHERE weight_kg = 8;


-- -- -- Create column called species

-- ALTER TABLE animals ADD species VARCHAR(40);

-- -- add DATA

-- INSERT INTO animals ( names, date_of_birth, escape_attempts, neutered, weight_kg)
-- VALUES (' Charmander', '2020-02-08', '0' , FALSE, '-11');

-- INSERT INTO animals ( names, date_of_birth, escape_attempts, neutered, weight_kg)
-- VALUES (' Plantom', '2021-11-15', '2' , TRUE, '-5.7');

-- INSERT INTO animals ( names, date_of_birth, escape_attempts, neutered, weight_kg)
-- VALUES (' Squirtle', '1993-04-02', '3' , FALSE, '-12.13');

-- INSERT INTO animals ( names, date_of_birth, escape_attempts, neutered, weight_kg)
-- VALUES (' Angemon', '2005-06-12', '1' , TRUE, '-45');

-- INSERT INTO animals ( names, date_of_birth, escape_attempts, neutered, weight_kg)
-- VALUES (' Boarmon', '2005-06-07', '7' , TRUE, '20.4');

-- INSERT INTO animals ( names, date_of_birth, escape_attempts, neutered, weight_kg)
-- VALUES (' Blossom', '1998-10-13', '3' , TRUE, '17');

-- INSERT INTO animals ( names, date_of_birth, escape_attempts, neutered, weight_kg)
-- VALUES (' Ditto', '2022-04-014', '4' , TRUE, '22');



-- --  Start the transaction for the clinic

-- BEGIN;
-- UPDATE animals SET species = 'unspecified';
-- ROLLBACK;


-- -- MUltiple Tables

DROP TABLE IF EXISTS owners;

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name CHAR(200),
    age INT,
    PRIMARY KEY (id)
);

INSERT INTO owners(full_name, age) VALUES('Sam Smith', 34);
INSERT INTO owners(full_name, age) VALUES('Jennifer Orwell', 19);
INSERT INTO owners(full_name, age) VALUES('Bob', 45);
INSERT INTO owners(full_name, age) VALUES('Melody Pond', 77);
INSERT INTO owners(full_name, age) VALUES('Dean Winchester', 14);
INSERT INTO owners(full_name, age) VALUES('Joddy Whitaker', 38);

-- DROP TABLE IF EXISTS species;

-- CREATE TABLE species (
--     id INT GENERATED ALWAYS AS IDENTITY,
--     names CHAR(100),
--     PRIMARY KEY (id)
-- );



