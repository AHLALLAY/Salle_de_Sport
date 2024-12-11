-- Active: 1733610144749@@127.0.0.1@3306@salle_de_sport

--Creation une base de donner
CREATE DATABASE salle_de_sport;

--Afficher tous les bases de donnes
SHOW DATABASES;


--Selectionner une base de donner
USE salle_de_sport;

--Creation des tables
CREATE TABLE Membre (
    ID_M INT AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Date_naissance DATE,
    Date_inscription DATE,
    Statu ENUM('Actif', 'Inactif', 'Suspendu')
);

CREATE TABLE Activity (
    ID_A INT AUTO_INCREMENT PRIMARY KEY,
    Nom VARCHAR(50),
    Description VARCHAR(255),
    Date_debut DATE,
    Date_fin DATE,
    Capacity INT,
    Statu ENUM('En cours', 'Terminer')
);

CREATE TABLE Reservations (
    ID_R INT AUTO_INCREMENT PRIMARY KEY,
    Date_reservation DATE,
    Statu ENUM('Confirmer', 'Annuler', 'En Attend'),
    ID_A INT,
    ID_M INT,
    Foreign Key (ID_A) REFERENCES Activity(ID_A) ON DELETE CASCADE,
    Foreign Key (ID_M) REFERENCES Membre(ID_M) ON DELETE CASCADE
);

CREATE TABLE Annulation (
    ID_AN INT AUTO_INCREMENT PRIMARY KEY,
    Date_annulation DATE,
    ID_R INT,
    Foreign Key (ID_R) REFERENCES Reservations(ID_R) ON DELETE CASCADE
);

--Ajouter de colonnes
ALTER Table Activity ADD COLUMN Statu ENUM('En Cours', 'Terminer');


--Inserer les donner
INSERT INTO Activity(Nom, Description, Date_debut, Date_fin, Capacity)
            VALUES('youga', 'sport pour la discipline spirituelle','2024-12-11', '2024-12-18', 20);

--Update
UPDATE Activity SET `Date_fin`='2024-12-30' WHERE `Date_fin`='2024-12-18';
UPDATE activity set `Date_debut`='2024-12-20';


--Afficher les donner de tableau
SELECT*FROM Activity;
SELECT * FROM Membre;

--Supprimer des table
DROP TABLE IF EXISTS Membre;
DROP TABLE IF EXISTS Activity;
DROP TABLE IF EXISTS Reservations;
DROP TABLE IF EXISTS Annulation;