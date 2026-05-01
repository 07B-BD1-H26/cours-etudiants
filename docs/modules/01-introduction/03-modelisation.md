---
title: "Lire un MRD (Modèle relationnel de données)"
aside: false
---

# Modèle relationnel de données (MRD)

Un **MRD** décrit visuellement la **structure** d’une base de données relationnelle :
tables, clés et relations.

L’objectif est de **savoir les lire et les interpréter**, pas de les concevoir à partir de zéro.

---

## Objectif du module

Être capable de :
- repérer les **tables**, **PK** et **FK**
- déduire les **relations** (1–N, N–N)
- comprendre **où sont stockées les informations**

---

## Rappels essentiels

---

### Clés (à repérer en premier)

- **PK** : identifie une ligne de façon unique  
- **FK** : relie une table à une autre

---

### Lire les relations

- FK vers une autre table → **relation 1–N**
- Table avec **au moins deux FK** → **relation N–N** (table associative)

---

## Exemple — MRD Concessionnaire

![MRD Concessionnaire](./images/mrd-concessionnaire.png)

---

## Exercices de lecture (en classe)

1. Identifie les **PK** et les **FK**.
2. Indique les **relations** et leur cardinalité.
3. Quelle table représente une **action / événement** ?
4. Où sont stockés :
   - le prix de vente
   - le vendeur
   - la voiture vendue
5. Qu'y a-t-il de spécial sur la table vendeur?

> Remarquer également les conventions de nomenclature :
> - Les **tables** sont nommées au **singulier** (`client`, `vendeur`, `voiture`, `achat`).
> - Les **clés primaires** portent le nom `id`.
> - Les **clés étrangères** contiennent le nom de la table qu’elles référencent 
>   (ex. : `achat.id_client` → `client.id_client`).
> - Les noms sont en **minuscules**, sans accents ni espaces.
> - Les mots sont séparés par un **underscore** (`snake_case`).
> - Les noms décrivent clairement le **rôle** de la colonne.

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
  <strong class="block">ℹ️ À faire maintenant</strong>
  <p class="m-0">
    Pour mettre ces notions en pratique, passez au
    <a href="./../../labs/lab02-modelisation" class="font-semibold underline hover:text-blue-700">
      Laboratoire 2 — Modélisation
    </a>.
  </p>
</div>