---
title: "Lab 09 — Sécurité, comptes et privilèges"
aside: true
---

# Lab 09 — Sécurité, comptes et privilèges

## Objectif du laboratoire
Mettre en pratique la création de comptes, de rôles et l'attribution de privilèges directement sur la base de données **Chinook**.

## Mise en situation

Réalisez la mise en place de la gestion des utilisateurs, des rôles et des privilèges du la base de données `Chinook` à l'aide des commandes vues dans le module précédent.

## Travail à réaliser

### 1. Créer les comptes et les rôles

Créez :

- les utilisateurs `alice_admin`, `bob_dev`, `joe_analyste` et `app_web`
- les rôles `admin`, `developpeur`, `lecture_seule`

Puis associez :

- `alice_admin` au rôle `admin`
- `bob_dev` au rôle `developpeur`
- `joe_analyste` au rôle `lecture_seule`
- `app_web` au rôle `developpeur`

### 2. Donner les droits de base sur Chinook

Accordez selon le cas :

- `connect` sur la base de données `chinook`
- `usage` sur le schéma `public`

### 3. Donner des droits à l'administrateur

Le rôle `admin` doit pouvoir :

- se connecter à la base de données
- accéder au schéma `public`
- créer des objets dans la base de données de travail
- gérer largement les objets du schéma `public`

Pour garder le laboratoire simple, donnez-lui des droits étendus sur les tables et séquences du schéma `public`.

Rappel :
- `admin` n'est pas automatiquement un superutilisateur PostgreSQL

### 4. Donner des droits réalistes au développeur

Le rôle `developpeur` doit pouvoir :

- lire les données de Chinook
- insérer, modifier et supprimer des données dans Chinook

Pour garder le laboratoire simple, donnez ces droits globalement sur toutes les tables du schéma `public`.

Si vous donnez des droits d'insertion sur des tables utilisant des séquences, pensez aussi aux séquences nécessaires.

### 5. Donner des droits réalistes à joe_analyste

Le rôle `lecture_seule` doit pouvoir :

- consulter les données
- sans pouvoir les modifier

Donnez-lui donc un accès en lecture seule sur toutes les tables du schéma `public`.

### 6. Vérifier le cas du compte applicatif

Le compte `app_web` hérite ici du rôle `developpeur`.

Vérifiez donc qu'il peut :

- lire les données de Chinook
- insérer, modifier et supprimer des données selon les droits accordés au rôle `developpeur`

Mais il ne doit toujours pas pouvoir :

- modifier la structure
- agir comme administrateur (ex.: créer des tables)

### 7. Révoquer un droit

Retirez ensuite un privilège déjà accordé.

Exemple concret :

- retirer `delete` au rôle `developpeur` sur `facture`

Question :
- pourquoi retirer `delete` peut-il être une bonne idée sur certaines tables ?

### 8. Valider le tout dans PostgreSQL

Vérifiez votre configuration :

- voir les rôles existants
- voir qui est connecté
- voir les privilèges sur les tables
- tester ce qu'un rôle peut faire avec `set role`

Tests suggérés :

- avec `admin`, essayer un `create table test_admin (...)`
- avec `lecture_seule`, faire un `select` sur `client`
- avec `lecture_seule`, essayer un `update` sur `client`
- avec `developpeur`, faire un `select` sur `piste`
- avec `developpeur`, essayer un `delete` sur `facture`

## Quelques questions de réflexion

- Pourquoi est-il préférable de donner les droits au rôle `developpeur` ou `lecture_seule` plutôt qu'aux comptes directement ?
- Pourquoi un rôle `admin` avec beaucoup de `grant` n'est-il pas équivalent à un superutilisateur PostgreSQL ?
- Pourquoi un compte applicatif ne devrait-il pas recevoir `all privileges` sur Chinook ?
- Pourquoi `connect` sur la base de données ne suffit-il pas, à lui seul, pour lire ou modifier les tables ?

---
