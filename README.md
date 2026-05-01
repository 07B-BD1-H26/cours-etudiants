# 420-07B-FX — Introduction aux bases de données

Notes de cours disponibles en ligne via GitHub Pages.

---

## Consulter le site en ligne

**[https://[nom-utilisateur].github.io/cours-etudiants/](https://[nom-utilisateur].github.io/cours-etudiants/)**

---

## Lancer le site localement

### Prérequis

- [Node.js](https://nodejs.org/) v18 ou plus récent (inclut npm)

### Installation

```bash
npm install
```

### Démarrer le serveur de développement

```bash
npm run docs:dev
```

Le site est accessible à `http://localhost:5173/cours-etudiants/`.

Les modifications aux fichiers `.md` sont reflétées immédiatement dans le navigateur.

### Compiler et prévisualiser le site

```bash
npm run docs:build
npm run docs:preview
```

Le site compilé est généré dans `docs/.vitepress/dist/` et accessible à `http://localhost:4173/cours-etudiants/`.
