create database btp_construction;

\c btp_construction;

-- create table users(
--     id serial primary key not null,
--     nom varchar(255) not null,
--     mail varchar(255) not null,
--     mdp varchar(255) not null,
--     corbeille int default 0,
--     createdAt TIMESTAMP DEFAULT NOW()
-- );

-- INSERT INTO users (nom, mail, mdp, corbeille, createdAt)
-- VALUES 
--     ('Admin', 'admin@gmail.com', 'admin', 0, NOW()),
--     ('Alice', 'alice@gmail.com', 'alice', 0, NOW()),
--     ('Bob', 'bob@gmail.com', 'bob', 0, NOW());

-- create table roles(
--     id serial primary key not null,
--     rolename varchar(255) not null,
--     corbeille int default 0,
--     createdAt TIMESTAMP DEFAULT NOW()
-- ) ;

-- INSERT INTO roles (rolename)
-- VALUES 
--     ('Admin'),
--     ('User') ;

-- create table userroles(
--     id serial primary key not null,
--     idUser INT REFERENCES users(id),
--     idRole INT REFERENCES roles(id),
--     createdAt TIMESTAMP DEFAULT NOW()
-- );

-- insert into userroles (idUser,idRole) VALUES
--     (1,1),
--     (2,2),
--     (3,2);


-- ------------------------------------------------------------------------------------------------------------------------------------------------------
create table users(
    id serial primary key not null,
    nom varchar(255),
    mail varchar(255),
    numero varchar(14),
    mdp varchar(255),
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);


-- ------------------------------------------------------------------------------------------------------------------------------------------------------

create table typeFinition(
    id serial primary key not null,
    typeFinition varchar(255) not null,
    pourcentage numeric(10,2) not null,
    createdAt TIMESTAMP DEFAULT NOW()
);

insert into typeFinition (typeFinition,pourcentage)values
('Standard',1),
('Premium',1.2),
('V.I.P',1.3),
('Gold',1.4);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------

create table typeMaison(
    id serial primary key not null,
    nom varchar(255),
    descriptions text not null default 'aucune',
    photos varchar(255) not null,
    nbJourConstruction numeric(3,2),
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);

-- Insert 1: Modern house
INSERT INTO typeMaison (nom, descriptions, photos, nbJourConstruction) VALUES 
    ('Maison Moderne', '2 chambres, 2 salles de bain, une terrasse spacieuse', 'class1.jpeg', 6.5),
    ('Loft Spacieux', 'Grand espace ouvert, 1 chambre en mezzanine, emplacement parking', 'class2.jpeg', 4.0),
    ('Villa de Luxe', 'Piscine privée, 3 chambres avec salle de bain attenante, jardin paysagé', 'class3.jpeg', 8.0),
    ('Bungalow Confortable', '1 chambre, 1 salle de bain, salon avec cheminée', 'class1.jpeg', 3.5),
    ('Studio Lumineux', 'Pièce principale avec cuisine intégrée, salle de bain moderne', 'class4.jpeg', 1.0);


-- ------------------------------------------------------------------------------------------------------------------------------------------------------

create table detailDevisMaison(
    id serial primary key not null,
    descriptions text not null default 'aucune',
    prixUnitaire numeric(9,2) not null,
    quantite numeric(9,2) not null,
    unite varchar(10),
    idTypeMaison int REFERENCES typeMaison(id) not null,
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);




INSERT INTO detailDevisMaison (descriptions, prixUnitaire, quantite, unite, idTypeMaison) 
VALUES 
('Porte en bois', 150.00, 5, 'pièces', 1),
('Fenêtre en aluminium', 200.00, 10, 'pièces', 2),
('Toit en tuiles', 300.00, 1, 'm²', 3);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------

create table Devis(
    id serial primary key not null,
    idUser int REFERENCES users (id) not null,
    descriptions text not null default 'aucune',
    idTypeFinition int REFERENCES typeFinition(id) not null,
    idTypeMaison int REFERENCES typeMaison(id) not null,
    dateDebut DATE DEFAULT NOW() not null,
    dateFin DATE,
    montant numeric(10,2),
    pourcentageFinition  numeric(10,2) not null, 
    etatDevis int default 0,
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);

insert into users (numero) values ('0345137423') returning *