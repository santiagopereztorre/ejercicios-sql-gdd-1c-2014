-- Generar una consulta que muestre para cada articulo código, detalle, mayor precio, 
-- menor precio y % de la diferencia de precios (respecto del menor Ej.: menor precio 
-- = 10, mayor precio =12 => mostrar 20 %). Mostrar solo aquellos artículos que 
-- posean stock. 

SELECT
	prod_codigo,
	prod_detalle,
	(SELECT TOP 1 item_precio FROM dbo.Item_Factura i1 WHERE i1.item_producto = prod_codigo ORDER BY i1.item_precio DESC),
	(SELECT TOP 1 item_precio FROM dbo.Item_Factura i1 WHERE i1.item_producto = prod_codigo ORDER BY i1.item_precio ASC),
	((SELECT TOP 1 item_precio FROM dbo.Item_Factura i1 WHERE i1.item_producto = prod_codigo ORDER BY i1.item_precio DESC) -
	(SELECT TOP 1 item_precio FROM dbo.Item_Factura i1 WHERE i1.item_producto = prod_codigo ORDER BY i1.item_precio ASC)) * 100 /
	(SELECT TOP 1 item_precio FROM dbo.Item_Factura i1 WHERE i1.item_producto = prod_codigo ORDER BY i1.item_precio ASC)
FROM dbo.Item_Factura i2
	INNER JOIN dbo.Producto ON item_producto = prod_codigo
	INNER JOIN dbo.STOCK ON item_producto = stoc_producto
GROUP BY prod_codigo, prod_detalle
HAVING SUM(stoc_cantidad) > 0