/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, TRUE, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, TRUE, 11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, FALSE, -11);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, TRUE, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, FALSE, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, TRUE, -45);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, TRUE, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, TRUE, 17);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, TRUE, 22);


INSERT INTO owners (full_name, age) VALUES ('Sam Smith',34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell',19);
INSERT INTO owners (full_name, age) VALUES ('Bob',45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond',77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester',14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker',38);

INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

UPDATE animals SET species_id = (SELECT id FROM species WHERE name LIKE 'Digimon' ) WHERE name LIKE '%mon';
UPDATE animals SET species_id = (SELECT id FROM species WHERE name LIKE 'Pokemon' ) WHERE species_id IS NULL;

UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Sam Smith') WHERE name LIKE 'Agumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Jennifer Orwell') WHERE name LIKE 'Gabumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Jennifer Orwell') WHERE name LIKE 'Pikachu';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Bob') WHERE name LIKE 'Devimon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Bob') WHERE name LIKE 'Plantmon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Melody Pond') WHERE name LIKE 'Charmander';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Melody Pond') WHERE name LIKE 'Squirtle';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Melody Pond') WHERE name LIKE 'Blossom';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Dean Winchester') WHERE name LIKE 'Angemon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name LIKE 'Dean Winchester') WHERE name LIKE 'Boarmon';