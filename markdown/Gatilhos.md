# Programação e Administração de Banco de Dados
## Gatilhos
Gatilhos (triggers) em bancos de dados são objetos que permitem que ações automáticas sejam executadas em resposta a eventos específicos que ocorrem nas tabelas. Esses eventos podem ser operações de inserção, atualização ou exclusão de dados. Os gatilhos fornecem uma forma de adicionar lógica personalizada ao banco de dados, permitindo que você automatize tarefas, aplique regras de negócios e mantenha a integridade dos dados.

Aqui estão algumas informações importantes sobre gatilhos em banco de dados:
1. Eventos disparadores: Os gatilhos são ativados por eventos específicos nas tabelas, como antes ou depois de uma operação de inserção, atualização ou exclusão. Por exemplo, um gatilho pode ser acionado antes de uma linha ser inserida em uma tabela, permitindo que você execute ações adicionais ou aplique validações antes que os dados sejam adicionados.

2. Lógica personalizada: Os gatilhos permitem que você adicione lógica personalizada para realizar ações específicas quando o evento é acionado. Essa lógica pode incluir consultas SQL, chamadas de procedimentos armazenados ou até mesmo interações com outros sistemas. Por exemplo, você pode ter um gatilho que, após uma atualização em uma tabela de vendas, atualiza automaticamente o estoque em outra tabela relacionada.

3. Manutenção da integridade dos dados: Os gatilhos podem ser usados para aplicar regras de negócios e manter a integridade dos dados. Por exemplo, um gatilho pode impedir a exclusão de registros em uma tabela se houver registros relacionados em outras tabelas. Isso garante que as regras de integridade referencial sejam respeitadas.

4. Controle de fluxo: Os gatilhos podem ser usados para controlar o fluxo das operações no banco de dados. Por exemplo, um gatilho pode abortar uma operação ou reverter uma ação se determinadas condições forem atendidas. Isso permite que você aplique lógica condicional e tome decisões com base nos dados ou eventos que ocorreram.

5. Contexto de execução: Os gatilhos são executados no contexto da transação que acionou o evento. Isso significa que eles podem ter acesso aos dados inseridos, atualizados ou excluídos na transação e podem afetar outros objetos do banco de dados dentro dessa transação.

### Exemplos
1. Gatilho de inserção:
~~~
CREATE TRIGGER InsertAuditTrigger
ON Employees
AFTER INSERT
AS
BEGIN
  INSERT INTO AuditTable (TableName, Operation)
  VALUES ('Employees', 'INSERT');
END;
~~~
> Neste exemplo, um gatilho de inserção chamado "InsertAuditTrigger" é criado na tabela "Employees". Após a inserção de novos registros na tabela "Employees", o gatilho é acionado e insere uma nova entrada na tabela "AuditTable" para registrar a operação de inserção.

2. Gatilho de atualização:
~~~
CREATE TRIGGER UpdateAuditTrigger
ON Customers
AFTER UPDATE
AS
BEGIN
  IF UPDATE(CustomerName)
  BEGIN
    INSERT INTO AuditTable (TableName, Operation)
    VALUES ('Customers', 'UPDATE');
  END;
END;
~~~
> Neste exemplo, um gatilho de atualização chamado "UpdateAuditTrigger" é criado na tabela "Customers". Quando ocorre uma atualização na tabela "Customers" e a coluna "CustomerName" é modificada, o gatilho é acionado e registra a operação de atualização na tabela "AuditTable".

3. Gatilho de exclusão:
~~~
CREATE TRIGGER DeleteAuditTrigger
ON Orders
AFTER DELETE
AS
BEGIN
  INSERT INTO AuditTable (TableName, Operation)
  VALUES ('Orders', 'DELETE');
END;
~~~
> Neste exemplo, um gatilho de exclusão chamado "DeleteAuditTrigger" é criado na tabela "Orders". Após a exclusão de registros na tabela "Orders", o gatilho é acionado e insere uma nova entrada na tabela "AuditTable" para registrar a operação de exclusão.
