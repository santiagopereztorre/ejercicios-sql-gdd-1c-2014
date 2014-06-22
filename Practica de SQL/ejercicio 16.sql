-- Con el fin de lanzar una nueva campaña comercial para los clientes que menos 
-- compran en la empresa, se pide una consulta SQL que retorne aquellos clientes 
-- cuyas ventas son inferiores a 1/3 del promedio de ventas del/los producto/s que más se vendieron en el 2012. 
-- Además mostrar 
 
-- 1. Nombre del Cliente 
-- 2. Cantidad de unidades totales vendidas en el 2012 para ese cliente. 
-- 3. Código de producto que mayor venta tuvo en el 2012 (en caso de existir más de 
-- 1, mostrar solamente el de menor código) para ese cliente. 
 
-- Aclaraciones: 
-- La composición es de 2 niveles, es decir, un producto compuesto solo se compone 
-- de productos no compuestos. 
-- Los clientes deben ser ordenados por código de provincia ascendente. SELECT clie_razon_social,	(SELECT SUM(i1.item_cantidad) FROM dbo.Item_Factura i1 INNER JOIN dbo.Factura f1 ON i1.item_tipo = f1.fact_tipo AND i1.item_sucursal = f1.fact_sucursal AND i1.item_numero = f1.fact_numero WHERE f1.fact_cliente = clie_codigo AND DATEPART(year, f1.fact_fecha) = 2012),	(SELECT TOP 1 i3.item_producto FROM dbo.Item_Factura i3 INNER JOIN dbo.Factura f3 ON i3.item_tipo = f3.fact_tipo AND i3.item_sucursal = f3.fact_sucursal AND i3.item_numero = f3.fact_numero WHERE DATEPART(year, f3.fact_fecha) = 2012 AND f3.fact_cliente = clie_codigo GROUP BY i3.item_producto ORDER BY SUM(i3.item_cantidad) DESC, i3.item_producto ASC)FROM dbo.Cliente	INNER JOIN dbo.Factura ON fact_cliente = clie_codigoGROUP BY clie_razon_social, clie_codigoHAVING SUM(fact_total) >	((SELECT SUM(i2.item_cantidad) 							FROM dbo.Item_Factura i2							WHERE i2.item_producto IN (								SELECT TOP 10 item_producto 								FROM dbo.Item_Factura INNER JOIN dbo.Factura ON item_tipo = fact_tipo AND item_sucursal = fact_sucursal AND item_numero = fact_numero								WHERE DATEPART(year, fact_fecha) = 2012								GROUP BY item_producto								ORDER BY SUM(item_cantidad) DESC								)) / 3)