---
title: "Révision — Examen 2"
---

# Révision — Examen 2 : Club PhotoClic

## Pour voir le corrigé en format vidéo:
[Corrigé en vidéo](https://livecegepfxgqc-my.sharepoint.com/:v:/g/personal/otremblay_cegepgarneau_ca/IQCRjLGCFE8cTLzJ0bzxXfckAQvgMu9x7_M8-FCc0wkR3JY?e=kruYre)

> Les questions ont été organisées par chapitres pour vous aider dans votre révision.

## Modalités de l'examen 2
-	Durée : 2h50
-	Aucune sortie tolérée
-	Permis : site du cours uniquement (et le site regexr en retrouvant le lien dans le site du cours)
-	Aucune aide extérieure n'est permise (autres sites Web, Ami, IA, etc.).
-	Assurez-vous d'écrire des réponses complètes et détaillées.
-	Veuillez remettre votre fichier .sql sur Léa dans le travail nommé Examen 2.

<div class="my-6 rounded-lg border border-yellow-300 bg-yellow-50 p-4 text-yellow-900">
  <strong>Important — Installation de Safe Exam Browser :</strong><br>
  Vous devez <strong>obligatoirement</strong> installer et tester
  <a href="https://safeexambrowser.org/download_en.html" class="underline text-blue-600" target="_blank">Safe Exam Browser</a>
  avant la journée de l'examen.
</div>

> Le code d'entrée pour la révision est 1234 et le code de sortie est 4321

## Contenu de la révision

- débogage de requêtes
- `INSERT`, `UPDATE`, `DELETE`
- jointures
- agrégations
- sous-requêtes
- expressions régulières
- `ALTER TABLE`
- suppression en cascade
- sécurité, rôles et hachage

---

## Contexte

**PhotoClic** est un club de photographie qui organise des ateliers et des sorties photo pour ses membres.

La base de données a été montée rapidement par une ancienne coordonnatrice. Elle fonctionne, mais plusieurs éléments sont incomplets ou peu sécuritaires :

- certains filtres SQL ont été mal rédigés
- plusieurs validations sont absentes
- les mots de passe sont stockés en clair
- les comptes et privilèges ne sont pas gérés proprement
- certaines suppressions devraient entraîner la suppression automatique des enregistrements liés

Vous devez analyser la base de données, écrire des requêtes correctes et proposer des corrections de structure.

---

## Structure de départ

La révision repose sur **3 tables** :

- `membre`
- `atelier`
- `inscription_atelier`

Le code de départ complet se trouve aussi dans le fichier `revision-examen2-reponses.sql` disponible sur Léa dans le travail associé à la révision.

---

## PARTIE 1 — Révision des acquis (30 points)

### Q1 — Débogage de requête

La requête suivante devrait afficher les ateliers prévus dans l'intervalle demandé par la coordonnatrice, soit les ateliers planifiés après le `2026-05-15` et avant le `2026-07-05`.

Cependant, la requête ci-dessous ne retourne pas exactement le bon ensemble de résultats.

```sql
select titre, date_atelier
from atelier
where date_atelier between '2026-05-15' and '2026-07-05';
```

1. Expliquez l'erreur logique.
2. Écrivez une version corrigée.

**Critères d'évaluation**

- Explication juste et complète du problème
- Correction appropriée apportée à la requête

---

### Q2 — Débogage de requête

La requête suivante devrait afficher les membres dont le courriel n'est pas une adresse du domaine `photoclic.ca`.

Cependant, elle ne retourne pas le bon résultat.

```sql
select nom, courriel
from membre
where courriel not like 'photoclic.ca';
```

1. Expliquez pourquoi cette requête est logiquement incorrecte.
2. Écrivez une version corrigée.

**Critères d'évaluation**

- Explication juste et complète du problème
- Correction appropriée apportée à la requête

---

### Q3 — Insertions de données

La coordonnatrice du club veut ajouter deux nouveaux ateliers à l'horaire.

Le premier atelier s'intitule `Photo de rue au crépuscule`. Il aura lieu le `2026-07-18`, offrira `16` places et les inscriptions doivent être ouvertes.

Le deuxième atelier s'intitule `Initiation au portrait studio`. Il est prévu pour le `2026-08-09`, comptera `10` places et ne doit pas encore être ouvert aux inscriptions.

Ajoutez ces deux ateliers dans la table `atelier` en indiquant explicitement toutes les colonnes dans votre ou vos instructions `INSERT`.

**Critères d'évaluation**

- Syntaxe SQL correcte
- Données ajoutées conformes à la consigne
- Colonnes correctement précisées

---

### Q4 — UPDATE avec sous-requête non corrélée

La coordonnatrice veut ajuster certains frais annuels.

Augmentez les `frais_annuels` de **10 $** pour les membres dont les frais actuels sont **inférieurs à la moyenne des frais annuels de tous les membres**.

La solution doit utiliser une **sous-requête non corrélée** dans le `UPDATE`.

**Critères d'évaluation**

- Utilisation appropriée d'une sous-requête non corrélée
- Ciblage correct des lignes à modifier
- Modification demandée appliquée correctement
- Syntaxe SQL correcte

---

### Q5 — DELETE avec sous-requête non corrélée

Supprimez les inscriptions associées à des membres **inactifs**.

La solution doit utiliser une sous-requête dans la clause `WHERE`.

**Critères d'évaluation**

- Table ciblée correctement
- Logique de suppression conforme à la consigne
- Utilisation appropriée d'une sous-requête

---

## PARTIE 2 — Jointures, agrégations et sous-requêtes (35 points)

### Q6 — Filtre avec expression régulière

Affichez les inscriptions dont le `code_badge` respecte l'un des deux formats suivants :

- `PHO-` suivi de deux chiffres
- `STU-` suivi de deux chiffres

Exemples valides : `PHO-07`, `STU-08`

Colonnes à afficher :

- `inscription_id`
- `code_badge`

Triez par `code_badge`.

**Critères d'évaluation**

- Filtrage conforme au format demandé
- Colonnes demandées présentes
- Tri correct

---

### Q7 — Jointure interne avec filtre multiple

Affichez les membres **actifs** inscrits à un atelier **ouvert**.

Ne conservez que les ateliers prévus à partir du `2026-06-01`.

Colonnes à afficher :

- `membre_id`
- `nom` du membre
- `titre` de l'atelier
- `date_atelier`

Triez par `date_atelier`, puis par `nom`.

**Critères d'évaluation**

- Jointures appropriées
- Filtres conformes à la consigne
- Colonnes et tri corrects

---

### Q8 — Jointure externe

Affichez **tous les ateliers**, même ceux sans inscription, avec :

- le `titre`
- le `nom` du membre lié à l'inscription, s'il y en a un (sinon NULL)

Un atelier sans inscription doit quand même apparaître dans le résultat.

Triez par `titre`.

**Critères d'évaluation**

- Structure de requête appropriée
- Résultat conforme à la consigne
- Gestion correcte des cas sans correspondance

---

### Q9 — GROUP BY et agrégations

Pour chaque `statut` de membre, affichez :

- le statut
- le nombre total de membres
- les revenus totaux générés par les frais annuels

Triez par les revenus totaux décroissants.

**Critères d'évaluation**

- Regroupement approprié
- Fonctions d'agrégation utilisées correctement
- Tri correct

---

### Q10 — GROUP BY / HAVING sur les revenus par statut

Affichez uniquement les statuts de membres dont les **revenus totaux** dépassent `500`.

Colonnes à afficher :

- `statut`
- les revenus totaux générés par les frais annuels

**Critères d'évaluation**

- Regroupement approprié
- Filtrage d'agrégation correct
- Colonnes demandées présentes

---

### Q11 — Sous-requête corrélée

Affichez les membres qui n'ont **aucune inscription** à un atelier.

Colonnes à afficher :

- `nom`
- `statut`
- `frais_annuels`

Triez par `statut`, puis par `nom`.

La solution doit utiliser une sous-requête corrélée.

**Critères d'évaluation**

- Sous-requête appropriée à la consigne
- Logique de comparaison correcte
- Colonnes et tri conformes

---

## PARTIE 3 — DDL avancé, sécurité et mots de passe (35 points)

### Q12 — ALTER TABLE avec deux contraintes sur la même table

Modifiez la table `membre` pour :

1. ajouter une contrainte `UNIQUE` sur `courriel`, nommée `membre_courriel_uq`
2. ajouter une contrainte `CHECK` sur `code_membre` pour imposer :
   `deux lettres majuscules`, un tiret, puis `trois chiffres`

Nom de la contrainte :

`membre_code_membre_format_ck`

**Critères d'évaluation**

- Contraintes ajoutées correctement
- Noms des contraintes conformes
- Validation demandée correctement exprimée

---

### Q13 — Suppression en cascade

La clé étrangère entre `inscription_atelier` et `atelier` ne possède pas de règle de suppression en cascade.

La contrainte actuelle se nomme `inscription_atelier_atelier_id_fkey`.

1. Supprimez cette contrainte.
2. Recréez-la avec `ON DELETE CASCADE`.
3. Nommez la nouvelle contrainte `inscription_atelier_atelier_fk`.

**Critères d'évaluation**

- Suppression de la contrainte appropriée
- Recréation correcte de la contrainte
- Comportement de cascade conforme à la consigne

---

### Q14 — Migration des mots de passe

La colonne `mot_de_passe_clair` de la table `membre` doit être remplacée par une version hachée.

Effectuez la migration complète :

1. activez `pgcrypto`
2. ajoutez `mot_de_passe_hache` de type `text`
3. remplissez la colonne avec `crypt(..., gen_salt('bf'))`
4. supprimez la colonne `mot_de_passe_clair`

**Critères d'évaluation**

- Étapes de migration complètes
- Syntaxe SQL correcte
- Résultat conforme aux exigences de sécurité (aucun mot de passe visible dans la table)

---

### Q15 — Rôles, utilisateurs et privilèges

Mettez en place la gestion des accès suivante pour la base **photoclic**.

#### Rôles

| Rôle | Description |
|---|---|
| `animation_lecture` | lecture seule |
| `admin_photo` | accès complet |

#### Utilisateurs

| Utilisateur | Rôle | Mot de passe |
|---|---|---|
| `lea_anim` | `animation_lecture` | `Photo2026!` |
| `sam_admin` | `admin_photo` | `Flash#99` |

#### Privilèges attendus

- `animation_lecture` :
  accès `SELECT` sur toutes les tables du schéma `public`
- `admin_photo` :
  `ALL PRIVILEGES` sur toutes les tables et séquences du schéma `public`
- retirez le droit `SELECT` à `animation_lecture` sur la table `membre`

**Critères d'évaluation**

- Création correcte des rôles et utilisateurs
- Attribution correcte des rôles
- Gestion des privilèges conforme à la consigne
- Restriction finale correctement appliquée

---

## Annexe — Code de départ

```sql
create table membre (
  membre_id serial primary key,
  nom varchar(80) not null,
  courriel varchar(100) not null,
  code_membre varchar(10) not null,
  statut varchar(20) not null,
  frais_annuels numeric(10,2) not null check (frais_annuels >= 0),
  date_inscription date not null default current_date,
  est_actif boolean not null default true,
  mot_de_passe_clair varchar(120) not null
);

create table atelier (
  atelier_id serial primary key,
  titre varchar(100) not null,
  date_atelier date not null,
  nb_places integer not null check (nb_places > 0),
  est_ouvert boolean not null default true
);

create table inscription_atelier (
  inscription_id serial primary key,
  membre_id integer not null,
  atelier_id integer not null,
  code_badge varchar(20),
  date_inscription timestamp not null default current_timestamp,
  foreign key (membre_id) references membre(membre_id),
  foreign key (atelier_id) references atelier(atelier_id)
);

insert into membre (membre_id, nom, courriel, code_membre, statut, frais_annuels, date_inscription, est_actif, mot_de_passe_clair) values
(1, 'Alice Gendron',   'alice.g@photoclic.ca',   'AG-001', 'premium', 210.00, '2023-09-12', true,  'Photo#01'),
(2, 'Benoit Renaud',   'benoit.r@photoclic.ca',  'BR-002', 'regulier', 180.00, '2022-05-18', true,  'Photo#02'),
(3, 'Clara Dubois',    'clara.d@photoclic.ca',   'CD-003', 'regulier', 190.00, '2024-01-08', true,  'Photo#03'),
(4, 'David Pelletier', 'david.p@photoclic.ca',   'DP-004', 'etudiant', 120.00, '2023-03-22', true,  'Photo#04'),
(5, 'Emma Cote',       'emma.c@photoclic.ca',    'EC-005', 'etudiant', 115.00, '2025-02-14', true,  'Photo#05'),
(6, 'Fanny Morin',     'fanny.m@photoclic.ca',   'FM-006', 'premium', 220.00, '2021-11-30', true,  'Photo#06'),
(7, 'Gabriel Lavoie',  'gabriel.l@photoclic.ca', 'GL-007', 'regulier', 175.00, '2022-08-19', false, 'Photo#07'),
(8, 'Helene Bouchard', 'helene.b@photoclic.ca',  'HB-008', 'premium', 230.00, '2024-04-02', true,  'Photo#08'),
(9, 'Ismael Gagnon',   'ismael.g@gmail.com',  'IG-009', 'etudiant', 125.00, '2025-01-10', true,  'Photo#09');

insert into atelier (atelier_id, titre, date_atelier, nb_places, est_ouvert) values
(1, 'Composition en lumiere naturelle', '2026-05-11', 12, true),
(2, 'Retouche Lightroom debutant',      '2026-05-25', 15, true),
(3, 'Sortie photo urbaine',             '2026-06-07', 20, false),
(4, 'Macro creatif au jardin',          '2026-06-21', 10, true),
(5, 'Noir et blanc en studio',          '2026-07-05', 8, true),
(6, 'Photos de nuit',                   '2026-07-19', 14, false);

insert into inscription_atelier (inscription_id, membre_id, atelier_id, code_badge) values
(1, 1, 1, 'PHO-01'),
(2, 2, 1, 'PHO-02'),
(3, 3, 2, 'PHO-03'),
(4, 4, 2, 'badge-libre'),
(5, 5, 3, 'PHO-05'),
(6, 6, 4, 'MAC-06'),
(7, 7, 4, 'GL07'),
(8, 8, 5, 'STU-08'),
(9, 9, 5, 'PHO-09');
-- note : l'atelier 6 n'a aucune inscription
```
