-- Active: 1733610144749@@127.0.0.1@3306@salle_de_sport

-- Création de la base de données
CREATE DATABASE IF NOT EXISTS salle_de_sport CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Utilisation de la base de données
USE salle_de_sport;

-- Suppression des tables si elles existent (dans l'ordre inverse des dépendances)
DROP TABLE IF EXISTS Annulation;
DROP TABLE IF EXISTS Reservation;
DROP TABLE IF EXISTS Activite;
DROP TABLE IF EXISTS Membre;


-- Table des membres
CREATE TABLE Membre (
    id_membre INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telephone VARCHAR(15) NOT NULL,
    date_naissance DATE NOT NULL,
    date_inscription DATE NOT NULL DEFAULT CURRENT_DATE,
    statut ENUM('Actif', 'Inactif', 'Suspendu') NOT NULL DEFAULT 'Actif',
    CONSTRAINT check_email CHECK (email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    CONSTRAINT check_age CHECK (DATEDIFF(CURRENT_DATE, date_naissance) >= 6210) -- 17 ans minimum (la valeur en jours)
);

-- Table des activités
CREATE TABLE Activite (
    id_activite INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    description TEXT,
    date_debut DATETIME NOT NULL,
    date_fin DATETIME NOT NULL,
    capacite INT NOT NULL,
    statut ENUM('En cours', 'Terminé', 'Annulé') NOT NULL DEFAULT 'En cours',
    CONSTRAINT check_dates CHECK (date_debut < date_fin),
    CONSTRAINT check_capacite CHECK (capacite > 0)
);

-- Table des réservations
CREATE TABLE Reservation (
    id_reservation INT AUTO_INCREMENT PRIMARY KEY,
    date_reservation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    statut ENUM('Confirmé', 'Annulé', 'En attente') NOT NULL DEFAULT 'En attente',
    id_activite INT NOT NULL,
    id_membre INT NOT NULL,
    FOREIGN KEY (id_activite) REFERENCES Activite(id_activite) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_membre) REFERENCES Membre(id_membre) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Table des annulations
CREATE TABLE Annulation (
    id_annulation INT AUTO_INCREMENT PRIMARY KEY,
    date_annulation DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    motif TEXT,
    id_reservation INT NOT NULL,
    FOREIGN KEY (id_reservation) REFERENCES Reservation(id_reservation) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Ajouter de colonnes aprés la créations
ALTER Table Activity ADD COLUMN Statu ENUM('En Cours', 'Terminer');

-- ========== CRUD POUR LA TABLE MEMBRE ==========
-- CREATE (Créer)
INSERT INTO Membre (nom, prenom, email, telephone, date_naissance) VALUES 
('Dubois', 'Marie', 'marie.dubois@email.com', '0612345678', '1992-05-15');

-- READ (Lire)
-- Lire tous les membres
SELECT * FROM Membre;
-- Lire un membre spécifique
SELECT * FROM Membre WHERE id_membre = 1;
-- Lire avec condition
SELECT * FROM Membre WHERE statut = 'Actif';

-- UPDATE (Mettre à jour)
UPDATE Membre 
SET telephone = '0687654321',email = 'nouvelle.email@email.com' 
WHERE id_membre = 1;

-- DELETE (Supprimer)
DELETE FROM Membre WHERE id_membre = 1;
-- ===============================================

-- Lire les réservations avec détails
SELECT r.*, m.nom, m.prenom, a.nom as activite_nom
FROM Reservation r
JOIN Membre m ON r.id_membre = m.id_membre
JOIN Activite a ON r.id_activite = a.id_activite;