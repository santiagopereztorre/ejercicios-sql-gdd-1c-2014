-- Escriba una consulta que retorne una estadística de ventas para todos los rubros. 
-- La consulta debe retornar: 
--  DETALLE_RUBRO: Detalle del rubro 
--  VENTAS: Suma de las ventas en pesos de productos vendidos de dicho 
-- rubro 
--  PROD1: Código del producto más vendido de dicho rubro 
--  PROD2: Código del segundo producto más vendido de dicho rubro 
--  CLIENTE: Código del cliente que compro más productos del rubro en los 
-- últimos 30 días 
-- La consulta no puede mostrar NULL en ninguna de sus columnas y debe estar 
-- ordenada por cantidad de productos diferentes vendidos del rubro SELECT 	rubr_detalle,	SUM(item_precio * item_cantidad),	(SELECT TOP 1 p1.prod_codigo FROM dbo.Producto p1 INNER JOIN dbo.Item_Factura i1 ON p1.prod_codigo = i1.item_producto WHERE p1.prod_rubro = rubr_id GROUP BY p1.prod_codigo ORDER BY SUM(item_cantidad) DESC),	(SELECT TOP 1 p1.prod_codigo FROM dbo.Producto p1 INNER JOIN dbo.Item_Factura i1 ON p1.prod_codigo = i1.item_producto WHERE p1.prod_rubro = rubr_id AND p1.prod_codigo NOT IN (SELECT TOP 1 p1.prod_codigo FROM dbo.Producto p1 INNER JOIN dbo.Item_Factura i1 ON p1.prod_codigo = i1.item_producto WHERE p1.prod_rubro = rubr_id GROUP BY p1.prod_codigo ORDER BY SUM(item_cantidad) DESC) GROUP BY p1.prod_codigo ORDER BY SUM(item_cantidad) DESC),	(SELECT TOP 1 f1.fact_cliente FROM dbo.Factura f1 INNER JOIN dbo.Item_Factura i1 ON f1.fact_tipo = i1.item_tipo AND f1.fact_sucursal = i1.item_sucursal AND f1.fact_numero = i1.item_numero INNER JOIN dbo.Producto p1 ON i1.item_producto = p1.prod_codigo WHERE p1.prod_rubro = rubr_id AND f1.fact_fecha BETWEEN GETDATE() AND GETDATE() - 30 GROUP BY f1.fact_cliente ORDER BY SUM(fact_total))FROM dbo.Rubro	INNER JOIN dbo.Producto ON rubr_id = prod_rubro	INNER JOIN dbo.Item_Factura i ON prod_codigo = item_productoGROUP BY rubr_id, rubr_detalleORDER BY rubr_detalle