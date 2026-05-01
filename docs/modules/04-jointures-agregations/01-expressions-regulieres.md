---
title: "01 — Expressions régulières"
---

# 01 — Expressions régulières
> Adapté des notes de Gilles Duquerroy et Nouha Bouteldja

Les expressions régulières (regex) sont des **motifs décrivant la forme d’une chaîne de caractères**.

Elles servent surtout à :
- **valider des données** (ex. formulaires web, contraintes en base de données) ;
- **rechercher / filtrer** du texte (logs, contenu d’une BD, fichiers texte) ;
- **extraire ou transformer** certaines parties d’une chaîne de caractères.

Les **métacaractères** sont les symboles qui permettent de décrire ces motifs.

Le langage des expressions régulières est **largement similaire d’un langage à un autre** (avec quelques variations selon les outils ou SGBD).

## Ressource complémentaire utile

:::tip RegexLearn
Pour pratiquer avec un parcours interactif :  
https://regexlearn.com/fr/learn/regex101

À faire sur votre téléphone mobile dans l'autobus.
:::

## Outil indispensable pour construire et tester une expression régulière

:::tip Regexr
Vous pouvez construire et tester vos expressions régulières ici :  
https://regexr.com/
:::

## Métacaractères de base

| Métacaractère | Signification | Exemples |
|---------------|--------------|----------|
| `[]` | Classe de caractères | `[abc]` : la chaîne contient **a**, **b** ou **c** |
| `[A-Z]`<br>`[0-9]` | Intervalle de caractères | `[A-Z]` : lettres majuscules<br>`[0-9]` : chiffres |
| `{n}`<br>`{n,m}` | Nombre d’occurrences de l’élément précédent | `a{3}` : **a** apparaît 3 fois<br>`a{2,3}` : **a** apparaît 2 ou 3 fois |
| `*` | 0, 1 ou plusieurs occurrences | `a*` : **a** apparaît 0, 1 ou plusieurs fois |
| `+` | 1 ou plusieurs occurrences | `a+` : **a** apparaît au moins une fois |
| `?` | 0 ou 1 occurrence | `a?` : **a** apparaît ou non |
| `.` | N’importe quel caractère (selon le moteur, inclut ou non le saut de ligne) | `.{2,3}` : deux à trois caractères |
| `^` | Début de chaîne | `^b` : commence par **b** |
| `$` | Fin de chaîne | `b$` : finit par **b** |

### Autres métacaractères utiles

| Métacaractère | Signification | Exemples |
|---------------|--------------|----------|
| `[^...]` | Négation de classe (tout sauf…) | `[^abc]` : la chaîne ne contient ni **a**, ni **b**, ni **c** |
| `()` | Groupe de caractères | `(ab)+` : **ab** apparaît une ou plusieurs fois |
| `\d` / `\D` | Chiffre (`0` à `9`) / tout sauf un chiffre | `^\d{3}$` : exactement 3 chiffres |
| `\w` / `\W` | Caractère alphanumérique ou `_` / tout sauf ces caractères | `^a\w*$` : variable qui commence par **a** |
| `\s` / `\S` | Caractère d'espacement (espace, tabulation, retour de ligne) / tout sauf un caractère d'espacement | `\s+` : une ou plusieurs occurrences d'un espace ou autre blanc |

## Exemples simples de motifs

### Texte à coller dans Regexr pour tester

chat chien Chat alpha beta gamma abc abbc ac aabc abbbc 123 4567 A1B2 Z99 hello world hello_world nom-variable nom variable test@test.com alice@example.com bob@domain.org invalid-email @example.com alice@ alice@example ABC12 SQL20 XYZ00 AB12 ABCD12 abc12 A1B23 12345 2025-03-07 1999-12-31 2005-01-01 25-03-07 2025/03/07 (418) 456-7890 418-123-4567 418 999 0000 4187771234 G1K8P4 G1K 8P4 #tag #urgent #client_important fin.

