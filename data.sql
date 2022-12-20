/* Populate database with sample data. */

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', '2020-02-03', '0' , TRUE, '10.23' );

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (' Gabumon', '2018-11-15', '3' , TRUE, '8' );

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (' Pikachu', '2021-01-07', '1' , FALSE, '15.04');

INSERT INTO animals ( name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', '2017-05-12', '5' , TRUE, '11');

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

--  insert data for owners
INSERT INTO owners(full_name, age) VALUES('Sam Smith', 34);
INSERT INTO owners(full_name, age) VALUES('Jennifer Orwell', 19);
INSERT INTO owners(full_name, age) VALUES('Bob', 45);
INSERT INTO owners(full_name, age) VALUES('Melody Pond', 77);
INSERT INTO owners(full_name, age) VALUES('Dean Winchester', 14);
INSERT INTO owners(full_name, age) VALUES('Joddy Whitaker', 38);

--  insert data for species 

INSERT INTO species(name) VALUES('Pokemon');
INSERT INTO species(name) VALUES('Digimon');


-- Modify your inserted animals so it includes the species_id value
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id =1 WHERE species_id IS NULL; 


-- Modify your inserted animals to include owner information (owner_id
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


INSERT INTO vets(name, age, date_of_graduation) VALUES('Vets William Tatcher', 45, '2000-04-23');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Vets Maisy Smith', 26, '2019-01-17');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Vets Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets(name, age, date_of_graduation) VALUES('Vets Jack Harkness', 38, '2008-06-08');

-- INSERT INTO specializations(vets_name,species_name) 
-- VALUES('William Tatcher','Pokemon'),
-- ('Stephanie Mendez','Digimon,Pokemon'),
-- ('Jack Harkness','Digimon');





-- INSERT INTO visits (animals_name,vets_name,date_of_visit)
-- VALUES('Agumon','William Tatcher','2020-05-25'),
-- ('Agumon','Stephanie Mendez','2020-07-22'),
-- ('Gabumon','Jack Harkness','2021-02-02'),
-- ('Pikachu','Maisy Smith','2020-01-05'),
-- ('Pikachu','Maisy Smith','2020-03-08'),('Pikachu','Maisy Smith','2020-05-14'),
-- ('Devimon','Stephanie Mendez','2021-05-04'),
-- ('Charmander','Jack Harkness','2021-02-24'),
-- ('Plantmon','Maisy Smith','2019-12-21'),
-- ('Plantmon','William Tatcher','2020-04-10'),
-- ('Squirtle','Stephanie Mendez','2020-09-29'),
-- ('Angemon','Jack Harkness','2020-10-03'),
-- ('Angemon','Jack Harkness','2020-11-04'),
-- ('Boarmon','Maisy Smith','2019-01-24'),
-- ('Boarmon','Maisy Smith','2019-05-15'),
-- ('Boarmon','Maisy Smith','2020-02-27'),
-- ('Boarmon','Maisy Smith','2019-01-24'),
-- ('Boarmon','Maisy Smith','2020-08-03'),
-- ('Blossom','Stephanie Mendaz','2020-05-24'),
-- ('Blossom','Willia, Tatcher','2021-01-11');