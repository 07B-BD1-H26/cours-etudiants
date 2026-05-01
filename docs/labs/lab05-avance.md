---
title: "Lab 05 — Modification, opérateurs et sous-requêtes"
aside: false
---

# 🧪 Laboratoire 05 — Modification, opérateurs et sous-requêtes

## Travail à réaliser

### Vidéo explicative
>Dans cette vidéo, je démontre quelques requêtes plus complexes du laboratoire.
<iframe width="560" height="315" src="https://www.youtube.com/embed/bOvQIp7RQ1U?si=n-1-1yRi9kGwewE2" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

### 1. Base de données de test à importer (c'est la même qu'au labo précédent)

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Attention</strong><br>

Pour réaliser ce labo, vous devez importer une <strong>base de données de test</strong>.<br>
[BD de test](../modules/03-sql-base/02-select-where#base-de-donnees-de-test-a-importer)

</div>

### 2. Exercices de modification de données

#### a) Corrections simples
- Corrigez le lieu de l'événement "Sommet Cybersécurité" pour qu'il soit à "Montréal" au lieu de "Paris"
- Augmentez la capacité de l'événement "Meetup Python" de 50 places

#### b) Désactivation logique
- Désactivez le participant dont le courriel est "bruno.lefevre@example.com"
- Désactivez toutes les inscriptions des participants inactifs (sous-requête)

#### c) Suppression de données
- Supprimez l'inscription créée par erreur (participant_id = 1, evenement_id = 1)
- Supprimez toutes les inscriptions d'un événement annulé (choisissez un événement inactif)

::: warning ⚠️ Attention
Avant chaque `update` ou `delete`, testez d'abord avec un `select` pour vérifier quelles lignes seront affectées !
:::

### 3. Exercices avec les opérateurs

#### a) Combinaisons AND/OR/NOT
- Événements à Paris OU Lyon, mais seulement ceux actifs
- Participants dont le nom commence par "A" ET qui sont actifs
- Événements qui ne sont PAS à Paris

#### b) Recherche textuelle LIKE
- Événements dont le nom contient "Tech"
- Participants dont le courriel se termine par "@gmail.com"
- Événements dont le nom commence par "Conférence"

#### c) Intervals BETWEEN et listes IN
- Événements prévus entre aujourd'hui et le 1er août 2026
- Participants dans les villes "Paris", "Lyon", "Marseille"
- Événements avec capacité entre 100 et 500

#### d) Élimination des doublons DISTINCT
- Liste des villes distinctes où ont lieu des événements

### 4. Exercices avec les sous-requêtes non corrélées

#### a) Sous-requêtes avec IN
- Participants inscrits à des événements gratuits (prix = 0)
- Événements qui ont des inscriptions récentes (après le 1er janvier 2026)
- Participants inscrits à des événements à Paris

#### b) Sous-requêtes avec ANY/ALL
- Événements plus chers que TOUS les événements à Lyon
- Événements moins chers qu'AU MOINS UN événement à Paris

#### c) Requêtes complexes multi-niveaux
- Participants inscrits à des événements gratuits ET actifs
- Participants **actifs** qui se sont inscrits à **au moins un événement payant** (prix > 0) **à Paris** ou **Lyon**, et dont **le nom contient "Tech"**