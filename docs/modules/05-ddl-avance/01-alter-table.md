---
title: "01 — ALTER TABLE"
aside: true
---

# 01 — ALTER TABLE

## Objectif
Comprendre comment modifier la structure d'une table existante avec `ALTER TABLE`, sans la recréer, afin de progresser rapidement vers des cas de maintenance concrets.

---

## Pourquoi `ALTER TABLE`

Dans un projet réel, le premier modèle n'est presque jamais définitif.

Avec le temps, on doit par exemple :
- ajouter une colonne devenue nécessaire
- ajuster un type de donnée
- renforcer une règle métier avec une contrainte
- rendre une colonne obligatoire

`ALTER TABLE` sert à faire évoluer une table déjà créée.

```sql
alter table nom_table
operation;
```

Avant de modifier une table existante, gardez en tête que :
- les données déjà présentes peuvent empêcher certaines modifications
- une nouvelle contrainte peut échouer si des données actuelles ne respectent pas la règle
- certains changements peuvent avoir un impact sur d'autres requêtes ou applications

---

## Opérations les plus utiles

### Ajouter une colonne

```sql
alter table employe
add column date_fin_emploi date;
```

Effet :
- la structure change
- les lignes existantes conservent leurs données
- la nouvelle colonne vaut généralement `null` pour les lignes déjà présentes

Exemple avec valeur par défaut :

```sql
alter table client
add column actif boolean not null default true;
```

>Ajouter une colonne `not null` sans valeur par défaut est souvent impossible si la table contient déjà des données.

### Modifier le type d'une colonne

```sql
alter table album
alter column titre type varchar(220);
```

Exemple typique :
- augmenter la longueur permise d'un texte
- ajuster un type devenu trop restrictif

Certaines conversions sont simples, d'autres non.
Si les données existantes ne sont pas compatibles, la modification peut échouer.

### Ajouter une contrainte

Exemple `check` :

```sql
alter table facture
add constraint ck_facture_total_positif
check (total >= 0);
```

Exemple `unique` :

```sql
alter table client
add constraint uq_client_courriel
unique (courriel);
```

Exemple clé étrangère :

```sql
alter table client
add constraint fk_client_representant
foreign key (representant_id) references employe(employe_id);
```

Bonne pratique :
- donner un nom explicite à la contrainte

### Supprimer une contrainte

```sql
alter table client
drop constraint uq_client_courriel;
```

On fait cela quand :
- une règle métier change
- une contrainte a été mal définie
- on veut la remplacer par une autre

### Ajouter ou retirer `NOT NULL`

Rendre une colonne obligatoire :

```sql
alter table client
alter column telephone set not null;
```

Retirer l'obligation :

```sql
alter table client
alter column fax drop not null;
```

Si des lignes contiennent déjà `null`, `set not null` échouera tant que ces données n'auront pas été corrigées.

---

## Opérations à connaître, mais moins fréquentes

### Renommer une colonne

```sql
alter table client
rename column telephone to telephone_principal;
```

Les données sont conservées, mais il faut vérifier l'impact sur :
- les requêtes SQL
- les vues
- le code applicatif

### Renommer une table

```sql
alter table artiste
rename to artiste_archive;
```

Ici aussi, il faut vérifier les systèmes qui référencent déjà cette table.

### Supprimer une colonne

```sql
alter table employe
drop column date_fin_emploi;
```

### Supprimer une table

```sql
drop table artiste_archive;
```

La suppression d'une colonne ou d'une table est généralement moins fréquente dans les cas de maintenance courants.

Avant de supprimer :
- vérifiez si d'autres systèmes utilisent déjà ces données
- vérifiez les dépendances possibles
- gardez en tête que la perte de données peut être définitive

---

## À retenir

- `ALTER TABLE` sert à faire évoluer une table déjà créée
- pour avancer rapidement vers le labo, retenez surtout : ajouter une colonne, modifier un type, ajouter ou supprimer une contrainte, ajouter ou retirer `not null`
- les renommages et suppressions existent, mais demandent plus d'attention à cause de leurs impacts possibles
- avant toute modification, il faut tenir compte des données déjà présentes

---

### Sources

- [W3Schools — SQL ALTER TABLE Statement](https://www.w3schools.com/sql/sql_alter.asp)
- [PostgreSQL Documentation — ALTER TABLE](https://www.postgresql.org/docs/current/sql-altertable.html)

---

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
	<strong class="block">ℹ️ À faire maintenant</strong>
	<p class="m-0">
		Passez au
		<a href="./../../labs/lab08-ddl-maintenance" class="font-semibold underline hover:text-blue-700">
			laboratoire 8 — DDL de maintenance
		</a>
		pour appliquer ces transformations sur des tables de travail inspirées de Chinook.
	</p>
</div>
