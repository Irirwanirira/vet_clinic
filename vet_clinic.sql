-- vet database with a table of animal and id as a PRIMARY KEY

DROP TABLE IF EXISTS animals;

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY (id)
);

-- insert data into the table

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', '0' , TRUE, '10.23' );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (' Gabumon', '2018-11-15', '2' , TRUE, '8' );

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (' Pikachu', '2021-01-07', '1' , FALSE, '15.04');

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', '2017-05-12', '5' , TRUE, '11');

-- -- Quest Querries,

-- SELECT * from animals where name LIKE '%mon';
-- SELECT name from animals where date_of_birth  BETWEEN '2016-01-01' AND '2019-12-31';
-- SELECT name from animals where escape_attempts < 3 AND neutered =true;
-- SELECT date_of_birth from animals where name='Agumon' OR name='Pikachu';
-- SELECT name,escape_attempts from animals where weight_kg > 10.5;
-- SELECT * from animals where neutered =true;
-- SELECT * from animals where name!='Gabumon.' ;
-- SELECT * from animals where weight_kg>=10.4 AND weight_kg<=17.3;

-- -- Create column called species

-- ALTER TABLE animals ADD species VARCHAR(40);

-- add DATA

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (' Charmander', '2020-02-08', '0' , FALSE, '-11');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (' Plantom', '2021-11-15', '2' , TRUE, '-5.7');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (' Squirtle', '1993-04-02', '3' , FALSE, '-12.13');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (' Angemon', '2005-06-12', '1' , TRUE, '-45');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (' Boarmon', '2005-06-07', '7' , TRUE, '20.4');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (' Blossom', '1998-10-13', '3' , TRUE, '17');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (' Ditto', '2022-04-014', '4' , TRUE, '22');

-- --  Start the transaction for the clinic

-- BEGIN;
-- UPDATE animals SET species = 'unspecified';
-- ROLLBACK;

-- -- MUltiple Tables

-- -- Remove species from animal table
-- ALTER TABLE animals DROP species;

-- Create  owners table
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

--  species table 

DROP TABLE IF EXISTS species;

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name CHAR(100),
    PRIMARY KEY (id)
);

INSERT INTO species(name) VALUES('Pokemon');
INSERT INTO species(name) VALUES('Digimon');

-- add species and owner to animal table,

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD COLUMN owners_id INT;

-- reference owner and species into animals

ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY (owners_id) REFERENCES owners(id);

-- Modify your inserted animals so it includes the species_id value

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id =1 WHERE species_id IS NULL; 


-- Modify your inserted animals to include owner information (owner_id)
--  Sam Smith owns Agumon.
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') WHERE name = 'Agumon';
-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Jenifer Orwell') WHERE name IN ('Gabumon', 'Pikacu');
-- Bob owns Devimon and Plantmon.
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Bob') WHERE name IN ('Devimon', 'Plantmon');
-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond') WHERE name IN ('Charmander', 'Squirtle', 'Blossmon');
-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owners_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') WHERE name IN ('Angemon', 'Boarmon');

-- Write queries (using JOIN) to answer the following questions

-- What animals belong to Melody Pond?
SELECT name, full_name FROM animals INNER JOIN owners ON animals.id = owners.id WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owners_id;

-- How many animals are there per species?
SELECT COUNT(animals.name), species.name FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT owners.full_name, animals.name, species.name FROM animals INNER JOIN owners ON animals.id = owners_id INNER JOIN species ON species.id = animals.species_id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT owners.full_name, animals.name, animals.escape_attempts FROM animals INNER JOIN owners ON animals.id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = '0';

-- Who owns the most animals?
SELECT owners.full_name, COUNT(*) FROM animals INNER JOIN owners ON animals.id = owners.id GROUP BY owners.full_name ORDER BY count DESC LIMIT 1;
