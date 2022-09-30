# Script de recalcul du calque de plantabilité

Ces scripts ont pour objectif de calculer les indices de plantabilité sur l'ensemble du territoire de la Métropole de Lyon.

## Installation

* Installez **Python 3.8.10** (version recommandée)
* Clonez ce projet sur votre instance
```bash
git clone https://forge.grandlyon.com/erasme/script-recalcul-calque.git
```
* Téléchargez les fichiers source de données via l'adresse : [https://documents.exo-dev.fr/source_file_data_calque_lyon_2022.7z](https://documents.exo-dev.fr/source_file_data_calque_lyon_2022.7z)
* Copiez ces fichiers source dans le dossier `file_data/` à la racine du projet
* Créez et configurez le fichier `.env` à partir du fichier `.env.example` (Cf. Configuration avancée)
```bash
cp .env.example .env
nano .env
```
* Installez les dépendances sur votre environnement Python
```bash
pip install -r requirements.txt
```
<i>Certains packages étant difficilement installables sur Windows, il est parfois nécessaire de passer par pipwin...</i>

* Lancer une première fois le script pour afficher la documentation
```bash
python main.py
```

**Bravo ! Vous êtes désormais prêt à lancer un nouveau calcul du calque de plantabilité !** 🎉

## Utilisation

La documentation du script vous aidera à comprendre les arguments à passer pour lancer chaque étape du calcul :

```bash
$ python main.py help

Args:
  initCommunes                                        Insert Communes in database from a geoJSON file path (with geometry and insee column)
  initGrid <gridSize: int, inseeCode: int>            Generate with the size defined and insert Grid in database merged from a bounding box
                                                      Can be launch on certain "communes" with one <inseeCode> or in all territory by default (no parameter)
  initDatas                                           Make treatments on the datas from informations in metadatas table
  computeFactors <inseeCode: int>                     Compute the factors area on each tile with database informations. 
                                                      Can be launch on certain "communes" with one <inseeCode> or in all territory by default (no parameter)
  computeIndices                                      Compute the plantability indices on each tile with database informations. 
  computeAll <gridSize: int, listInseeCode: int>      Generate all the plantability layer (launch all previous steps). 
                                                      List of inseeCode must be separated with comma (,) and without space (e.g. python main.py 5 69266,69388,69256) 
                                                      but you can launch treatments for only one commune (e.g. python main.py 5 69266)
  help                                                Show this documentation
```

L'ordre complet de lancement des étapes (effectué avec `computeAll`) est le suivant :

```bash
initCommunes
initGrid (30 mètres par défaut et sur toutes les communes)
initDatas
computeFactors (sur toutes les communes)
computeIndices (sur toutes les communes)
```

<i>Si toutes ces étapes se sont bien déroulées, c'est que les données sont désormais prêtes à être exploitée au travers d'un serveur cartographique (GeoServer par exemple).</i>

<i>Pour cela, il faudra configurer une nouvelle couche sur la table `tiles` de la base de donnée. (Cf. Documentation > Modèle conceptuel de la base de données)</i>

## Configuration avancée

* Détail de configuration des attributs du fichier .env
```bash
# DB settings
DB_HOST="XXXXXXXXXXXXXX"      # Nom de domaine ou adresse IP de connexion à la base de données
DB_PORT=5432                  # Port de connexion à la base de données
DB_USER="XXXXXXXXXXXXXX"      # Nom d'utilisateur de connexion à la base de données
DB_PWD="XXXXXXXXXXXXXX"       # Mot de passe de connexion à la base de données
DB_NAME="XXXXXXXXXXXXXX"      # Nom de la base de données (exemple : calque_planta)
DB_SCHEMA="XXXXXXXXXXXXXX"    # Schéma PostgreSQL dans lequel se trouve la base de données
# Python settings
PYTHON_LAUNCH="python"        # Commande bash utilisée pour le lancement des sous scripts Python (peut être remplacé par python3 si nécessaire)
# Others settings
TARGET_PROJ="EPSG:2154"       # Projection cible utilisée pour réaliser les traitements de données
REMOVE_TEMP_FILE=False        # Permet de supprimer les fichiers temporaires générés lors des traitements de données
SKIP_EXISTING_DATA=True       # Permet de passer automatiquement à l'étape suivante lorsque la donnée traitée existe déjà en base
ENABLE_TRUNCATE=False         # Permet de supprimer automatiquement la donnée lors de son traitement si elle existe déjà en base
```

## Documentation complète du projet

L'architecture logicielle cible pour le fonctionnement du projet utilise les briques technologiques suivante : 
* Une instance de calcul du calque de plantabilité (Serveur Linux / Python 3.8.X)
* Une base de données PostgreSQL (l'extension PostGIS est un plus)
* Un serveur cartographique (GeoServer par exemple)
* Une plateforme web de visualisation

Dans le cadre de notre expérimentation, nous avons fait le choix de "containeriser" l'instance de calcul du calque, ainsi que le front et back de la plateforme web.

Vous trouverez le détail de ce projet sur les documents suivants :
* [Notice d'utilisation du calque](https://documents.exo-dev.fr/notice_utilisation_calque_plantabilite_lyon_V1.pdf)
* [Documentation générale du projet]()
* [Documentation technique du projet]()
* [Modèle logique de données (MLD)](https://documents.exo-dev.fr/MLD_calque_plantabilite_lyon.png)

## Crédits

* Author: Romain MATIAS
* Copyright: Copyright 2022, EXO-DEV x ERASME, Métropole de Lyon
* Description: Script de création d'un calque de plantabilité pour la Métropole de Lyon
* Credits: Romain MATIAS, Natacha SALMERON, Anthony ANGELOT
* Date: 06/07/2022
* License: MIT
* Version: 1.0.0
* Maintainer: Romain MATIAS
* Email: contact@exo-dev.fr ou info@erasme.org
* Status: Expérimentation

## TODO : Test and Deploy

Use the built-in continuous integration in GitLab.

- [ ] [Get started with GitLab CI/CD](https://docs.gitlab.com/ee/ci/quick_start/index.html)
- [ ] [Analyze your code for known vulnerabilities with Static Application Security Testing(SAST)](https://docs.gitlab.com/ee/user/application_security/sast/)
- [ ] [Deploy to Kubernetes, Amazon EC2, or Amazon ECS using Auto Deploy](https://docs.gitlab.com/ee/topics/autodevops/requirements.html)
- [ ] [Use pull-based deployments for improved Kubernetes management](https://docs.gitlab.com/ee/user/clusters/agent/)
- [ ] [Set up protected environments](https://docs.gitlab.com/ee/ci/environments/protected_environments.html)

