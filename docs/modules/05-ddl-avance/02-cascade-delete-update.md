---
title: "02 — Cascade Delete/Update"
aside: true
---

# 02 — Cascade Delete/Update

## Objectif
Comprendre surtout l'effet de `on delete cascade` sur une clé étrangère, et connaître `on update cascade` comme option plus rare à manipuler avec prudence.

---

## Pourquoi utilise Cascade

Quand une table enfant référence une table parent avec une clé étrangère, PostgreSQL protège normalement l'intégrité référentielle.

Exemple :
- un `client` peut être référencé par plusieurs `facture`
- une `facture` peut être référencée par plusieurs `ligne_facture`

Si on tente de supprimer ou modifier une ligne parent encore référencée, l'opération échoue souvent.

La cascade sert à définir quoi faire automatiquement dans ces cas.

---

## `On delete cascade`

`on delete cascade` signifie :
- si la ligne parent est supprimée
- les lignes enfants liées sont supprimées automatiquement

Exemple générique :

```sql
create table departement (
  departement_id integer primary key,
  nom varchar(50) not null
);

create table employe_demo (
  employe_id integer primary key,
  nom varchar(50) not null,
  departement_id integer not null,
  foreign key (departement_id) references departement(departement_id) on delete cascade
);

insert into departement (departement_id, nom) values
  (1, 'Informatique'),
  (2, 'Comptabilite');

insert into employe_demo (employe_id, nom, departement_id) values
  (101, 'Alice', 1),
  (102, 'Karim', 1),
  (103, 'Sophie', 2);

select * from departement;
select * from employe_demo;

delete from departement
where departement_id = 1;

select * from departement;
select * from employe_demo;
```

Si on supprime un département, les employés liés seront aussi supprimés.

### Quand c'est utile

- tables purement dépendantes
- données enfants qui n'ont aucun sens sans le parent

Exemple courant :
- supprimer une facture et supprimer aussi ses lignes de facture

### Risque

Une suppression sur la table parent peut entraîner plusieurs suppressions en chaîne.

Il faut donc utiliser cette option seulement si cet effet est réellement voulu.

---

## `On update cascade`

`on update cascade` existe aussi :
- si la clé référencée du parent change
- la valeur liée dans l'enfant est mise à jour automatiquement

En pratique, on lui donne moins d'importance, car :
- une clé primaire devrait rarement changer
- modifier un identifiant est généralement une mauvaise pratique

Retenez surtout ceci :
- l'option existe
- elle peut dépanner dans certains cas particuliers
- mais on essaie normalement de concevoir un système où ce besoin est rare

---

## Sans cascade

Sans `cascade`, PostgreSQL bloque souvent l'opération.

Exemple :
- on veut supprimer un client
- mais des factures pointent encore vers ce client
- la suppression échoue

Cette protection est souvent une bonne chose.

---

## Quand utiliser la cascade

Utilisez `on delete cascade` surtout quand :
- l'enfant dépend totalement du parent
- conserver l'enfant seul n'a pas de sens

Soyez prudent si :
- les données enfants ont une valeur métier autonome
- une suppression automatique pourrait causer une perte importante de données

Pour `on update cascade`, retenez surtout :
- c'est une option secondaire
- si vous devez souvent changer des identifiants, il y a probablement un problème de conception à revoir

---

## Avec `alter table`

Pour ajouter une nouvelle clé étrangère avec cascade, on passe souvent par `alter table`.

Exemple :

```sql
alter table ligne_facture
add constraint fk_ligne_facture_facture
foreign key (facture_id) references facture(facture_id)
on delete cascade;
```

Si une contrainte existe déjà, on ne peut généralement pas simplement "ajouter la cascade" à cette contrainte.

En pratique, on doit souvent :

1. la supprimer avec `drop constraint`
2. la recréer avec l'action souhaitée (cascade)

---

## À retenir

- `on delete cascade` est le cas le plus important à retenir
- `on update cascade` existe, mais changer des identifiants reste généralement une mauvaise pratique
- la cascade est utile, mais elle doit être choisie volontairement
- plus la relation est sensible, plus il faut être prudent avant d'ajouter une cascade

---

### Sources

- [PostgreSQL Documentation — Constraints](https://www.postgresql.org/docs/current/ddl-constraints.html)
- [PostgreSQL Documentation — Alter table](https://www.postgresql.org/docs/current/sql-altertable.html)

---

<div class="my-6 rounded-lg border border-blue-300 bg-blue-50 p-4 text-blue-900">
	<strong class="block">ℹ️ À faire maintenant</strong>
	<p class="m-0">
		Ajoutez une petite démonstration de cascade dans le
		<a href="./../../labs/lab08-ddl-maintenance" class="font-semibold underline hover:text-blue-700">
			laboratoire 8
		</a>
		pour observer la différence entre une relation avec et sans cascade.
	</p>
</div>
