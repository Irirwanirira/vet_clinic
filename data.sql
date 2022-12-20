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

INSERT INTO specializations (species_id, vets_id) VALUES (1,1),
(1,3),
(2,3),
(2,4);

INSERT INTO visits (animals_id, vets_id, visit_date) VALUES (1, 1, '2020-05-24'),
(1, 3, '2020-07-22'),
(2, 4, '2021-02-02'),
(3, 2, '2020-01-05'),
(3, 2, '2020-03-08'),
(3, 2, '2020-05-14'),
(4, 3, '2021-05-04'),
(8, 4, '2021-02-24'),
(9, 2, '2019-12-21'),
(9, 1, '2020-08-10'),
(9, 2, '2021-04-07'),
(10, 3, '2019-09-29'),
(11, 4, '2020-10-03'),
(11, 4, '2020-11-04'),
(5, 2, '2019-01-24'),
(5, 2, '2019-05-15'),
(5, 2, '2020-02-27'),
(5, 2, '2020-08-03'),
(6, 3, '2020-05-24'),
(6, 1, '2021-01-11');

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)

INSERT INTO visits (animals_id, vets_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)

insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
