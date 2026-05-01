---
title: "03 — Structure relationnelle"
---

# 03 — Structure relationnelle

## Objectifs
- Décrire la structure d’une base relationnelle.
- Expliquer tables, champs, enregistrements, clés, index, relations.

## Base de données relationnelle : composants

Nous allons modéliser une base de données qui contient plusieurs entités, reliées entre elles par des relations.

### Table (entités)
Les tables servent à représenter les différentes entités (étudiant, cours, inscription) d'un modèle de données.
>Devant un cas réel, on doit se poser la question: *Quelles sont les choses distinctes du monde réel que je dois représenter et stocker séparément ?*

#### Champs / Colonnes

Les **champs** (ou **colonnes**) décrivent les **propriétés** d’une entité.  
Chaque champ représente **une information précise** que l’on souhaite conserver pour chaque entité.

Pour identifier les champs d’une table, on peut se poser la question :

> **Quelles informations dois-je mémoriser pour chaque entité ?**

##### Types principaux (aperçu)
À ce stade du cours, il suffit de connaître quelques grandes catégories de types :
- **Texte** (nom, courriel, description)
- **Nombre** (âge, quantité, prix)
- **Date / heure** (date d’inscription, date de commande)
- **Booléen** (oui/non, actif/inactif)

> Les types exacts dépendront du SGBD et seront vus plus tard.

##### Exemple de colonnes (sans données)

**Étudiant**
| Champ | Description |
|---|---|
| id | Identifiant unique |
| nom | Nom de l’étudiant |
| programme | Programme d’études |
| courriel | Adresse courriel |
| date_inscription | Date d’inscription |

---

#### Enregistrements / Lignes

Un **enregistrement** (ou **ligne**) correspond à **une instance concrète** d’une entité.  
Chaque ligne contient les valeurs des champs pour **un seul élément**.

Autrement dit :
- la table décrit la **structure**
- les lignes contiennent les **données**

##### Exemple avec données

**Étudiant**
| id | nom | programme | courriel | date_inscription |
|---|---|---|---|---|
| 1 | Alex Martin | Informatique | alex.martin@example.com | 2024-01-14 |
| 2 | Sophie Tremblay | Sciences | sophie.t@example.com | 2024-01-15 |

> Chaque ligne représente un étudiant distinct, mais tous partagent la **même structure de champs**.

## Clés et index

### Clé primaire (PK)

La **clé primaire** (*Primary Key – PK*) est un champ (ou un ensemble de champs) qui permet
d’**identifier de façon unique** chaque enregistrement d’une table.

Dans une table :
- chaque enregistrement doit avoir une **clé primaire**
- la valeur de la clé primaire est **unique**
- la clé primaire **ne change pas**
- la clé primaire permet de **retrouver rapidement** un enregistrement

##### Exemple (à partir de la table Étudiant)

**Étudiant**
| id | nom | programme | courriel | date_inscription |
|---|---|---|---|---|
| 1 | Alex Martin | Informatique | alex.martin@example.com | 2024-01-14 |
| 2 | Sophie Tremblay | Sciences | sophie.t@example.com | 2024-01-15 |

Ici :
- le champ `id` est la **clé primaire**
- même si deux étudiants ont le même nom, leur `id` reste distinct

> La clé primaire sert de **référence stable** pour relier cette table à d’autres tables.

---

### Index

Un **index** est une structure qui permet d’**accélérer la recherche** de données dans une table.

Sans index, le système doit parcourir toutes les lignes pour trouver une information.
Avec un index, la recherche est **beaucoup plus rapide**.

##### Exemple

Dans la table **Étudiant**, on pourrait créer un index sur :
- `courriel` (rechercher rapidement un étudiant par courriel)
- `programme` (lister les étudiants d’un programme)

> Les index sont particulièrement utiles lorsque la table contient **beaucoup d’enregistrements**.

## Relations entre tables

Les **relations** permettent de lier des tables entre elles afin de représenter
les liens qui existent entre les entités du monde réel.

Une relation est généralement réalisée à l’aide d’une **clé étrangère (FK)**,
qui fait référence à la clé primaire d’une autre table.

---

### Relation 1–N (un à plusieurs)

Une relation **1–N** signifie qu’un enregistrement d’une table peut être lié
à **plusieurs enregistrements** d’une autre table.

#### Exemple (relation 1–N : Cours → Groupes)

- Un **cours** peut avoir **plusieurs groupes**
- Un **groupe** est associé à **un seul cours**

**Cours**
| id | code | titre |
|---:|:---|:---|
| 10 | BD1 | Bases de données 1 |
| 11 | PR1 | Programmation 1 |

