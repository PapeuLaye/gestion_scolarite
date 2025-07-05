CREATE DATABASE gestion_scolarite;

USE gestion_scolarite;

CREATE TABLE etudiants (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           nom VARCHAR(100),
                           prenom VARCHAR(100),
                           email VARCHAR(100),
                           matricule VARCHAR(50) UNIQUE,
                           date_naissance DATE
);

CREATE TABLE enseignants (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             nom VARCHAR(100),
                             prenom VARCHAR(100),
                             email VARCHAR(100)
);

CREATE TABLE matieres (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          nom VARCHAR(100),
                          code VARCHAR(20) UNIQUE,
                          coefficient INT
);

CREATE TABLE cours (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       matiere_id INT,
                       enseignant_id INT,
                       FOREIGN KEY (matiere_id) REFERENCES matieres(id),
                       FOREIGN KEY (enseignant_id) REFERENCES enseignants(id)
);

CREATE TABLE notes (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       etudiant_id INT,
                       matiere_id INT,
                       note DECIMAL(5,2),
                       FOREIGN KEY (etudiant_id) REFERENCES etudiants(id),
                       FOREIGN KEY (matiere_id) REFERENCES matieres(id)
);

CREATE TABLE absences (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          etudiant_id INT,
                          matiere_id INT,
                          date DATE,
                          FOREIGN KEY (etudiant_id) REFERENCES etudiants(id),
                          FOREIGN KEY (matiere_id) REFERENCES matieres(id)
);

CREATE TABLE utilisateurs (
                              id INT AUTO_INCREMENT PRIMARY KEY,
                              email VARCHAR(100) UNIQUE,
                              mot_de_passe VARCHAR(100),
                              role ENUM('etudiant', 'enseignant', 'administrateur')
);
