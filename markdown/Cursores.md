# Programação e Administração de Banco de Dados
## Cursores
Cursores em bancos de dados são objetos que permitem percorrer e manipular registros individualmente em um conjunto de resultados retornado por uma consulta SQL. Eles fornecem uma forma de processar linhas de dados uma de cada vez, permitindo que você execute operações personalizadas em cada registro.

Aqui estão algumas informações importantes sobre cursores em bancos de dados:
1. Declaração e abertura do cursor: Para usar um cursor, você precisa declará-lo e abrir uma consulta SQL que retorna os registros desejados. A consulta pode conter uma cláusula SELECT com as condições e junções necessárias para obter os dados desejados. Ao abrir o cursor, o conjunto de resultados é retornado e pode ser percorrido uma linha de cada vez.

2. Posicionamento e movimentação: Um cursor possui um ponto de posicionamento, que indica em qual registro ele está atualmente. Você pode mover o cursor para a próxima linha, linha anterior, primeira linha, última linha ou para uma posição específica no conjunto de resultados. Isso permite que você navegue pelos registros e acesse seus dados individualmente.

3. Recuperação de dados: Com um cursor, você pode recuperar os valores das colunas para o registro atual. Isso pode ser feito atribuindo os valores das colunas a variáveis ou usando-as diretamente em operações de manipulação de dados. Por exemplo, você pode acessar o valor de uma coluna específica e usá-lo para atualizar outra tabela.

4. Looping com cursores: Os cursores são frequentemente usados em loops para processar cada registro do conjunto de resultados. Você pode repetir um bloco de código para cada registro no cursor até que não haja mais registros a serem processados. Isso permite que você execute ações personalizadas em cada registro, como cálculos, atualizações ou inserções.

5. Fechamento do cursor: Após a conclusão do processamento dos registros, é importante fechar o cursor para liberar os recursos do sistema. Isso é feito com uma declaração de fechamento do cursor. O fechamento do cursor encerra a iteração pelos registros e libera a memória ou outros recursos associados ao cursor.

### Exemplos
1. Exemplo de cursos simples:
~~~
DECLARE @CustomerID INT;
DECLARE @CustomerName VARCHAR(50);

DECLARE CustomerCursor CURSOR FOR
SELECT CustomerID, CustomerName FROM Customers;

OPEN CustomerCursor;
FETCH NEXT FROM CustomerCursor INTO @CustomerID, @CustomerName;

WHILE @@FETCH_STATUS = 0
BEGIN
  PRINT 'Customer ID: ' + CAST(@CustomerID AS VARCHAR) + ', Customer Name: ' + @CustomerName;
  FETCH NEXT FROM CustomerCursor INTO @CustomerID, @CustomerName;
END;

CLOSE CustomerCursor;
DEALLOCATE CustomerCursor;
~~~
> Neste exemplo, um cursor chamado "CustomerCursor" é declarado e aberto para a tabela "Customers". Os valores das colunas "CustomerID" e "CustomerName" são armazenados em variáveis. Em seguida, um loop WHILE é usado para iterar pelos registros retornados pelo cursor. Dentro do loop, os valores das variáveis são impressos e o cursor é movido para o próximo registro usando a cláusula FETCH NEXT. O loop continua até que não haja mais registros para buscar (valor @@FETCH_STATUS diferente de zero). Por fim, o cursor é fechado e desalocado.

2. Cursor com atualização de valores:
~~~
DECLARE @ProductID INT;
DECLARE @UnitsInStock INT;

DECLARE ProductCursor CURSOR FOR
SELECT ProductID, UnitsInStock FROM Products;

OPEN ProductCursor;
FETCH NEXT FROM ProductCursor INTO @ProductID, @UnitsInStock;

WHILE @@FETCH_STATUS = 0
BEGIN
  IF @UnitsInStock < 10
  BEGIN
    UPDATE Products SET UnitsInStock = @UnitsInStock + 10 WHERE ProductID = @ProductID;
  END;
  
  FETCH NEXT FROM ProductCursor INTO @ProductID, @UnitsInStock;
END;

CLOSE ProductCursor;
DEALLOCATE ProductCursor;
~~~
> Neste exemplo, um cursor chamado "ProductCursor" é declarado e aberto para a tabela "Products". Os valores das colunas "ProductID" e "UnitsInStock" são armazenados em variáveis. Dentro do loop WHILE, verifica-se se o estoque de unidades é menor que 10. Se for, o estoque é atualizado adicionando 10 unidades. O cursor é então movido para o próximo registro e o loop continua até que não haja mais registros para buscar. Por fim, o cursor é fechado e desalocado.