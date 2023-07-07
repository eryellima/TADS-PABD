-- 1. Crie um procedimento armazenado para exibir o código do livro, o título do livro e o nome do autor, por ordem crescente de título do lviro e nome do autor.
/*
CREATE PROCEDURE spListBooksAndAuthors
AS
BEGIN
    SELECT t.title_id, t.title, a.au_lname + ', ' + a.au_fname AS author_name
    FROM titles t
    INNER JOIN titleauthor ta ON t.title_id = ta.title_id
    INNER JOIN authors a ON ta.au_id = a.au_id
    ORDER BY t.title, author_name
END
*/


-- 2. Crie um procedimento armazenado para exibir código do livro, o título do lviro e a quantidade de autores do livro, ordenando por título do livro.
/*
CREATE PROCEDURE spListBooksAndAuthorCount
AS
BEGIN
    SELECT t.title_id, t.title, COUNT(ta.au_id) AS author_count
    FROM titles t
    LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
    GROUP BY t.title_id, t.title
    ORDER BY t.title
END
*/


-- 3. Crie um procedimento armazenado para retornar como resultado a quantidade de editoras com mais de 5 livros editados.
/*
CREATE PROCEDURE spCountPublishersWithMoreThanFiveBooks
AS
BEGIN
    SELECT COUNT(*) AS publisher_count
    FROM (
        SELECT pub_id
        FROM titles
        GROUP BY pub_id
        HAVING COUNT(*) > 5
    ) AS publishers
END
*/


-- 4. Crie um procedimento armazenado para inserir uma nova loja de livros. O comando deve aprensetar uma mensagem de erro caso se tente inserir uma loja com código ou nome já existente.
/*
CREATE PROCEDURE spInsertBookstore
    @store_id VARCHAR(4),
    @store_name VARCHAR(40),
    @store_address VARCHAR(40),
    @city VARCHAR(20),
    @state CHAR(2),
    @zip CHAR(5)
AS
BEGIN
    -- Verificar se o código da loja já existe
    IF EXISTS (SELECT 1 FROM dbo.stores WHERE stor_id = @store_id)
    BEGIN
        RAISERROR('Código de loja já existente.', 16, 1)
        RETURN
    END

    -- Verificar se o nome da loja já existe
    IF EXISTS (SELECT 1 FROM dbo.stores WHERE stor_name = @stor_name)
    BEGIN
        RAISERROR('Nome de loja já existente.', 16, 1)
        RETURN
    END

    -- Inserir a nova loja
    INSERT INTO dbo.stores (stor_id, stor_name, stor_address, city, state, zip)
    VALUES (@stor_id, @stor_name, @stor_address, @city, @state, @zip)

    SELECT 'Nova loja inserida com sucesso.'
END
*/


-- 5. Crie um procedimento armazenado para apagar as lojas de livros que não realizaram vendas.
/*
CREATE PROCEDURE spDeleteEmptyBookstores
AS
BEGIN
    -- Verificar lojas sem vendas
    DELETE FROM dbo.stores
    WHERE stor_id NOT IN (SELECT DISTINCT stor_id FROM dbo.sales)

    SELECT 'Lojas sem vendas apagadas com sucesso.'
END
*/


-- 6. Crie um procedimento armazenado para listar os livros da editora com maior quantidade de títulso editados.
/*
CREATE PROCEDURE spListBooksByPublisher
AS
BEGIN
    WITH PublisherBooksCount AS (
        SELECT pub_id, COUNT(*) AS TotalBooks
        FROM dbo.titles
        GROUP BY pub_id
    ),
    MaxBooksPublisher AS (
        SELECT TOP 1 pub_id
        FROM PublisherBooksCount
        ORDER BY TotalBooks DESC
    )
    SELECT t.title_id, t.title, a.au_lname + ', ' + a.au_fname AS author_name
    FROM dbo.titles t
    INNER JOIN dbo.titleauthor ta ON t.title_id = ta.title_id
    INNER JOIN dbo.authors a ON ta.au_id = a.au_id
    WHERE t.pub_id = (SELECT pub_id FROM MaxBooksPublisher)
    ORDER BY t.title, a.au_lname, a.au_fname
END
*/


-- 7. Crie um procedimento armazenado que retorne em um parâmetro de saída o nome do autor cujo valor médio de custo dos seus livros seja o mais alto.
/*
CREATE PROCEDURE spGetAuthorWithHighestAverageCost
    @AuthorName VARCHAR(100) OUTPUT
AS
BEGIN
    SELECT TOP 1 @AuthorName = a.au_lname + ', ' + a.au_fname
    FROM dbo.authors a
    INNER JOIN dbo.titleauthor ta ON a.au_id = ta.au_id
    INNER JOIN dbo.titles t ON ta.title_id = t.title_id
    GROUP BY a.au_lname, a.au_fname
    ORDER BY AVG(t.price) DESC
END
*/


-- 8. Crie um procedimento armazenado para apresentar a lista de títulos nos quais a soma dos royalities sobre  as vendas que os autores têm direito difere de 100%.
/*
CREATE PROCEDURE spGetTitlesWithRoyaltyMismatch
AS
BEGIN
    SELECT t.title_id, t.title, SUM(ta.royaltyper) AS TotalRoyalty
    FROM dbo.titles t
    INNER JOIN dbo.titleauthor ta ON t.title_id = ta.title_id
    GROUP BY t.title_id, t.title
    HAVING SUM(ta.royaltyper) <> 100
END
*/


-- 9. Crie um procedimento armazenado que liste o nome e o telefone dos autores que não têm livros publicados.
/*
CREATE PROCEDURE spGetAuthorsWithoutBooks
AS
BEGIN
    SELECT au_lname, au_fname, phone
    FROM dbo.authors
    WHERE au_id NOT IN (
        SELECT au_id
        FROM dbo.titleauthor
    )
END
*/


-- 10. Crie um procedimento armazenado que retorne o valor total vendido por um livro passado como parametro
/*
CREATE PROCEDURE spGetTotalSalesByBook
    @title_id varchar(6)
AS
BEGIN
    DECLARE @total_sales money

    SELECT @total_sales = SUM(ytd_sales * price)
    FROM dbo.titles
    WHERE title_id = @title_id

    SELECT @total_sales AS total_sales
END
*/


-- 11. Crie um procedimento armazenado que retorne o valor total de royalities devido a um autor passado como parametro.
/*
CREATE PROCEDURE spGetTotalRoyaltiesByAuthor
    @au_id varchar(11)
AS
BEGIN
    DECLARE @total_royalties money

    SELECT @total_royalties = SUM(royaltyper * (price * ytd_sales) / 100)
    FROM dbo.titleauthor ta
    JOIN dbo.titles t ON ta.title_id = t.title_id
    WHERE ta.au_id = @au_id

    SELECT @total_royalties AS total_royalties
END
*/


-- 12. Crei um procedimento armazenado que retorne o valor total de royalities devidos por uma editora passada como parametro.
/*
CREATE PROCEDURE spGetTotalRoyaltiesByPublisher
    @pub_id char(4)
AS
BEGIN
    DECLARE @total_royalties money

    SELECT @total_royalties = SUM(royalty * (price * ytd_sales) / 100)
    FROM dbo.titles
    WHERE pub_id = @pub_id

    SELECT @total_royalties AS total_royalties
END
*/