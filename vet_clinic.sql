-- vet database with a table of animal and id as a PRIMARY KEY

DROP TABLE IF EXISTS vet_clinic;

CREATE TABLE animals (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', 'Feb 3rd, 2020', '0' , TRUE, '10.23' );


