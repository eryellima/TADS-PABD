-- 1. Criar uma função escalar para a partir de dois pares de informação de posicionamento GPS (latitude e longitude) seja retornado a distância em metros entre as duas posições.
CREATE FUNCTION dbo.CalcularDistancia(
	@lat1 FLOAT,
	@lon1 FLOAT,
	@lat2 FLOAT,
	@lon2 FLOAT
)
RETURNS FLOAT
AS
BEGIN
	DECLARE @raio_terra FLOAT = 6371000; -- Raio médio da Terra em metros
	DECLARE @dlat FLOAT, @dlon FLOAT, @a FLOAT, @c FLOAT, @distancia FLOAT;
	SET @dlat = RADIANS(@lat2 - @lat1);
	SET @dlon = RADIANS(@lon2 - @lon1);
	SET @a = SIN(@dlat / 2) * SIN(@dlat / 2) + COS(RADIANS(@lat1)) *
COS(RADIANS(@lat2)) * SIN(@dlon / 2) * SIN(@dlon / 2);
	SET @c = 2 * ATN2(SQRT(@a), SQRT(1 - @a));
	SET @distancia = @raio_terra * @c;
	RETURN @distancia;
END;


-- 2. Crie um procedimento para atualizar as informações de rastreio de uma atividade (parâmetro de entrada) e atualize os campos de velocidade, distância e intervalo de tempo dos registros de rastreio. Utilize uma estrutura de cursor para atualizar as informações.
CREATE PROCEDURE AtualizarInformacoesRastreio
	@UUIDAtividade VARCHAR(50)
AS
BEGIN
	DECLARE @UUIDRastreio VARCHAR(50);
	DECLARE @Latitude FLOAT, @Longitude FLOAT, @DataHora DATETIME;
	DECLARE @Velocidade FLOAT, @Distancia FLOAT, @IntervaloTempo INT;
	DECLARE @LatitudeAnterior FLOAT, @LongitudeAnterior FLOAT, @DataHoraAnterior DATETIME;

	DECLARE rastreio_cursor CURSOR FOR
	SELECT UUIDRastreio, Latitude, Longitude, DataHora
	FROM dbo.Rastreio
	WHERE UUIDAtividade = @UUIDAtividade;

	OPEN rastreio_cursor;

	-- Fetch do primeiro registro
	FETCH NEXT FROM rastreio_cursor INTO @UUIDRastreio, @Latitude, @Longitude, @DataHora;
	
	-- Loop através dos registros de rastreamento
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Verifica se é o primeiro registro
		IF @LatitudeAnterior IS NULL
		BEGIN
			SET @LatitudeAnterior = @Latitude;
			SET @LongitudeAnterior = @Longitude;
			SET @DataHoraAnterior = @DataHora;
		END
		ELSE
		BEGIN
			-- Atualiza os campos de velocidade, distância e intervalo
			SET @Distancia = dbo.CalcularDistancia(@LatitudeAnterior, @LongitudeAnterior, @Latitude, @Longitude);
			SET @IntervaloTempo = DATEDIFF(SECOND, @DataHoraAnterior, @DataHora);
			-- Verifica se o intervalo é maior que zero para evitar divisão por zero
			IF @IntervaloTempo > 0
			BEGIN
				SET @Velocidade = @Distancia / @IntervaloTempo;
			END
			ELSE
				BEGIN
					SET @Velocidade = 0; -- Define a velocidade como zero se o intervalo de tempo for zero
				END
				UPDATE dbo.Rastreio
					SET Velocidade = @Velocidade, Distancia = @Distancia, IntervaloTempo = @IntervaloTempo
				WHERE UUIDRastreio = @UUIDRastreio;
					-- Atribui os valores atuais às variáveis anteriores
					SET @LatitudeAnterior = @Latitude;
					SET @LongitudeAnterior = @Longitude;
					SET @DataHoraAnterior = @DataHora;
			END
			FETCH NEXT FROM rastreio_cursor INTO @UUIDRastreio, @Latitude, @Longitude, @DataHora;
		END;
	CLOSE rastreio_cursor;
	DEALLOCATE rastreio_cursor;
END;


