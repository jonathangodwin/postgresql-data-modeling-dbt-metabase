-- Vérifie qu'il n'y a pas de doublons sur order_id
SELECT order_id, COUNT(*)
FROM fact_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Vérifie que chaque product_id dans fact_orders existe bien dans dim_product
SELECT f.product_id
FROM fact_orders f
LEFT JOIN dim_product p ON f.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Vérifie qu'aucune commande n’a de customer_id manquant
SELECT *
FROM fact_orders
WHERE customer_id IS NULL;
