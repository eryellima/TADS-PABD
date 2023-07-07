# Programação e Administração de Banco de Dados
## Programação de Banco de Dados
A programação no banco de dados refere-se à capacidade de escrever código ou scripts dentro do próprio banco de dados para realizar tarefas específicas. Isso permite a criação de procedimentos armazenados, funções, gatilhos e outras estruturas que podem ser executadas diretamente no banco de dados.

Aqui estão alguns conceitos importantes relacionados à programação no banco de dados:
1. Procedimentos armazenados: São blocos de código que são armazenados no banco de dadso e podem ser chamados e executados posteriormente. Eles geralmente são usados para realizar tarefas complexas ou repetitivas no banco de dados. Os procedimentos armazenados podem aceitar parâmetros de entradae retornar resultados.

2. Funções: São blocos de código que aceitam argumentos de entrada e retornam um valor. As funções podem ser usadas para realizar cálculos, manipular dados e retornar resultados específicos com base nos parâmetros fornecidos. Elas podem ser usadas em consultas SQL para transformar ou manipular os dados durante a recuperação.

3. Gatilhos (Triggers): São estruturas que são acionadas automaticamente quando ocorrem determinados eventos no banco de dados, como inserão, atualizaçãoou exclusão de dados em uma tabela. Os gatilhos permitemm executar um conjunto de instruções ou um procedimento armazenado em resposta a esses eventos. Eles são usados principalmente para impor regras integridade, registrar atividades ou realizar ações específicas em resposta a eventos do banco de dados.

4. Linguagens de programação específicas do banco de dados: Alguns sistemas de gerenciamento de banco de dados (SGBDs) oferecem suas próprias linguagens de programação para escrever código dentro do banco de dados. Por exemplo, o PL/SQL é a linguagem de programaçãousada no Oracle, enquanto o T-SQL é usado no Microsoft SQL Server. Essas linguagens fornecem  recursos adicionais para trabalhar com o banco de dados, como estruturas de controle de fluxo, manipulação de exceções e acesso a recursos específicos do banco de dados.

### Exemplos
1. Criação de uma tabela:
~~~
CREATE TABLE Employees (
  EmployeeID INT PRIMARY KEY,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Age INT,
  Salary DECIMAL(10, 2)
);
~~~
> Este exemplo cria uma tabela chamada "Employees" com colunas para ID do funcionário, primeiro nome, sobrenome, idade e salário.

2. Inserção de dados em uma tabela:
~~~
INSERT INTO Employees (EmployeeID, FirstName, LastName, Age, Salary)
VALUES (1, 'John', 'Doe', 30, 5000.00);
~~~
> Neste exemplo, um novo registro é inserido na tabela "Employees" com valores para cada coluna especificada.

3. Atualização de registros em uma tabela:
~~~
UPDATE Employees
SET Salary = Salary * 1.1
WHERE Age > 40;
~~~
> Esta consulta atualiza o salário de todos os funcionários com mais de 40 anos, aumentando-o em 10%.

4. Exclusão de registros em uma tabela:
~~~
DELETE FROM Employees
WHERE EmployeeID = 1;
~~~
> Neste exemplo, o registro do funcionário com ID 1 é excluído da tabela "Employees".

5. Consulta de dados de várias tabelas usando JOIN:
~~~
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID;
~~~
> Esta consulta retorna o nome do cliente e o ID do pedido para todos os pedidos correspondentes na tabela "Orders" com base na correspondência do ID do cliente nas tabelas "Customers" e "Orders".

6. Criação de uma visão (view):
~~~
CREATE VIEW HighSalaryEmployees AS
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > 5000;
~~~
> Neste exemplo, uma exibição chamada "HighSalaryEmployees" é criada, que retorna os nomes e salários dos funcionários cujos salários são maiores que 5000.

7. Criação de um procedimento armazenado:
~~~
CREATE PROCEDURE GetEmployeeByID
@EmployeeID INT
AS
BEGIN
  SELECT FirstName, LastName, Age
  FROM Employees
  WHERE EmployeeID = @EmployeeID;
END;
~~~
> Este exemplo cria um procedimento armazenado chamado "GetEmployeeByID" que aceita um parâmetro de entrada "@EmployeeID" e retorna o nome, sobrenome e idade do funcionário correspondente ao ID fornecido.

8. Criação de uma função escalar:
~~~
CREATE FUNCTION CalculateTotalSales
(
  @StartDate DATE,
  @EndDate DATE
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
  DECLARE @TotalSales DECIMAL(10, 2);
  SELECT @TotalSales = SUM(Quantity * UnitPrice)
  FROM Orders
  WHERE OrderDate BETWEEN @StartDate AND @EndDate;
  RETURN @TotalSales;
END;
~~~
> Neste exemplo, uma função escalar chamada "CalculateTotalSales" é criada, que calcula o total de vendas entre duas datas fornecidas como parâmetros de entrada.

9. Criação de um gatilho (trigger):
~~~
CREATE TRIGGER UpdateProductPrice
ON Products
AFTER UPDATE
AS
BEGIN
  IF UPDATE(UnitPrice)
  BEGIN
    -- Lógica de atualização adicional aqui
    PRINT 'O preço do produto foi atualizado!';
  END;
END;
~~~
> Este exemplo cria um gatilho chamado "UpdateProductPrice" que é acionado após uma atualização na tabela "Products". O gatilho verifica se a coluna "UnitPrice" foi atualizada e executa uma lógica adicional, neste caso, imprime uma mensagem.

10. Uso de transações:
~~~
BEGIN TRANSACTION;
INSERT INTO Customers (CustomerID, CustomerName)
VALUES ('C001', 'John Doe');
INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES ('O001', 'C001', GETDATE());
COMMIT;
~~~
> Neste exemplo, uma transação é iniciada com a declaração "BEGIN TRANSACTION". Em seguida, duas instruções de inserção são executadas para adicionar um novo cliente na tabela "Customers" e um novo pedido na tabela "Orders". Após as operações, a transação é confirmada usando "COMMIT". Se ocorrer algum erro ou problema, a transação pode ser revertida usando "ROLLBACK" para desfazer todas as alterações feitas durante a transação.
