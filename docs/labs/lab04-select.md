---
title: "Lab 03 — Requêtes de sélection avec filtres"
aside: false
---

# 🧪 Laboratoire 04 — Requêtes de sélection avec filtres

## Travail à réaliser

### Base de données de test à importer (si ce n'est pas déjà fait)

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Attention</strong><br>

Pour réaliser ce labo, vous devez importer une <strong>base de données de test</strong>.<br>
[La même que le module précédent](../modules/03-sql-base/02-select-where#base-de-donnees-de-test-a-importer)

</div>

### Écrire des requêtes `select`

Créez un nouveau script SQL dans DBeaver (portée : base de données `module_03_evenement_data`).

Écrivez et exécutez les requêtes suivantes, une par une (chaque puce représente une requête `select`) :

#### a) Sélection simple
- Lister tous les événements (toutes colonnes)
- Lister seulement le nom et la date des événements

#### b) Filtrage de base
- Événements à Paris
- Événements avec capacité > 100
- Événements actifs (actif = true)

#### c) Conditions combinées
- Événements à Paris OU Toulouse
- Événements avec capacité entre 50 et 200
- Événements actifs ET à Paris

#### d) Ordonnancement
- Événements triés par date croissante
- Événements triés par capacité décroissante
- Événements à Paris, triés par nom

## Vérifications

Après chaque requête, vérifiez :
- Le nombre de lignes retournées
- Les valeurs dans les colonnes
- L'ordre des résultats (si applicable)

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

### Requêtes exemples

#### a) Sélection simple
```sql
select * from evenement;

select nom, date_evenement from evenement;
```

#### b) Filtrage de base
```sql
select * from evenement where lieu = 'Paris';

select * from evenement where capacite > 100;

select * from evenement where actif = true;
```

#### c) Conditions combinées
```sql
select * from evenement where lieu = 'Paris' or lieu = 'Toulouse';

select * from evenement where capacite >= 50 and capacite <= 200;

select * from evenement where actif = true and lieu = 'Paris';
```

#### d) Ordonnancement
```sql
select * from evenement order by date_evenement;

select * from evenement order by capacite desc;

select * from evenement where lieu = 'Paris' order by nom;
```

</details>