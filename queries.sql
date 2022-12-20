/*Queries that provide answers to the questions FROM all projects.*/

-- Find all animals whose name ends in "mon".

SELECT * from animals where name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name from animals where date_of_birth  BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name from animals where escape_attempts < 3 AND neutered =true;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals where name='Agumon' OR name='Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name,escape_attempts from animals where weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * from animals where neutered =true;

-- Find all animals not named Gabumon..
SELECT * from animals where name!='Gabumon.' ;

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
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
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


-- Write queries (using JOIN) to answer the following questions

SELECT name, full_name FROM animals INNER JOIN owners ON animals.owners_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name, species.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owners_id;

SELECT COUNT(animals.name), species.name FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT owners.full_name, animals.name, species.name FROM animals INNER JOIN owners ON animals.id = owners_id INNER JOIN species ON species.id = animals.species_id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT owners.full_name, animals.name, animals.escape_attempts FROM animals INNER JOIN owners ON animals.id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = '0';

SELECT owners.full_name, COUNT(*) FROM animals INNER JOIN owners ON animals.id = owners.id GROUP BY owners.full_name ORDER BY count DESC LIMIT 1;



-- Who was the last animal seen by William Tatcher?
SELECT a.name FROM animals AS a INNER JOIN visits AS v ON a.id = v.id INNER JOIN specializations AS s ON s.id = v.id WHERE s.vets_name ='William Tatcher' ORDER BY v.date_of_visit DESC LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) FROM animals AS a INNER JOIN specializations AS s ON a.id = s.id WHERE s.vets_name = 'Stephanie Mendez';
-- List all vets and their specialties, including vets with no specialties.
SELECT *  FROM specializations AS s INNER JOIN visits AS v ON s.id = v.id WHERE s.species_name IN ('Pokemon', 'Digimon');
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name FROM animals AS a INNER JOIN visits AS v ON a.id = v.id INNER JOIN specializations AS s ON v.id = s.id WHERE s.vets_name = 'Stephanie Mendez' ORDER BY v.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30' ;
-- What animal has the most visits to vets?
select a.name, COUNT(*) as visited from animals AS a INNER JOIN  visits AS v ON a.id = v.id INNER JOIN vets ON vets.id=v.id GROUP BY a.name ORDER BY visited DESC LIMIT 1;
--  Who was Maisy Smith's first visit?
select a.name, v.date_of_visit, vets_name from animals as a INNER JOIN visits as v on a.id = v.id INNER JOIN vets on vets.id = v.id where vets.name = 'Maisy Smith' ORDER BY date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
select a.*,vets.*,v.date_of_visit from animals AS a INNER JOIN visits as v ON v.id=a.id INNER JOIN vets ON vets.id=v.id ORDER BY date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
select vets.name,COUNT(v.id) as visit,COUNT(species.name) as specialization from vets LEFT JOIN specializations as s ON vets.id=s.id LEFT JOIN species ON species.id=s.id INNER JOIN visits  as v ON v.id =vets.id GROUP BY vets.name ORDER BY visit DESC LIMIT 1;

-- What speciality should Maisy Smith consider getting? Look for the species she gets the most.
select vets.name, species.name from vets INNER JOIN specializations as s  ON vets.id != s.id INNER JOIN species ON species.id != s.id where vets.name='Maisy Smith';


-- AUDIT PERFOMANCE

explain analyze SELECT COUNT(*) FROM visits where animalS_id = 4

explain analyze SELECT * FROM visits where vetS_id = 2;

explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';
