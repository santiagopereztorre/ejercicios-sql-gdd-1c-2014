-- Realizar un procedimiento que complete con los datos existentes en el modelo 
-- provisto la tabla de hechos denominada Fact_table tiene las siguiente definición:
IF OBJECT_ID('dbo.Fact_table') IS NOT NULL
DROP TABLE dbo.Fact_table
CREATE TABLE dbo.Fact_table 
( anio char(4), 
  mes char(2), 
  familia char(3), 
  rubro char(4), 
  cliente char(6), 
  producto char(8), 
  cantidad decimal(12,2), 
  monto decimal(12,2),
  PRIMARY KEY(anio,mes,familia,rubro,cliente,producto) 
)
IF OBJECT_ID('dbo.mi_procedure_5') IS NOT NULL
DROP PROCEDURE dbo.mi_procedure_5
GO
CREATE PROCEDURE dbo.mi_procedure_5
AS
BEGIN
	INSERT INTO dbo.Fact_table
	(
		anio,
		mes,
		familia,
		rubro,
		cliente,
		producto,
		cantidad,
		monto
	)
	SELECT YEAR(fact_fecha), MONTH(fact_fecha), fami_id, rubr_id, clie_codigo, prod_codigo, SUM(item_cantidad), SUM(item_cantidad * item_precio)
		FROM dbo.Item_Factura
			INNER JOIN dbo.Factura ON item_tipo = fact_tipo AND item_sucursal = fact_sucursal AND item_numero = fact_numero
			INNER JOIN dbo.Producto ON item_producto = prod_codigo
			INNER JOIN dbo.Rubro ON prod_rubro = rubr_id
			INNER JOIN dbo.Cliente ON fact_cliente = clie_codigo
			INNER JOIN dbo.Familia ON prod_familia = fami_id
		GROUP BY YEAR(fact_fecha), MONTH(fact_fecha), fami_id, rubr_id, clie_codigo, prod_codigo
		ORDER BY prod_codigo
END