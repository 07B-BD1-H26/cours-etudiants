---
title: "03 — Index de colonne"
aside: true
---

# 03 — Index de colonne

## Objectif
Comprendre à quoi sert un index, quand en créer un, et pourquoi un index peut accélérer certaines requêtes tout en ajoutant un coût sur les écritures.

---

## L'essentiel à connaître

Un index est une structure supplémentaire qu'une base de données maintient pour retrouver plus vite certaines lignes.

Sans index, le SGBD doit souvent lire beaucoup de lignes pour répondre à une requête.

Avec un index, il peut parfois accéder plus rapidement aux lignes utiles.

Exemple d'idée :
- chercher un client par `courriel`
- filtrer des pistes par `genre_id`
- joindre `facture` à `client` via `client_id`

---

## Pourquoi un index peut aider

Un index est surtout utile quand une colonne est souvent utilisée dans :
- un `where`
- un `join`
- un `order by`

Exemple :

```sql
select *
from client
where courriel = 'test@example.com';
```

Si cette recherche est fréquente, un index sur `courriel` peut aider.

---

## Créer un index

Syntaxe :

```sql
create index nom_index
on nom_table (nom_colonne);
```

Exemple avec Chinook :

```sql
create index idx_client_courriel
on client (courriel);
```

Exemple sur une colonne de relation :

```sql
create index idx_facture_client_id
on facture (client_id);
```

---

## Ce qu'un index ne fait pas

Un index n'améliore pas tout automatiquement.

Il peut être peu utile si :
- la table est très petite
- presque toutes les lignes doivent être lues de toute façon
- la colonne a très peu de valeurs différentes

---

## Coût d'un index

Créer un index apporte aussi un coût :
- l'index prend de l'espace disque
- Surtout, PostgreSQL doit aussi le mettre à jour lors des `insert`, `update` et `delete`

Donc :
- plus d'index peut améliorer certaines lectures
- mais trop d'index peut ralentir les écritures

---

## Index et clés

Quelques repères utiles :
- une clé primaire crée généralement un index
- une contrainte `unique` crée généralement un index unique
- les colonnes de clé étrangère sont souvent de bonnes candidates à l'indexation

Dans Chinook, plusieurs index existent déjà sur des colonnes servant aux relations.

---

## Supprimer un index

Syntaxe :

```sql
drop index nom_index;
```

Exemple :

```sql
drop index idx_client_courriel;
```

Comme pour d'autres opérations de maintenance :
- on supprime rarement un index sans raison
- il faut vérifier l'impact sur les requêtes avant de le retirer

---

## À retenir

- un index sert surtout à accélérer certaines lectures
- il est particulièrement utile sur des colonnes souvent filtrées, jointes ou triées
- un index a aussi un coût sur l'espace et les écritures
- il faut l'ajouter avec intention, pas automatiquement partout

---

### Sources

- [PostgreSQL Documentation — Indexes](https://www.postgresql.org/docs/current/indexes.html)
- [PostgreSQL Documentation — CREATE INDEX](https://www.postgresql.org/docs/current/sql-createindex.html)

---

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
	<strong class="block">ℹ️ À faire maintenant</strong>
	<p class="m-0">
		Poursuivez dans le
		<a href="./../../labs/lab08-ddl-maintenance" class="font-semibold underline hover:text-blue-700">
			laboratoire 8
		</a>
		en ajoutant quelques index simples sur des colonnes souvent utilisées dans les recherches ou les relations.
	</p>
</div>
