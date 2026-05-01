---
title: "02 — Jointures"
---

# 02 — Jointures

## Objectif

Comprendre comment **combiner des données provenant de plusieurs tables** :
- `inner join` (lignes qui matchent des deux côtés)
- `left join` (garder toutes les lignes de gauche)
- `right join` (garder toutes les lignes de droite)
- `full join` (garder tout des deux côtés)

Dans les exemples, on utilise maintenant des **alias de tables** (ex. `piste p`, `album al`) pour :
- rendre les requêtes plus courtes et lisibles
- éviter l’ambiguïté quand plusieurs tables ont des colonnes du même nom

---

## Base de données de test à importer (Chinook)

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Attention</strong><br>
Pour suivre les exemples de ce module, vous devez importer la base de données <strong>Chinook</strong>.<br>

<strong>Télécharger la base de données de test — Chinook :</strong>
<br>
<a href="./../../databases/chinook.sql" target="_blank" rel="noopener">Fichier .sql à télécharger</a>

</div>

### Importation

Téléchargez le fichier SQL, puis exécutez dans un invite de commandes :<br>
<strong>Changez le chemin d'accès du fichier selon où vous l'avez placé.</strong>

```bash
psql -U postgres -f "C:\Users\Admin\Desktop\chinook.sql"
```

### À propos de Chinook

Chinook est une base de données d’exemple qui représente une petite boutique de musique numérique.
Elle contient notamment :
- le catalogue musical (`artiste`, `album`, `piste`, `genre`, `type_media`)
- les ventes (`client`, `facture`, `ligne_facture`)
- des listes de lecture (`liste_lecture`, `liste_lecture_piste`)

---

## Pourquoi faire des jointures ?

Dans un modèle relationnel, l’information est **répartie en plusieurs tables**.
Une jointure permet de **rassembler** les données liées (par une clé primaire/étrangère) dans un même résultat.

Exemple (catalogue musical) :
- la piste est dans `piste`
- le nom de l’album est dans `album`
- le nom de l’artiste est dans `artiste`

---

## Syntaxe générale

Forme courante :

```sql
select ...
from table_a a
join table_b b
	on a.cle = b.cle;
```

À retenir :
- `join` seul = `inner join`
- préférez les **alias** (`a`, `b`) pour éviter l’ambiguïté
- dans le `on`, on compare généralement une colonne de la table de gauche avec une colonne de la table de droite (ex. `a.id = b.a_id`)
- les lignes pour lesquelles les deux valeurs correspondent seront associées dans le résultat
- le cas le plus courant : jointure entre une **clé primaire (PK)** et une **clé étrangère (FK)**

---

## Alias de tables et de colonnes
Les alias servent à **identifier facilement** les colonnes et les tables dans les requêtes qui référencent plus d'une table.

### Alias de tables

On met l’alias **après** le nom de la table :

```sql
select p.nom, al.titre
from piste p
join album al
	on al.album_id = p.album_id;
```

On peut préfixe les colonnes avec un alias (ex. `p.nom`, `al.titre`) généralement lorsqu'on a besoin de préciser le libellé de colonne de le résultat.

### Alias de colonnes 

```sql
select p.nom piste, al.titre album
from piste p
left join album al
	on al.album_id = p.album_id;
```

---

## Inner join

Un `inner join` retourne **uniquement** les lignes qui ont une correspondance des deux côtés.

### Exemple — Afficher les artistes et leurs albums

```sql
select ar.nom artiste, al.titre album
from artiste ar
join album al
	on al.artiste_id = ar.artiste_id
order by ar.nom, al.titre;
```

### Exemple — Afficher les albums et les pistes de l'artiste AC/DC

Le `where` se place **après** tous les `join`, comme dans n'importe quelle requête :

```sql
select ar.nom artiste, al.titre album, p.nom piste
from artiste ar
join album al
	on al.artiste_id = ar.artiste_id
join piste p
	on al.album_id = p.album_id 
where ar.nom = 'AC/DC'
order by al.titre, p.nom;
```

### Exemple — Afficher les factures et les lignes de facture

```sql
select f.facture_id, f.date_facture, lf.piste_id, lf.quantite, lf.prix_unitaire
from facture f
join ligne_facture lf
	on lf.facture_id = f.facture_id
order by f.facture_id;
```

> Remarque : on n’a pas besoin d’écrire `inner` ; `join` seul correspond à un `inner join`.

---

## Left join

Un `left join` retourne :
- **toutes** les lignes de la table de gauche
- et les lignes correspondantes de la table de droite (sinon, des `NULL`)

