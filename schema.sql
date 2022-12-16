/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY (id)
);

-- Remove species from animal table
ALTER TABLE animals DROP species;

-- Create  owners table
DROP TABLE IF EXISTS owners;

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name CHAR(200),
    age INT,
    PRIMARY KEY (id)
);

--  species table 

DROP TABLE IF EXISTS species;

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name CHAR(100),
    PRIMARY KEY (id)
);

-- add species and owner to animal table,

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD COLUMN owners_id INT;

-- reference owner and species into animals

ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY (owners_id) REFERENCES owners(id);

-- create vets table
DROP TABLE IF EXISTS vets;

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name CHAR(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY (id)
);

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