# Modelo-relacional-viveros

## 1. Entidades:

     - vivero (codigo_vivero, nombre, latitud, longitud);
     - empleado (codigo_empleado, nombre, primer_apellido, segundo_apellido, fecha_ingreso, dni, productividad);
     - pedido (codigo_pedido, fecha);
     - cliente_fidelizado (codigo_cliente, nombre, primer_apellido, segundo_apellido, bonificacion, telefono, fecha_registro, compra_total, fecha);
     - zona (codigo_zona, nombre, latitud, longitud, productividad);
     - producto (codigo_producto, nombre, precio, descripción);

## 2. Relaciones: 

### 1. Relacion Debil
       - vivero-zona (codigo_vivero, codigo_zona, nombre, latitud, longitud, productividad);

### 2. Relaciones 1:N

       - vivero-empleado [Empleado] (codigo_empleado, nombre, primer_apellido, segundo_apellido, fecha_ingreso, dni, productividad, codigo_vivero(FK), historico_puesto);
       - zona-empleado [Empleado] (codigo_empleado, nombre, primer_apellido, segundo_apellido, fecha_ingreso, dni, productividad, codigo_zona(FK), tarea);
       - empleado-pedido [Pedido] (codigo_pedido, fecha, codigo_empleado(FK));
       - cliente_fidelizado-pedido [Pedido] (codigo_pedido, fecha, codigo_cliente(FK));

### 3. Relaciones N:M (Tabla)
       - producto_pedido (codigo_producto, codigo_pedido);
       - zona_producto (codigo_zona, codigo_producto, stock);

