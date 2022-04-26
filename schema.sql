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
ALTER TABLE ANIMALS ADD SPECIES VARCHAR(100);
ALTER TABLE ANIMALS ADD SPECIES VARCHAR(100);
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