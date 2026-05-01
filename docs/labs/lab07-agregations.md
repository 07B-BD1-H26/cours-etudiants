---
title: "Lab 07 — Agrégations"
aside: false
---

# 🧪 Laboratoire 07 — Agrégations

## Travail à réaliser

### Base de données à utiliser (Chinook)

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Attention</strong><br>
Ce laboratoire utilise la base de données <strong>Chinook</strong>.<br>
Si vous ne l'avez pas encore importée, référez-vous aux instructions du module :
<a href="../modules/04-jointures-agregations/02-jointures#base-de-donnees-de-test-a-importer-chinook">Importer Chinook</a>
</div>

Créez un nouveau script SQL dans DBeaver (portée : base de données `chinook`).

---

<a id="partie-1"></a>

## Partie 1 — Agrégations, `group by` et `having`

## 1 — Fonctions d'agrégation

Écrivez les requêtes suivantes à l'aide des fonctions `count`, `sum`, `avg`, `min` et `max`.

1. Afficher le **prix unitaire moyen** de toutes les pistes.
2. Afficher la **durée maximale** et la **durée minimale** des pistes.
3. Afficher le **nombre total de factures**.
4. Pour chaque ligne de `ligne_facture`, calculez d'abord son montant avec `quantite * prix_unitaire`, puis affichez le **montant total** obtenu en additionnant toutes ces lignes.

---

## 2 — `Group by`

### a) Regroupements simples

1. Afficher le **nombre de clients par ville**. Trier par nombre décroissant, puis par ville.
2. Afficher le **nombre de pistes par type de média** (`media_type_id`).
3. Afficher le **prix unitaire moyen des pistes par album** (`album_id`).

### b) `Group by` avec jointures

1. Afficher, pour chaque **type de média**, son **nom** et le **nombre de pistes** associées.
2. Afficher, pour chaque **album**, son **titre** et le **nombre de pistes** qu'il contient.
3. Afficher, pour chaque **client**, son **prénom**, son **nom de famille** et le **nombre de factures** associées.
4. Afficher, pour chaque **genre**, son **nom** et la **durée moyenne des pistes** de ce genre.

### c) Bien choisir les colonnes du `group by`

Pour chacune des requêtes suivantes, écrivez une requête correcte en choisissant les bonnes colonnes à placer dans le `group by`.

1. Afficher le **nom de l'artiste** et le **nombre d'albums** qu'il possède.
2. Afficher le **pays de facturation** et le **montant total facturé** pour ce pays.
3. Afficher le **nom du client** et la **somme de ses factures**.

---

## 3 — `Having`

Dans cette section, mettez l'accent sur la différence entre `where` et `having`.

### a) Filtrer des groupes

1. Afficher les **villes** qui contiennent **au moins 2 clients**.
2. Afficher les **albums** qui contiennent **au moins 15 pistes**.
3. Afficher les **types de média** qui ont **au moins 20 pistes**.
4. Afficher les **clients** dont le **nombre de factures** est d'au moins 5.

### b) Bien placer `where` et `having`

Pour chacune des requêtes suivantes :
- écrivez la requête complète
- déterminez quelle condition doit aller dans `where`
- déterminez quelle condition doit aller dans `having`

1. Afficher les **pays de facturation** dont le **montant total facturé en 2009** dépasse 100.
2. Afficher les **genres** dont la **durée moyenne des pistes** dépasse 300000 millisecondes, en ne considérant que les pistes dont le prix unitaire est supérieur ou égal à 0.99.
3. Afficher les **albums** qui contiennent au moins 5 pistes dont la durée dépasse 240000 millisecondes.
4. Afficher les clients du **Canada** dont le total des achats dépasse 20.
5. Afficher les albums qui contiennent au moins 8 pistes vendues à 0.99 ou plus.

---

<a id="partie-2"></a>

## Partie 2 — Sous-requêtes corrélées et synthèse

## 4 — Sous-requêtes corrélées

### a) Avec `exists` et `not exists`

Écrivez deux sous-requêtes corrélées en utilisant explicitement `exists` et `not exists`.

1. Afficher les **artistes** qui ont **au moins un album**.
2. Afficher les **employés** qui ne représentent **aucun client**.

### b) Deux autres sous-requêtes corrélées

Écrivez les requêtes suivantes avec des sous-requêtes corrélées.

1. Afficher les **pistes** dont le **prix unitaire** est supérieur au **prix moyen des pistes du même type de média**.
2. Afficher les **factures** dont le **total** est supérieur au **montant moyen des factures du même pays de facturation**.

## 5 — Exercices supplémentaires

### a) Synthèse — `group by` et `having`

Afficher les **albums** dont la **durée totale** dépasse 3 000 000 millisecondes, avec le titre de l'album et la durée totale.

### b) Synthèse — Sous-requête corrélée

Afficher les **pistes** dont la **durée** est supérieure à la **durée moyenne des pistes de leur album**.

---

## Défi optionnel — Réécriture avec jointure et `group by`

> Ce défi va au-delà des attentes du cours. Il n'est pas obligatoire.

Réécrivez les deux requêtes de la section **4 b)** sans sous-requête corrélée.

Contraintes :
- utilisez une jointure avec une requête agrégée
- la requête agrégée doit contenir un `group by`
- donnez un alias clair au résultat agrégé

### Conseils de construction

1. Écrivez d'abord la requête qui calcule la valeur agrégée par groupe.
2. Vérifiez que cette requête retourne une ligne par groupe.
3. Joignez ensuite ce résultat à la table principale.
4. Terminez avec le filtre final dans le `where`.

---
