/* Database schema to keep the structure of entire database. */

CREATE TABLE ANIMALS(
   ID                      SERIAL PRIMARY KEY,
   NAME                    VARCHAR(100) NOT NULL,
   DATE_OF_BIRTH           DATE     NOT NULL,
   ESCAPE_ATTEMPTS         INT      NOT NULL,
   NEUTERED                BOOLEAN  NOT NULL,
   WEIGHT_KG               DECIMAL  NOT NULL
);

ALTER TABLE ANIMALS ADD SPECIES VARCHAR(100);

CREATE TABLE owners(
   ID                      SERIAL PRIMARY KEY,
   FULL_NAME               VARCHAR(100) NOT NULL,
   AGE                     INT     NOT NULL
);

CREATE TABLE species(
   ID                      SERIAL PRIMARY KEY,
   NAME                    VARCHAR(100) NOT NULL
);

ALTER TABLE ANIMALS DROP SPECIES;

ALTER TABLE ANIMALS
   ADD owner_id INT,
    ADD CONSTRAINT owners_constraint 
      FOREIGN KEY (owner_id) 
         REFERENCES owners (id);

ALTER TABLE ANIMALS
   ADD species_id INT,
    ADD CONSTRAINT species_constraint 
      FOREIGN KEY (species_id) 
         REFERENCES species (id);

CREATE TABLE vets(
   ID                      SERIAL PRIMARY KEY,
   NAME                    VARCHAR(100) NOT NULL,
   AGE                     INT NOT NULL,
   DATE_OF_GRADUATION      DATE NOT NULL
);

CREATE TABLE specializations(
   species_id INT NOT NULL,
   vets_id INT NOT NULL,
   CONSTRAINT specializations_species_constraint
      FOREIGN KEY (species_id)
         REFERENCES species (id),
   CONSTRAINT specializations_vets_constraint
      FOREIGN KEY (vets_id)
         REFERENCES vets (id)
);

CREATE TABLE visits(
   animal_id                      INT NOT NULL,
   vets_id                        INT NOT NULL,
   date_of_visit                  DATE NOT NULL,
   CONSTRAINT visits_animals_constraint
      FOREIGN KEY (animal_id)
         REFERENCES animals (id),
   CONSTRAINT visits_vets_constraint
      FOREIGN KEY (vets_id)
         REFERENCES vets (id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);