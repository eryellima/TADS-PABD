-- Exercicio 2609
SELECT c.name AS category, SUM(p.amount) AS quantity
FROM Categories c
INNER JOIN Products p ON c.id = p.id_categories
GROUP BY c.name

-- Exercício 2617
SELECT p.name as product_name, pr.name as provider_name
FROM Products p
JOIN Providers pr ON p.id_providers = pr.id
WHERE pr.name = 'Ajax SA';

-- Exercício 2618
SELECT Products.name AS 'Produto', Providers.name AS 'Fornecedor', Categories.name AS 'Categoria'
FROM Products
JOIN Providers ON Providers.id = Products.id_providers
JOIN Categories ON Categories.id = Products.id_categories
WHERE Providers.name = 'Sansul SA' AND Categories.name = 'Super Luxury';

-- Exercício 2619
SELECT Products.name as 'Product Name', Providers.name as 'Provider Name', price as 'Price'
FROM Products
INNER JOIN Providers ON Products.id_providers = Providers.id
INNER JOIN Categories ON Products.id_categories = Categories.id
WHERE Categories.name = 'Super Luxury' AND price > 1000

-- Exercício 2621
SELECT p.name AS 'Nome do Produto', pr.name AS 'Nome do Fornecedor', p.amount AS 'Quantidade em Estoque'
FROM Products p
INNER JOIN Providers pr ON p.id_providers = pr.id
WHERE p.amount BETWEEN 10 AND 20 AND pr.name LIKE 'P%'

-- Exercícioo 2623
SELECT p.product_name, c.category_name
FROM products p
INNER JOIN categories c ON p.category_id = c.category_id
WHERE p.quantity > 100 AND p.category_id IN (1, 2, 3, 6, 9)
ORDER BY c.category_id ASC;
