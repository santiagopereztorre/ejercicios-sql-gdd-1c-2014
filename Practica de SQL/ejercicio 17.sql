-- Escriba una consulta que retorne una estadística de ventas por año y mes para cada 
-- producto. 
-- La consulta debe retornar: 
--  PERIODO: Año y mes de la estadística con el formato YYYYMM 
--  PROD: Código de producto 
--  DETALLE: Detalle del producto 
--  CANTIDAD_VENDIDA= Cantidad vendida del producto en el periodo 
--  VENTAS_AÑO_ANT= Cantidad vendida del producto en el mismo mes 
-- del periodo pero del año anterior 
--  CANT_FACTURAS= Cantidad de facturas en las que se vendió el 
-- producto en el periodo 
-- La consulta no puede mostrar NULL en ninguna de sus columnas y debe estar 
-- ordenada por periodo y código de producto. SELECT 	CAST(DATEPART(YEAR, fact_fecha) AS VARCHAR) + CAST(DATEPART(MONTH, fact_fecha) AS VARCHAR),	item_producto,	prod_detalle,	SUM(item_cantidad),	(SELECT SUM(item_cantidad) FROM dbo.Item_Factura i1 INNER JOIN dbo.Factura f1 ON i1.item_tipo = f1.fact_tipo AND i1.item_sucursal = f1.fact_sucursal AND i1.item_numero = f1.fact_numero WHERE DATEPART(YEAR, f1.fact_fecha) = DATEPART(YEAR, fact_fecha) - 1 AND i1.item_producto = item_producto),	COUNT(DISTINCT fact_numero)	FROM dbo.Item_Factura	INNER JOIN dbo.Factura ON item_tipo = fact_tipo AND item_sucursal = fact_sucursal AND item_numero = fact_numero	INNER JOIN dbo.Producto ON item_producto = prod_codigoGROUP BY item_producto, prod_detalle, fact_fechaORDER BY DATEPART(YEAR, fact_fecha), DATEPART(MONTH, fact_fecha)