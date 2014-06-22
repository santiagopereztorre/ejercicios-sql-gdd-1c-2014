-- Realizar una consulta que retorne el detalle de la familia, la cantidad diferentes de 
-- productos vendidos y el monto de dichas ventas sin impuestos. Los datos se 
-- deber�n ordenar de mayor a menor, por la familia que m�s productos diferentes 
-- vendidos tenga, solo se deber�n mostrar las familias que tengan una venta superior a 
-- 20000 pesos para el a�o 2012. SELECT fami_id, prod_codigo, SUM(item_cantidad), SUM(item_cantidad * item_precio)FROM dbo.Familia	INNER JOIN dbo.Producto ON fami_id = prod_familia	INNER JOIN dbo.Item_Factura ON prod_codigo = item_productoWHERE (SELECT COUNT(*) FROM dbo.Item_Factura i1 INNER JOIN dbo.Factura f1 ON i1.item_tipo = f1.fact_tipo AND i1.item_sucursal = f1.fact_sucursal AND i1.item_numero = f1.fact_numero WHERE i1.item_producto = item_producto AND i1.item_cantidad * i1.item_precio > 20000 AND DATEPART(year, f1.fact_fecha) = 2012) > 0GROUP BY fami_id, prod_codigo ORDER BY fami_idSELECT item_cantidad * item_precio FROM dbo.Item_Factura WHERE item_cantidad * item_precio > 20000