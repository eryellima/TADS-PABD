# Índices
Abaixo estão alguns exemplos de índices que podem ser úteis em diferentes situações:

1. Índice Clusterizado:
```sql
CREATE CLUSTERED INDEX idx_clustered_orders ON orders (order_date);
```
Neste exemplo, estamos criando um índice clusterizado na coluna `order_date` da tabela `orders`. O índice clusterizado reorganiza fisicamente os dados da tabela com base na coluna especificada, tornando a busca por intervalos de datas mais eficiente.

2. Índice Não Clusterizado:
```sql
CREATE NONCLUSTERED INDEX idx_nonclustered_customers ON customers (last_name, first_name);
```
Neste exemplo, estamos criando um índice não clusterizado nas colunas `last_name` e `first_name` da tabela `customers`. O índice não clusterizado cria uma estrutura separada para as chaves do índice, tornando as consultas de pesquisa por nome de cliente mais eficientes.

3. Índice Único:
```sql
CREATE UNIQUE INDEX idx_unique_products ON products (product_code);
```
Neste exemplo, estamos criando um índice único na coluna `product_code` da tabela `products`. O índice único garante que não haverá duplicatas na coluna `product_code`, tornando-a uma chave primária alternativa.

4. Índice Filtrado:
```sql
CREATE NONCLUSTERED INDEX idx_filtered_orders ON orders (order_date) WHERE status = 'completed';
```
Neste exemplo, estamos criando um índice não clusterizado na coluna `order_date` da tabela `orders`, mas com filtro na coluna `status`. O índice filtrado só incluirá os registros com `status = 'completed'`, tornando as consultas relacionadas a pedidos completos mais rápidas.

5. Índice Composto:
```sql
CREATE NONCLUSTERED INDEX idx_composite_sales ON sales (customer_id, product_id);
```
Neste exemplo, estamos criando um índice não clusterizado nas colunas `customer_id` e `product_id` da tabela `sales`. O índice composto permite que consultas que envolvam ambas as colunas sejam mais eficientes.