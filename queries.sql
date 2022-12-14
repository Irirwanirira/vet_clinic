/*Queries that provide answers to the questions FROM all projects.*/

-- Find all animals whose names ends in "mon".

SELECT * from animals where names LIKE '%mon';

-- List the names of all animals born between 2016 and 2019.
SELECT names from animals where date_of_birth  BETWEEN '2016-01-01' AND '2019-12-31';

-- List the names of all animals that are neutered and have less than 3 escape attempts.
SELECT names from animals where escape_attempts < 3 AND neutered =true;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals where names='Agumon' OR names='Pikachu';

-- List names and escape attempts of animals that weigh more than 10.5kg
SELECT names,escape_attempts from animals where weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * from animals where neutered =true;

-- Find all animals not named Gabumon..
SELECT * from animals where names!='Gabumon.' ;

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * from animals where weight_kg>=10.4 AND weight_kg<=17.3;

--  Start the transaction for the clinic

-- Inside a transaction update the animals table by setting the species column to unspecified.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;

-- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
BEGIN;
UPDATE animals SET species = 'digimon' WHERE names LIKE '%mon';
SELECT species FROM animals;
UPDATE animals SET species = 'pokemon' WHERE species IS NULL ;
SELECT species FROM animals;
COMMIT;
SELECT species FROM animals;


-- delete all records in the animals table, then roll back the transaction.
-- After the rollback verify if all records in the animals table still exists. 
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Delete all animals born after Jan 1st, 2022.
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT SP1;
UPDATE animals SET weight_kg = -weight_kg WHERE weight_kg < 0;
COMMIT;  -- Commit transaction

-- How many animals are there?
SELECT * FROM animals;

-- How many animals have never tried to escape?
SELECT * FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT MAX(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT MAX(weight_kg) FROM animals;
SELECT MIN(weight_kg) FROM animals;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth  BETWEEN '1990-01-01' AND '2000-12-31';
