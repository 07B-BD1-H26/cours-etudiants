---
title: "01 — Créer une base de données"
aside: false
---

# 01 — Créer une base de données

## Objectif
Comprendre qu’une **base de données PostgreSQL** est un **contenant logique de haut niveau**, utilisé pour regrouper les tables d’un même travail ou projet, avant même de contenir des données.

---

## DDL — Data Definition Language

Le **DDL** est la partie du langage SQL qui permet de **définir et modifier la structure d’une base de données** (BDs, tables, colonnes, contraintes).

---

## Organisation logique dans PostgreSQL

Dans PostgreSQL, les éléments sont organisés de la façon suivante :
- Serveur PostgreSQL
    - Base de données
        - Schémas
            - Tables

> Une table appartient à un **schéma**,  
> et un schéma appartient à une **base de données**.

---

## Rôle d’une base de données

Une base de données permet de :

- isoler complètement les données d’un travail ou d’un projet
- regrouper toutes les tables liées à un même contexte dans des schémas
- appliquer des paramètres globaux (droits, encodage)

---

## Le concept de schéma dans PostgreSQL

Un **schéma** est un regroupement logique de tables à l’intérieur d’une base de données.

- À la création d'une base de données, PostgreSQL crée automatiquement le schéma `public`
- Toutes les tables sont créées dans ce schéma par défaut
- Aucun schéma supplémentaire ne sera créé dans ce cours

>Toutes les tables seront créées dans le schéma par défaut `public`

---

## Encodage de la base de données

Lors de la création d’une base de données, PostgreSQL lui associe un **encodage de caractères**.

- L’encodage détermine comment les caractères sont stockés
- Il influence la gestion des accents et caractères spéciaux
- L’encodage **UTF-8** est recommandé et utilisé par défaut dans la majorité des installations

**Dans ce cours**  
> Nous utilisons l’encodage par défaut (UTF-8).  
> Aucune configuration particulière n’est requise de votre part.


## Convention de nommage

### Bases de données
- minuscules
- mots séparés par des underscores (`_`)
- pas d’espaces ni d’accents
- nom représentatif du travail

**Exemples**
- `tp_evenements`
- `tp_gestion_clients`
- `tp_suivi_projets`

---

## Créer une base de données

### Instruction `CREATE DATABASE`

#### Syntaxe
```sql
create database nom_base;

create database tp_evenements;
```

#### Option GUI

<img src="./images/creation-bd-gui.png" alt="Création BD GUI" class="img-bordered w-s" />

## Se connecter à une base de données

La base de données est sélectionnée :
- au moment de la connexion
- ou en ouvrant une nouvelle connexion dans l’outil de gestion (clic droit + nouveau script)

Toutes les instructions SQL s’exécutent toujours dans **une seule base de données à la fois**.

>Contrairement à d'autres SGBD, PostgreSQL n'utilise pas l'instruction USE

#### Option GUI

<img src="./images/connexion-gui.png" alt="Connexion BD GUI" class="img-bordered w-s" />

>Vous pouvez aussi définir la base de données dans laquelle vous travaillez comme `objet par défaut`

---

## Vérifier l’existence des bases de données

### Lister les bases disponibles
```sql
select datname
from pg_database;
```

Vous pouvez également faire clic-droit et rafraîchir (F5)

<img src="./images/regenerer.png" alt="Regénérer BD" class="img-bordered w-s" />