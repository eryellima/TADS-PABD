# Programação e Administração de Banco de Dados
## Transações
Transações em bancos de dados são unidades de trabalho lógicas que envolvem uma ou mais operações de banco de dados. Elas são usadas para garantir que um conjunto de operações seja executado como uma unidade atômica, ou seja, todas as operações são executadas com sucesso ou nenhuma delas é executada, mantendo a consistência e a integridade dos dados.

Aqui estão algumas informações importantes sobre transações em bancos de dados:
1. Atomicidade: A atomicidade é uma propriedade fundamental das transações. Ela garante que todas as operações em uma transação sejam executadas com sucesso ou que nenhuma delas seja executada. Se ocorrer um erro durante a execução de qualquer operação dentro da transação, todas as alterações feitas até aquele ponto são revertidas, restaurando o estado anterior dos dados.

2. Consistência: A consistência garante que os dados estejam em um estado válido antes e após a execução da transação. Isso significa que as operações dentro da transação devem preservar as regras de integridade referencial, restrições de chave estrangeira e quaisquer outras restrições definidas no banco de dados. Se uma operação violar essas restrições, a transação é revertida.

3. Isolamento: O isolamento controla como as transações se comportam e interagem entre si. Ele garante que uma transação em execução seja isolada das outras transações concorrentes até ser concluída (commit) ou revertida (rollback). O isolamento evita que os efeitos de uma transação interfiram ou sejam afetados pelas operações de outras transações em execução simultânea.

4. Durabilidade: A durabilidade garante que as alterações feitas em uma transação bem-sucedida sejam permanentes, mesmo em caso de falha do sistema, queda de energia ou reinicialização do banco de dados. As alterações são gravadas em um meio persistente, geralmente em disco, para que possam ser recuperadas mesmo após uma interrupção.

5. Controle de transações: Os bancos de dados fornecem mecanismos para iniciar, controlar e finalizar transações. Isso inclui a declaração explícita de transações, como BEGIN TRANSACTION, COMMIT e ROLLBACK, que permitem ao aplicativo controlar o escopo e o resultado das transações.

### Exemplos
1. Exemplo de transação simples:
~~~
BEGIN TRANSACTION;

UPDATE Products SET UnitsInStock = UnitsInStock - 10 WHERE ProductID = 1;
INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES (1, 1, 10);

COMMIT;
~~~
> Neste exemplo, uma transação é iniciada com a cláusula "BEGIN TRANSACTION". Em seguida, duas operações são executadas dentro da transação: uma atualização na tabela "Products" para diminuir a quantidade em estoque em 10 unidades e uma inserção na tabela "OrderDetails" para adicionar um novo detalhe do pedido. Por fim, a transação é confirmada com a cláusula "COMMIT", confirmando todas as alterações feitas na transação.

2. Transação com tratamento de exceção:
~~~
BEGIN TRANSACTION;

BEGIN TRY
  DELETE FROM Orders WHERE OrderID = 1;
  UPDATE Customers SET Points = Points + 100 WHERE CustomerID = 1;

  COMMIT;
END TRY
BEGIN CATCH
  PRINT 'Ocorreu um erro durante a transação.';
  ROLLBACK;
END CATCH;
~~~
> Neste exemplo, uma transação é iniciada com a cláusula "BEGIN TRANSACTION". Dentro da transação, duas operações são executadas: a exclusão de um pedido da tabela "Orders" e a atualização dos pontos de um cliente na tabela "Customers". O bloco TRY-CATCH é usado para capturar e tratar erros. Se ocorrer algum erro durante a transação, o bloco CATCH é acionado, uma mensagem de erro é impressa e a transação é revertida usando a cláusula "ROLLBACK".

3. Transação aninhada:
~~~
BEGIN TRANSACTION;

UPDATE Accounts SET Balance = Balance - 100 WHERE AccountID = 1;

BEGIN TRANSACTION;

UPDATE Accounts SET Balance = Balance + 100 WHERE AccountID = 2;

COMMIT;
COMMIT;
~~~
> Neste exemplo, duas transações aninhadas são usadas. A primeira transação diminui o saldo da conta com o ID 1, enquanto a segunda transação aumenta o saldo da conta com o ID 2. Ambas as transações são confirmadas individualmente usando a cláusula "COMMIT".