-- 3. Ajuste o procedimento da questão 2, inclua o controle de transação. Forçe um erro caso a quantidade de registro de rastreio alterados seja superior a 1000. Verifique se ao mandar atualizar uma atividade com menos de 1000 rastreios os registros são todos atualizados e quando tem mais de 1000 nenhum seja atualizado.
CREATE PROCEDURE AtualizarInformacoesRastreio
@UUIDAtividade VARCHAR(50)
AS
BEGIN
BEGIN TRANSACTION; -- Início da transação
DECLARE @UUIDRastreio VARCHAR(50);
DECLARE @Latitude FLOAT, @Longitude FLOAT, @DataHora DATETIME;
DECLARE @Velocidade FLOAT, @Distancia FLOAT, @IntervaloTempo INT;
DECLARE @LatitudeAnterior FLOAT, @LongitudeAnterior FLOAT,
@DataHoraAnterior DATETIME;
DECLARE @RegistrosAtualizados INT;
DECLARE rastreio_cursor CURSOR FOR
SELECT UUIDRastreio, Latitude, Longitude, DataHora
FROM dbo.Rastreio
WHERE UUIDAtividade = @UUIDAtividade;
OPEN rastreio_cursor;
FETCH NEXT FROM rastreio_cursor INTO @UUIDRastreio, @Latitude,
@Longitude, @DataHora;
-- Inicializa a variável de registros
SET @RegistrosAtualizados = 0;
WHILE @@FETCH_STATUS = 0
BEGIN
-- Verifica se é o primeiro registro
IF @LatitudeAnterior IS NULL
BEGIN
SET @LatitudeAnterior = @Latitude;
SET @LongitudeAnterior = @Longitude;
SET @DataHoraAnterior = @DataHora;
END
ELSE
BEGIN
SET @Distancia = dbo.CalcularDistancia(@LatitudeAnterior,
@LongitudeAnterior, @Latitude, @Longitude);
SET @IntervaloTempo = DATEDIFF(SECOND, @DataHoraAnterior,
@DataHora);
-- Verifica se o intervalo é maior que zero para evitar divisão
por zero
IF @IntervaloTempo > 0
BEGIN
SET @Velocidade = @Distancia / @IntervaloTempo;
END
ELSE
BEGIN
SET @Velocidade = 0;
END
UPDATE dbo.Rastreio
SET Velocidade = @Velocidade, Distancia = @Distancia,
IntervaloTempo = @IntervaloTempo
WHERE UUIDRastreio = @UUIDRastreio;

-- Atribui os valores atuais às variáveis
SET @LatitudeAnterior = @Latitude;
SET @LongitudeAnterior = @Longitude;
SET @DataHoraAnterior = @DataHora;
SET @RegistrosAtualizados = @RegistrosAtualizados + 1;
END
FETCH NEXT FROM rastreio_cursor INTO @UUIDRastreio, @Latitude,
@Longitude, @DataHora;
END;
CLOSE rastreio_cursor;
DEALLOCATE rastreio_cursor;
-- Verifica a quantidade de registros
IF @RegistrosAtualizados > 1000
BEGIN
-- Força um erro caso os registros seja superior a 1000
ROLLBACK TRANSACTION; -- Desfaz a transação
RAISERROR ('Erro: A quantidade de registros atualizados é superior
a 1000.', 16, 1);
END
ELSE
BEGIN
COMMIT TRANSACTION;
END;
END;


-- 4. Crie um procedimento para a partir do parâmetro de entrada de código da atividade, totalize as informações de velocidade média, distancia total e tempo total da atividade informada.
CREATE PROCEDURE TotalizarInformacoesAtividade
@CodigoAtividade VARCHAR(50)
AS
BEGIN
DECLARE @VelocidadeMedia FLOAT, @DistanciaTotal FLOAT, @TempoTotal INT;
-- Variáveis
SET @VelocidadeMedia = 0;
SET @DistanciaTotal = 0;
SET @TempoTotal = 0;
-- Velocidade média, distância total e tempo total
SELECT @VelocidadeMedia = AVG(Velocidade),
@DistanciaTotal = SUM(Distancia),
@TempoTotal = SUM(IntervaloTempo)
FROM dbo.Rastreio
WHERE UUIDAtividade = @CodigoAtividade;
-- Exibir os resultados
PRINT 'Informações da atividade ' + @CodigoAtividade + ':';
PRINT 'Velocidade média: ' + CAST(@VelocidadeMedia AS VARCHAR) + '
km/h';
PRINT 'Distância total: ' + CAST(@DistanciaTotal AS VARCHAR) + ' km';
PRINT 'Tempo total: ' + CAST(@TempoTotal AS VARCHAR) + ' segundos';
END;


-- 5. Crie um cursor que leia todas as atividade e, para cada uma delas, chame o procedimento de atualização das informações de rastreio (questão 2) e, em seguida, chame o procedimento de totalização das atividades
(questão 4).
CREATE PROCEDURE ProcessarTodasAtividades
AS
BEGIN
DECLARE @CodigoAtividade VARCHAR(50);
-- Vai criar um cursos para percorrer as atividades
DECLARE atividade_cursor CURSOR FOR
SELECT DISTINCT UUIDAtividade
FROM dbo.Rastreio;
-- Abre o cursor
OPEN atividade_cursor;
FETCH NEXT FROM atividade_cursor INTO @CodigoAtividade;
WHILE @@FETCH_STATUS = 0
BEGIN
-- Chaman o procedimento da questão 2
EXEC AtualizarInformacoesRastreio @UUIDAtividade =
@CodigoAtividade;
-- Chama o procedimento da questão 4
EXEC TotalizarInformacoesAtividade @CodigoAtividade =
@CodigoAtividade;
FETCH NEXT FROM atividade_cursor INTO @CodigoAtividade;
END;
-- Fecha o cursor
CLOSE atividade_cursor;
DEALLOCATE atividade_cursor;
END;