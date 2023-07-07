# Programação e Administração de Banco de Dados
## Visões
Visões em banco de dados são objetos virtuais que representam uma visualização específica dos dados armazenados em uma ou mais tabelas. Uma visão é como uma tabela virtual que consiste em uma consulta armazenada, que é executada sempre que a visão é acessada. Elas são uma ferramenta poderosa para simplificar e personalizar o acesso aos dados, fornecendo uma camada de abstração sobre as tabelas subjacentes.

Aqui estão alguns pontos importantes sobre visões em banco de dados:
1. Definição: A definição de uma visão consiste em uma consulta SQL que define quais dados serão incluídos na visão e como eles serão representados. Essa consulta pode conter cláusulas de seleção, junção, filtragem agregação e ordenação, permitindo que a visão represetne apenas uma parte dos dados ou aplique transformações específicas.

2. Abstração: As visões fornecem uma camada de abstração sobre as tabelas subjacentes. Elas podem ocultas colunas desnecessárias, expor apenas as informações relevantes para determinados usuários ou fornecer uma visualização simplificada dos dados. Isso pode ajudar a proteger a integridade dos dados e melhorar a segurança, evitando que usuários acessem diretamente as tabelas subjacentes.

3. Simplificação do acesso aos dados: As visões podem simplificar as consultas aos dados, fornecendo consultas predefinidas e otimizadas. Em vez de escrever consultas complexas todas as vezes, os usuários podem simplesmente consultar a visão, que já encapsula a lógica necessária para recuperar os dados desejados. Isso também reduz a quantidade de código duplicado em diferentes partes do sistema.

4. Restrições de segurança: As visões podem ser usadas para impor restrições de segurança e controle de acesso aos dados. Por exemplo, uma visão pode ser configurada para filtrar dados sensíveis e exibir apenas informações não confidenciais para usuários comuns. Isso ajuda a proteger os dados confidenciais, limitando o acesso somente às informações necessárias para cada usuário ou grupo de usuários.

5. Atualizações limitadas: Embora seja possível atualizar uma visão em alguns SGBDs, a maioria das visões é apenas para leitura e não permite alterações nos dados subjacentes. Isso ocorre porque as visões geralmente envolvem consultas complexas e junções de várias tabelas, tornando difícil determinar como as atualizações devem ser refletidas nas tabelas originais.

### Exemplos
1. Criação de uma visão simples:
~~~
CREATE VIEW HighSalaryEmployees AS
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > 5000;
~~~
> Neste exemplo, uma visão chamada "HighSalaryEmployees" é criada com base em uma consulta na tabela "Employees". A visão retorna os nomes e salários dos funcionários cujos salários são maiores que 5000.

2. Criação de uma visão com junção de tabelas:
~~~
CREATE VIEW CustomerOrders AS
SELECT Customers.CustomerID, Customers.CustomerName, Orders.OrderID, Orders.OrderDate
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
~~~
> Este exemplo cria uma visão chamada "CustomerOrders" que combina dados das tabelas "Customers" e "Orders" usando uma junção. A visão retorna os IDs e nomes dos clientes juntamente com os IDs e datas dos pedidos correspondentes.

3. Criação de uma visão agragada:
~~~
CREATE VIEW TotalSalesByYear AS
SELECT YEAR(OrderDate) AS Year, SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY YEAR(OrderDate);
~~~
> Neste exemplo, a visão "TotalSalesByYear" é criada para calcular as vendas totais por ano com base na tabela "Orders". A visão usa a função YEAR() para extrair o ano da coluna "OrderDate" e, em seguida, agrupa os resultados por ano usando a cláusula GROUP BY.

4. Criação de uma visão com subconsulta:
~~~
CREATE VIEW ExpensiveProducts AS
SELECT ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);
~~~
> Este exemplo cria a visão "ExpensiveProducts" para exibir os nomes e preços dos produtos que têm um preço unitário superior à média dos preços unitários de todos os produtos na tabela "Products". A subconsulta é usada como um critério na cláusula WHERE da consulta da visão.
