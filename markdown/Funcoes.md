# Programação e Administração de Banco de Dados
## Funções
Funções em bancos de dados são blocos de código que recebem argumentos de entrada, executam uma lógica específica e retornam um valor. Elas são usadas para realizar cálculos, manipular dados e executar operações complexas dentro do banco de dados. As funções podem ser usadas em consultas SQL, expressões e até mesmo em outros objetos do banco de dados, como procedimentos armazenados ou gatilhos.

Aqui estão algumas informações importantes sobre funções em banco de dados:
1. Definição: As funções em banco de dados têm uma definição que especifica o nome da função, os argumentos de entrada, o tipo de retorno e o bloco de código que será executado. O código dentro da função pode incluir instruções SQL, operações matemáticas, manipulação de strings e outras lógicas personalizadas.

2. Tipos de retorno: As funções podem retornar diferentes tipos de dados, dependendo da lógica e dos cálculos realizados. Por exemplo, uma função pode retornar um valor numérico, uma cadeia de caracteres, uma data, um conjunto de resultados ou até mesmo uma tabela. O tipo de retorno deve ser especificado na definição da função.

3. Parâmetros de entrada: As funções podem receber um ou mais parâmetros de entrada, que são os valores passados quando a função é chamada. Esses parâmetros podem ser usados dentro da função para executar cálculos ou filtrar os resultados. As funções podem ter parâmetros obrigatórios ou opcionais, dependendo da definição.

4. Reutilização: As funções podem ser reutilizadas em várias partes do banco de dados. Elas podem ser usadas em consultas SQL para executar cálculos ou transformações em tempo real, em expressões para obter valores calculados ou até mesmo em outros objetos do banco de dados, como procedimentos armazenados ou gatilhos.

5. Funções agregadas: Além das funções regulares, os bancos de dados geralmente fornecem funções agregadas, como SUM, AVG, COUNT, MAX e MIN. Essas funções são usadas para realizar cálculos em conjuntos de dados, geralmente retornando um único valor. Por exemplo, a função SUM pode ser usada para calcular a soma total de uma coluna numérica.

### Exemplos
1. Função escalar simples:
~~~
CREATE FUNCTION GetFullName (@FirstName VARCHAR(50), @LastName VARCHAR(50))
RETURNS VARCHAR(101)
AS
BEGIN
  DECLARE @FullName VARCHAR(101);
  SET @FullName = @FirstName + ' ' + @LastName;
  RETURN @FullName;
END;
~~~
> Neste exemplo, uma função escalar chamada "GetFullName" é criada para concatenar o primeiro nome e o sobrenome em um nome completo. A função aceita dois parâmetros de entrada e retorna uma string contendo o nome completo.

2. Função escalar com lógica condicional:
~~~
CREATE FUNCTION GetDiscountedPrice (@Price DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
  DECLARE @DiscountedPrice DECIMAL(10, 2);
  IF @Price > 100
    SET @DiscountedPrice = @Price * 0.9;
  ELSE
    SET @DiscountedPrice = @Price * 0.95;
  RETURN @DiscountedPrice;
END;
~~~
> Neste exemplo, a função escalar "GetDiscountedPrice" é criada para calcular o preço com desconto com base no preço de entrada. Se o preço for maior que 100, um desconto de 10% é aplicado. Caso contrário, um desconto de 5% é aplicado.

3. Função de tabela:
~~~
CREATE FUNCTION GetCustomersByCountry (@Country VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
  SELECT * FROM Customers WHERE Country = @Country
);
~~~
> Neste exemplo, uma função de tabela chamada "GetCustomersByCountry" é criada para retornar os clientes com base no país fornecido como parâmetro de entrada. A função retorna uma tabela resultante da consulta.

4. Função agragada:
~~~
CREATE FUNCTION GetTotalSales (@StartDate DATE, @EndDate DATE)
RETURNS DECIMAL(10, 2)
AS
BEGIN
  DECLARE @TotalSales DECIMAL(10, 2);
  SELECT @TotalSales = SUM(TotalAmount) FROM Sales WHERE SaleDate BETWEEN @StartDate AND @EndDate;
  RETURN @TotalSales;
END;
~~~
> Neste exemplo, a função agregada "GetTotalSales" é criada para calcular as vendas totais em um determinado intervalo de datas. A função aceita duas datas como parâmetros de entrada e retorna o valor total das vendas no período especificado.
