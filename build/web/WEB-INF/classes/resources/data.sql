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
    nom varchar(255) not null,
    mail varchar(255) not null,
    numero varchar(14) not null,
    mdp varchar(255) not null,
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);


-- ------------------------------------------------------------------------------------------------------------------------------------------------------

create table typeFinition(
    id serial primary key not null,
    typeFinition varchar(255) not null,
    niveua numeric(10,2) not null,
    createdAt TIMESTAMP DEFAULT NOW()
);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------

create table typeMaison(
    id serial primary key not null,
    descriptions text not null default "aucune",
    photos varchar(255) not null,
    nbJourConstruction numeric(3,2),
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);



-- ------------------------------------------------------------------------------------------------------------------------------------------------------

create table detailDevisMaison(
    id serial primary key not null,
    descriptions text not null default "aucune",
    prixUnitaire numeric(9,2) not null,
    quantite numeric(9,2) not null,
    unite varchar(10),
    idTypeMaison int REFERENCES typeMaison(id) not null,
    corbeille int default 0,
    createdAt TIMESTAMP DEFAULT NOW()
);