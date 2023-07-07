-- OBS: os comandos estão dentro dos blocos de comentários para que não houvesse conflito com os outros quando eu estava fazendo basta retirar /**/ para executar cada um deles.

-- 1. Crie um procedimento armazenado para inserir uma nova loja de livros.
/* CREATE PROCEDURE InserirLoja
    @stor_id CHAR(4),
    @stor_name VARCHAR(40),
    @stor_address VARCHAR(40),
    @city VARCHAR(20),
    @state CHAR(2),
    @zip CHAR(5)
AS
BEGIN
    -- Verificar se o stor_id ou stor_name já existem
    IF EXISTS (SELECT 1 FROM dbo.stores WHERE stor_id = @stor_id OR stor_name = @stor_name)
    BEGIN
        RAISERROR('stor_id ou stor_name da loja já existente.', 16, 1)
        RETURN
    END

    -- Inserir a nova loja
    INSERT INTO dbo.stores (stor_id, stor_name, stor_address, city, state, zip)
    VALUES (@stor_id, @stor_name, @stor_address, @city, @state, @zip)

    -- Mensagem de sucesso
    PRINT 'Loja inserida com sucesso.'
END
*/


-- 2. Crie um procedimento armazenado para listar os livros da editora com maior quantidade de titulos editados.
/* CREATE PROCEDURE ListarLivrosEditoraMaiorQuantidade
AS
BEGIN
    -- Obter a editora com a maior quantidade de títulos editados
    DECLARE @pub_id CHAR(4)
    SELECT TOP 1 @pub_id = pub_id
    FROM dbo.titles
    GROUP BY pub_id
    ORDER BY COUNT(*) DESC

    -- Listar os livros da editora com seus detalhes
    SELECT t.title_id, t.title, t.type, t.price, t.royalty, t.ytd_sales, t.notes, t.pubdate, p.pub_name, a.au_fname, a.au_lname
    FROM dbo.titles t
    INNER JOIN dbo.publishers p ON t.pub_id = p.pub_id
    INNER JOIN dbo.titleauthors ta ON t.title_id = ta.title_id
    INNER JOIN dbo.authors a ON ta.au_id = a.au_id
    WHERE t.pub_id = @pub_id
END
*/


-- 3. Escreva um comando para alterar a tabela authors incluindo os campos qty (quantidade de livros publicados pelo autor) e midprice (preço médio dos livros do autor). Crie um gatilho de insert na tabela titleauthors para atualizar os valores dos campos qty e mid price.
/* ALTER TABLE authors
ADD qty INT,
    midprice DECIMAL(10,2);
CREATE TRIGGER trg_titleauthor_insert
ON titleauthor
AFTER INSERT
AS
BEGIN
    UPDATE authors
    SET qty = (SELECT COUNT(*) FROM titleauthor WHERE au_id = inserted.au_id),
        midprice = (SELECT AVG(price) FROM titles WHERE title_id IN (SELECT title_id FROM titleauthor WHERE au_id = inserted.au_id))
    FROM authors
    INNER JOIN inserted ON authors.au_id = inserted.au_id;
END;
*/


-- 4. Considere a tabela author com o campo Qty introduzido na questão 3. Crie um cursor para ler todos os autores e fazer uma atualização posicionada do capmo Qty, atualizando com a quantidade de livros existentes de cada autor na tabela titleauthors.
/* DECLARE @au_id VARCHAR(11);
DECLARE @qty INT;

DECLARE author_cursor CURSOR FOR
SELECT au_id FROM authors;

OPEN author_cursor;

FETCH NEXT FROM author_cursor INTO @au_id;

WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @qty = COUNT(*) FROM titleauthor WHERE au_id = @au_id;
    
    UPDATE authors SET qty = @qty WHERE au_id = @au_id;
    
    FETCH NEXT FROM author_cursor INTO @au_id;
END

CLOSE author_cursor;
DEALLOCATE author_cursor;
*/