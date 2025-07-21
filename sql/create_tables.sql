-- Fichier de données CSV chargé de façon brute

CREATE TABLE IF NOT EXISTS staging_orders (
  order_id INT,
  customer_id INT,
  product_id INT,
  product_name TEXT,
  category TEXT,
  price NUMERIC,
  quantity INT,
  order_date DATE
);

-- Snowflake schema pour mes données 

CREATE TABLE dim_customer (
  customer_id INT PRIMARY KEY
  -- autres colonnes client s’il y en a, sinon au moins l’ID
);

CREATE TABLE dim_category (
  category_id SERIAL PRIMARY KEY,
  category_name TEXT UNIQUE
);

CREATE TABLE dim_product (
  product_id INT PRIMARY KEY,
  product_name TEXT,
  price NUMERIC,
  category_id INT REFERENCES dim_category(category_id)
);

CREATE TABLE fact_orders (
  order_id INT PRIMARY KEY,
  customer_id INT REFERENCES dim_customer(customer_id),
  product_id INT REFERENCES dim_product(product_id),
  quantity INT,
  order_date DATE
);
