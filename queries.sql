/*Queries that provide answers to the questions FROM all projects.*/

/*Find all animals whose name ends in "mon"*/
SELECT 
  * 
FROM 
  animals 
WHERE name LIKE '%mon';

/*List the name of all animals born between 2016 and 2019*/
SELECT 
  name
FROM 
  animals 
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;

/*List the name of all animals that are neutered and have less than 3 escape attempts*/
SELECT 
  name 
FROM 
  animals 
WHERE neutered = true AND escape_attempts < 3;

/*List date of birth of all animals named either "Agumon" or "Pikachu"*/
SELECT 
  date_of_birth 
FROM 
  animals 
WHERE name IN ('Agumon','Pikachu');

/*List name and escape attempts of animals that weigh more than 10.5kg*/
SELECT 
  name, 
  escape_attempts 
FROM 
  animals 
WHERE weight_kg > 10.5;

/*Find all animals that are neutered*/
SELECT 
  * 
FROM 
  animals 
WHERE neutered = true;

/*Find all animals not named Gabumon*/
SELECT 
  * 
FROM 
  animals 
WHERE NOT name LIKE 'Gabumon';

/*Find all animals with a weigh between 10.4kg and 17.3kg 
(including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
SELECT 
  * 
FROM 
  animals 
WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*Inside a transaction UPDATE the animals table by SETting the species column to unspecified. Verify that change was made. 
Then roll back the change and verify that species columns went back to the state before transaction.*/
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*Inside a transaction:
Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
Commit the transaction.
Verify that change was made and persists after commit.*/
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

/*Now, take a deep breath and... Inside a transaction DELETE all records in the animals table, then roll back the transaction.
After the roll back verify if all records in the animals table still exist. After that you can start breath as usual ;)*/
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*Inside a transaction:
Delete all animals born after Jan 1st, 2022.
Create a savepoint for the transaction.
Update all animals' weight to be their weight multiplied by -1.
Rollback to the savepoint
Update all animals' weights that are negative to be their weight multiplied by -1.
Commit transaction*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT savepoint_1;
UPDATE animals SET weight_kg=weight_kg*-1;
ROLLBACK TO savepoint_1;
UPDATE animals SET weight_kg=weight_kg*-1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

/*How many animals are there?*/
SELECT 
  count(*) 
FROM animals;

/*How many animals have never tried to escape?*/
SELECT 
  count(*) 
FROM 
  animals 
WHERE escape_attempts = 0;

/*What is the average weight of animals?*/
SELECT 
  avg(weight_kg) 
FROM 
  animals;

/*Who escapes the most, neutered or not neutered animals?*/
SELECT 
  neutered, 
  MAX(escape_attempts)
FROM 
  animals 
GROUP BY neutered;

/*What is the minimum and maximum weight of each type of animal?*/
SELECT 
  max(weight_kg), 
  min(weight_kg) 
FROM 
  animals;

/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/
SELECT 
  species, 
  avg(escape_attempts) 
FROM 
  animals 
WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 1990 AND 2000 GROUP BY species;

/*What animals belong to Melody Pond?*/
SELECT
    name AS animal_name,
    full_name AS owner_name
FROM
    animals
INNER JOIN owners
    ON owner_id = owners.id AND full_name = 'Melody Pond';

/*List of all animals that are pokemon (their type is Pokemon).*/
SELECT
    animals.name AS animal_name
FROM
  animals
INNER JOIN species
    on species.id = species_id AND species.name = 'Pokemon';

/*List all owners and their animals, remember to include those that don't own any animal.*/
SELECT 
  full_name as owner_name,
  name as animal_name
FROM
  owners
LEFT JOIN animals
  ON owner_id = owners.id;

/*How many animals are there per species?*/
SELECT
  species.name as species,
  count(species_id) as number_of_animals
FROM
  animals
INNER JOIN species
  ON species.id = species_id
GROUP BY species.name;

/*List all Digimon owned by Jennifer Orwell*/
SELECT
    full_name as owner_name,
    animals.name as animal_name
