-- Realizar una consulta que retorne para cada producto que posea composici�n, 
-- nombre del producto, precio del producto, precio de la sumatoria de los precios por 
-- la cantidad de los productos que lo componen. Solo se deber�n mostrar los 
-- productos que est�n compuestos por m�s de 2 productos y deben ser ordenados de 
-- mayor a menor por cantidad de productos que lo componen. SELECT prod_detalle, prod_precio, SUM(prod_precio * comp_cantidad)FROM dbo.Producto	INNER JOIN dbo.Composicion ON prod_codigo = comp_productoGROUP BY prod_detalle, prod_precioHAVING COUNT(comp_componente) >= 2ORDER BY COUNT(comp_componente)