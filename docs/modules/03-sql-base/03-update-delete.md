---
title: "03 — Update, delete"
aside: false
---

# 03 — Modification et suppression de données

## Objectif
- Comprendre **pourquoi** on modifie ou supprime des données (contexte applicatif)
- Modifier des données avec `update ... set ... where`
- Supprimer des données avec `delete ... where`
- Comprendre les **risques** liés aux opérations destructives
>Utiliser la même base de données qui a été importée précédemment.

---

## Pourquoi modifier et supprimer ?

Dans une application réelle, on **modifie** des données pour :
- corriger une erreur (ex. : une ville mal saisie)
- mettre à jour un état (ex. : actif / inactif)
- ajuster une règle d’affaires (ex. : capacité d’un événement)

On **supprime** des données pour :
- retirer une donnée créée par erreur
- nettoyer des données de test
- respecter une loi (loi 25)

>En pratique, on supprime rarement.  
>On privilégie souvent un champ `actif` (suppression logique).

---

## update — Modifier des données

### Syntaxe générale

```sql
update table  
set colonne = valeur  
where condition;
```

> ⚠️ Sans `where`, **toutes les lignes** seront modifiées.

---

### Exemple 1 — Corriger une erreur de lieu

Contexte :  
Le lieu de l’événement avec l’id 4 est incorrect.

```sql
update evenement  
set lieu = 'Montréal'  
where id = 4;
```

---

### Exemple 2 — Augmenter la capacité d’un événement populaire

Contexte :  
Le Salon Open Source (id 16) attire plus de participants que prévu.

```sql
update evenement  
set capacite = capacite + 100  
where id = 16;
```

---

### Exemple 3 — Désactiver un participant (soft delete)

Contexte :  
Un participant ne souhaite plus utiliser la plateforme.

```sql
update participant  
set actif = false  
where courriel = 'julie.petit2@example.com';
```

---

### Exemple 4 — Modifier plusieurs colonnes à la fois

Contexte :  
On met à jour le nom et la capacité d’un événement.

```sql
update evenement  
set nom = 'Conférence Tech 2026 (édition spéciale)',  
    capacite = 350  
where id = 1;
```

---

### Exemple 5 — Mise à jour conditionnelle (plusieurs lignes)

Contexte :  
Les événements ayant une capacité trop faible sont annulés.

```sql
update evenement  
set actif = false  
where capacite < 50;
```

---

## update avec sous-requête (à titre d'exemple, cela sera vu bientôt)

### Exemple 6 — Désactiver les inscriptions des participants inactifs

Contexte :  
Lorsqu’un participant devient inactif, ses inscriptions doivent aussi être désactivées.

```sql
update inscription  
set actif = false  
where participant_id in (  
  select id  
  from participant  
  where actif = false  
);
```

---

## delete — Supprimer des données

### Syntaxe générale

```sql
delete from table  
where condition;
```

> ⚠️ Sans `where`, **toutes les lignes** seront supprimées.

---

### Exemple 7 — Supprimer une inscription créée par erreur

Contexte :  
Une inscription incorrecte doit être retirée.

```sql
delete from inscription  
where id = 21;
```

---

### Exemple 8 — Supprimer les inscriptions d’un événement annulé

Contexte :  
Un événement a été annulé et toutes ses inscriptions doivent être supprimées.

```sql
delete from inscription  
where evenement_id = 5;
```

---

## ⚠️ Mise en garde importante

Avant d’exécuter un `update` ou un `delete` :

1. Tester la condition avec un `select`
2. Vérifier le nombre de lignes affectées
3. S’assurer que la condition est précise

Exemple de bonne pratique :

```sql
select *  
from evenement  
where capacite < 50;
```

➡️ Si le résultat est conforme, **alors seulement** appliquer le `update` ou le `delete`.

---

## À retenir

- `update` modifie des données existantes
- `delete` supprime définitivement des lignes
- `where` est **essentiel**
- En contexte applicatif, on préfère souvent la **suppression logique** (`actif = false`)
