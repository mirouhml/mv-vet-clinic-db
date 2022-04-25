/* Database schema to keep the structure of entire database. */

CREATE TABLE ANIMALS(
   ID                      SERIAL PRIMARY KEY,
   NAME                    VARCHAR(100) NOT NULL,
   DATE_OF_BIRTH           DATE     NOT NULL,
   ESCAPE_ATTEMPTS         INT      NOT NULL,
   NEUTERED                BOOLEAN  NOT NULL,
   WEIGHT_KG               DECIMAL  NOT NULL
);
