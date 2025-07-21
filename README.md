# 🧱 Data Modeling & Analytics Pipeline — Snowflake Schema (PostgreSQL, dbt, Metabase)

Ce projet présente la construction d'un pipeline analytique complet autour de la modélisation en **snowflake schema**, incluant :

- 💾 Chargement de données depuis un fichier CSV
- 🧠 Transformation SQL manuelle puis automatisée avec **dbt**
- ✅ Tests manuels + automatisés de qualité des données
- 📊 Visualisation avec **Metabase**
- ☁️ Export facultatif vers **Snowflake** (entrepôt cloud)

---

## 📁 Structure du projet

├── data/ # Données sources (CSV)

├── dbt_project/ # Projet dbt avec modèles et tests

├── diagrams/ # Schéma du modèle relationnel (ERD)

├── metabase/ # Dashboards & visuels

├── snowflake/ # Scripts Snowflake (optionnel)

├── sql/ # SQL brut : création, transformation, tests

└── README.md # Ce fichier


---

## 📌 Cas d’usage

Le jeu de données représente des commandes e-commerce avec les colonnes suivantes :

- `order_id`, `customer_id`, `product_id`, `product_name`, `category`, `price`, `quantity`, `order_date`

---

## 🧱 Étapes du pipeline

### 1. 🔄 Chargement initial (PostgreSQL)

- Création d'une table `staging_orders`
- Import du fichier `ecommerce_orders.csv` avec `\copy` ou Airbyte
- Fichier : [`sql/load_staging.sql`](sql/load_staging.sql)

---

### 2. 🧊 Modélisation en **Snowflake Schema**

- Tables de dimensions :
  - `dim_customer`
  - `dim_category`
  - `dim_product` (référant `dim_category`)
- Table de faits :
  - `fact_orders`

- Fichiers : [`sql/create_tables.sql`](sql/create_tables.sql), [`sql/transform_to_star.sql`](sql/transform_to_star.sql)

---

### 3. 🧪 Tests qualité des données

#### ✔️ Tests manuels (`sql/tests_manual.sql`)

- Unicité de `order_id`
- Clés étrangères valides (`product_id`, `customer_id`)
- Champs obligatoires non vides

#### ⚙️ Tests automatisés avec dbt

- `unique`, `not_null`, `relationships` définis dans le fichier `schema.yml`

---

### 4. ⚙️ Transformation automatisée avec **dbt**

- Modèles `staging/`, `dims/`, `facts/` organisés proprement
- Configuration dans `dbt_project/dbt_project.yml`
- Exécution :
  ```bash
  dbt run
  dbt test
