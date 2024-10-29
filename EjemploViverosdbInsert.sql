\c viveros;

-- Insertar datos en Vivero
INSERT INTO Vivero (nombre, latitud, longitud) VALUES 
('Vivero Central', -12.046374, -77.042793),
('Vivero Norte', -11.983333, -77.066667),
('Vivero Sur', -12.15, -76.95),
('Vivero Este', -12.08, -76.94),
('Vivero Oeste', -12.07, -77.1);

-- Insertar datos en Zona
INSERT INTO Zona (codigo_vivero, nombre, latitud, longitud) VALUES 
(1, 'Zona A', -12.0465, -77.0427),
(1, 'Zona B', -12.0466, -77.0426),
(2, 'Zona Norte 1', -11.9833, -77.0666),
(3, 'Zona Sur 1', -12.15, -76.95),
(4, 'Zona Este 1', -12.08, -76.94);

-- Insertar datos en Empleado
INSERT INTO Empleado (nombre, primer_apellido, segundo_apellido, fecha_ingreso, dni, tarea, codigo_vivero, codigo_zona) VALUES 
('Juan', 'Pérez', 'González', '2015-06-23', 'DNI1234567', 'regar', 1, 1),
('María', 'López', 'Ramírez', '2017-03-19', 'DNI2345678', 'plantar', 1, 2),
('Pedro', 'Martínez', 'Santos', '2018-01-11', 'DNI3456789', 'cosechar', 2, 3),
('Lucía', 'García', 'Hernández', '2019-09-15', 'DNI4567890', 'todo', 3, 4),
('Ana', 'Mendoza', 'Quispe', '2020-05-02', 'DNI5678901', 'vender', 4, 5);

-- Insertar datos en Historico_puesto
INSERT INTO Historico_puesto (codigo_empleado, codigo_vivero, fecha) VALUES 
(1, 4, '2015-06-23'),
(1, 2, '2016-09-01'),
(2, 5, '2017-03-19'),
(3, 3, '2018-01-11'),
(4, 1, '2019-09-15');

-- Insertar datos en Producto
INSERT INTO Producto (nombre, precio, descripcion) VALUES 
('Rosa', 10.00, 'Flor de rosa roja'),
('Tulipán', 8.50, 'Flor de tulipán amarillo'),
('Orquídea', 15.00, 'Flor exótica de orquídea'),
('Cactus', 5.00, 'Planta suculenta de cactus'),
('Helecho', 7.50, 'Planta ornamental de helecho');

-- Insertar datos en Cliente_fidelizado
INSERT INTO Cliente_fidelizado (nombre, primer_apellido, segundo_apellido, telefono, email, fecha_registro) VALUES 
('Carlos', 'Rodríguez', 'Luna', '999111222', 'carlos@correo.com', '2010-07-15'),
('Elena', 'Vásquez', 'Ortiz', '998333444', 'elena@correo.com', '2012-03-10'),
('Fernando', 'Gómez', 'Pérez', '997555666', 'fernando@correo.com', '2015-11-20'),
('Isabel', 'Torres', 'Ríos', '996777888', 'isabel@correo.com', '2018-05-30'),
('Laura', 'Sánchez', 'Flores', '995999000', 'laura@correo.com', '2021-08-25');

-- Insertar datos en Pedido
INSERT INTO Pedido (fecha, codigo_empleado, codigo_cliente) VALUES 
('2023-01-10', 1, 1),
('2023-02-15', 2, 2),
('2023-03-18', 3, 3),
('2023-04-20', 4, 4),
('2023-05-22', 5, 5);

-- Insertar datos en Pedido_Producto
INSERT INTO Pedido_Producto (codigo_pedido, codigo_producto) VALUES 
(1, 1), (1, 2), (2, 2), (2, 3), (3, 3), (3, 4), (4, 4), (4, 5), (5, 1), (5, 5);

-- Insertar datos en Zona_Producto
INSERT INTO Zona_Producto (codigo_vivero, codigo_zona, codigo_producto, stock) VALUES 
(1, 1, 1, 20), (1, 2, 3, 10), (2, 3, 4, 25), (3, 4, 5, 30), (4, 5, 2, 15);
