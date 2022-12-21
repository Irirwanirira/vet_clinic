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
DROP TABLE IF EXISTS specializations CASCADE;
CREATE TABLE specializations (
    species_id int REFERENCES species (id),
    vets_id int REFERENCES vets (id),
    PRIMARY KEY (species_id, vets_id)
);

-- visits table

--  we use cascade to delete a column which has a relatiojship eith other talbes in perfoming querries.
DROP TABLE IF EXISTS visits CASCADE;
CREATE TABLE visits (
    animals_id int REFERENCES animals (id),
    vets_id int REFERENCES vets (id),
    visit_date date,
    PRIMARY KEY (animals_id, vets_id, visit_date)
   
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);



CREATE INDEX audit_visits
ON visits (animals_id);

CREATE INDEX vets_1
ON visits (vets_id);


CREATE INDEX email_1
ON owners (email);