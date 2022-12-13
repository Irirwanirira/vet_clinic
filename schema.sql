/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT,
    names VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL,

);
ALTER TABLE animals ADD species TEXT;