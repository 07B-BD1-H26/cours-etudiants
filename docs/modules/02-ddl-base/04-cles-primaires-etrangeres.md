---
title: "04 — Clés primaires et clés étrangères"
aside: false
---

# 04 — Clés primaires et clés étrangères

## Objectif
Appliquer des **clés primaires** et des **clés étrangères** afin de :
- identifier de façon unique chaque ligne d’une table
- représenter des **relations entre les tables**
- assurer l’**intégrité référentielle** de la base de données

---

## Qu’est-ce qu’une clé primaire (rappel)?

Une **clé primaire (PRIMARY KEY)** est une colonne qui :
- identifie **de manière unique** chaque ligne d’une table
- ne peut pas contenir de valeur NULL
- ne peut pas contenir de doublons
- est utilisée en tant que clé étrangère par d'autres tables pour établir les relations

---

## Définir une clé primaire

- utiliser un identifiant **numérique** et **générée automatiquement** (SERIAL dans PostgreSQL)
- sans signification métier directe

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Conseil</strong><br>
Ne jamais d’utiliser comme clé primaire : un nom, un courriel, ou un numéro qui peut changer.
</div>

---

## Définir une clé primaire

### Exemple simple

```sql
create table evenement (
    id serial primary key,
    nom varchar(100) not null,
    date_evenement date not null
);
```

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Note</strong><br>
<code>SERIAL</code> génère automatiquement un identifiant unique (auto-incrémenté).
</div>

### Exemple d’enregistrements

| id | nom              | date_evenement |
|----|------------------|----------------|
| <span class="bg-yellow-200 px-1 rounded">1</span> | Conférence SQL   | 2025-03-10 |
| <span class="bg-yellow-200 px-1 rounded">2</span> | Atelier PostgreSQL | 2025-04-02 |
| <span class="bg-yellow-200 px-1 rounded">3</span> | Journée techno   | 2025-05-18 |

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4 mt-4">
<strong>À observer</strong><br>
Les valeurs de la colonne <code>id</code> sont générées automatiquement par PostgreSQL grâce au type <code>SERIAL</code>.  
Elles ne sont pas fournies manuellement lors de l’insertion (l'insertion de données sera vue plus tard).
</div>

---

## Qu’est-ce qu’une clé étrangère (rappel)?

Une **clé étrangère (FOREIGN KEY)** est une colonne qui :
- fait référence à la clé primaire d’une autre table
- permet de créer une **relation entre deux tables**

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>À retenir</strong><br>
Une clé étrangère assure l’<strong>intégrité référentielle</strong> : on ne peut pas référencer une ligne qui n’existe pas.
</div>

---

## Relation entre deux tables (1–N)

Exemple :

- une salle peut avoir plusieurs sièges
- un siège appartient à une seule salle

---

### Définir une clé étrangère

#### Exemple

On crée d'abord la table qui ne contient pas de clée étrangère (la table `parent`).

```sql
create table salle (
    id serial primary key,
    porte varchar(15),
    nom integer null,
);
```
On crée ensuite la table `enfant` en s'assurant de référencer la clée primaire de la table `parent`

```sql
create table siege (
    id serial primary key,
    rangee varchar(2),
    salle_id integer,
    foreign key (salle_id) references salle(id)
);
```

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Note</strong><br>

- La valeur de <code>salle_id</code> doit obligatoirement exister dans la table <code>salle</code>.
- La valeur de <code>salle_id</code> est de type <code>INTEGER</code> et non <code>SERIAL</code>.

</div>

---

## Ordre de création des tables

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Règle importante</strong><br>
La table référencée (clé primaire) doit être créée <strong>avant</strong> la table qui contient la clé étrangère.
</div>

Exemple d’ordre correct :
1. salle  
2. siege  

---

## Comportement par défaut des clés étrangères

Par défaut, PostgreSQL :
- empêche la suppression d’une ligne référencée
- empêche la modification d’une clé primaire utilisée ailleurs

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Note</strong><br>
Il existe des options (ex. suppression en cascade), mais elles sont hors-scope pour ce cours.
</div>

---

## Clés primaires composées (c'est possible mais plus rare)

Une clé primaire peut être composée de plusieurs colonnes (ex.: deux clées étrangères peuvent être sélectionnées comme clée primaire composée).

<div class="bg-yellow-50 border border-yellow-200 text-yellow-900 rounded-lg p-4">
<strong>Dans ce cours</strong><br>
On privilégie les <strong>clés primaires simples</strong>. Les clés composées sont mentionnées à titre informatif.
</div>

---

## Erreurs à éviter

- Oublier de définir une clé primaire (faites le toujours en premier)
- Utiliser une colonne métier comme clé primaire
- Créer une clé étrangère vers une table inexistante
- Inverser l’ordre de création des tables (toujours créer les tables sans clées étrangères en premier)