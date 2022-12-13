-- vet database with a table of animal and id as a unic value

DROP TABLE IF EXISTS vet_clinic;

CREATE TABLE animals (
    id INT,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL
);
