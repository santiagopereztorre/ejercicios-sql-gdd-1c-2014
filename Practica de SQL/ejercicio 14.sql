-- Escriba una consulta que retorne una estadística de ventas por cliente. Los campos 
-- que debe retornar son: 
-- Código del cliente 
-- Cantidad de veces que compro en el último año 
-- Promedio por compra en el último año 
-- Cantidad de productos diferentes que compro en el último año 
-- Monto de la mayor compra que realizo en el último año 
-- Se deberán retornar todos los clientes ordenados por la cantidad de veces que 
-- compro en el último año. 
-- No se deberán visualizar NULLs en ninguna columna SELECT 	clie_codigo,	COUNT(DISTINCT fact_numero),	(SELECT SUM(f1.fact_total) FROM dbo.Factura f1 WHERE f1.fact_cliente = clie_codigo AND DATEPART(YEAR, f1.fact_fecha) = 2012) /	(SELECT COUNT(f1.fact_numero) FROM dbo.Factura f1 WHERE f1.fact_cliente = clie_codigo AND DATEPART(YEAR, f1.fact_fecha) = 2012),	(SELECT COUNT(DISTINCT item_producto) FROM dbo.Item_Factura i1 INNER JOIN dbo.Factura f1 ON i1.item_tipo = f1.fact_tipo AND i1.item_sucursal = f1.fact_sucursal AND i1.item_numero = f1.fact_numero WHERE f1.fact_cliente = clie_codigo AND DATEPART(year, f1.fact_fecha) = 2012),	(SELECT MAX(fact_total) FROM dbo.Factura f1 WHERE f1.fact_cliente = clie_codigo AND DATEPART(YEAR, f1.fact_fecha) = 2012)FROM dbo.Cliente	INNER JOIN dbo.Factura ON clie_codigo = fact_cliente	INNER JOIN dbo.Item_factura ON item_tipo = fact_tipo AND item_sucursal = fact_sucursal AND item_numero = fact_numeroGROUP BY clie_codigoHAVING ISNULL((SELECT SUM(f1.fact_total) FROM dbo.Factura f1 WHERE f1.fact_cliente = clie_codigo AND DATEPART(YEAR, f1.fact_fecha) = 2012) , 0) != 0ORDER BY (SELECT COUNT(f1.fact_numero) FROM dbo.Factura f1 WHERE f1.fact_cliente = clie_codigo AND DATEPART(YEAR, f1.fact_fecha) = 2012) DESC