FROM
    animals
INNER JOIN owners
    ON owner_id = owners.id AND full_name = 'Jennifer Orwell'
INNER JOIN species
    on species.id = species_id AND species.name = 'Digimon';

/*List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT
    full_name as owner_name,
    animals.name as animal_name
FROM
    animals
INNER JOIN owners
    ON owner_id = owners.id AND full_name = 'Dean Winchester'
WHERE escape_attempts = 0;

/*Who owns the most animals?*/
SELECT number.full_name AS owner_with_most_animals 
FROM
  (SELECT 
    owners.full_name, 
    COUNT(animals.name) 
  FROM owners 
  JOIN animals 
    ON owners.id = animals.owner_id 
  GROUP BY owners.full_name 
  ORDER BY COUNT(animals.name) DESC LIMIT 1) number ;

select * from visits where vets_id=1 order by date_of_visit desc limit 1;

/*Who was the last animal seen by William Tatcher?*/
SELECT
  animals.name,
  date_of_visit
FROM
  animals
INNER JOIN visits
  ON animals.id = animal_id
WHERE
  vets_id = (SELECT id FROM vets WHERE name LIKE 'William Tatcher')
ORDER BY date_of_visit DESC LIMIT 1;

/*How many different animals did Stephanie Mendez see?*/
SELECT
  count(animal_id) as number_of_animals
FROM
  visits
WHERE
  vets_id = (SELECT id FROM vets WHERE name LIKE 'Stephanie Mendez');

-- List all vets and their specialties, including vets with no specialties.
SELECT
  vets.name as vet_name,
  species.name as specilization
FROM
  vets
LEFT JOIN specializations
  ON vets.id = vets_id
LEFT JOIN species
  ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT
  animals.name as animal_name,
  date_of_visit
FROM
  visits
JOIN animals
  ON animal_id = animals.id
WHERE 
  (date_of_visit BETWEEN '2020-04-01' AND '2020-08-30') AND
  visits.vets_id = (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez')
ORDER BY date_of_visit ASC;

-- What animal has the most visits to vets?
SELECT
  animals.name as animal_name,
  COUNT(animal_id) as number_of_visits
FROM
  animals
INNER JOIN visits
  ON animal_id = animals.id
JOIN vets
  ON vets.id = visits.vets_id
GROUP BY animals.name
ORDER BY number_of_visits DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT
  animals.name as animal_name
FROM
  visits
JOIN animals
  ON animal_id = animals.id
WHERE vets_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY date_of_visit LIMIT 1;


-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT
  animals.name as animal_name,
  animals.date_of_birth,
  animals.escape_attempts,
  animals.neutered as is_neutered,
  animals.weight_kg,
  species.name as species,
  owners.full_name as owner_full_name,
  vets.name as vet_name,
  vets.age as vet_age,
  vets.date_of_graduation as vet_date_of_graduation,
  date_of_visit
FROM
  animals
JOIN visits
  ON animals.id = visits.animal_id
JOIN vets
  ON vets.id = visits.vets_id
JOIN species
  ON species.id = animals.species_id
JOIN owners
  ON owners.id = animals.owner_id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT
  vets.name as vet_name,
  count(*) as number_of_visits
FROM
  visits
INNER JOIN vets
  ON visits.vets_id = vets.id
WHERE visits.vets_id NOT IN (SELECT vets_id FROM specializations)
GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT
  species.name as proposed_specialty,
  count(*) as number_of_visits
FROM
  visits
JOIN vets
  ON vets.id = vets_id
JOIN animals
  ON visits.animal_id = animals.id
JOIN species
  ON species.id = animals.species_id
WHERE visits.vets_id = (
     SELECT id FROM vets WHERE name = 'Maisy Smith'
)
GROUP BY species.name
LIMIT 1;

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';

CREATE INDEX animal_ids ON visits(animal_id ASC);
CREATE INDEX vet_ids ON visits(vets_id ASC);
CREATE INDEX owners_emails ON owners(email ASC);
