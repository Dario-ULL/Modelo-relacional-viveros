\c viveros;

-- Eliminar empleado: La eliminación de un empleado afectará automáticamente a Historico_puesto y Pedido gracias a ON DELETE SET NULL.
-- Eliminar un empleado y observar la cascada en Historico_puesto y Pedido
DELETE FROM Empleado WHERE codigo_empleado = 1;

-- Eliminar cliente: Elimina todos los registros de Pedido donde el cliente es referenciado.
-- Eliminar un cliente y observar cómo afecta a los pedidos relacionados
DELETE FROM Cliente_fidelizado WHERE codigo_cliente = 2;

-- Eliminar pedido: Los productos relacionados en Pedido_Producto se eliminan debido a ON DELETE CASCADE.
-- Eliminar un pedido y sus productos relacionados
DELETE FROM Pedido WHERE codigo_pedido = 3;

-- Eliminar vivero: La eliminación en Vivero afecta a sus zonas y registros asociados.
-- Eliminar un vivero y observar cómo afecta las zonas, empleados y otros datos relacionados
DELETE FROM Vivero WHERE codigo_vivero = 4;

-- Eliminar zona: La eliminación en Zona afecta los registros relacionados en Zona_Producto y Empleado_Zona debido a ON DELETE CASCADE.
-- Eliminar una zona y ver el efecto en Zona_Producto y Empleado_Zona
DELETE FROM Zona WHERE codigo_vivero = 5 AND codigo_zona = 5;