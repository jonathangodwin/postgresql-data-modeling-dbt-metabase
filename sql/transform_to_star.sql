-- Peuplement de la base de données

-- Categories de produits
INSERT INTO dim_category (category_name)
SELECT DISTINCT category
FROM staging_orders
ON CONFLICT (category_name) DO NOTHING;

-- Produits en les reliant aux categories
INSERT INTO dim_product (product_id, product_name, price, category_id)
SELECT 
  DISTINCT s.product_id,
  s.product_name,
  s.price / s.quantity, 
  c.category_id
FROM staging_orders s
JOIN dim_category c ON s.category = c.category_name
ON CONFLICT (product_id) DO NOTHING;

-- Customers 
INSERT INTO dim_customer (customer_id)
SELECT DISTINCT customer_id
FROM staging_orders
ON CONFLICT (customer_id) DO NOTHING;


-- Nos orders enfin
INSERT INTO fact_orders (order_id, customer_id, product_id, quantity, order_date)
SELECT
  order_id,
  customer_id,
  product_id,
  quantity,
  order_date
FROM staging_orders
ON CONFLICT (order_id) DO NOTHING;