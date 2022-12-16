-- vet database with a table of animal and id as a PRIMARY KEY
-- psql --host=localhost dbname=vet_clinic --username=postgres, very useful in the terminal
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

-- -- What animals belong to Melody Pond?
-- SELECT name, full_name FROM animals INNER JOIN owners ON animals.id = owners.id WHERE owners.full_name = 'Melody Pond';

-- -- List of all animals that are pokemon (their type is Pokemon).
-- SELECT animals.name, species.name FROM animals INNER JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- -- List all owners and their animals, remember to include those that don't own any animal.
-- SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owners_id;

-- -- How many animals are there per species?
-- SELECT COUNT(animals.name), species.name FROM animals INNER JOIN species ON animals.species_id = species.id GROUP BY species.name;

-- -- List all Digimon owned by Jennifer Orwell
-- SELECT owners.full_name, animals.name, species.name FROM animals INNER JOIN owners ON animals.id = owners_id INNER JOIN species ON species.id = animals.species_id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- -- List all animals owned by Dean Winchester that haven't tried to escape.
-- SELECT owners.full_name, animals.name, animals.escape_attempts FROM animals INNER JOIN owners ON animals.id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = '0';

-- -- Who owns the most animals?
-- SELECT owners.full_name, COUNT(*) FROM animals INNER JOIN owners ON animals.id = owners.id GROUP BY owners.full_name ORDER BY count DESC LIMIT 1;


-- create vets table
DROP TABLE IF EXISTS vets;

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name CHAR(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

INSERT INTO vets(name, age, date_of_graduation) VALUES('Vets William Tatcher', 45, '2000-04-23');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Vets Maisy Smith', 26, '2019-01-17');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Vets Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Vets Jack Harkness', 38, '2008-06-08');

-- ADD VISITS AND SPECIALIZATION INTO animals table

ALTER TABLE animals ADD COLUMN specialization_id INT;
ALTER TABLE animals ADD COLUMN visits_id INT;

-- refference them in animlas

ALTER TABLE animals ADD CONSTRAINT fk_specializations FOREIGN KEY (specialization_id) REFERENCES specializations(id);
ALTER TABLE animals ADD CONSTRAINT fk_visits FOREIGN KEY (visits_id) REFERENCES visits(id);

-- specialisation table
DROP TABLE IF EXISTS specializations;
CREATE TABLE specializations (
    id INT GENERATED ALWAYS AS IDENTITY,
    vets_name CHAR(100),
    species_name CHAR(100),
    PRIMARY KEY (id)
);

INSERT INTO specializations(vets_name,species_name) 
VALUES('William Tatcher','Pokemon'),
('Stephanie Mendez','Digimon,Pokemon'),
('Jack Harkness','Digimon');


-- visits table
DROP TABLE IF EXISTS visits;
CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY,
    animals_name CHAR(100),
    vets_name CHAR(100),
    date_of_visit DATE,
    PRIMARY KEY(id)
);

INSERT INTO visits (animals_name,vets_name,date_of_visit)
VALUES('Agumon','William Tatcher','2020-05-25'),
('Agumon','Stephanie Mendez','2020-07-22'),
('Gabumon','Jack Harkness','2021-02-02'),
('Pikachu','Maisy Smith','2020-01-05'),
('Pikachu','Maisy Smith','2020-03-08'),('Pikachu','Maisy Smith','2020-05-14'),
('Devimon','Stephanie Mendez','2021-05-04'),
('Charmander','Jack Harkness','2021-02-24'),
('Plantmon','Maisy Smith','2019-12-21'),
('Plantmon','William Tatcher','2020-04-10'),
('Squirtle','Stephanie Mendez','2020-09-29'),
('Angemon','Jack Harkness','2020-10-03'),
('Angemon','Jack Harkness','2020-11-04'),
('Boarmon','Maisy Smith','2019-01-24'),
('Boarmon','Maisy Smith','2019-05-15'),
('Boarmon','Maisy Smith','2020-02-27'),
('Boarmon','Maisy Smith','2019-01-24'),
('Boarmon','Maisy Smith','2020-08-03'),
('Blossom','Stephanie Mendaz','2020-05-24'),
('Blossom','Willia, Tatcher','2021-01-11');

-- Further querries

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
select vets.name, species.name from vets INNER JOIN specializations as s ON vets.id!= s.id INNER JOIN species ON species.id !=s.id where vets.name = 'Maisy Smith';

select vets.name,species.name from vets INNER JOIN specializations ON vets.id!=specializations.id INNER JOIN species ON species.id !=specializations.id where vets.name='Maisy Smith';