| Étape | Expression | Concept | Explication |
|------|------------|--------|-------------|
| 1 | `chat` | Texte littéral | Cherche exactement le mot |
| 2 | `[abc]` | Classe de caractères | Correspond à **un caractère parmi a,b,c** |
| 3 | `[a-z]` | Intervalle | Toute lettre minuscule |
| 4 | `[A-Z]` | Intervalle | Toute lettre majuscule |
| 5 | `[0-9]` | Intervalle | Tout chiffre |
| 6 | `[0-9]{4}` | Quantificateur | Exactement **4 chiffres** |
| 7 | `[0-9]{2,4}` | Quantificateur | Entre **2 et 4 chiffres** |
| 8 | `ab*c` | `*` | 0 ou plusieurs occurrences |
| 9 | `ab+c` | `+` | 1 ou plusieurs occurrences |
| 10 | `ab?c` | `?` | 0 ou 1 occurrence |
| 11 | `a.c` | `.` | N’importe quel caractère |
| 12 | `[^0-9]` | Négation | Tout sauf un chiffre |
| 13 | `\d` | Classe spéciale | Un chiffre |
| 14 | `\d{3}` | Quantificateur | Trois chiffres consécutifs |
| 15 | `\w+` | Mot | Suite de caractères alphanumériques ou `_` |
| 16 | `\s` | Espace | Un caractère d’espacement |
| 17 | `\s+` | Quantificateur | Un ou plusieurs espaces |
| 18 | `\S+` | Non espace | Suite de caractères sans espace |
| 19 | `\.` | Échappement | Point littéral |

:::warning Important
`^` et `$` servent à **ancrer la regex** au début et à la fin de la chaîne.
Sans eux, le motif peut correspondre à **une sous-partie du texte seulement** (par ex. `123` dans `abc123xyz`).
Attention : **à l’intérieur d’une classe de caractères** `[...]`, `^` ne signifie plus « début de chaîne » mais « tout sauf ».
:::

| Expression | Objectif | Correspond | Ne correspond pas |
|-----------|---------|------------|------------------|
| `\d{3}` | Cherche 3 chiffres | 123 dans 12345 | — |
| `^\d{3}$` | Exactement 3 chiffres | 123 | 4567 |
| `^[^@\s]+@[^@\s]+\.[^@\s]+$` | Courriel simple | alice@example.com | alice@ |
| `^A` | Commence par A | ABC12 | SQL20 |
| `0$` | Finit par 0 | SQL20 | ABC12 |
| `^A.*0$` | Commence par A et finit par 0 | A100 | SQL20 |

## Caractère d’échappement `\`

