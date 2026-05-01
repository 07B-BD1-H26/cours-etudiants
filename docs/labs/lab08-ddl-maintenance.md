---
title: "Lab 08 — DDL de maintenance"
aside: true
---

# Lab 08 — DDL de maintenance

## Objectif du laboratoire
Mettre en pratique les opérations de maintenance de schéma sur des tables déjà existantes de **Chinook** à l'aide de `alter table`.

<div class="bg-red-50 border border-red-300 text-red-900 rounded-lg p-4 mb-5">
<strong>Important</strong><br>
Conservez une copie de toutes vos instructions.  
Au besoin, supprimez et restaurez la base de données car ce laboratoire modifie directement les vraies tables de Chinook.
</div>

---

## Mise en place

Dans ce laboratoire, vous travaillez directement sur les tables existantes :
- `employe`
- `piste`
- `client`
- `facture`
- `ligne_facture`

### Ordre de travail recommandé

Pour chaque modification :

1. observez d'abord la structure actuelle
2. appliquez une seule modification à la fois
3. vérifiez le résultat dans DBeaver
4. testez lorsque c'est pertinent

---

## Alter table

### 1. Ajouter une colonne `date_fin_emploi`

Ajoutez à la table `employe` :
- `date_fin_emploi` de type `date`

Vérifiez ensuite que :
- la colonne existe
- les lignes actuelles contiennent `null`

### 2. Ajouter une colonne `actif` avec valeur par défaut

Ajoutez à la table `employe` :
- `actif`
- type `boolean`
- `not null`
- valeur par défaut `true`

Vérifiez que les lignes déjà présentes reçoivent bien une valeur.

### 3. Ajouter une contrainte `unique` sur `courriel`

Ajoutez sur la table `employe` une contrainte `unique` sur :
- `courriel`

Avant d'ajouter la contrainte, vérifiez d'abord si des doublons existent déjà à l'aide d'une requête `select`.

### 4. Renommer `telephone`

Renommez dans la table `employe` :
- `telephone` en `telephone_principal`

Vérifiez que :
- la colonne a bien changé de nom
- les données ont été conservées

### 5. Supprimer la colonne `fax`

Supprimez dans la table `employe` :
- `fax`

Rappel :
- ce type de suppression est moins fréquent
- avant de supprimer en contexte réel, il faut vérifier si d'autres systèmes utilisent déjà cette donnée

### 6. Rendre `album_id` et `genre_id` obligatoires dans `piste`

Modifiez la table `piste` pour rendre `not null` :
- `album_id`
- `genre_id`

Avant d'appliquer ce changement, vérifiez s'il existe déjà des lignes où :
- `album_id is null`
- `genre_id is null`

Si c'est le cas, il faut corriger ces données avant d'ajouter `not null`.

---

## Cascade

### 7. Remplacer la contrainte entre `client` et `facture`

Repérez d'abord la contrainte existante entre :
- `facture(client_id)`
- `client(client_id)`

Ensuite, avec `alter table` :

1. supprimez la contrainte actuelle
2. recréez-la avec `on delete cascade`

But :
- pratiquer le fait qu'on ne modifie pas simplement une cascade sur une FK existante
- observer qu'on remplace la contrainte par une nouvelle version

### 8. Remplacer la contrainte entre `facture` et `ligne_facture`

Repérez ensuite la contrainte existante entre :
- `ligne_facture(facture_id)`
- `facture(facture_id)`

Puis :

1. supprimez la contrainte actuelle
2. recréez-la avec `on delete cascade`

Question :
- pourquoi cette relation est-elle une meilleure candidate à `on delete cascade` ?

---

## Index

### 9. Ajouter des index simples

Ajoutez les index suivants :
- un index sur `employe(ville)`
- un index sur `piste(nom)`

Vérifiez ensuite dans DBeaver que ces index existent.

Question :
- pourquoi un index sur `ville` ou `nom` peut-il aider certaines recherches ?
- pourquoi ne pas avoir ajouté un index sur le courriel de l'employé ?

### 10. Supprimer un index

Supprimez ensuite l'index sur `ville`.