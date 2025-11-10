# 🛡️ Mise en place de politiques de sécurité avec Open Policy Agent (OPA)

## 📘 Description

Ce projet démontre comment **intégrer la sécurité dès les premières étapes du cycle de développement logiciel** (approche **DevSecOps**) en utilisant **Open Policy Agent (OPA)** et **Conftest**.  
L’objectif principal est d’analyser automatiquement les **Dockerfiles** dans un pipeline **CI/CD** afin de détecter les mauvaises pratiques et de **prévenir le déploiement de configurations non sécurisées**.

Les règles de sécurité sont écrites en **langage Rego** et sont exécutées automatiquement dans un **workflow GitHub Actions**.

---

## 🚀 Fonctionnalités principales

- 🔍 **Analyse automatique des Dockerfiles** via Conftest  
- ⚙️ **Politiques de sécurité OPA** pour :
  - Interdire l’utilisation du tag `latest`
  - Empêcher l’exécution en tant qu’utilisateur `root`
  - Obliger la présence d’une instruction `HEALTHCHECK`
  - Interdire `ADD` au profit de `COPY`
- 🧩 **Intégration CI/CD** avec GitHub Actions
- ✅ **Blocage automatique** des Dockerfiles non conformes

---

## 🏗️ Architecture du projet

```
.
├── Dockerfile
├── opa/
│   └── policy.rego          # Règles de sécurité OPA
├── .github/
│   └── workflows/
│       └── opa-docker-check.yml   # Pipeline GitHub Actions
└── README.md
```

---

## ⚙️ Installation et exécution locale

### 1. Installer Conftest

```bash
wget https://github.com/open-policy-agent/conftest/releases/download/v0.50.0/conftest_0.50.0_Linux_x86_64.tar.gz
tar xzf conftest_0.50.0_Linux_x86_64.tar.gz
sudo mv conftest /usr/local/bin/
conftest --version
```

### 2. Tester un Dockerfile manuellement

```bash
conftest test Dockerfile -p ./opa/policy.rego
```

Si le Dockerfile enfreint une règle, Conftest renverra un message d’erreur explicite.

---

## 🔄 Intégration CI/CD (GitHub Actions)

Le pipeline CI/CD s’exécute à chaque **push** ou **pull request**.  
Voici un extrait du fichier `.github/workflows/opa-docker-check.yml` :

```yaml
name: Dockerfile Security Check

on: [push, pull_request]

jobs:
  conftest-check:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Install Conftest
        run: |
          wget https://github.com/open-policy-agent/conftest/releases/download/v0.50.0/conftest_0.50.0_Linux_x86_64.tar.gz
          tar xzf conftest_0.50.0_Linux_x86_64.tar.gz
          sudo mv conftest /usr/local/bin/

      - name: Evaluate Dockerfile against policies
        run: |
          conftest test Dockerfile -p ./opa/policy.rego --no-color --all-namespaces
```

---

## 🧪 Exemple de résultats

### ✅ Dockerfile conforme
Le pipeline passe avec succès :

```
PASS - Dockerfile - All checks passed
```

### ❌ Dockerfile non conforme
Le pipeline échoue :

```
FAIL - Dockerfile - Container should not run as root user.
FAIL - Dockerfile - Avoid using 'latest' tag in FROM instruction.
```

---

## 📈 Résultats et bénéfices

- **Détection rapide** des erreurs de sécurité avant déploiement  
- **Automatisation** complète des vérifications  
- **Amélioration des pratiques DevSecOps** au sein du cycle CI/CD  
- **Réduction des risques** liés à des configurations vulnérables

---

## 🧰 Technologies utilisées

- **Open Policy Agent (OPA)** – moteur de politique open source  
- **Conftest** – outil de test de fichiers de configuration  
- **GitHub Actions** – pipeline CI/CD  
- **Docker** – conteneurisation d’applications  
- **Rego** – langage déclaratif pour OPA  

---

## 👩‍💻 Auteur

**Zineb SAIDI**  
Université Ibn Zohr – Master Ingénierie Logicielle  
Année universitaire **2024/2025**