**Groupe**
| id | <span class="inline-block px-1 rounded bg-yellow-100 text-yellow-900 font-semibold">id_cours (FK)</span> | numero_groupe | session |
|---:|---:|:---|:---|
| 100 | <span class="inline-block px-1 rounded bg-yellow-100 text-yellow-900 font-semibold">10</span> | 01 | Hiver 2025 |
| 101 | <span class="inline-block px-1 rounded bg-yellow-100 text-yellow-900 font-semibold">10</span> | 02 | Hiver 2025 |
| 102 | <span class="inline-block px-1 rounded bg-yellow-100 text-yellow-900 font-semibold">11</span> | 01 | Hiver 2025 |

> Ici, `id_cours` est une **clé étrangère (FK)** qui référence `Cours.id`.  
> Cette clé permet de relier chaque groupe à **un seul cours**,  
> tout en permettant à un cours d’avoir **plusieurs groupes**.

---

### Relation N–N (plusieurs à plusieurs)

Une relation **N–N** signifie que plusieurs enregistrements d’une table
peuvent être liés à plusieurs enregistrements d’une autre table.

En base relationnelle, une relation N–N est toujours représentée
par une **table associative**.

#### Exemple (relation N–N : Étudiant → Inscription ← Cours)

- Un **étudiant** peut suivre **plusieurs cours**
- Un **cours** peut être suivi par **plusieurs étudiants**

**Étudiant**
| id | nom |
|---:|:---|
| 1 | Alex |
| 2 | Sophie |

**Cours**
| id | titre |
|---:|:---|
| 1 | BD1 |
| 2 | Math |

**Inscription** *(table associative)*
| id | <span class="inline-block px-1 rounded bg-yellow-100 text-yellow-900 font-semibold">id_etudiant (FK)</span> | <span class="inline-block px-1 rounded bg-yellow-100 text-yellow-900 font-semibold">id_cours (FK)</span> |
|---:|---:|---:|
| 1 | <span class="inline-block px-1 rounded bg-yellow-100 text-yellow-900 font-semibold">1</span> | <span class="inline-block px-1 rounded bg-yellow-100 text-yellow-900 font-semibold">1</span> |
| 2 | <span class="inline-block px-1 rounded bg-yellow-100 text-yellow-900 font-semibold">1</span> | <span class="inline-block px-1 rounded bg-yellow-100 text-yellow-900 font-semibold">2</span> |
| 3 | <span class="inline-block px-1 rounded bg-yellow-100 text-yellow-900 font-semibold">2</span> | <span class="inline-block px-1 rounded bg-yellow-100 text-yellow-900 font-semibold">1</span> |

> La table associative **Inscription** contient :
> - une **clé étrangère** `id_etudiant` qui référence `Étudiant.id`
> - une **clé étrangère** `id_cours` qui référence `Cours.id`

---

### Relation 1–1 (un à un)

Une relation **1–1** signifie qu’un enregistrement d’une table est lié
à **un seul enregistrement** d’une autre table, et inversement.

#### Pourquoi c’est plus rare

Souvent, une relation 1–1 pourrait être :
- fusionnée dans une seule table
- inutilement complexe

#### Quand l’utiliser

Une relation 1–1 est pertinente lorsque :
- les données sont **optionnelles**
- les données sont **sensibles**
- les données ne sont **pas toujours utilisées**

#### Exemple

**Étudiant**
| id | nom |
|---|---|
| 1 | Alex |

**DossierMedical**
| id | etudiant_id | allergies |
|---|---|---|
| 1 | 1 | Arachides |

>Tous les étudiants n’ont pas nécessairement un dossier médical,
ce qui justifie une table séparée.

---

### Relations auto-référencées (réflexive)

Une **auto-référencée** relie une table à **elle-même**.

Ce type de relation est plus avancé, mais permet de modéliser
des liens hiérarchiques ou de mentorat.

#### Exemple : mentorat entre étudiants

- Un étudiant peut **mentorer un autre étudiant**
- Un étudiant peut avoir **un mentor**

**Étudiant**
| id | nom | mentor_id |
|---|---|---|
| 1 | Alex | NULL |
| 2 | Sophie | 1 |

>Le champ `mentor_id` est une clé étrangère qui référence
la clé primaire **de la même table**.

---

### À retenir

- Les relations permettent de lier des tables
- Les relations **1–N** sont les plus fréquentes
- Les relations **N–N** nécessitent une table associative
- Les relations **1–1** sont rares mais utiles dans certains cas
- Les relations réflexives existent, mais sont également plus rare


