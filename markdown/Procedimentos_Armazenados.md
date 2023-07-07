# Programação e Administração de Banco de Dados
## Procedimentos Armazenados
Procedimentos armazenados (stored procedures) são blocos de código nomeados e armazenados em um banco de dados. Eles contêm instruções SQL e lógica de programação que podem ser chamadas e executadas posteriormente. Os procedimentos armazenados são uma forma de programação no banco de dados, permitindo executar tarefas complexas, repetitivas ou específicas diretamente no banco de dados.

Aqui estão algumas características e benefícios dos procedimentos armazenados:
1. Modularidade: Os procedimentos armazenados permitem agrupar um conjunto de instruções relacionadas em uma unidade lógica. Isso facilita a manutenção e a reutilização do código, pois eles podem ser chamados de diferentes partes do sistema, evitando repetição de código.

2. Melhor desempenho: Uma vez que os procedimentos armazenados são armazenados no banco de dados, eles são compilados e otimizados. Isso pode resultar em u melhor desempenho em comparação com a eecução de consutas SQL diretamente de uma aplicação, pois o banco de dados pode armazenar planos de execução otimizados para os procedimentos.

3. Segurança: Os procedimentos armazenados podem ser usados para restringir o acesso direto às tabelas e fornecer uma interface controlada para acessar e manipular os dados.  Os procedimentos armazenados podem ser configurados com permissões específicas, permitindo que os usuários executem determinadas operações sem conceder acesso direto às tabelas subjacentes.

4. Transações e atomicidade: Os procedimentos armazenados podem ser executados dentro de uma transação, permitindo que um conjunto de operações seja tratado como uma unidade atîmica. Isso garante que, se ocorrer algum erro durante a execução do procedimento, todas as alterações feitas até aquele ponto possam ser revertidas, mantendo a consistência dos dados.

5. Encapsulamento de Lógica de Negócios: Os procedimentos armazenados podem conter lógica de negócios complexa que manipula e processa os dados no banco facilitando a manutenção e a alteração da lógica sem afetar diretamente a aplicação que chama o procedimento.

### Exemplos
1. Procedimento armazenado simples:
~~~
CREATE PROCEDURE GetCustomers
AS
BEGIN
  SELECT * FROM Customers;
END;
~~~
> Neste exemplo, um procedimento armazenado chamado "GetCustomers" é criado para recuperar todos os clientes da tabela "Customers".

2. Procedimentos armazenados com parâmetros:
~~~
CREATE PROCEDURE GetOrdersByCustomer
@CustomerID INT
AS
BEGIN
  SELECT * FROM Orders WHERE CustomerID = @CustomerID;
END;
~~~
> Este exemplo define um procedimento armazenado chamado "GetOrdersByCustomer" que aceita um parâmetro de entrada "@CustomerID" para recuperar os pedidos correspondentes a um determinado ID de cliente.

3. Procedimento armazenado com parâmetro de saída:
~~~
CREATE PROCEDURE GetOrderCountByCustomer
@CustomerID INT,
@OrderCount INT OUTPUT
AS
BEGIN
  SELECT @OrderCount = COUNT(*) FROM Orders WHERE CustomerID = @CustomerID;
END;
~~~
> Neste exemplo, o procedimento armazenado "GetOrderCountByCustomer" recebe um parâmetro de entrada "@CustomerID" e um parâmetro de saída "@OrderCount". O procedimento armazenado conta o número de pedidos para um cliente específico e atribui o valor ao parâmetro de saída.

4. Procedimento armazenado com lógica condicional:
~~~
CREATE PROCEDURE UpdateOrderStatus
@OrderID INT,
@Status VARCHAR(50)
AS
BEGIN
  IF @Status = 'Shipped'
  BEGIN
    UPDATE Orders SET OrderStatus = @Status WHERE OrderID = @OrderID;
    PRINT 'O status do pedido foi atualizado para Shipped.';
  END
  ELSE IF @Status = 'Cancelled'
  BEGIN
    UPDATE Orders SET OrderStatus = @Status WHERE OrderID = @OrderID;
    PRINT 'O pedido foi cancelado.';
  END
  ELSE
  BEGIN
    PRINT 'Status inválido.';
  END;
END;
~~~
> Neste exemplo, o procedimento armazenado "UpdateOrderStatus" recebe um ID de pedido e um status como parâmetros de entrada. Dependendo do status fornecido, o procedimento armazenado atualiza o status do pedido na tabela "Orders" e imprime mensagens correspondentes com base na lógica condicional.

5. Procedimento armazenado com instruções de controle de fluxo:
~~~
CREATE PROCEDURE GetOrderDetails
@OrderID INT
AS
BEGIN
  IF EXISTS (SELECT * FROM Orders WHERE OrderID = @OrderID)
  BEGIN
    SELECT * FROM OrderDetails WHERE OrderID = @OrderID;
  END
  ELSE
  BEGIN
    PRINT 'O pedido especificado não existe.';
  END;
END;
~~~
> Neste exemplo, o procedimento armazenado "GetOrderDetails" recebe um ID de pedido como parâmetro de entrada. O procedimento armazenado verifica se o pedido existe na tabela "Orders" e, em caso afirmativo, retorna os detalhes do pedido da tabela "OrderDetails". Se o pedido não existir, uma mensagem é impressa.

6. Procedimento armazenado com manipulação de transações:
~~~
CREATE PROCEDURE PlaceOrder
@CustomerID INT,
@ProductID INT,
@Quantity INT
AS
BEGIN
  BEGIN TRANSACTION;
  
  INSERT INTO Orders (CustomerID, OrderDate) VALUES (@CustomerID, GETDATE());
  DECLARE @OrderID INT = SCOPE_IDENTITY();
  
  INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES (@OrderID, @ProductID, @Quantity);
  
  UPDATE Products SET UnitsInStock = UnitsInStock - @Quantity WHERE ProductID = @ProductID;
  
  COMMIT;
END;
~~~
> Neste exemplo, o procedimento armazenado "PlaceOrder" recebe um ID de cliente, um ID de produto e uma quantidade como parâmetros de entrada. O procedimento armazenado executa uma série de operações, incluindo a inserção de um novo pedido na tabela "Orders", a obtenção do ID do pedido inserido, a inserção de detalhes do pedido na tabela "OrderDetails" e a atualização do estoque do produto na tabela "Products". As operações são envoltas em uma transação para garantir que todas as alterações sejam aplicadas com êxito ou revertidas em caso de erro.

7. Procedimento armazenado com tratamento de exceções:
~~~
CREATE PROCEDURE DeleteCustomer
@CustomerID INT
AS
BEGIN
  BEGIN TRY
    DELETE FROM Customers WHERE CustomerID = @CustomerID;
  END TRY
  BEGIN CATCH
    PRINT 'Ocorreu um erro ao excluir o cliente.';
    PRINT ERROR_MESSAGE();
  END CATCH;
END;
~~~
> Neste exemplo, o procedimento armazenado "DeleteCustomer" recebe um ID de cliente como parâmetro de entrada. O procedimento armazenado tenta excluir o cliente da tabela "Customers". Se ocorrer um erro durante a operação de exclusão, o bloco CATCH é executado, onde uma mensagem de erro é impressa, juntamente com a descrição do erro retornada pela função ERROR_MESSAGE().
