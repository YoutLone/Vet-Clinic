/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name like '%mon';

SElECT * from animals WHERE date_of_birth between '2016-01-01' and '2019-12-31';

SELECT * FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Pikachu', 'Agumon');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.50;

SELECT * FROM animals WHERE neutered = TRUE;

SELECT * FROM animals WHERE name NOT IN ('Gabumon');

SELECT * FROM animals WHERE weight_kg BETWEEN 10.40 and 17.30;

-- Transaction 1:
BEGIN;
UPDATE animals 
SET species = 'unspecified';
SELECT * FROM animals; 
ROLLBACK;
SELECT * FROM animals; 

-- Transaction 2: Set species column to digimon for animals with name ending in mon
BEGIN;
UPDATE animals 
SET species = 'digimon' WHERE name LIKE '%mon';
SELECT * FROM animals;

-- Set species column to pokemon for animals without a species set
UPDATE animals 
SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;

COMMIT;
SELECT * FROM animals;

-- Transaction 3: Delete all records in the animals table
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK; 
SELECT * FROM animals;

-- Transaction 4: Delete animals born after Jan 1st, 2022
BEGIN;
DELETE FROM animals 
WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete_all_animals;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals 
SET weight_kg = weight_kg * -1;
ROLLBACK TO delete_all_animals;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals 
SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT * FROM animals; -- Verify changes after commit


SELECT count(*) FROM animals;

SELECT count(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, MAX(escape_attempts) as max_escape_attempts
FROM animals
GROUP BY neutered
ORDER BY max_escape_attempts DESC
LIMIT 1;

SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) as avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
GROUP BY species;