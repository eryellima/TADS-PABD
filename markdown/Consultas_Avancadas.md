# Programação e Administração de Banco de Dados
## Consultas Avançadas
As consultas avançadas em banco de dados referem-se a consultas complexas e poderosas que permitem recuperar informações de um banco de dados de maneira mais precisa e eficiente. Essas consultas vão além das consultas básicas, como seleção, inserção, atualização e exclusão de dados.

Aqui estão algumas técnicas comuns usadas em consultas avançadas:
1. Junção de tabelas: Permite combinar dados de duas ou mais tabelas com base em colunas relacionadas. A junção pode ser feita usando operadores como INNER JOIN, LEFT JOIN, RIGHT JOIN ou FULL JOIN, permitindo extrair informações relacionadas de várias tabelas em uma únicas consulta.

2. Subconsultas: São consultas aninhadas dentro de uma consulta principal. As subconsultas podem ser usadas para filtrar resultados com base em crite´rios específicos. Por exemplo, você pode usar uma subconsulta para obter todos os clientes que fizeram compras acima de um determinado valor.

3. Fuções agregadas: São funções que realizam cálculos em conjuntos de dados, geralmente retornando um único valor. Exemplos de funções agregadas incluem SUM (soma), AVG (média), COUNT (contagem), MAX (valor máximo), MIN ( valor mínimo). Essas funções são úteis para obter infromaç~es resumidas sobre os dados como o total de vendar ou a média de idade dos clientes.

4. Cláusulas GROUP BY e HAVING: A cláusula GROUP BY permite agrupar os resultaados da consulta com base em uma ou mais colunas. Por exemplo, você pode agrupar vendas por mês ou agrupar produtos por categoria. Já a cláusula HAVING é usada para filtrar grupos com base em condições específicas, como exibir apenas os grupos com um determinado total de vendas.

5. Ordenação de resultados: A cláusula ORDER By permite ordenar os resultados da consulta com base em uma ou mais colunas, em ordem ascendente ou desdente. Isso é útil para classificar os resultados de acordo com critérios específico, como ordenar produtos por preço ou listar clientes em ordem alfabética.

### Exemplos
1. Consulta de junção (JOIN):
~~~
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
~~~
> Esta consulta retorna o nome do cliente e o ID do pedido para todos os pedidos correspondentes na tabela "Orders" com base na correspondência do ID do cliente nas tabelas "Customers" e "Orders".

2. Consulta de subconsulta:
~~~
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);
~~~
> Neste exemplo, a subconsulta calcula a média dos preços unitários dos produtos e a consulta principal retorna o nome do produto e o preço unitário para todos os produtos com preço unitário superior à média.

3. Consulta com cláusula GROUP BY:
~~~
SELECT CategoryID, AVG(UnitPrice) AS AveragePrice
FROM Products
GROUP BY CategoryID;
~~~
> Essa consulta calcula a média dos preços unitários dos produtos para cada categoria de produto com base no ID da categoria. A cláusula GROUP BY agrupa os registros com base na coluna "CategoryID".

4. Consulta com cláusula HAVING:
~~~
SELECT CategoryID, AVG(UnitPrice) AS AveragePrice
FROM Products
GROUP BY CategoryID
HAVING AVG(UnitPrice) > 50;
~~~
> Neste exemplo, a cláusula HAVING é usada para filtrar os resultados da consulta com base na média do preço unitário. A consulta retorna apenas as categorias de produtos cuja média do preço unitário é superior a 50.

5. Consulta com função de agregação e JOIN:
~~~
SELECT Customers.CustomerName, COUNT(Orders.OrderID) AS OrderCount
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
GROUP BY Customers.CustomerName;
~~~
> Esta consulta retorna o nome do cliente e o número de pedidos para cada cliente na tabela "Customers". A função COUNT é usada para contar o número de pedidos correspondentes na tabela "Orders".

6. Consulta com cláusula ORDER BY:
~~~
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC;
~~~
> Esta consulta retorna o nome do produto e o preço unitário de todos os produtos na tabela "Products", ordenados em ordem decrescente com base no preço unitário.

7. Consulta com cláusula DISTINCT:
~~~
SELECT DISTINCT Country
FROM Customers;
~~~
> Neste exemplo, a consulta retorna uma lista de países únicos presentes na coluna "Country" da tabela "Customers", eliminando duplicatas.

8. Consulta com cláusula LIKE:
~~~
SELECT ProductName
FROM Products
WHERE ProductName LIKE 'Chai%';
~~~
> Esta consulta retorna o nome do produto da tabela "Products" em que o nome começa com "Chai". O operador "LIKE" é usado com o caractere curinga "%" para representar qualquer conjunto de caracteres.

9. Consulta com cláusula IN:
~~~
SELECT OrderID, CustomerID
FROM Orders
WHERE CustomerID IN ('VINET', 'HANAR', 'LONEP');
~~~
> Neste exemplo, a consulta retorna o ID do pedido e o ID do cliente da tabela "Orders" para os pedidos cujos IDs dos clientes estão na lista especificada.

10. Consulta com cláusula BETWEEN:
~~~
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 10 AND 20;
~~~
> Esta consulta retorna o nome do produto e o preço unitário da tabela "Products" para os produtos cujos preços unitários estão entre 10 e 20.
