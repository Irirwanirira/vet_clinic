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

