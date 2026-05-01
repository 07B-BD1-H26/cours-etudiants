import { defineConfig } from "vitepress";
import { withMermaid } from "vitepress-plugin-mermaid";

export default withMermaid(defineConfig({
	base: "/cours-etudiants/",
	lang: "fr-CA",
	cleanUrls: true,
	title: "420-07B-FX",
	description: "Introduction aux bases de données — Notes de cours",
	themeConfig: {
		logo: "./logos/logo.png",

		nav: [
			{
				text: "Modules",
				items: [
					{ text: "Module 1 — Introduction", link: "/modules/01-introduction/" },
					{ text: "Module 2 — DDL de base", link: "/modules/02-ddl-base/" },
					{ text: "Module 3 — SQL", link: "/modules/03-sql-base/" },
					{ text: "Module 4 — Jointures et agrégations", link: "/modules/04-jointures-agregations/" },
					{ text: "Module 5 — DDL avancé", link: "/modules/05-ddl-avance/" },
				],
			},
			{
				text: "Laboratoires",
				items: [
					{ text: "Lab 01 — Installations", link: "/labs/lab01-installations" },
					{ text: "Lab 02 — Modélisation", link: "/labs/lab02-modelisation" },
					{ text: "Lab 03 — DDL", link: "/labs/lab03-ddl" },
					{ text: "Lab 04 — Requêtes select", link: "/labs/lab04-select" },
					{ text: "Lab 05 — Modification, opérateurs et sous-requêtes", link: "/labs/lab05-avance" },
					{ text: "Lab 06 — Jointures", link: "/labs/lab06-jointures" },
					{ text: "Lab 07 — Agrégations", link: "/labs/lab07-agregations" },
					{ text: "Lab 08 — DDL & maintenance", link: "/labs/lab08-ddl-maintenance" },
					{ text: "Lab 09 — Sécurité", link: "/labs/lab09-securite" },
				],
			},
			{
				text: "Documentation SGBD",
				items: [
					{ text: "PostgreSQL", link: "https://docs.postgresql.fr/18/" },
					{ text: "SQLite", link: "https://www.sqlite.org/docs.html" },
					{ text: "MariaDB", link: "https://mariadb.com/kb/fr/" },
					{ text: "Oracle Database", link: "https://docs.oracle.com/en/database/" },
					{ text: "Microsoft SQL Server", link: "https://learn.microsoft.com/fr-ca/sql/sql-server/" },
				],
			}
		],

		sidebar: [
			{
				text: "Modules du cours",
				collapsed: false,
				items: [
					{
						text: "Module 1 — Introduction",
						collapsed: true,
						items: [
							{
								text: "Formats de données",
								link: "/modules/01-introduction/01-formats-donnees",
							},
							{
								text: "Structure relationnelle",
								link: "/modules/01-introduction/02-structure-relationnelle",
							},
							{
								text: "Modèle de données",
								link: "/modules/01-introduction/03-modelisation",
							},
						],
					},
					{
						text: "Module 2 — DDL de base",
						collapsed: true,
						items: [
							{
								text: "Create database",
								link: "/modules/02-ddl-base/01-create-database",
							},
							{
								text: "Create table",
								link: "/modules/02-ddl-base/02-create-table",
							},
							{
								text: "Contraintes et Enums",
								link: "/modules/02-ddl-base/03-contraintes-simples",
							},
							{
								text: "Clés primaires et étrangères",
								link: "/modules/02-ddl-base/04-cles-primaires-etrangeres",
							},
							{
								text: "Démonstration de création de BD",
								link: "/modules/02-ddl-base/05-demo-ddl",
							},
							{
								text: "DROP simple",
								link: "/modules/02-ddl-base/06-drop-simple",
							},
							{
								text: "Import & export",
								link: "/modules/02-ddl-base/07-import-export",
							},
						],
					},
					{
						text: "Module 3 — SQL",
						collapsed: true,
						items: [
							{
								text: "Insert",
								link: "/modules/03-sql-base/01-insert",
							},
							{
								text: "Requête de sélection (select)",
								link: "/modules/03-sql-base/02-select-where",
							},
							{
								text: "Update, delete",
								link: "/modules/03-sql-base/03-update-delete",
							},
							{
								text: "Opérateurs et filtres",
								link: "/modules/03-sql-base/04-operateurs",
							},
							{
								text: "Sous-requêtes non corrélées",
								link: "/modules/03-sql-base/05-sous-requetes-non-correlees",
							},
							{
								text: "Révision d'examen 1",
								link: "/modules/03-sql-base/06-examen-1",
							},
						],
					},
					{
						text: "Module 4 — Jointures et agrégations",
						collapsed: true,
						items: [
							{
								text: "Expressions régulières & fonctions textuelles",
								link: "/modules/04-jointures-agregations/01-expressions-regulieres",
							},
							{
								text: "Jointures de tables",
								link: "/modules/04-jointures-agregations/02-jointures",
							},
							{
								text: "Fonctions d'agrégation",
								link: "/modules/04-jointures-agregations/03-fonctions-agregation",
							},
							{
								text: "Group by & Having",
								link: "/modules/04-jointures-agregations/04-group-by-having",
							},
							{
								text: "Sous-requêtes corrélées",
								link: "/modules/04-jointures-agregations/05-sous-requetes-correlees",
							},
						],
					},
					{
						text: "Module 5 — DDL avancé",
						collapsed: true,
						items: [
							{
								text: "Alter Table",
								link: "/modules/05-ddl-avance/01-alter-table",
							},
							{
								text: "Cascade Delete / Update",
								link: "/modules/05-ddl-avance/02-cascade-delete-update",
							},
							{
								text: "Index de colonne",
								link: "/modules/05-ddl-avance/03-index-de-colonne",
							},
							{
								text: "Gestion des comptes & privilèges",
								link: "/modules/05-ddl-avance/04-gestion-de-comptes",
							},
							{
								text: "Hachage des mots de passe",
								link: "/modules/05-ddl-avance/05-hachage-mots-de-passe",
							},
							{
								text: "Révision — Examen 2",
								link: "/modules/05-ddl-avance/06-revision-examen-2",
							},
						],
					},
				],
			},
			{
				text: "Laboratoires",
				collapsed: false,
				items: [
					{ text: "Lab 01 — Installations", link: "/labs/lab01-installations" },
					{ text: "Lab 02 — Modélisation", link: "/labs/lab02-modelisation" },
					{ text: "Lab 03 — DDL", link: "/labs/lab03-ddl" },
					{ text: "Lab 04 — Requêtes select", link: "/labs/lab04-select" },
					{ text: "Lab 05 — Modification, opérateurs et sous-requêtes", link: "/labs/lab05-avance" },
					{ text: "Lab 06 — Jointures", link: "/labs/lab06-jointures" },
					{ text: "Lab 07 — Agrégations", link: "/labs/lab07-agregations" },
					{ text: "Lab 08 — DDL & maintenance", link: "/labs/lab08-ddl-maintenance" },
					{ text: "Lab 09 — Sécurité", link: "/labs/lab09-securite" },
				],
			},
		],

		search: {
			provider: "local",
		},
	},
}));

