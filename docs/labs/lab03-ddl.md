---
title: "Lab 03 — Modélisation DDL : Concessionnaire automobile"
aside: false
---

# Lab 03 — Modélisation DDL : Concessionnaire automobile

## Objectif du laboratoire
Appliquer les notions de **DDL** vues dans le cours afin de :
- créer des tables relationnelles
- définir des **types de données appropriés**
- respecter un **schéma relationnel fourni**

<div class="bg-red-50 border border-red-300 text-red-900 rounded-lg p-4 mb-5">
<strong>Important — apprentissage</strong><br>
Les instructions SQL doivent être <strong>tapées manuellement</strong> (ne pas copier-coller).  
L’objectif est de maîtriser la syntaxe et d’être capable de la reproduire lors d’un examen.
</div>

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Consignes importantes</strong><br>
<ul class="list-disc pl-5">
  <li>Créez d'abord la base de données lab03_concessionnaire</li>
  <li>Ouvrez ensuite un nouveau script sur cette base de données</li>
  <li>Exécutez une étape à la fois</li>
</ul>
</div>

---

## Contexte

Un concessionnaire automobile souhaite gérer :
- ses **clients**
- ses **vendeurs**
- ses **voitures**
- les **achats** effectués

Un schéma relationnel est fourni (image).

<img src="../modules/01-introduction/images/mrd-concessionnaire.png" alt="Schéma du concessionnaire" class="img-bordered mb-5" />

---

## Travail à réaliser

À partir du schéma fourni, écrire les instructions SQL nécessaires pour :

1. Créer un **type ENUM PostgreSQL** représentant le **type de carburant** d’une voiture.
2. Créer les tables suivantes :
   - `client`
   - `vendeur`
   - `voiture`
   - `achat`

Le script doit pouvoir être exécuté **sur une base de données vide déjà créée**.

---

## Détails et contraintes à respecter

### 1) Type ENUM — carburant
- Le type ENUM doit contenir plusieurs valeurs possibles (ex. essence, diesel, electrique).
- Le type ENUM doit être créé **avant** la table `voiture`.

---

### 2) Table `client`
- Clé primaire auto-générée
- Colonnes :
  - nom (obligatoire)
  - prénom (obligatoire)
  - téléphone (obligatoire)

---

### 3) Table `vendeur`
- Clé primaire auto-générée
- Colonnes :
  - nom (obligatoire)
  - prénom (obligatoire)
- Relation récursive :
  - un vendeur peut avoir **0 ou 1 superviseur**
  - le superviseur est un autre vendeur

---

### 4) Table `voiture`
- Clé primaire auto-générée
- Colonnes obligatoires :
  - marque
  - modèle
  - année
  - prix affiché
  - type de carburant (ENUM)
- Le prix affiché doit être **strictement positif**
- Deux voitures identiques (même marque, modèle et année) ne doivent pas être dupliquées

---

### 5) Table `achat`
- Clé primaire auto-générée
- Colonnes obligatoires :
  - date d’achat
  - prix de vente
- Le prix de vente doit être **strictement positif**
- Un achat est associé :
  - à un client
  - à un vendeur
  - à une voiture
- Toutes ces relations doivent être représentées par des **clés étrangères**

---

## Vérification (dans DBeaver)

- Visualiser le schéma relationnel.
- Vérifier :
  - les clés primaires
  - les clés étrangères
  - les contraintes (NOT NULL, UNIQUE, CHECK)
  - la relation récursive du vendeur

---

## Questions (réflexion)

- Pourquoi le type ENUM doit-il être créé avant la table `voiture` ?
- Pourquoi la relation superviseur → vendeur est-elle optionnelle ?
- Pourquoi la table `achat` contient-elle plusieurs clés étrangères ?
- Quel problème est évité par la contrainte d’unicité sur la table `voiture` ?

<details class="mt-6">
<summary class="cursor-pointer font-semibold text-red-700">
⚠️ Corrigé — À consulter seulement après avoir fait l’exercice
</summary>

<div class="bg-red-50 border border-red-300 text-red-900 rounded-lg p-4 mt-4">
<strong>Important</strong><br>
Assurez-vous d’avoir <strong>complété l’exercice</strong> ou, au minimum, d’avoir
<strong>tenté sérieusement chacune des étapes</strong> avant de consulter le corrigé.<br><br>
Le but du laboratoire est de pratiquer l’écriture du SQL et la réflexion sur la structure,
pas de recopier une solution.
</div>

---

### Type ENUM — carburant

```sql
create type type_carburant as enum (
  'essence',
  'diesel',
  'electrique'
);
```

---

### Table `client`

```sql
create table client (
  id_client serial primary key,
  nom varchar(50) not null,
  prenom varchar(50) not null,
  telephone varchar(20) not null
);
```

---

### Table `vendeur`

```sql
create table vendeur (
  id_vendeur serial primary key,
  nom varchar(50) not null,
  prenom varchar(50) not null,
  id_superviseur integer,
  foreign key (id_superviseur) references vendeur(id_vendeur)
);
```

---

### Table `voiture`

```sql
create table voiture (
  id_voiture serial primary key,
  marque varchar(40) not null,
  modele varchar(40) not null,
  annee integer not null,
  prix_affiche numeric(10,2) not null check (prix_affiche > 0),
  carburant type_carburant not null,
  unique (marque, modele, annee)
);
```
---

### Table `achat`

```sql
create table achat (
  id_achat serial primary key,
  date_achat date not null,
  prix_vente numeric(10,2) not null check (prix_vente > 0),
  id_client integer not null,
  id_vendeur integer not null,
  id_voiture integer not null,
  foreign key (id_client) references client(id_client),
  foreign key (id_vendeur) references vendeur(id_vendeur),
  foreign key (id_voiture) references voiture(id_voiture)
);
```

---

### Ordre de création recommandé

1. type_carburant  
2. client  
3. vendeur  
4. voiture  
5. achat  

</details>

