Exercício 1:
	ALTER TABLE dbo.authors
	ADD qty INT,
	    midprice DECIMAL(10, 2);

Exercício 2:
	-- Criação do procedimento que contém o gatilho de inserção (INSERT)
		CREATE PROCEDURE sp_insert_titleauthor_trigger
		AS
		BEGIN
		    SET NOCOUNT ON;

		    -- Gatilho de inserção (INSERT)
		    UPDATE dbo.authors
		    SET qty = qty + 1,
		        midprice = (SELECT AVG(price) FROM dbo.titles WHERE title_id IN (SELECT title_id FROM inserted))
		    WHERE au_id IN (SELECT au_id FROM inserted)
		END;
		GO

		-- Criação do gatilho de inserção (INSERT)
		CREATE TRIGGER tr_insert_titleauthor
		ON dbo.titleauthor
		AFTER INSERT
		AS
		BEGIN
		    EXEC sp_insert_titleauthor_trigger;
		END;
		GO

		-- Criação do procedimento que contém o gatilho de exclusão (DELETE)
		CREATE PROCEDURE sp_delete_titleauthor_trigger
		AS
		BEGIN
		    SET NOCOUNT ON;

		    -- Gatilho de exclusão (DELETE)
		    UPDATE dbo.authors
		    SET qty = qty - 1,
		        midprice = (SELECT AVG(price) FROM dbo.titles WHERE title_id IN (SELECT title_id FROM deleted))
		    WHERE au_id IN (SELECT au_id FROM deleted)
		END;
		GO

		-- Criação do gatilho de exclusão (DELETE)
		CREATE TRIGGER tr_delete_titleauthor
		ON dbo.titleauthor
		AFTER DELETE
		AS
		BEGIN
		    EXEC sp_delete_titleauthor_trigger;
		END;
		GO

	OBS: não sei se essa é a melhor forma ou a correta mas foi a que eu consegui achar que desse certo, aparentemente a versão do SQK que eu estava usando não suportava a criação dos gatilhos diretamente no SSMS ou ao menos foi o erro que achei procurando quando deu errado nas primeiras vezes.

Exercício 3:
	CREATE FUNCTION SalesMonth (@Ano INT)
	RETURNS TABLE
	AS
	RETURN (
	    SELECT s.stor_id, s.title_id, MONTH(s.ord_date) AS month, YEAR(s.ord_date) AS year, s.qty
	    FROM dbo.sales s
	    WHERE YEAR(s.ord_date) = @Ano
	);

Exercício 4:
	ALTER TABLE dbo.authors
	ADD positivacao BIT DEFAULT 0;


	-- para registrar a postivação do autor no corrente
	UPDATE dbo.authors
	SET positivacao = 1
	WHERE YEAR(GETDATE()) = YEAR(CURRRENT_TIMESTAMP)

Exercício 5:
	CREATE PROCEDURE AtualizarPositivacaoAutor
    @au_id varchar(11),
    @ano int
	AS
	BEGIN
	    DECLARE @positivacao int;

	    -- Calcula a positivação contando os meses distintos com vendas no ano especificado
	    SELECT @positivacao = COUNT(DISTINCT MONTH(ord_date))
	    FROM dbo.sales
	    WHERE stor_id = @au_id
	        AND YEAR(ord_date) = @ano;

	    -- Atualiza o campo positivacao na tabela authors
	    UPDATE dbo.authors
	    SET positivacao = CASE WHEN @positivacao > 0 THEN 1 ELSE 0 END
	    WHERE au_id = @au_id;
	END;
