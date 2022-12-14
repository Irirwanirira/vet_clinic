/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    names VARCHAR(100) NOT NULL,
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
    names CHAR(100),
    PRIMARY KEY (id)
);
