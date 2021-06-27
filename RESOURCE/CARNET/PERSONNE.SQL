CREATE TABLE Personne (
   NoPersonne    SMALLINT NOT NULL,
   Entete        CHAR(3),
   Prenom        CHAR(30) PRIMARY KEY,
   Nom           CHAR(30) PRIMARY KEY,
   Fonction      CHAR(20),
   Societe       CHAR(30),
   Adresse       CHAR(40),
   Ville         CHAR(20),
   Province      CHAR(10),
   Pays          CHAR(20),
   CodePostal    CHAR(6),
   Courriel      CHAR(50),
   IconeAssociee CHAR(255)
);