### Exemple — Afficher tous les clients ainsi que leur représentant respectif

Dans Chinook, un client pourrait ne pas avoir de représentant, car la colonne representant_id est nullable.

```sql
select c.prenom client, r.prenom représentant
from client c
left join employe r
	on c.representant_id = r.employe_id
order by r.prenom desc;
```

> Ici, 4 clients n'ont pas de représentant.

### Exemple — Conserver tous les clients, même ceux sans facture

```sql
select c.client_id, c.prenom, c.nom_famille, f.facture_id
from client c
left join facture f
	on f.client_id = c.client_id
order by c.client_id, f.facture_id;
```
> Ici, le client avec id_client = 1 n'est jamais référencé dans facture.


Dans les deux exemples, on veut quand-même afficher les informations de la table de gauche, le client, même pour les enregistrements où la référence avec la table de droite est inexistante.

---

## Right join

Un `right join` est l’équivalent d’un `left join`, mais en gardant **toutes** les lignes de la table de droite.
En pratique, on l’utilise moins : on préfère souvent **inverser l’ordre** des tables et faire un `left join`.

### Exemple — la même requête que le `left join`, réécrite en `right join`

Rappel — avec un `left join` :

```sql
select c.prenom client, r.prenom représentant
from client c
left join employe r
	on c.representant_id = r.employe_id
order by r.prenom desc;
```

La version strictement équivalente avec un `right join` consiste à **inverser l'ordre des tables** :

```sql
select c.prenom client, r.prenom représentant
from employe r
right join client c
	on c.representant_id = r.employe_id
order by r.prenom desc;
```

Les deux requêtes produisent **exactement le même résultat** : tous les clients, avec `NULL` pour le représentant quand il n'y en a pas.

<div class="my-3 rounded-lg border border-red-300 bg-red-50 p-3 text-red-900">
<strong>Important</strong><br>
En pratique, évitez <code>right join</code> : réécrivez la requête avec un <code>left join</code> en inversant l’ordre des tables. C’est généralement plus lisible.
</div>

---

## Full join

Un `full join` retourne :
- toutes les lignes de gauche
- toutes les lignes de droite
- avec des `NULL` quand il n’y a pas de correspondance

### Exemple — clients avec ou sans représentant, et représentants avec ou sans clients

Ce `full join` permet de voir :
- les clients qui n’ont pas de représentant (`employe` = `NULL`)
- les employés qui ne sont le représentant d’aucun client (`client` = `NULL`)

```sql
select c.prenom client, r.prenom représentant
from client c
full join employe r
	on c.representant_id = r.employe_id
order by r.prenom, c.prenom;
```

---

## Exemples de jointures multi-tables

### Exemple A — Catalogue de musique complet

>Afficher le catalogue complet de la boutique : pour chaque piste, montrer le nom de l'artiste, le titre de l'album, le nom de la piste, son type de média, son genre et son prix unitaire. Trier par artiste, puis par album, puis par piste.

```sql
select
	ar.nom artiste,
	al.titre album,
	p.nom piste,
	tm.nom type_media,
	g.nom genre,
	p.prix_unitaire
from artiste ar
join album al
	on al.artiste_id = ar.artiste_id
join piste p
	on p.album_id = al.album_id
join type_media tm
	on tm.type_media_id = p.type_media_id
left join genre g
	on g.genre_id = p.genre_id
order by ar.nom, al.titre, p.nom;
```

### Exemple B — Détail des ventes pour un client précis

>Afficher le détail de toutes les ventes pour le client **François Tremblay** : pour chaque ligne de facture, montrer le prénom et nom du client, le numéro et la date de la facture, le nom de la piste achetée, la quantité, le prix unitaire et le total de la ligne. Trier par date de facture décroissante.

```sql
select
	c.prenom,
	c.nom_famille,
	f.facture_id,
	f.date_facture,
	p.nom piste,
	lf.quantite,
	lf.prix_unitaire,
	(lf.quantite * lf.prix_unitaire) total_ligne
from client c
join facture f
	on f.client_id = c.client_id
join ligne_facture lf
	on lf.facture_id = f.facture_id
join piste p
	on p.piste_id = lf.piste_id
where c.prenom = 'François'
	and c.nom_famille = 'Tremblay'
order by f.date_facture desc, f.facture_id;
```

---

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
	<strong class="block">ℹ️ À faire maintenant</strong>
	<p class="m-0">
		Pour mettre ces notions en pratique, passez au
		<a href="./../../labs/lab06-jointures" class="font-semibold underline hover:text-blue-700">
			Laboratoire 6 — Jointures
		</a>.
	</p>
</div>