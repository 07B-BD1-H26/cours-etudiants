---
title: "05 — Sous-requêtes non corrélées"
aside: false
---

# 05 — Sous-requêtes non corrélées

## Objectif
- Comprendre le concept de sous-requête non corrélée
- Utiliser `in`, `any`, `all` avec des sous-requêtes
- Écrire des requêtes avec des sous-requêtes dans `where`
- Différencier des sous-requêtes corrélées

## Sous-requêtes

Une sous-requête est une requête SQL **imbriquée** dans une autre requête.

- **Non corrélée** : la sous-requête s'exécute **une seule fois**, indépendamment de la requête principale
- **Corrélée** : la sous-requête dépend de la requête principale (sera vue plus tard)

## Sous-requête non corrélée — Principe

La sous-requête s'exécute **en premier**, et son résultat est utilisé par la requête principale.

### Exemple — Événements avec inscriptions récentes

```sql
select nom, date_evenement
from evenement
where id in (
  select evenement_id
  from inscription
  where date_inscription > '2026-01-01'
);
```

Ce que ça fait : Retourne les événements qui ont des inscriptions après le 1er janvier 2026.

::: tip Important
Avec `in`, la sous-requête doit retourner **une seule colonne** (généralement la clé étrangère). Ici, `select evenement_id` retourne uniquement les IDs des événements.
:::

Quand l'utiliser : Quand le résultat de la sous-requête est fixe et peut être calculé une fois.

## Exemple guidé — Étape par étape

Prenons un problème concret : **"Trouver les noms des participants qui se sont inscrits à au moins un événement gratuit"**

### Méthodologie pour construire des sous-requêtes

Pour résoudre ce problème, il faut **partir de la fin** et **décortiquer la requête** en petites parties :

1. **Comprendre le résultat final souhaité** : noms des participants
2. **Identifier les relations** : participants → inscriptions → événements
3. **Construire les sous-requêtes en partant de la table la plus loin et en remontant vers la table qu'on veut afficher**

Voici la requête complète :

```sql
select nom
from participant
where id in (
  select participant_id
  from inscription
  where evenement_id in (
    select id
    from evenement
    where prix = 0
  )
);
```

Maintenant, décortiquons-la en petites requêtes pour comprendre chaque niveau :

### Étape 1 : Identifier les événements gratuits

La sous-requête la plus interne trouve les événements gratuits :

```sql
select id
from evenement
where prix = 0;
```

### Étape 2 : Identifier les inscriptions à ces événements

Utilisons le résultat de l'étape 1 pour trouver les inscriptions :

```sql
select participant_id
from inscription
where evenement_id in (
  select id
  from evenement
  where prix = 0
);
```

### Étape 3 : Obtenir les noms des participants

Enfin, utilisons le résultat de l'étape 2 pour obtenir les noms :

```sql
select nom, courriel
from participant
where id in (
  select participant_id
  from inscription
  where evenement_id in (
    select id
    from evenement
    where prix = 0
  )
);
```

### Analyse de la requête finale

- **Sous-requête la plus interne** : `select id from evenement where prix = 0`
  - S'exécute en premier
  - Retourne : liste des IDs d'événements gratuits

- **Sous-requête intermédiaire** : `select participant_id from inscription where evenement_id in (...)`
  - Utilise le résultat de la sous-requête interne
  - Retourne : liste des IDs de participants inscrits à des événements gratuits

- **Requête principale** : `select nom, courriel from participant where id in (...)`
  - Utilise le résultat de la sous-requête intermédiaire
  - Retourne : noms et courriels des participants

::: tip À noter
Cette requête utilise **deux niveaux de sous-requêtes non corrélées**. Chaque niveau s'exécute indépendamment des autres.
:::

## IN — Appartenance à un ensemble

`in` teste si une valeur appartient au résultat de la sous-requête.

### Exemple — Participants inscrits à des événements à Paris

```sql
select nom, courriel
from participant
where id in (
  select participant_id
  from inscription
  where evenement_id in (
    select id
    from evenement
    where lieu = 'Paris'
  )
);
```

## ANY — Comparaison avec au moins un élément

`any` compare avec **au moins un** élément du résultat.

### Exemple — Événements plus chers que certains autres

```sql
select nom, prix
from evenement
where prix > any (
  select prix
  from evenement
  where lieu = 'Paris'
);
```

Ce que ça fait : Événements dont le prix est supérieur à au moins un événement à Paris.
>Un des événements à Paris est à zéro dollars, mais pas tous.

## ALL — Comparaison avec tous les éléments

`all` compare avec **tous** les éléments du résultat.

### Exemple — Événements plus chers que tous les autres

```sql
select nom, prix
from evenement
where prix > all (
  select prix
  from evenement
  where lieu = 'Lyon'
);
```

Ce que ça fait : Événements dont le prix est supérieur à tous les événements à Lyon.
>Tous les événements à Lyon sont à zéro dollars.


## Pièges fréquents

- Sous-requête qui retourne plusieurs colonnes alors que `in` attend une seule
- Oublier que la sous-requête s'exécute en premier
- Performances : sous-requêtes non corrélées peuvent être lentes avec de gros volumes

## À retenir

- Sous-requête non corrélée : s'exécute indépendamment
- `in` : appartenance à un ensemble
- `any` / `all` : comparaisons avec sous-ensembles
- Utiliser des alias pour clarifier
- Préférer les jointures si possible pour les performances