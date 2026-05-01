---
title: "03 — Fonctions d'agrégations"
---

# 03 — Fonctions d'agrégations

> Adapté de [W3 Schools](https://www.w3schools.com/sql/sql_aggregate_functions.asp)

Une fonction agrégée est une fonction qui effectue un calcul sur un ensemble de valeurs et renvoie une seule valeur.

Les fonctions d'agrégation SQL les plus courantes :

---

**MIN()** — Renvoie la plus petite valeur d'une colonne.

*Exemple* : Quel est le prix le plus bas d'une piste ?

```sql
select min(prix_unitaire) prix_minimum
from piste;
```

---

**MAX()** — Renvoie la plus grande valeur d'une colonne.

*Exemple* : Quel est le prix le plus élevé d'une piste ?

```sql
select max(prix_unitaire) prix_maximum
from piste;
```

---

**COUNT()** — Renvoie le nombre de lignes dans un ensemble.

*Exemple* : Combien y a-t-il de clients ?

```sql
select count(*) nombre_clients
from client;
```

---

**SUM()** — Renvoie la somme d'une colonne numérique.

*Exemple* : Quel est le montant total de toutes les factures ?

```sql
select sum(total) montant_total
from facture;
```

---

**AVG()** — Renvoie la valeur moyenne d'une colonne numérique.

*Exemple* : Quel est le montant moyen d'une facture ?

```sql
select avg(total) montant_moyen
from facture;
```

---

Les fonctions agrégées ignorent les valeurs nulles, sauf `COUNT(*)`.
