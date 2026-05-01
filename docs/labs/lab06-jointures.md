---
title: "Lab 06 — Jointures"
aside: false
---

# 🧪 Laboratoire 06 — Jointures

## Travail à réaliser

### Base de données à utiliser (Chinook)

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
<strong>Attention</strong><br>
Ce laboratoire utilise la base de données <strong>Chinook</strong>.<br>
Si vous ne l'avez pas encore importée, référez-vous aux instructions du module :
<a href="../modules/04-jointures-agregations/02-jointures#base-de-donnees-de-test-a-importer-chinook">Importer Chinook</a>
</div>

Créez un nouveau script SQL dans DBeaver (portée : base de données `chinook`).

---

## 1 — De la sous-requête à la jointure

Dans la partie précédente du cours, vous avez utilisé des sous-requêtes non corrélées pour **filtrer** des données.
Mais une sous-requête ne permet pas d'**afficher** les colonnes des deux tables en même temps — pour ça, il faut utiliser une jointure.

### a) Transformer en jointure

Les requêtes suivantes utilisent une sous-requête. Pour chacune, réécrivez-la avec un `join` de façon à afficher les colonnes des **deux** tables indiquées.

**Requête 1 :**

> Obtenir les `piste_id` des pistes qui appartiennent à un album de l'artiste **'Led Zeppelin'** :
> ```sql
> select piste_id
> from piste
> where album_id in (
>     select album_id from album
>     where artiste_id = (
>         select artiste_id from artiste where nom = 'Led Zeppelin'
>     )
> );
> ```
> Réécrivez cette requête avec des jointures pour afficher : le **nom de la piste**, le **titre de l'album** et le **nom de l'artiste**.

**Requête 2 :**

> Obtenir les clients qui ont au moins une facture :
> ```sql
> select c.client_id, c.prenom, c.nom_famille 
>from client c
>where c.client_id in (
>	select c.client_id 
>	from facture f 
>);
> ```
> Réécrivez avec un `join` pour afficher : le **prénom**, le **nom de famille** des clients, ainsi que le **numéro de facture (id_facture)** et la **date de facturation**. Triez par prénom de client et par date de facturation décroissante.

---

## 2 — Inner join

### a) Requêtes simples

1) Afficher le **titre de chaque album** ainsi que le **nom de l'artiste** correspondant. Trier par nom d'artiste, puis par titre d'album.
2) Afficher le **nom de chaque liste de lecture** et les **noms des pistes** qu'elle contient. Trier par nom de liste de lecture, puis par nom de piste. *(Indice : la table `liste_lecture_piste` fait le lien entre les deux)*

### b) Avec un filtre `where`

1) Afficher le **nom des pistes** et le **titre de l'album** pour toutes les pistes de l'album **'Nevermind'**.
2) Afficher le **prénom et nom du client**, le **numéro de facture** et la **date** pour toutes les factures du client **'Frank Harris'**.
3) Afficher le **nom des pistes** et leur **prix** pour les pistes du genre **'Jazz'**. Trier par prix décroissant.

---

## 3 — Left join

### Employés et leur superviseur

Dans Chinook, chaque employé peut avoir un superviseur — mais pas nécessairement (le grand patron n'en a pas). La colonne `superviseur_id` dans `employe` référence un autre employé.

Afficher le **prénom de chaque employé** ainsi que le **prénom de son superviseur**. Afficher `NULL` si l'employé n'a pas de superviseur. Trier par nom de superviseur.

---

## 4 — Transformer un `right join` en `left join`

La requête suivante répond à la question : **Afficher tous les employés (représentants), même ceux qui n'ont aucun client assigné, avec le prénom du client s'il existe.**

```sql
select r.prenom représentant, c.prenom client
from client c
right join employe r
    on c.representant_id = r.employe_id
order by r.prenom, c.prenom;
```

- Réécrivez cette requête en utilisant un `left join` à la place, de façon à obtenir **exactement le même résultat**.

---

## 5 — Expressions régulières (rappel) avec jointures

L'opérateur `~` permet de filtrer avec une **expression régulière** en PostgreSQL. Il s'utilise dans le `where`, comme `like`, mais avec la syntaxe regex.

```sql
-- Exemple : pistes dont le nom commence par un chiffre
select nom from piste where nom ~ '^[0-9]';
```

### Requêtes à écrire

- Afficher le **nom des pistes** et le **titre de l'album** pour les pistes dont le nom **commence par un chiffre**.
- Afficher le **nom des artistes** dont le nom **contient un nombre** (un ou plusieurs chiffres consécutifs).
- Afficher le **prénom et nom des clients** ainsi que leur **pays**, pour les clients dont le courriel **se termine par `.com`** (en utilisant une regex).
- Afficher le **nom des pistes** et le **nom de l'artiste** pour les pistes dont le nom **ne contient pas de voyelle**. Trier par nom de piste.

---

## 6 — Jointures multi-tables

- Afficher, pour chaque piste vendue : le **nom de la piste**, le **titre de l'album**, le **nom de l'artiste**, la **quantité** vendue et le **prix unitaire**. Trier par nom d'artiste.
- Afficher le **prénom et nom du client**, la **date de la facture** et le **nom des pistes** achetées pour toutes les factures de **2010**. Trier par nom de client, puis par date.