:::warning Important
Le caractère d’échappement est `\`.  
Il permet d’indiquer que le caractère suivant est **littéral** et non interprété comme métacaractère.
:::

Exemple :

- `\{` correspond à une accolade littérale
- `\.` correspond à un point littéral
- `\\` correspond à un antislash

---

### Exemples avec échappement

| Expression | Signification |
|------------|--------------|
| `^\{.+\}$` | Texte entouré d’accolades |
| `^\(\d{3}\) \d{3}-\d{4}$` | Numéro de téléphone ex. `(418) 456-7890` |
| `[a\-z]` | Contient **a**, `-` ou **z** |

---

## Exemple guidé — valider un courriel

Objectif : accepter des courriels simples comme :

-   `alice@example.com`
-   `bob@domain.org`

Refuser :

-   `invalid-email`
-   `@example.com`
-   `alice@`
-   `alice@example`

------------------------------------------------------------------------

### Étape 1 — Structure minimale d'un courriel

Un courriel simple ressemble à :

    quelquechose@quelquechose.quelquechose

Donc on a :

1.  Du texte
2.  Un `@`
3.  Du texte
4.  Un `.`
5.  Du texte

------------------------------------------------------------------------

### Étape 2 — Construire progressivement

#### 1. Autoriser « du texte » avant le @

On veut **au moins un caractère qui n'est pas un espace ni un @** :

```text
[^@\s]+
```

### Détail des éléments utilisés

Dans ce motif :

- `[]` définit une **classe de caractères**.
- `^` **à l’intérieur des crochets** signifie « tout sauf ».
- `\s` représente un **caractère d’espacement** (espace, tabulation, retour de ligne).
- `+` signifie **une ou plusieurs occurrences** de l’élément précédent.

Donc :
```text
[^@\s]+
```
correspond à une ou plusieurs occurrences d’un caractère qui n’est ni `@` ni un espace.

------------------------------------------------------------------------

#### 2. Ajouter le symbole @

On ajoute simplement :

```text
[^@\s]+@
```

Le `@` n'est pas un métacaractère → pas besoin d'échappement.

------------------------------------------------------------------------

#### 3. Ajouter le domaine

Même logique que la partie locale :

```text
[^@\s]+@[^@\s]+
```

------------------------------------------------------------------------

#### 4. Ajouter le point du domaine

Le point est un métacaractère (`.` = n'importe quel caractère).

Pour un point littéral, on doit écrire : `\.`

On obtient :

```text
    [^@\s]+@[^@\s]+\.[^@\s]+
```

------------------------------------------------------------------------

#### 5. Ancrer la regex

Pour valider toute la chaîne, on ajoute :

-   `^` → début
-   `$` → fin

Version finale :

```text
^[^@\s]+@[^@\s]+\.[^@\s]+$
```

### Important

Cette regex est volontairement simple.

Elle ne couvre pas toutes les règles officielles des courriels (RFC).

## Exercices — s'entraîner avec regexr

Pour les exercices suivants, utilisez https://regexr.com/ pour construire et tester vos expressions régulières.

### Exercice 1 — code produit

Construire une expression régulière qui valide un **code produit** composé de :

- exactement **3 lettres majuscules**
- suivies de **2 chiffres**

Par exemple, un format du type :

- `ABC12`

Jeu de tests à essayer dans regexr :

- Doit correspondre (match full) : `ABC12`, `SQL20`, `XYZ00` 
- Ne doit pas correspondre (match none) : `AB12`, `ABCD12`, `abc12`, `A1B23`, `12345`

:::tip Conseils pour regexr
- Utilisez la **cheatsheet** (onglet « Cheatsheet » à gauche) pour retrouver rapidement la syntaxe des quantificateurs (`{}`, `*`, `+`, `?`) et des classes (`[A-Z]`, `[0-9]`, etc.).
- Ajoutez les exemples ci-dessus dans l’onglet **Tests** de regexr et indiquez lesquels doivent « matcher » ou non. Cela vous permet de voir rapidement si votre regex couvre tous les cas.
- Pensez à **ancrer** votre regex avec `^` (début de chaîne) et `$` (fin de chaîne) pour vérifier toute la chaîne, pas seulement une partie du texte.
:::

### Exercice 2 — identifiant de variable

Construire une expression régulière qui valide un **identifiant de variable simple** :

- commence par **une lettre minuscule**
- est suivi de **0 ou plusieurs** caractères alphanumériques ou `_`

Exemples de tests à essayer dans regexr :

- Doit correspondre : `nom`, `x1`, `compteur_total`, `index2`, `a`
- Ne doit pas correspondre : `1x`, `_var`, `nom-variable`, `mon var`, `Nom`

### Exercice 3 — date au format AAAA-MM-JJ

Construire une expression régulière qui valide une **date simple** au format :

- `AAAA-MM-JJ` (par exemple `2025-03-07`)

Contraintes à respecter :

- exactement 4 chiffres, un tiret, 2 chiffres, un tiret, 2 chiffres
- pas d'espaces avant ou après

Défi (optionnel) :

- n'accepter que des années dans les **1900** ou **2000** (par exemple `1999`, `2005`)

À vous de proposer plusieurs dates valides et invalides, puis de les tester dans regexr.

### Exercice 4 — numéro composé uniquement de chiffres

Construire une expression régulière qui valide un **numéro de téléphone simplifié** composé :

- uniquement de **chiffres** (`0` à `9`)
- exactement 10 caractères

Contraintes à respecter :

- pas d'espaces ni de tirets ni de parenthèses
- pas d'autres caractères que les chiffres

À vous d'imaginer des numéros valides et invalides, puis de les tester dans regexr.

### Exercice 5 — cibler les séparateurs dans un numéro de téléphone

Dans cet exercice, on s'intéresse uniquement aux **séparateurs** d'un numéro de téléphone :

- parenthèses `(` et `)`
- tirets `-`
- espaces

Objectif : construire une expression régulière qui **repère seulement ces caractères** (et non les chiffres), par exemple dans un texte contenant plusieurs numéros comme :

- `(418) 456-7890`
- `418-123-4567`
- `418 999 0000`

Consigne : testez cette regex dans l'onglet **Text** de regexr (et non dans l'onglet Tests). Vous devriez voir les parenthèses, les tirets et les espaces **surlignés** dans le texte.

## Utilisation avec PostgreSQL

Dans PostgreSQL, les expressions régulières sont surtout utiles pour :

- **filtrer ou valider** des valeurs (`~`, `regexp_matches`)
- **nettoyer ou transformer** des valeurs (`regexp_replace`)

### L'opérateur `~` (tilde)

En PostgreSQL, `~` signifie **« la valeur correspond à cette expression régulière »**.

- `colonne ~ 'motif'` : la valeur matche le motif regex.
- `not (colonne ~ 'motif')` : la valeur ne matche pas.
- Version insensible à la casse : `colonne ~* 'motif'`.

Par rapport à `LIKE`, `~` permet d'exprimer des contraintes plus précises (longueur, classes de caractères, position dans la chaîne, etc.).

:::tip Clavier — taper le caractère `~`
Sur un clavier « Français (Canada) » sous Windows :
- appuyez sur `AltGr` (celui de droite) + `;:` (à côté du L), pour insérer `~` ;
- ou maintenez `Alt` (celui de gauche) enfoncé et tapez `126` sur le pavé numérique, puis relâchez `Alt` (`~` est le caractère ASCII 126).
:::

### Table d'exemple

>Remarquer l'utilisation d'expressions régulières avec `check` pour valider le courriel et le code postal. 

>Le numéro de téléphone est intentionnellement non normalisé ici. Nous allons le faire dans une démo plus bas avec un `insert`.
```sql
create table utilisateur (
	id serial primary key,
	nom varchar(100) not null,
	courriel varchar(150) unique not null check (courriel ~ '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
	telephone varchar(25) not null,
	notes text,
	code_postal varchar check (upper(code_postal) ~ '^[A-Z][0-9][A-Z][0-9][A-Z][0-9]$')
);

-- Insert non valide --> Que faut-il corriger?
insert into utilisateur (nom, courriel, telephone, notes, code_postal) values
('Alice', 'alice@exemple.com', '(418) 456-7890', '#tag1 data', 'G1K 7P4');

-- Insert non valide --> Que faut-il corriger?
insert into utilisateur (nom, courriel, telephone, notes, code_postal) values
('Paul', 'paulexemple.com', '(418) 555-7890', '#tag1 data', 'G1K8P4');

-- Données supplémentaires
insert into utilisateur (nom, courriel, telephone, notes, code_postal) values
('Sophie', 'sophie@exemple.com', '4187771234', 'urgent : paiement en retard #facture #urgent', 'H2X1Y4'),
('Marc',   'marc@exemple.com',   '4187779999', 'à rappeler demain #client_important #vip',   'G1K8P4');
```

### Filtrer / valider avec un motif

- Extraire les tags dans la colonne `notes` avec `regexp_matches` :

```sql
select id, regexp_matches(notes, '#(\w+)', 'g') as tag
from utilisateur;
```

- Rechercher les numéros de téléphone où **l'indicatif régional (3 chiffres)** est immédiatement suivi de `777` :

```sql
select id, nom, telephone
from utilisateur
where telephone ~ '^(\d){3}777';
```

### Nettoyer un numéro de téléphone avec `regexp_replace`

- Conserver uniquement les chiffres lors d'un `INSERT` pour stocker seulement les chiffres dans un numéro de téléphone.

```sql
insert into utilisateur (nom, courriel, telephone, notes, code_postal) values (
	'Olivier', 
	'olivier3@exemple.com', 
	regexp_replace('(418) 888-7890', '[()\-\s]', '', 'g'), 
	'#tag1 data', 
	'G1K8P4'
);
```

:::tip Détail sur le paramètre `'g'`
- Dans `regexp_matches(..., 'g')`, le `g` signifie **global** : on récupère **toutes** les occurrences qui correspondent au motif dans la chaîne, pas seulement la première.
- Dans `regexp_replace(..., 'g')`, le `g` indique que le remplacement s'applique à **toutes** les correspondances dans la chaîne (et pas uniquement à la première).
:::

> Pour d'autres usages avancés, voir la documentation PostgreSQL : https://www.postgresql.org/docs/current/functions-matching.html


## Exercices avec PostgreSQL

On travaille ici sur des **produits alimentaires** stockés en base de données.

### Table de départ

```sql
create table produits (
	id serial primary key,
	sku varchar(8) not null,      -- code article interne
	code_couleur varchar(7) not null, -- couleur en notation hexadécimale (#RRGGBB)
	ingredients text              -- texte libre : ingrédients, additifs, etc.
);
```

### 1. Deux contraintes `check` avec regex

1. Ajoutez une contrainte `check` sur `sku` qui impose le format suivant :  
	- 3 lettres majuscules, un tiret, 4 chiffres, par exemple `BOI-1234`.

2. Ajoutez une contrainte `check` sur `code_couleur` qui impose un format de couleur hexadécimale simple :  
	- un `#` suivi de exactement 6 caractères hexadécimaux (`0–9`, `A–F` ou `a–f`), 
	- par exemple `#FF8800`.

*Indication : utilisez l’opérateur `~` et ancrez bien vos motifs avec `^` et `$`.*

### 2. `insert` avec nettoyage de caractères

Un fournisseur envoie des données un peu non normalisées pour le `sku` :

- `boi 1234`
- `Boi_1234`

Nous cherchons à normaliser le sku au format `BOI-1234` avant de le stocker en base de données.
Corrigez les insert suivants à l'aide de `upper(...)` et `regexp_replace` pour 
- convertir le `sku` en majuscules 
- supprimer les espaces inutiles et caractères de séparation (`_`, `/`, etc.) 
- inséser au final un `sku` du type `BOI-1234`.

```sql
insert into produits (sku, code_couleur, ingredients) values (
	'boi 1234', -- Utiliser upper et regexp_replace sur cette colonne
	'#FF8800', 
	'Boisson orange', 
	'sucre, arômes'
);

insert into produits (sku, code_couleur, ingredients) values (
	'Boi_1234', -- Utiliser upper et regexp_replace sur cette colonne
	'#00FF00', 
	'Boisson pomme', 
	'colorant E102'
);
```

### 3. `select` avec `~` et `regexp_matches`

Pour les deux exercices suivants, exécutez les insertions suivantes:

```sql
-- Quelques produits "normaux" et "série spéciale -25XX"
insert into produits (sku, code_couleur, ingredients) values
('BOI-2501', '#FF8800', 'Ingrédients : eau, sucre, colorant E102, conservateur E220'),
('BOI-2509', '#FFA500', 'Eau, arômes, E330, E414, colorant E160a'),          -- E160a => la regex E[0-9]{3} extrait "E160"
('JUS-2510', '#F4D03F', 'Jus de pomme, antioxydant E300, acidifiant E330'),
('CHP-2599', '#D35400', 'Pomme de terre, sel, paprika, exhausteur E621'),
('BAR-2500', '#8E44AD', 'Céréales, sirop de glucose, émulsifiant E322, E322'), -- E322 répété

-- Hors série -25XX (ne doit pas sortir dans la requête a)
('BOI-2401', '#00FF00', 'Eau, sucre'),                                       -- aucun additif E###
('SOU-2601', '#3498DB', 'Tomates, eau, sel, correcteur d’acidité E509'),
('THE-1234', '#2ECC71', 'Thé, arômes naturels, colorant E150d'),             -- extrait "E150" (car E150d)
('BIS-2314', '#111111', 'Farine, sucre, E202'); 
```

Sur la table `produits` remplie avec quelques lignes, écrivez les requêtes suivantes.

#### a) `select` qui utilise `~`

Sélectionner les produits dont le `sku` correspond à une **série spéciale -25XX**, par exemple tous les codes finissant par `-25XX`.

#### b) `select` qui utilise `regexp_matches`

On suppose que la colonne `ingredients` peut contenir des codes d’additifs, par exemple :

- `Ingrédients : sucre, colorant E102, conservateur E220`
- `Eau, arômes, E330, E414, colorant E160a`

Écrire une requête qui, pour chaque produit contenant au moins un additif, **extrait un code d’additif** de la forme `E` suivi de 3 chiffres (par exemple `E220`).

*Indication : un code d’additif peut être modélisé par le motif `E[0-9]{3}`.*



