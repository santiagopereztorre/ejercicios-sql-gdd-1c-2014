-- Cree el/los objetos de base de datos necesarios para actualizar la columna de 
-- empleado empl_comision con la sumatoria del total de lo vendido por ese empleado 
-- a lo largo del ultimo a�o. Se deber� retornar el c�digo del vendedor que m�s vendi� 
-- (en monto) a lo largo del �ltimo a�o. USE [Guia de ejerecicios]BEGIN TRANSACTION mi_transaction_4	DECLARE @empleado_codigo numeric(6,0)	DECLARE mi_cursor_4 CURSOR		FOR (SELECT empl_codigo FROM dbo.Empleado)			OPEN mi_cursor_4

	FETCH NEXT FROM mi_cursor_4
	INTO @empleado_codigo

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
	    
		UPDATE dbo.Empleado
			SET empl_comision = dbo.mi_funcion_4(@empleado_codigo)
			WHERE empl_codigo = @empleado_codigo
	    
		FETCH NEXT FROM <nombre_del_cursor>
		INTO @empl_codigo
	END 
	CLOSE mi_cursor_4;
	DEALLOCATE mi_cursor_4;		COMMIT	CREATE FUNCTION mi_funcion_4(	@empl_codigo numeric(6,0),)RETURNS decimal(12,2)BEGIN	DECLARE @comision decimal(12,2);		SELECT @comision = SUM(item_cantidad)		FROM dbo.Item_Factura			INNER JOIN dbo.Factura ON item_tipo = fact_tipo AND item_sucursal = fact_sucursal AND item_numero = fact_numero		WHERE fact_vendedor = @empl_codigo			RETURN @comisionEND	