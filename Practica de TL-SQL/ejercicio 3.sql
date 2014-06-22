-- Cree el/los objetos de base de datos necesarios para corregir la tabla empleado en 
-- caso que sea necesario. 
-- Se sabe que deber�a existir un �nico gerente general (deber�a ser el �nico empleado 
-- sin jefe). Si detecta que hay m�s de un empleado sin jefe deber� elegir entre ellos el 
-- gerente general, el cual ser� seleccionado por mayor salario. Si hay m�s de uno se 
-- seleccionara el de mayor antig�edad en la empresa. 
-- Al finalizar la ejecuci�n del objeto la tabla deber� cumplir con la regla de un �nico 
-- empleado sin jefe (el gerente general) y deber� retornar la cantidad de empleados 
-- que hab�a sin jefe antes de la ejecuci�n. 

BEGIN TRANSACTION mi_transaction_3
	
	DECLARE @empleados_sin_jefe table(empl_codigo numeric(6,0), empl_salario decimal(12,2), empl_ingreso smalldatetime)
	DECLARE @gerente_general numeric(6,0)
	
	INSERT @empleados_sin_jefe
		SELECT empl_codigo, empl_salario, empl_ingreso FROM dbo.Empleado WHERE ISNULL(empl_jefe, 0) = 0
	
	SELECT @gerente_general = empl_codigo
		FROM @empleados_sin_jefe
		ORDER BY empl_salario DESC, empl_ingreso ASC
	
	UPDATE dbo.Empleado
	SET empl_jefe = @gerente_general
	WHERE empl_codigo != @gerente_general
	
	SELECT @gerente_general

COMMIT