-- Escriba una consulta que retorne los pares de productos que hayan sido vendidos 
-- juntos (en la misma factura) más de 500 veces. El resultado debe mostrar el código 
-- y descripción de cada uno de los productos y la cantidad de veces que fueron 
-- vendidos juntos. El resultado debe estar ordenado por la cantidad de veces que se 
-- vendieron juntos dichos productos. Los distintos pares no deben retornarse más de 
-- una vez. 
SELECT p1.prod_codigo, p1.prod_detalle, p2.prod_codigo, p2.prod_detalle, COUNT(*)
FROM dbo.Factura
	INNER JOIN dbo.Item_Factura i1 ON fact_tipo = i1.item_tipo AND fact_sucursal = i1.item_sucursal AND fact_numero = i1.item_numero
	INNER JOIN dbo.Item_Factura i2 ON fact_tipo = i2.item_tipo AND fact_sucursal = i2.item_sucursal AND fact_numero = i2.item_numero
	INNER JOIN dbo.Producto p1 ON i1.item_producto = p1.prod_codigo
	INNER JOIN dbo.Producto p2 ON i2.item_producto = p2.prod_codigo
GROUP BY p1.prod_codigo, p2.prod_codigo, p1.prod_detalle, p2.prod_detalle
HAVING COUNT(*) > 500